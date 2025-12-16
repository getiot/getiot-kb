---
sidebar_position: 3
slug: /nanomsg
---

# nanomsg



nanomsg是一个消息通信组件 - [zeromq](https://so.csdn.net/so/search?q=zeromq&spm=1001.2101.3001.7020)的作者之一用C语言重写的通信框架，使用宽松的MIT许可开源，小、轻、快，非常方便。



[NNG/nanomsg](https://github.com/nanomsg/nng) 是最近项目上使用到的一个通信库，用来实现进程间过程调用和线程间通信，很是方便。

NNG 是 nanomsg 的继任版本，而 nanomsg 则是流行的 [ZMQ](http://zeromq.org/) 的 C 重写版。

NNG 将通信使用的协议和传输分离，同一个协议可以工作在不同的传输层上，类似与 TCP/IP 的应用层和传输层的分层，同时接口上屏蔽了底层细节，统一用字符串 URL 来描述传输模式。这样当使用场景修改时，可以通过简单修改 URL 来实现适应，极具灵活性。

同时如 NNG 描述所言 “light-weight brokerless messaging”，NNG 中的通信各方是不需要第三方程序介入的，这与 MQTT/Redis 通信需要服务器不同。这样很适合作为通信库来使用而没有其他依赖。

NNG 支持的通信协议主要有以下几种：

- PAIR 一对一双向通信。
- PIPELINE(PUSH/PULL) 单向通信，类似与生产者消费者模型的消息队列。
- PUB/SUB 单向广播。
- REQ/REP 请求-应答模式，类似与 RPC 模式。
- BUS 网状连接通信，每个加入节点都可以发送/接受广播消息。
- SURVEY 用于多节点表决或者服务发现。

NNG 支持的传输模式主要有以下三种常用，其他还有tcp附加tls 1.2加密的tls传输和基于WebSocket的ws传输：

- inproc 进程内线程间传输
- ipc 主机内进程间传输
- tcp 网络内主机间传输

通信协议里除了 PAIR 之外，基本都是一对多的通信模式，这点需要注意，以 PIPELINE 和 PUB/SUB 为例：

1. PIPELINE 的 PUSH 端是 client，一个 PUSH 可以连接多个 PULL 端，发送数据时会选择其中一个可用的发送；PULL 端是 server，一个 PULL 可以接收多个 PUSH 连接和数据。
2. PUB/SUB 的 SUB 端是 client，一个 SUB 可以连接多个不同的 PUB 端，接收多个 PUB 端广播的数据；PUB 端是 server，一个 PUB 可以接收多个 SUB 连接并广播数据。

基于以上，多个程序是没办法共用一个 PUB/SUB 通道来广播数据的，这与 ROS 里的 topic 和 LCM 中的 channel 模式不同。如果要实现类似功能，则可以使用 PIPELINE + PUB/SUB 来处理：

- 独立一个话题发布的程序，拥有一个 PULL 和 PUB。
- PULL 约定一个 URL，所有需要发布该话题的程序都 PUSH 数据到该 URL 上。
- PUB 约定一个 URL，所有需要获取该话题的程序都 SUB 到该 URL 上。
- 程序内部循环将 PULL 读取的数据发送到 PUB 上。

以上则可以模拟出 ROS topic 数据合并 或者 LCM 中 channel 的类似功能。

整体上看，NNG 的 API 很简约，主要是 4 个，open/recv/send/close，open 根据协议不同使用的函数会不同。配置则是 setopt/getopt，与 UNIX API 类似。API 中没有上下文环境（context-less）依赖，只需要一个 nng_socket，这种设计和实现方法值得去学习一下（初步揣测应该是使用指针值作为handle，如果要强制编译器做类型检测，则会套上一层 struct，如 `typedef struct { _nng_xxx_socket * p } nng_socket;`）。

NNG 协议基本上囊括了常见的通信需求，一些特殊的需求，也可以通过组合协议来实现，比如上面的模拟 ROS topic 或者 LCM channel 的方法。这样一来，如果在程序中使用 NNG，不管是多进程，还是多线程，通过设计，可以进一步增强模块化，同时不乏灵活性。如果环境变化，程序不管是由多进程改成多线程，还是由多线程改成多主机，都很容易实现。

常见模块/进程/线程间通信，可以依据具体需求来使用 PIPELINE（消息队列） 还是 REQ/REP（过程调用），而不是锁+全局变量，每个模块单元只需要做单一相关的具体事务，无需知晓全局状态。
