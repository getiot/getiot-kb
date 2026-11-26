---
sidebar_position: 34
authors: [luhuadong]
---

# Linux poll 使用示例

在进行网络编程时，当你需要同时监听多个 socket 或文件描述符的 I/O 状态，`poll` 是一种比 `select` 更现代的 I/O 多路复用机制。相比于 `select`，它没有描述符数量限制、接口更简洁，而且使用起来也更灵活。

本文将带你通过实际示例理解 `poll` 的用法，包括其基本概念、数据结构和使用流程。



## poll 函数介绍

`poll` 的函数原型如下：

```c
int poll(struct pollfd fds[], nfds_t nfds, int timeout);
```

- `fds[]`：一个 `pollfd` 结构体数组，保存需要监听的文件描述符及其感兴趣的事件；
- `nfds`：表示 `fds[]` 数组的大小；
- `timeout`：等待时间（毫秒），设置为 `-1` 表示无限等待。

`struct pollfd` 的定义如下：

```c
struct pollfd {
    int fd;         // 文件描述符
    short events;   // 关心的事件，例如 POLLIN、POLLOUT
    short revents;  // 实际发生的事件，由内核设置
};
```

常用事件有：

- `POLLIN`：表示该文件描述符可读；
- `POLLOUT`：表示该文件描述符可写；
- `POLLERR`：发生错误；
- `POLLHUP`：挂起（连接断开）；
- `POLLNVAL`：描述符未打开或非法。



## 示例：TCP echo 服务器

下面的代码使用 `poll` 实现一个简单的 echo 服务器。

```c showLineNumbers title="poll_echo_server.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <poll.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define PORT 8888
#define MAX_CLIENTS 1024
#define BUFFER_SIZE 1024

int main() {
    int listen_fd, new_fd;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);
    struct pollfd fds[MAX_CLIENTS];
    char buffer[BUFFER_SIZE];
    int i;

    // 创建监听 socket
    listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (listen_fd < 0) {
        perror("socket");
        exit(1);
    }

    int opt = 1;
    setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    // 绑定地址
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);
    bind(listen_fd, (struct sockaddr *)&server_addr, sizeof(server_addr));

    // 监听
    listen(listen_fd, 10);
    printf("服务器启动，监听端口 %d...\n", PORT);

    // 初始化 poll 数组
    for (i = 0; i < MAX_CLIENTS; i++) {
        fds[i].fd = -1;
        fds[i].events = 0;
    }

    fds[0].fd = listen_fd;
    fds[0].events = POLLIN;

    while (1) {
        int ready = poll(fds, MAX_CLIENTS, -1);
        if (ready < 0) {
            perror("poll");
            break;
        }

        // 有新连接
        if (fds[0].revents & POLLIN) {
            new_fd = accept(listen_fd, (struct sockaddr *)&client_addr, &client_len);
            if (new_fd < 0) {
                perror("accept");
                continue;
            }
            printf("新连接：%s:%d\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

            // 添加到 poll 数组中
            for (i = 1; i < MAX_CLIENTS; i++) {
                if (fds[i].fd == -1) {
                    fds[i].fd = new_fd;
                    fds[i].events = POLLIN;
                    break;
                }
            }
        }

        // 处理客户端消息
        for (i = 1; i < MAX_CLIENTS; i++) {
            if (fds[i].fd == -1) continue;

            if (fds[i].revents & POLLIN) {
                int n = read(fds[i].fd, buffer, BUFFER_SIZE);
                if (n <= 0) {
                    printf("客户端断开连接\n");
                    close(fds[i].fd);
                    fds[i].fd = -1;
                } else {
                    buffer[n] = '\0';
                    printf("收到消息：%s", buffer);
                    write(fds[i].fd, buffer, n);  // 回显
                }
            }
        }
    }

    close(listen_fd);
    return 0;
}
```



## 编译与测试

使用以下命令编译运行：

```bash
gcc -o poll_echo_server poll_echo_server.c
./poll_echo_server
```

然后用多个终端连接：

```bash
telnet 127.0.0.1 8888
```



## 小结

通过本文你学到了：

- `poll` 是比 `select` 更现代的 I/O 多路复用方法；
- `pollfd` 数组用于管理多个文件描述符；
- `poll` 没有像 `select` 那样的描述符数量限制；
- 如何使用 `poll` 编写一个多客户端的 echo 服务器。

在实际开发中，`poll` 适用于中等规模的连接处理需求。如果你需要处理上万连接，可以进一步学习 `epoll`。不过，掌握 `poll` 是迈向高性能网络编程的重要一步。
