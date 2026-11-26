---
sidebar_position: 3
authors: [luhuadong]
---

# Modbus 协议版本



Modbus 是工业界常用的一种简单、可靠、开放的通信协议，可以在多种通信媒介上实施，包括常见的 RS232、RS485 和以太网。随着 Modbus-TCP 的广泛应用，国际互联网组织规定并保留了 TCP/IP 协议栈上的系统 502 端口，专门用于访问 Modbus 设备。

下图大致展示了 Modbus 协议栈模型。

![](https://static.getiot.tech/modbus-stack.png#center)

Modbus 通信协议目前存在用于串行链路、TCP/IP 以太网以及其他支持互联网协议的网络版本。在实际应用中，通过 RS485 和 TCP/IP 连接的方式最为常见。下面介绍 Modbus 协议的多种变体。



## Modbus RTU

Modbus RTU 是 Modbus 最常见的实现方式，它基于串行通信总线（例如 RS232、RS485），并采用紧凑的二进制数据形式进行协议通信。RTU 格式在命令/数据之后带有循环冗余校验的校验和作为错误校验机制，以确保数据的可靠性。Modbus RTU 消息必须连续传输，没有字符间犹豫。Modbus 消息由空闲（静默）时段构成（分隔）。 

![](https://static.getiot.tech/modbus-frame-rtu.png#center)

RTU 模式每个字节（11位）的格式为：

| 帧格式     | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| 编码系统   | 8位二进制                                                    |
| 数据位     | 1位 起始位<br/>8位 数据位，首先发送最低有效位<br/>1位 奇偶校验（注：默认偶校验是必须的，奇校验或无校验也可以使用）<br/>1位 停止位（注：使用无校验时要求2个停止位） |
| 帧发送方式 | 每个字符或字节均由从左到右顺序发送                           |
| 检验       | CRC（循环冗余校验），低位字节先发                            |
| 起始/结束  | 报文帧由时长至少为 3.5 个字节时间的空闲间隔区分 1 帧数据     |



## Modbus ASCII

Modbus ASCII 和 Modbus RTU 一样都是使用串行链路通信方式，不同的是，Modbus ASCII 采用一种人类可读的、冗长的表示方式，并使用纵向冗余校验的校验和保证数据传输的完整性。Modbus ASCII 消息由前导冒号 (":") 和尾随换行符 (CR/LF) 构成。

![](https://static.getiot.tech/modbus-frame-ascii.png#center)

ASCII 模式每个字节（10位）的格式为：

| 帧格式     | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| 编码系统   | 十六进制，ASCII 字符 0-9，A-F                                |
| 数据位     | 1位 起始位<br/>7位 数据位，首先发送最低有效位<br/>1位 奇偶校验（注：默认偶校验是必须的，奇校验或无校验也可以使用）<br/>1位 停止位（注：使用无校验时要求2个停止位） |
| 帧发送方式 | 每个字符或字节均由从左到右顺序发送                           |
| 检验       | LRC（纵向冗余校验），低位字节先发                            |
| 起始       | 一个‘冒号’（:）起始，对应 ASCII 十六进制为 3A                |
| 结束       | 以‘回车-换行’（CR，LF）对（ASCII 十六进制 0D 和 0A）结束     |

需要注意的是，由于帧格式不同，被配置为 RTU 模式的节点是不能与配置为 ASCII 模式的节点正常通信，反之亦然。



## Modbus TCP

Modbus TCP（或称为 Modbus TCP/IP）是一种 Modbus 变体，用于通过 TCP/IP 网络进行通信，通过端口 502 进行连接。和前面两种不一样，Modbus TCP 不需要校验和计算，因为较低层的 TCP/IP 协议栈已经提供校验和保护。

如果将校验和包含在有效载荷中，形成与 Modbus RTU 类似的帧，则称为 Modbus RTU/IP。

![](https://static.getiot.tech/modbus-frame-tcp.png#center)



## 其他版本

除了上述三种常用的 Modbus 协议，还有如下一些不太常见的 Modbus 扩展版本。

### Modbus over UDP

既然有 Modbus over TCP，那么自然也会有人尝试将 Modbus 运行在 UDP 之上，即 Modbus over UDP。 这么做的好处是消除了 TCP 所需的开销。 

### Modbus Plus

Modbus Plus（Modbus+、MB+ 或 MBP）协议是 Schneider Electric 的专利，与其他变体不同，它支持多个主站之间的点对点通信。不过，它需要一个专用的协处理器来处理类似 HDLC 的高速令牌轮换。它使用 1 Mbit/s 的双绞线，并在每个节点都有变压器隔离，这使其成为转换/边沿触发而不是电压/电平触发。连接 Modbus Plus 到计算机需要特殊的硬件，通常是支持 ISA、PCI 或 PCMCIA 总线的板卡。

### Pemex Modbus

Pemex Modbus 是标准 Modbus 的扩展，支持历史和流量数据。它是为 Pemex 石油和天然气公司设计的，用于过程控制，但从未得到广泛采用。

### Enron Modbus

Enron Modbus 是 Enron 公司开发的标准 Modbus 的另一个扩展，支持 32 位整数和浮点变量以及历史和流量数据。数据类型使用标准地址映射。历史数据用于满足美国石油协会 (API) 行业标准，即如何存储数据。



## 注意事项

前四种 Modbus 协议（Modbus RTU、Modbus ASCII、Modbus TCP 和 Modbus UDP）在数据模型和功能调用上都是相同的，只是传输报文的封装方式不同。但是，由于帧格式不同，因此这些协议变体并不是可互操作的。 





