---
sidebar_position: 25
authors: [luhuadong]
---

# UNIX 本地套接字

在这篇文章中，你将学习什么是 UNIX 本地套接字（UNIX Domain Socket，简称 UDS），它的工作原理、使用场景，以及如何通过它实现同一台机器上不同进程之间的通信。我们还会用 C 语言写一个简单的服务端和客户端程序进行演示。



## 什么是 UNIX 本地套接字？

UNIX 本地套接字是一种特殊的套接字类型，用于同一台计算机上两个进程之间的通信。与 TCP/UDP 套接字不同，它不经过网络协议栈，而是通过文件系统中的一个“伪文件”（通常在 `/tmp` 或用户自定义路径下）进行通信。

它的主要特点包括：

- **本地通信**，不依赖网络；
- **低延迟、高效率**，因为跳过了 TCP/IP 协议栈；
- **使用文件路径作为地址**，不是 IP 和端口；
- 支持面向连接（SOCK_STREAM）和无连接（SOCK_DGRAM）模式。



## UNIX 套接字的基本流程

和 TCP 套接字类似，UNIX 套接字也分为服务端和客户端，它们之间的通信基本流程如下：

1. 服务端创建套接字并绑定到一个路径；
2. 服务端监听连接请求；
3. 客户端连接到该路径；
4. 双方通过 `read` / `write` 或 `recv` / `send` 进行数据交换；
5. 关闭连接，服务端删除套接字文件。



## UNIX 套接字服务端示例

```c showLineNumbers title="unix_socket_server.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCKET_PATH "/tmp/unix_socket_demo"

int main() {
    int server_fd, client_fd;
    struct sockaddr_un addr;
    char buf[100];

    server_fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (server_fd < 0) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    unlink(SOCKET_PATH); // 确保路径未被占用

    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, SOCKET_PATH, sizeof(addr.sun_path) - 1);

    bind(server_fd, (struct sockaddr*)&addr, sizeof(addr));
    listen(server_fd, 5);
    printf("等待客户端连接...\n");

    client_fd = accept(server_fd, NULL, NULL);
    int len = read(client_fd, buf, sizeof(buf)-1);
    buf[len] = '\0';
    printf("接收到客户端消息：%s\n", buf);

    write(client_fd, "你好客户端！", strlen("你好客户端！"));

    close(client_fd);
    close(server_fd);
    unlink(SOCKET_PATH); // 删除套接字文件
    return 0;
}
```



## UNIX 套接字客户端示例

```c showLineNumbers title="unix_socket_client.c"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

#define SOCKET_PATH "/tmp/unix_socket_demo"

int main() {
    int client_fd;
    struct sockaddr_un addr;
    char buf[100];

    client_fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (client_fd < 0) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, SOCKET_PATH, sizeof(addr.sun_path) - 1);

    connect(client_fd, (struct sockaddr*)&addr, sizeof(addr));
    write(client_fd, "你好服务端！", strlen("你好服务端！"));

    int len = read(client_fd, buf, sizeof(buf)-1);
    buf[len] = '\0';
    printf("收到服务端回复：%s\n", buf);

    close(client_fd);
    return 0;
}
```



## 编译和运行

使用以下命令编译：

```bash
gcc unix_socket_server.c -o server
gcc unix_socket_client.c -o client
```

先运行服务端：

```bash
./server
```

再运行客户端：

```bash
./client
```

你会看到服务端打印接收到的消息，客户端收到服务端的回复。



## 适用场景

你可以在以下场景使用 UNIX 本地套接字：

- 系统守护进程和前端程序之间的通信（如 systemd 和各种管理工具）；
- 桌面应用的进程间消息传递；
- Web 服务器（如 Nginx、php-fpm）之间的内部通信；
- 替代共享内存、管道等其他 IPC 方式。



## 小结

通过本文你学会了：

- UNIX 本地套接字的原理和特点；
- 如何创建、绑定、连接和通信；
- 实现了服务端和客户端程序；
- 知道了它适用于本机进程间的高效通信。

相比网络 socket，UNIX 本地套接字更轻量、延迟更低、部署更方便，是本地通信的理想选择。
