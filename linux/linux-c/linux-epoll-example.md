---
sidebar_position: 35
authors: [luhuadong]
---

# Linux epoll 使用示例

当你需要同时处理上千甚至上万的网络连接时，传统的 `select` 和 `poll` 就显得力不从心了。这个时候，`epoll` 就是更高效的选择。它是 Linux 下最好的准备就绪通知机制（Linux 特有的 I/O 多路复用机制），适用于大规模并发场景，尤其是网络服务器开发中。

本文将带你了解 `epoll` 的基本概念、核心 API 以及通过一个 TCP echo 服务端示例来学习如何使用它。



## epoll 机制简介

`epoll` 是事件驱动的、基于回调的 I/O 机制，解决了 `select` 和 `poll` 每次调用都要遍历所有文件描述符的问题。它采用内核和用户空间共享的方式，极大地提升了效率。

`epoll` 是在 Linux 2.6 中引入的，在其他的类 UNIX 操作系统中不可用。它提供了和 `select` 、 `poll` 类似的机制：

- `select` 可以最多同时监视 `FD_SETSIZE` 个描述符，通常是一个较小的数（比如 1024）。
- `poll` 没有同时监视的描述符个数的限制，但是它在每次检查准备就绪的通知时需要扫描所有的描述符，这是 O(n) 的而且比较慢。

而 `epoll` 没有固定的限制，也不执行线性检查，因此它的效率更高，可以处理更多的事件。



### epoll 核心函数

```c
int epoll_create(int size);                 // 创建 epoll 实例
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event); // 添加/修改/删除监听事件
int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout); // 等待事件
```

参数说明：

- `epfd` 是 `epoll_create` 返回的文件描述符；
- `op` 可以是 `EPOLL_CTL_ADD`、`EPOLL_CTL_MOD` 或 `EPOLL_CTL_DEL`；
- `epoll_event` 包含要监听的事件类型，如 `EPOLLIN`（可读）、`EPOLLOUT`（可写）等；
- `epoll_wait` 会阻塞直到有事件发生或超时。

你可以用 `epoll_create` 或 `epoll_create1` 创建 `epoll` 实例，用 `epoll_ctl` 添加/删除需要观察的描述符，用 `epoll_wait` 等待观察集合上的事件，它阻塞直到有事件发生。更多的相关信息请见 Man 手册。



### epoll 触发模式

当描述符添加到 `epoll` 实例中时，有两种模式：水平触发和边缘触发。

- **LT（Level Triggered，水平触发）**是缺省的工作方式，并且同时支持 block 和 non-block socket。在这种模式下，内核告诉你一个文件描述符是否就绪了，然后你可以对这个就绪的 `fd` 进行 I/O 操作，如果你不作任何操作，内核还是会继续通知你的。所以，这种模式编程出错的可能性要小一点，传统的 select/poll 都是这种模型的代表。

  当被监控的文件描述符上有可读写事件发生时，`epoll_wait()` 会通知处理程序去读写。如果这次没有把数据一次性全部读写完（如读写缓冲区太小），那么下次调用 `epoll_wait()` 时，它还会通知你在上次没有读写完的文件描述符上继续读写，当然如果你一直不去读写，它会一直通知你。

  如果系统中有大量你不需要读写的就绪文件描述符，而它们每次都会返回，这样会大大降低处理程序检索自己关心的就绪文件描述符的效率。

- **ET（Edge Triggered，边缘触发）**是高速工作方式，只支持 non-block socket。在这种模式下，当描述符从未就绪变为就绪时，内核将通过 epoll 通知你。然后它会假设你知道文件描述符已经就绪，并且不会再为那个文件描述符发送更多的就绪通知，直到你做了某些操作导致那个文件描述符不再为就绪状态

  当被监控的文件描述符上有可读写事件发生时，`epoll_wait()` 会通知处理程序去读写。如果这次没有把数据全部读写完（如读写缓冲区太小），那么下次调用 `epoll_wait()` 时，它不会通知你，也就是它只会通知你一次，直到该文件描述符上出现第二次可读写事件才会通知你。这种模式比水平触发效率高，系统不会充斥大量你不关心的就绪文件描述符。



## 接口函数说明

epoll 相关的接口函数声明在 `sys/epoll.h` 头文件，主要有三类函数：创建、操作 和 等待。

### 创建 `epoll_create()`

```c showLineNumbers
int epoll_create(int size);
```

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| size     | 用来告诉内核要监听的 socket 数目一共有多少个，<br/>但从 Linux 2.6.8 开始，size 参数就被忽略，只要大于零即可。 |
| **返回** |                                                              |
| ≥0       | 执行成功返回一个非负整数的文件描述符，作为创建好的 epoll 句柄。 |
| -1       | 执行失败，返回 -1，错误信息可以通过 errno 获得。             |

