---
sidebar_label: Socket 套接字
sidebar_position: 9
slug: /socket
---

# Socket 套接字

**Socket**（套接字）是一种通信机制（通信的两方的一种约定），也是 TCP/IP 网络最为通用的 API。它屏蔽了各个协议的通信细节，提供了 TCP/IP 协议的抽象，对外提供了一套接口，同过这个接口就可以统一、方便的使用 TCP/IP 协议的功能。使得程序员无需关注协议本身，直接使用 socket 提供的接口来进行互联的不同主机间的进程的通信。

## Socket 的起源

起源于 20 世纪 70 年代加利福尼亚大学伯克利分校版本的 Unix，即人们所说的 BSD Unix。因此,有时人们也把套接字称为“伯克利套接字”或“BSD 套接字”。一开始，套接字被设计用在同一台主机上多个应用程序之间的通讯，这也被称进程间通讯（IPC）。后来发展出基于基于文件型的和基于网络型的两个种族，成为计算机网络编程的基础设施。

## Socket 设计理念

Socket 是应用层与 TCP/IP 协议族通信的中间软件抽象层，它是一组接口。在设计模式中，Socket 其实就是一个门面模式，它把复杂的 TCP/IP 协议族隐藏在 Socket 接口后面，对用户来说，一组简单的接口就是全部。对用户来说，一组简单的接口就是全部，让 Socket 去组织数据，以符合指定的协议。

我们知道，Unix/Linux 的基本哲学之一就是“一切皆文件”，都可以用 “打开 open –> 读写 write/read –> 关闭 close” 模式来操作。Socket 就是该模式的一个实现，socket 即是一种特殊的文件，一些 socket 函数就是对其进行的操作（读/写 IO、打开、关闭）。

![](https://static.getiot.tech/socket-communication.png#center)
