---
sidebar_position: 14
---

# CoAP 协议



## 简介

**CoAP**（Constrained Application Protocol）是一种专为受限环境下的设备（如传感器、执行器等）设计的轻量级通信协议，用于在低带宽、高时延和不稳定的网络中进行通信，是物联网中重要的通信协议。

CoAP 通常位于 OSI 七层模型中的应用层或传输层，取决于具体的实现方式。底层基于 UDP 协议，但为了弥补 UDP 传输的不可靠性，CoAP 定义了带有重传机制的事务处理机制，实现类似 HTTP 协议的请求/响应模型。

为了克服 HTTP 对于受限环境的劣势，CoAP 既考虑到数据报长度的最优化，又考虑到提供可靠通信。相对于使用文本格式的 HTTP 协议，CoAP 采用二进制格式，因此报文更加紧凑，CoAP 报文的最小长度仅仅 4 个字节，而一个 HTTP 的头大小就约有几十个字节。



## 协议特点

CoAP 协议具有以下特点：

- 消息模型，以消息为数据通信载体，通过交换网络消息来实现设备间数据通信；
- 对云端设备资源操作都是通过请求与响应机制来完成，类似 HTTP，设备端可通过 4 个请求方法（GET、PUT、POST、DELETE）对服务器端资源进行操作；
- 协议包轻量级，采用紧凑的二进制格式，最小长度仅为 4 字节；
- 支持可靠传输、数据重传、块传输，确保数据可靠到达；
- 支持 IP 多播, 即可以同时向多个设备发送请求；
- 非长连接通信，适用于低功耗物联网场景。



## 协议格式

报文的格式如下所示：

![](https://static.getiot.tech/CoAP-message-format.jpg#center)

协议字段具体说明：

- Ver：版本号占 2bit，固定为 01。
- T：报文类型，占 2bit，CoAP 中有四种报文类型，分别是 CON、NON、ACK 和 Reset 报文。
- TKL：标签长度指示，占 4bit，用于指示后面的 Token 占几个字节，可以取值为 0000、0001、0010、0100，分别表示没有 Token、Token 占 1 字节、Token 占 2 字节、Token 占 4 字节。
- Code：占 8bit，其中前 3bit 为 Class 部分，后 5bit 为 Detail 部分，采用 c.dd 形式来描述。在 CoAP 请求报文中表示请求方法，在 CoAP 响应报文中表示响应状态。
- Messages ID：报文序号，占 2 字节，大端格式，一组对应的 CoAP 请求和响应使用相同的报文序号。
- Token：标签，长度由 TKL 标签长度指示确定，与是资源的“身份证”，CoAP 有 3 种不同的请求/响应模式，即携带模式、分离模式和非确认模式，Token 在分离模式起重要作用，携带模式可以忽略。
- Options：选项。
- 分隔符 0xFF，占1字节。
- Payload：负载。



## 请求/响应码

CoAP 中的 Code 字段采用 `c.dd` 格式来描述请求方法和响应状态，具体说明如下。

| Code 值 | CoAP 请求方法 | Code 值 | CoAP 响应状态  |
| ------- | ------------- | ------- | -------------- |
| 0.01    | GET方法       | 0.00    | 空报文         |
| 0.02    | POST方法      | 2.xx    | 正确响应       |
| 0.03    | PUT方法       | 4.xx    | 表示客户端错误 |
| 0.04    | DELETE方法    | 5.xx    | 表示服务器错误 |



## 报文类型

| 类型       | 描述                                | T 值 |
| ---------- | ----------------------------------- | ---- |
| CON 报文   | Confirmable，需要被确认的报文       | T=00 |
| NON 报文   | Non-Confirmable，不需要被确认的报文 | T=01 |
| ACK 报文   | Acknowledgement，应答报文           | T=10 |
| Reset 报文 | 复位报文                            | T=11 |

具体来说：

- CON：请求必须要接收者发送 ACK 或者 RST 确认，如果发送者规定时间内内有收到 ACK 或者 RST，则会重发。
- NON：不要求接收者确认。
- ACK：用于确认 Messages ID 一致的 CON 报文，ACK 的 payload 可能为空（在分离模式）。
- RST：用于对应无法处理 CON 的报文，Messages ID 需要与 CON 一致，且 payload 一定为空。



## CoAP 方法

| 方法   | 描述                                                         |
| ------ | ------------------------------------------------------------ |
| GET    | 查询资源                                                     |
| POST   | 要求请求中的资源描述内容被服务器处理，比如创建（返回 2.01 create）、修改（返回 2.04 changed）、删除（返回 2.02 delete） |
| PUT    | 要求服务器根据请求中的URI和payload更新服务器指定资源，比如创建（返回 2.01 create）、修改（返回 2.04 changed） |
| DELETE | 要求根据请求中的 URI 删除服务器指定资源内容，返回删除（返回 2.02 delete） |



## 工作流程

**携带模式**

ACK 的 payload 部分包含响应负载，最少 2 个报文就可得到数据。

![](https://static.getiot.tech/CoAP-protocol-workflow-1.png#center)

**分离模式**

客户端同样发送 CON 请求，服务器立即回复 ACK，但是 ACK 中没有 payload，而是过段时间后服务器再回应 CON，其中这个 CON 的 Token 要与客户端之前发送 CON 的 Token 一致，该 CON 还包含 payload，客户端收到后用 ACK 回应。至少需要 4 个报文。

![](https://static.getiot.tech/CoAP-protocol-workflow-2.png#center)

**非确认模式**

这种客户端发送 NON 报文，不需要服务器回应。

![](https://static.getiot.tech/CoAP-protocol-workflow-3.png#center)



## 小结

CoAP 是一种专为受限环境下的设备设计的轻量级通信协议，具有高效、灵活、可靠的特点。它使得受限设备能够通过简单的 RESTful 接口进行通信，实现了对资源的发现、观察和控制。CoAP 协议的出现大大促进了物联网设备之间的互联互通，推动了物联网技术的发展和应用。

