---
sidebar_position: 4
---

# TCP 连接状态



TCP 的 11 种状态分别对应 TCP 三次握手过程的 5 种状态和 TCP 四次挥手断开过程中的 6 种状态。

![](https://static.getiot.tech/tcp-socket-flowchart.jpg#center)

对于 TCP 客户端或服务端来说，一个 TCP 连接可能处于这 11 种状态中的一种，具体描述如下。

| 状态        | 描述                                                         |
| ----------- | ------------------------------------------------------------ |
| CLOSED      | 初始状态，表示 TCP 连接是”关闭着的”或”未打开的”，该状态下无法通信。 |
| LISTEN      | 表示服务器端的某个 socket 处于监听状态，可以接受客户端的连接。 |
| SYN_RCVD    | 表示服务器接收到了来自客户端请求连接的 SYN 报文。这个状态是在服务端的，但是它是一个中间状态，很短暂，平常我们用 netstat 或 ss 的时候，不太容易看到这种状态，但是遇到 SYN flood 之类的 SYN 攻击时，会出现大量的这种状态，即收不到三次握手最后一个客户端发来的 ACK，所以一直是这个状态，不会转换到 `ESTABLISHED` 状态。 |
| SYN_SENT    | 这个状态与 `SYN_RCVD` 状态相呼应，它是 TCP 连接客户端的状态，当客户端 socket 执行 connect() 进行连接时，它首先发送 SYN 报文，然后随即进入到 `SYN_SENT` 状态，并等待服务端的 SYN 和 ACK，该状态表示客户端的 SYN 已发送。 |
| ESTABLISHED | 表示 TCP 连接已经成功建立，开始传输数据。                    |
| FIN_WAIT_1  | 这个状态在实际工作中很少能看到，当客户端想要主动关闭连接时，它会向服务端发送 FIN 报文，此时 TCP 状态就进入到 `FIN_WAIT_1` 的状态，而当服务端回复 ACK，确认关闭后，则客户端进入到 `FIN_WAIT_2` 的状态，也就是只有在没有收到服务端 ACK 的情况下，`FIN_WAIT_1` 状态才能看到，然后长时间收不到 ACK，通常会在默认超时时间 60s（由内核参数 tcp_fin_timeout 控制）后，直接进入 `CLOSED` 状态。 |
| FIN_WAIT_2  | 这个状态相比较常见，也是需要注意的一个状态，`FIN_WAIT_1` 在接收到服务端 ACK 之后就进入到 `FIN_WAIT_2` 的状态，然后等待服务端发送 FIN，所以在收到对端 FIN 之前，TCP 都会处于 `FIN_WAIT_2` 的状态，也就是，在主动断开的一端发现大量的 `FIN_WAIT_2` 状态时，需要注意，可能时网络不稳定或程序中忘记调用连接关闭，`FIN_WAIT_2` 也有超时时间，也是由内核参数 tcp_fin_timeout 控制，当 `FIN_WAIT_2` 状态超时后，连接直接销毁。 |
| CLOSE_WAIT  | 表示正在等待关闭，该状态只在被动端出现，即当主动断开的一端调用 close() 后发送 FIN 报文给被动端，被动端必然会回应一个 ACK（这是由 TCP 协议层决定的），这个时候，TCP 连接状态就进入到 `CLOSE_WAIT` 状态。 |
| LAST_ACT    | 当被动关闭的一方在发送 FIN 报文后，等待对方的 ACK 报文的时候，就处于 `LAST_ACK` 的状态，当收到对方的 ACK 之后，就进入到 `CLOSED` 状态了。 |
| TIME_WAIT   | 该状态是最常见的状态，主动方在收到对方 FIN 后，就由 `FIN_WAIT_2` 状态进入到 `TIME_WAIT` 状态。 |
| CLOSING     | 这个状态是一个比较特殊的状态，也比较少见，正常情况下不会出现，但是当双方同时都作为主动的一方，调用 close() 关闭连接的时候，两边都进入 `FIN_WAIT_1` 的状态，此时期望收到的是 ACK包，进入 `FIN_WAIT_2` 的状态，但是却先收到了对方的 FIN 包，这个时候，就会进入到 `CLOSING` 的状态，然后给对方一个ACK，接收到 ACK 后直接进入到 `CLOSED` 状态。 |


下图展示了在一次连接过程中的 TCP 状态的转换，可以加深对 TCP 连接状态的理解。

![](https://static.getiot.tech/tcp-states-in-a-connection.png#center)





