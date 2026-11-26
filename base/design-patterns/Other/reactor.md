---
sidebar_position: 2
slug: /reactor
sidebar_label: Reactor 模式
---

# Reactor 模式：高并发的事件调度器

在构建高性能服务器、网络框架或响应式系统时，你可能听说过 **Reactor 模式**（反应器模式）。它是支撑现代网络编程（如 Node.js、Netty、libuv）背后的核心模式之一，特别适用于处理高并发 I/O 请求的服务器。



## 什么是 Reactor 模式

Reactor 设计模式是一种事件处理模式，用于处理由一个或多个输入并发传递的服务请求。服务处理程序会将传入的请求进行多路分解，并将它们同步分发给相关的请求处理程序。

Reactor 模式的核心思想可以总结为一句话：**使用事件分发器统一监听多个 I/O 事件，并将事件交给注册的回调处理器来响应，从而实现高并发、非阻塞的程序结构。**（💡 关键词是：事件驱动、非阻塞、回调机制）

你可以把 Reactor 模式类比成一个“餐厅接待员”系统：

- 一个接待员（Reactor）负责等待所有顾客（I/O 事件）的到来。
- 每当有顾客到达（如连接请求、数据可读），接待员不会自己处理，而是把顾客分派给具体服务员（事件处理器）来响应。
- 所有的等待和派发都是非阻塞的，这样一个接待员就能服务成百上千个顾客。

这就避免了为每个客户开一个服务员线程（也就是避免了传统的“每连接一个线程”模型），节省了大量资源。



## 为何需要 Reactor 模式？

对于应用程序而言，CPU 的处理速度是远远快于 IO 的速度的。如果 CPU 为了 IO 操作（例如从 Socket 读取一段数据）而阻塞显然是不划算的。好一点的方法是分为多进程或者线程去进行处理，但是这样会带来一些进程切换的开销，试想一个进程一个数据读了500ms，期间进程切换到它 3 次，但是 CPU 却什么都不能干，就这么切换走了，是不是也不划算？

这时先驱们找到了事件驱动，或者叫回调的方式，来完成这件事情。这种方式就是，应用业务向一个中间人注册一个回调（event handler），当 IO 就绪后，就这个中间人产生一个事件，并通知此 handler 进行处理。这种回调的方式，也体现了“好莱坞原则”（Hollywood principle）—— “Don’t call us, we’ll call you”，在我们熟悉的 IoC 中也有用到。看来软件开发真是互通的！



## Reactor 应用场景

Reactor 核心是解决多请求问题。一般来说，Thread-Per-Connection 的应用场景并发量不是特别大，如果并发量过大，会导致线程资源瞬间耗尽，导致服务陷入阻塞，这个时候就需要 Reactor 模式来解决这个问题。Reactor 通过多路复用的思想大大减少线程资源的使用。

Reactor 模式主要用于 **高并发 I/O 密集型系统**，比如：

- Web 服务器（如 Nginx、Tomcat、Netty）
- 聊天服务器、游戏服务器
- 异步数据库代理
- Node.js（底层用 libuv 实现了 Reactor 模式）



## Reactor vs 线程模型

Reactor 模式和线程模型有一些相似之处，但它们是有区别的，具体如下表所示。

| 模型                         | 特点                                             |
| ---------------------------- | ------------------------------------------------ |
| **每连接一线程**             | 简单直观，但线程资源消耗大，不适合高并发。       |
| **线程池模型**               | 线程数有限制，减少资源浪费，但仍要面对阻塞问题。 |
| **Reactor 模式（事件驱动）** | 少量线程 + 非阻塞 I/O，高效处理大量连接。        |



## 示例：实现一个小型 Reactor

下面我们使用 Python 中的 `selectors` 模块实现一个简单的 Reactor 服务器。

```python showLineNumbers
import selectors
import socket

sel = selectors.DefaultSelector()

def accept(sock):
    conn, addr = sock.accept()
    print('接收到连接：', addr)
    conn.setblocking(False)
    sel.register(conn, selectors.EVENT_READ, read)

def read(conn):
    data = conn.recv(1024)
    if data:
        print('接收到数据：', data.decode())
        conn.sendall(data)  # 回显
    else:
        print('关闭连接')
        sel.unregister(conn)
        conn.close()

sock = socket.socket()
sock.bind(('localhost', 8888))
sock.listen()
sock.setblocking(False)

sel.register(sock, selectors.EVENT_READ, accept)

print("服务器启动：监听端口 8888")
while True:
    events = sel.select()  # 监听所有事件
    for key, _ in events:
        callback = key.data  # accept 或 read
        callback(key.fileobj)
```

这段代码展示了：

- 如何注册事件（`sel.register`）；
- 如何用一个线程处理多个 socket；
- 每个事件交给相应的回调函数处理（即 handler）。



## 开源项目

- [libevent](https://github.com/libevent/libevent)
- [Netty](https://github.com/netty/netty)
- [Spring IOC](https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/beans.html)



## 小结

Reactor 模式是一种经典的事件驱动架构，广泛应用于高性能 I/O 系统中。它的优势在于“非阻塞 + 少量线程”，拥有高并发处理能力，并与事件机制自然契合（回调、任务调度）。如果你正在研究服务器框架、事件循环系统或者网络编程，Reactor 模式会是你理解和设计核心机制的重要基础。