---
sidebar_position: 19
authors: [luhuadong]
---

# Linux 网络编程

在学习 Linux 系统编程的过程中，**网络编程**是一个非常重要的模块。它让你能够编写通过网络通信的程序，比如聊天软件、Web 服务器或数据采集客户端等。本文将带你了解网络通信的基本原理、Socket 编程模型，以及常见的通信协议和系统调用。阅读完这篇文章后，你将能清楚地理解一个简单网络程序的结构，并为后续深入学习打下基础。



## 什么是网络编程？

**网络编程**指的是编写程序，使之能在不同设备之间通过网络（如 TCP/IP）进行数据通信。在 Linux 中，网络编程最核心的技术是使用 **Socket API**。



## Socket 编程模型

Socket（套接字）是网络编程的基础，是对网络通信端点的一种抽象。你可以把它想象成一个“网络插座”，让你的程序可以发消息、收消息。

### 套接字通信的基本流程

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

<Tabs>
  <TabItem value="server" label="服务端（Server）" default>

1. **创建 socket**（`socket()`）
2. **绑定地址**（`bind()`）
3. **监听连接**（`listen()`）
4. **接受连接**（`accept()`）
5. **接收和发送数据**（`recv()` / `send()`）
6. **关闭连接**（`close()`）

  </TabItem>
  <TabItem value="client" label="客户端（Client）">

1. **创建 socket**（`socket()`）
2. **连接服务端**（`connect()`）
3. **接收和发送数据**（`recv()` / `send()`）
4. **关闭连接**（`close()`）

  </TabItem>
</Tabs>




### Socket 通信流程图

```scss
客户端                          服务端

socket()                       socket()
connect() <------------------> bind()
                               listen()
                               accept()
send()/recv() <-------------> recv()/send()
close()                        close()
```



## TCP 和 UDP 协议

在网络编程中，你通常使用两种协议：TCP（传输控制协议）和 UDP（用户数据报协议）。

| 协议 | 特点                                                         |
| :--: | ------------------------------------------------------------ |
| TCP  | 面向连接、可靠、有序、流控制，适用于聊天、文件传输等需要保证数据可靠的应用。 |
| UDP  | 无连接、不可靠、速度快，适用于视频直播、DNS 查询等对速度要求高但不在乎丢包的场景。 |

你在创建 socket 时，可以通过参数指定协议：

```c
socket(AF_INET, SOCK_STREAM, 0); // 创建 TCP 套接字
socket(AF_INET, SOCK_DGRAM, 0);  // 创建 UDP 套接字
```



## 地址结构体

你在绑定地址或连接时，会用到如下结构体来描述 IP 和端口：

```c
struct sockaddr_in {
    sa_family_t    sin_family; // 地址族，AF_INET
    in_port_t      sin_port;   // 端口号（网络字节序）
    struct in_addr sin_addr;   // IP 地址（网络字节序）
};
```

你可以使用 `inet_pton()` 把点分十进制的 IP 地址转换为结构体中的字段，使用 `htons()` 转换端口号。



## 初识 I/O 模型

网络通信时，一个连接的读写方式也很重要，Linux 提供了多种 I/O 模型，比如：

- **阻塞 I/O（Blocking）**
- **非阻塞 I/O（Non-blocking）**
- **I/O 多路复用（select/poll/epoll）**
- **信号驱动 I/O**
- **异步 I/O（AIO）**

对于入门阶段，你可以先从阻塞式 I/O 学起，即程序在 `recv()` 时会一直等待直到有数据为止。



## 小结

本文带你了解了 Linux 网络编程的基础内容，包括 Socket 的基本概念、客户端与服务端的工作流程、TCP 与 UDP 的区别、常用系统调用等。

后续你可以尝试自己动手写一个简单的客户端和服务端程序，逐步掌握网络通信的实际编码技巧。网络编程虽然看似复杂，但理解核心流程后会发现它其实非常清晰明了。