另外，系统还提供了 `epoll_create1` 函数，当其参数 flags 为 0 时，除了丢弃过时的 size 参数之外，它的效果与 `epoll_create` 一样。

```c showLineNumbers
int epoll_create1(int flags);
```

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| flags    | `EPOLL_CLOEXEC` ：在新文件描述符上设置 close-on-exec (FD_CLOEXEC) 标志。 |
| **返回** |                                                              |
| ≥0       | 执行成功返回一个非负整数的文件描述符，作为创建好的 epoll 句柄。 |
| -1       | 执行失败，返回 -1，错误信息可以通过 errno 获得。             |

实现（eventpoll.c）

```c showLineNumbers
SYSCALL_DEFINE1(epoll_create1, int, flags)
{
	return do_epoll_create(flags);
}

SYSCALL_DEFINE1(epoll_create, int, size)
{
	if (size <= 0)
		return -EINVAL;

	return do_epoll_create(0);
}
```



### 操作 `epoll_ctl()`

```c showLineNumbers
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);
```



### 等待 `epoll_wait()`

```c showLineNumbers
int epoll_wait(int epfd, struct epoll_event *events, int maxevents, int timeout);
int epoll_pwait(int epfd, struct epoll_event *events, int maxevents, int timeout, const sigset_t *sigmask);
```



## 示例：TCP echo 服务器

```c showLineNumbers title="epoll_server.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/epoll.h>
#include <fcntl.h>

#define PORT 8888
#define MAX_EVENTS 1024
#define BUFFER_SIZE 1024

int make_socket_non_blocking(int fd) {
    int flags = fcntl(fd, F_GETFL, 0);
    return fcntl(fd, F_SETFL, flags | O_NONBLOCK);
}

int main() {
    int listen_fd, conn_fd, epfd, nready;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);
    struct epoll_event ev, events[MAX_EVENTS];
    char buffer[BUFFER_SIZE];

    // 创建 socket
    listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR, &(int){1}, sizeof(int));

    // 绑定地址
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);
    bind(listen_fd, (struct sockaddr *)&server_addr, sizeof(server_addr));

    // 监听
    listen(listen_fd, 10);
    printf("服务器启动，监听端口 %d...\n", PORT);

    // 创建 epoll 实例
    epfd = epoll_create(1);
    ev.events = EPOLLIN;
    ev.data.fd = listen_fd;
    epoll_ctl(epfd, EPOLL_CTL_ADD, listen_fd, &ev);

    while (1) {
        nready = epoll_wait(epfd, events, MAX_EVENTS, -1);
        for (int i = 0; i < nready; i++) {
            int fd = events[i].data.fd;

            if (fd == listen_fd) {
                // 新连接
                conn_fd = accept(listen_fd, (struct sockaddr *)&client_addr, &client_len);
                make_socket_non_blocking(conn_fd);
                printf("新连接：%s:%d\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));
                ev.events = EPOLLIN;
                ev.data.fd = conn_fd;
                epoll_ctl(epfd, EPOLL_CTL_ADD, conn_fd, &ev);
            } else if (events[i].events & EPOLLIN) {
                // 可读事件
                int n = read(fd, buffer, BUFFER_SIZE);
                if (n <= 0) {
                    close(fd);
                    epoll_ctl(epfd, EPOLL_CTL_DEL, fd, NULL);
                    printf("连接关闭\n");
                } else {
                    buffer[n] = '\0';
                    printf("收到消息：%s", buffer);
                    write(fd, buffer, n); // 回显
                }
            }
        }
    }

    close(listen_fd);
    return 0;
}
```

### 编译与运行

```bash
gcc -o epoll_server epoll_server.c
./epoll_server
```

然后你可以使用 `telnet` 测试：

```bash
telnet 127.0.0.1 8888
```



## 小结

通过本文，你了解了：

- `epoll` 是 Linux 下高效的 I/O 多路复用机制；
- 它通过 `epoll_create`、`epoll_ctl` 和 `epoll_wait` 实现监听多个事件；
- 相比 `select` 和 `poll`，`epoll` 更适合处理大量并发连接；
- 你可以使用 `EPOLLIN`、`EPOLLOUT` 等事件类型控制监听行为；
- 示例中展示了如何构建一个基于 `epoll` 的 TCP echo 服务器。

熟练掌握 `epoll` 是开发高性能网络服务程序的必备技能。如果你后续还想更深入，可以了解边缘触发（`EPOLLET`）模式和 `epoll` 的性能调优技巧。

