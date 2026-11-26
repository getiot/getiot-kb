---
sidebar_position: 32
authors: [luhuadong]
---

# Linux I/O 多路复用

在进行网络编程或高并发处理时，你常常需要同时监听多个文件描述符（如多个 socket 连接）。这时，**I/O 多路复用** 就成了一种非常高效的技术。本文将带你理解什么是 I/O 多路复用、它的几种常见实现方式（`select`、`poll`、`epoll`）以及各自的优缺点。



## 什么是 I/O 多路复用？

I/O 多路复用的本质是：**使用一个线程同时等待多个文件描述符变为“就绪”状态（可读、可写或有异常）**，一旦某个文件描述符准备好了，你就可以对它进行 I/O 操作。

通俗来说，你不用为每个连接创建一个线程，而是可以用一个线程“盯着”多个 socket，当某个 socket 有数据时才处理它。这样做的好处是资源消耗更少，效率更高，尤其适合**高并发**场景。



## 常见的多路复用方式

Linux 下提供了三种常用的多路复用 API：

### 1. `select`

这是最早期的多路复用接口，几乎所有系统都支持。

```c
int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);
```

- 你需要通过 `FD_SET()` 等宏手动设置监听的文件描述符集合；
- `nfds` 是所有监听的 fd 中最大值加一；
- `timeout` 控制阻塞时间，传 NULL 表示一直等待；
- 每次调用后，fd 集合会被修改，需重新设置。

**缺点**：

- 监听数量有限制（通常是 1024）；
- 每次调用都需要重建 fd 集合；
- 难以扩展，高并发场景性能差。



### 2. `poll`

`poll` 的功能和 `select` 类似，但使用数组结构代替了 `fd_set`，消除了 fd 数量的限制。

```c
int poll(struct pollfd *fds, nfds_t nfds, int timeout);
```

- `fds` 是一个 `pollfd` 数组；
- 每个 `pollfd` 包含文件描述符和感兴趣的事件；
- 返回时可以知道哪些 fd 准备好了。

**改进点**：

- 不再限制最大 fd；
- 结构更灵活；
- 但每次仍需遍历整个数组，效率不够高。



### 3. `epoll`（Linux 独有，推荐）

`epoll` 是 Linux 为大规模并发优化的多路复用接口，性能远高于前两者。

```c
int epoll_create(int size);
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);
```

- `epoll_create` 创建 epoll 实例；
- `epoll_ctl` 添加/修改/删除监听 fd；
- `epoll_wait` 等待事件，返回就绪的 fd 列表。

**优点**：

- 支持成千上万个连接；
- 内核帮你管理感兴趣的事件；
- 只返回发生变化的 fd，避免无效遍历；
- 支持边缘触发（edge-triggered）和水平触发（level-triggered）。



## 三者的对比总结

|     特性     |      select      |    poll    |        epoll         |
| :----------: | :--------------: | :--------: | :------------------: |
|  平台兼容性  |        高        |     高     |      Linux 专有      |
|  连接数上限  |  有限制（1024）  | 无显著限制 |      无显著限制      |
|   内核效率   |        低        |    一般    |          高          |
| 内核通知机制 |       轮询       |    轮询    |       事件驱动       |
|   实用场景   | 小规模、兼容性好 | 中等连接数 | 高并发、高性能服务器 |



## 什么时候该使用多路复用？

你应该在以下场景中考虑使用 I/O 多路复用：

- 有大量 socket 需要监听（如聊天服务器、HTTP 代理等）；
- 资源有限，不希望创建太多线程或进程；
- 对响应延迟和吞吐量要求较高。



## 小结

I/O 多路复用让你可以用一个线程监听多个连接，提高系统的并发处理能力。你了解了三种方式：

- `select`：老旧但广泛兼容，适合入门学习；
- `poll`：无连接数限制，结构更清晰；
- `epoll`：性能最优，适合高并发场景，是 Linux 网络服务器的首选。

在后续的实践中，你可以尝试用 `epoll` 实现一个简单的并发 TCP 聊天室，也可以用 `poll` 模拟一个轻量级的 HTTP 服务器。多路复用是理解高性能服务器编程的核心基础，值得你深入掌握。
