---
sidebar_position: 20
authors: [luhuadong]
---

# TCP 网络套接字



## TCP 头部信息

![TCP 头部](https://static.getiot.tech/TCP-header-01.jpeg#center)



## TCP 通信流程

TCP 网络套接字，也称为流式套接字，是面向连接的通信。因此在 TCP 网络编程中，通常分为服务器端和客户端两部分，大致流程如下。

**TCP 服务器端编程步骤：**

1. 创建服务端套接字（使用 socket 函数）；
2. 绑定 socket 到一个 IP 地址和一个端口上（使用 bind 函数）；
3. 将套接字设置为监听模式，等待连接请求（使用 listen 函数）；
4. 请求到来后，接受连接请求，返回一个新的对应此次连接的套接字（使用 accept 函数）；
5. 用返回的新的套接字和客户端进行通信，即发送或接收数据（使用 send 和 recv 函数），通信结束则关闭这个新创建的套接字（使用 close 函数）；
6. 监听套接字继续处于监听状态，等待其他客户端的连接请求；
7. 如果要退出服务端程序，则先关闭监听套接字（使用 close 函数）。

**TCP 客户端编程步骤：**

1. 创建客户端套接字（使用 socket 函数）；
2. 向服务器端发出连接请求（使用 connect 函数）；
3. 连接成功即可与服务器端通信，即发送或接收数据（使用 send 和 recv 函数）；
4. 如果要关闭客户端程序，则先关闭套接字（使用 close 函数）。

下面是 TCP 网络套接字服务器端和客户端连接过程的示意图。

![](https://static.getiot.tech/tcp-socket-diagrams.png#center)



## TCP 连接状态

TCP 的 11 种状态分别对应 TCP 三次握手过程的 5 种状态和 TCP 四次挥手断开过程中的 6 种状态。

![](https://static.getiot.tech/tcp-socket-flowchart.jpg#center)

一个 TCP 连接可以是下面状态中的一种：

| 状态        | 描述                                                         |
| ----------- | ------------------------------------------------------------ |
| CLOSED      | 初始状态，表示 TCP 连接是”关闭着的”或”未打开的”，此状态下不能通信。 |
| LISTEN      | 表示服务器端的某个 socket 处于监听状态，可以接受客户端的连接。 |
| SYN_RCVD    | 表示服务器接收到了来自客户端请求连接的 SYN 报文。这个状态是在服务端的，但是它是一个中间状态，很短暂，平常我们用 netstat 或 ss 的时候，不太容易看到这种状态，但是遇到 SYN flood 之类的 SYN 攻击时，会出现大量的这种状态，即收不到三次握手最后一个客户端发来的 ACK，所以一直是这个状态，不会转换到 ESTABLISHED<br/>a TCP server has received the first TCP message from the client in the three-way TCP open hand-shake. |
| SYN_SENT    | 这个状态与SYN_RCVD状态相呼应，，它是TCP连接客户端的状态，当客户端SOCKET执行connect()进行连接时，它首先发送SYN报文，然后随机进入到SYN_SENT状态，并等待服务端的SYN和ACK，该状态表示客户端的SYN已发送<br/>a TCP client has sent its first message in the three-way handshake. This message has the SYN bit set. |
| ESTABLISHED | 表示TCP连接已经成功建立，开始传输数据<br/>the connection can start to send and receive data. |
| FIN_WAIT_1  | one side of a TCP connection shuts down by sending a message with the FIN bit set and waits for a FIN from the other side of the connection. |
| FIN_WAIT_2  | one side of a TCP connection has sent a FIN and received the ACK from the other side of the connection. |
| CLOSE_WAIT  | one side of a TCP connection receives a shutdown from the other side of the connection by receiving a message with the FIN bit set. It sends a message with the ACK bit set acknowledging the FIN. |
| CLOSING     | one side of a connection in FIN_WAIT_1 state gets a shutdown from the other side by receiving a FIN message and sends an ACK for that FIN and awaits the other side to send its final ACK. |
| TIME_WAIT   | one side of a connection sends its final ACK. The connection waits for a period of time to be sure of the other side has terminated completely. |
| RST_ACT     | one side of a connection sends its final FIN and awaits a final ACK from the other side of the connection. Upon reception of the final ACK, the connection is closed. |





