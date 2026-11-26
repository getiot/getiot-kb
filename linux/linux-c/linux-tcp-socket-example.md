---
sidebar_position: 21
sidebar_label: Linux TCP 通信示例
authors: [luhuadong]
---

# Linux TCP socket 通信示例

通过前面的学习，你已经了解了网络通信的基本流程和 Socket 的概念。接下来，我们将通过一个完整的 TCP 客户端-服务端通信示例，帮助你更深入理解 Linux 下的 Socket 编程。

本教程将带你逐步实现：

- 一个 TCP 服务端（监听、接受连接、接收数据、回应）
- 一个 TCP 客户端（连接服务端、发送数据、接收回应）

我们将使用 C 语言和 POSIX 标准 API 来完成示例。



## 服务端代码

```c showLineNumbers title="server.c"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 8888
#define BUFFER_SIZE 1024

int main() {
    int server_fd, client_fd;
    struct sockaddr_in server_addr, client_addr;
    char buffer[BUFFER_SIZE];
    socklen_t addr_len = sizeof(client_addr);

    // 创建套接字
    server_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_fd == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    // 设置地址和端口
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY; // 本地所有 IP
    server_addr.sin_port = htons(PORT);

    // 绑定地址
    if (bind(server_fd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("bind");
        exit(EXIT_FAILURE);
    }

    // 监听连接
    listen(server_fd, 5);
    printf("服务端监听中，端口 %d...\n", PORT);

    // 接受客户端连接
    client_fd = accept(server_fd, (struct sockaddr*)&client_addr, &addr_len);
    if (client_fd < 0) {
        perror("accept");
        exit(EXIT_FAILURE);
    }

    printf("客户端已连接：%s\n", inet_ntoa(client_addr.sin_addr));

    // 接收数据
    memset(buffer, 0, BUFFER_SIZE);
    read(client_fd, buffer, BUFFER_SIZE);
    printf("接收到客户端消息：%s\n", buffer);

    // 发送回应
    char* reply = "你好，客户端！";
    write(client_fd, reply, strlen(reply));

    // 关闭连接
    close(client_fd);
    close(server_fd);
    return 0;
}
```



## 客户端代码

```c showLineNumbers title="client.c"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>

#define SERVER_IP "127.0.0.1"
#define PORT 8888
#define BUFFER_SIZE 1024

int main() {
    int sock_fd;
    struct sockaddr_in server_addr;
    char buffer[BUFFER_SIZE];

    // 创建套接字
    sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (sock_fd == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    // 设置服务端地址
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    inet_pton(AF_INET, SERVER_IP, &server_addr.sin_addr);

    // 连接服务端
    if (connect(sock_fd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("connect");
        exit(EXIT_FAILURE);
    }

    // 发送数据
    char* message = "你好，服务端！";
    write(sock_fd, message, strlen(message));

    // 接收回应
    memset(buffer, 0, BUFFER_SIZE);
    read(sock_fd, buffer, BUFFER_SIZE);
    printf("接收到服务端回应：%s\n", buffer);

    // 关闭连接
    close(sock_fd);
    return 0;
}
```



## 编译与运行

你可以使用以下命令分别编译服务端和客户端程序：

```bash
gcc server.c -o server
gcc client.c -o client
```

然后分别在两个终端中运行：

**终端 1（服务端）**

```bash
./server
```

**终端 2（客户端）**

```bash
./client
```

你应该能看到服务端打印了客户端的消息，而客户端收到了服务端的回应。



## 小结

本文通过一个完整的示例，带你了解了如何在 Linux 下用 C 语言实现 TCP 通信。你学到了：

- 服务端和客户端的基础流程。
- 如何使用 `socket`、`bind`、`listen`、`accept`、`connect` 等系统调用。
- 基本的网络地址设置和数据发送/接收操作。
