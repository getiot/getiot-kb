---
sidebar_position: 33
authors: [luhuadong]
---

# Linux select 使用示例

在 Linux 网络编程中，当你需要同时监听多个文件描述符（例如多个 socket 连接）时，`select` 是最早被引入的 I/O 多路复用技术。它可以让你在单线程中等待多个 I/O 事件的发生，而不必为每个连接启动一个线程。

本文将带你通过一个完整示例，理解 `select` 的工作原理和使用方法。



## `select` 函数简介

在 C 语言中，`select` 的函数原型如下：

```c
int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);
```

各个参数含义如下：

- `nfds`：所有监视的文件描述符中最大值加一；
- `readfds`：你希望监听“可读事件”的文件描述符集合；
- `writefds`：你希望监听“可写事件”的文件描述符集合；
- `exceptfds`：监听异常事件的集合（用得少）；
- `timeout`：设置等待时间，传 NULL 表示一直等。

辅助宏函数如下：

- `FD_ZERO(fd_set *set)`：清空集合；
- `FD_SET(int fd, fd_set *set)`：将 fd 加入集合；
- `FD_CLR(int fd, fd_set *set)`：将 fd 从集合中移除；
- `FD_ISSET(int fd, fd_set *set)`：判断 fd 是否准备好。



## 示例：TCP echo 服务器

下面的代码展示了一个简单的 echo 服务器，使用 `select` 同时处理多个客户端连接。

```c showLineNumbers title="select_echo_server.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/select.h>

#define PORT 8888
#define MAX_CLIENTS  FD_SETSIZE
#define BUFFER_SIZE 1024

int main() {
    int listen_fd, client_fd, max_fd, i;
    int client_sockets[MAX_CLIENTS];
    fd_set read_fds, all_fds;
    char buffer[BUFFER_SIZE];

    struct sockaddr_in server_addr, client_addr;
    socklen_t addrlen = sizeof(client_addr);

    // 创建监听 socket
    listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (listen_fd < 0) {
        perror("socket");
        exit(1);
    }

    // 设置地址复用
    int opt = 1;
    setsockopt(listen_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    // 绑定
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);
    bind(listen_fd, (struct sockaddr *)&server_addr, sizeof(server_addr));

    // 监听
    listen(listen_fd, 10);

    // 初始化客户端列表
    for (i = 0; i < MAX_CLIENTS; i++)
        client_sockets[i] = -1;

    FD_ZERO(&all_fds);
    FD_SET(listen_fd, &all_fds);
    max_fd = listen_fd;

    printf("服务器启动，监听端口 %d...\n", PORT);

    while (1) {
        read_fds = all_fds;

        if (select(max_fd + 1, &read_fds, NULL, NULL, NULL) < 0) {
            perror("select");
            exit(1);
        }

        // 处理新连接
        if (FD_ISSET(listen_fd, &read_fds)) {
            client_fd = accept(listen_fd, (struct sockaddr *)&client_addr, &addrlen);
            if (client_fd < 0) {
                perror("accept");
                continue;
            }

            printf("新连接：%s:%d\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

            for (i = 0; i < MAX_CLIENTS; i++) {
                if (client_sockets[i] < 0) {
                    client_sockets[i] = client_fd;
                    break;
                }
            }

            FD_SET(client_fd, &all_fds);
            if (client_fd > max_fd) max_fd = client_fd;
        }

        // 处理客户端数据
        for (i = 0; i < MAX_CLIENTS; i++) {
            int sock = client_sockets[i];
            if (sock < 0) continue;

            if (FD_ISSET(sock, &read_fds)) {
                int n = read(sock, buffer, BUFFER_SIZE);
                if (n <= 0) {
                    printf("客户端断开连接\n");
                    close(sock);
                    FD_CLR(sock, &all_fds);
                    client_sockets[i] = -1;
                } else {
                    buffer[n] = '\0';
                    printf("收到消息：%s", buffer);
                    write(sock, buffer, n);  // 回显
                }
            }
        }
    }

    return 0;
}
```



## 如何编译和运行

你可以使用如下命令进行编译：

```bash
gcc -o select_echo_server select_echo_server.c
./select_echo_server
```

然后你可以使用 `telnet` 来连接测试：

```bash
telnet 127.0.0.1 8888
```



## 小结

通过 `select`，你可以让一个进程或线程监听多个文件描述符的 I/O 事件，适合中小规模的多连接服务器程序。本文通过一个完整的 TCP echo 示例演示了如何使用 `select`：

- 设置监听 socket；
- 初始化 `fd_set` 集合；
- 使用 `select` 等待事件；
- 处理新连接和客户端数据。

虽然 `select` 存在文件描述符数量限制和性能问题，但它作为 I/O 多路复用的入门方案，仍然是理解高性能服务器编程的重要一环。在将来学习 `poll` 和 `epoll` 之前，掌握 `select` 的原理和使用方法非常有帮助。
