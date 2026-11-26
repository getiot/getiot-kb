---
sidebar_position: 23
sidebar_label: Linux UDP 通信示例
authors: [luhuadong]
---

# Linux UDP socket 通信示例

前面你已经了解了 UDP 协议的基本原理和特点。这一节我们就来实战一下，手动写出 UDP 的客户端和服务端程序，掌握 UDP 通信在 Linux 下的实际用法。



## UDP 通信模型回顾

UDP 是无连接的，因此服务端不需要像 TCP 那样 `listen()` 和 `accept()`，客户端也无需 `connect()`，双方可以通过 `sendto()` 和 `recvfrom()` 实现互发数据。

UDP 是一种面向无连接的 Socket 通信方式，和 TCP 传输数据流不同，UDP 传输的是数据包。由于 UDP 不需要事先在通信双方之间建立连接，因此也弱化了客户端（Client）和服务端（Server）的概念，把它们称为接收端和发送端更为合适。

在下面的示例中，我们将创建两个 UDP 程序，暂时仍称为 UDP Server 和 UDP Client，它们的工作流程如下所示。

**UDP 服务端（Server）：**

1. 创建一个 UDP socket
2. 将 socket 与本机的 IP 地址绑定
3. 等待客户端发送数据包（datagram packet）
4. 处理数据包并给客户端发送一个回复
5. 回到第 3 步循环

**UDP 客户端（Client）：**

1. 创建一个 UDP socket.
2. 给服务端发送一条消息
3. 等待服务端的回复
4. 处理回复后回到第 2 步（如果需要）
5. 关闭 socket，退出程序



## UDP 完整示例代码

### UDP 服务端

你可以先创建一个简单的服务端程序，监听某个端口，接收客户端发来的消息：

```c showLineNumbers title="udp_server.c"
// udp_server.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 12345
#define BUF_SIZE 1024

int main() {
    int sockfd;
    char buffer[BUF_SIZE];
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);

    // 创建 UDP 套接字
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // 设置服务器地址
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(PORT);

    // 绑定地址
    if (bind(sockfd, (const struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        perror("bind failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("UDP 服务端已启动，监听端口 %d...\n", PORT);

    while (1) {
        int n = recvfrom(sockfd, buffer, BUF_SIZE - 1, 0,
                         (struct sockaddr *)&client_addr, &client_len);
        buffer[n] = '\0';
        printf("收到来自客户端的消息：%s\n", buffer);

        // 回复客户端
        sendto(sockfd, "收到消息", strlen("收到消息"), 0,
               (struct sockaddr *)&client_addr, client_len);
    }

    close(sockfd);
    return 0;
}
```



### UDP 客户端

然后写一个简单的客户端，向服务端发送消息并接收回应：

```c showLineNumbers title="udp_client.c"
// udp_client.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 12345
#define BUF_SIZE 1024

int main() {
    int sockfd;
    char buffer[BUF_SIZE];
    struct sockaddr_in server_addr;

    // 创建 UDP 套接字
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }

    // 设置服务器地址
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");

    // 发送消息
    const char *msg = "你好，UDP 服务器！";
    sendto(sockfd, msg, strlen(msg), 0,
           (const struct sockaddr *)&server_addr, sizeof(server_addr));

    // 接收回应
    socklen_t len = sizeof(server_addr);
    int n = recvfrom(sockfd, buffer, BUF_SIZE - 1, 0,
                     (struct sockaddr *)&server_addr, &len);
    buffer[n] = '\0';
    printf("收到服务器回应：%s\n", buffer);

    close(sockfd);
    return 0;
}
```



## 编译和运行

**方式一：编写 Makefile 文件**

```makefile
all:
	gcc udp_server.c -o udp_server
	gcc udp_client.c -o udp_client

.PHONY: clean
clean:
	rm udp_server udp_client
```

现在可以执行 `make` 命令编译代码

```bash
$ make
gcc udp_server.c -o udp_server
gcc udp_client.c -o udp_client
```

**方式二：编写 CMakeLists.txt 文件**

```c showLineNumbersmake
cmake_minimum_required(VERSION 3.0.2)

project(UDP_Example VERSION 1.0.0)

add_executable(udp_server udp_server.c)
add_executable(udp_client udp_client.c)
```

新建一个 build 目录，然后通过 `cmake` 和 `make` 命令编译代码

```bash
$ mkdir build
$ cd build
$ cmake ..
$ make
```

编译完成后，先运行 UDP 服务端（保持运行）：

```bash
$ ./udp_server 
```

再运行 UDP 客户端：

```bash
$ ./udp_client
```

你会看到服务端输出接收到的消息，客户端收到回复。



## API 说明

- [recvfrom](https://getiot.tech/manual/linux-c-functions/network.html#recvfrom)
- [sendto](https://getiot.tech/manual/linux-c-functions/network.html#sendto)



## 小结

通过本文你学会了：

- 如何使用 `socket()`、`bind()`、`sendto()` 和 `recvfrom()` 创建 UDP 服务端与客户端。
- UDP 的通信流程不需要建立连接，适合快速、一对多、轻量的通信场景。
- 使用 C 语言和 POSIX API 可以方便地在 Linux 下实现 UDP 网络通信。

后续你可以试试加入多线程、非阻塞 IO 或使用 `select()`、`poll()` 等方式让你的服务端更强大。
