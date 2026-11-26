---
sidebar_position: 24
authors: [luhuadong]
---

# Linux UDP 广播示例

在本篇文章中，你将学习如何使用 UDP 广播在局域网中发送消息。这种方式常用于设备发现、通知广播等场景。我们将使用 C 语言和标准 socket API，编写一个广播端和接收端程序。



## 什么是 UDP 广播？

UDP 广播是指向局域网内所有主机发送消息。它使用特定的广播地址（如 `255.255.255.255` 或子网广播地址 `192.168.1.255`），让同一网段的所有主机都有机会接收到消息。

:::tip 注意

你发送广播消息时，需要设置 `SO_BROADCAST` 套接字选项。

:::



## UDP 广播发送端示例

下面是一个简单的广播客户端程序：（完整示例代码：[GitHub](https://github.com/getiot/linux-c/tree/main/network/udp/broadcast)）

```c showLineNumbers title="udp_broadcast_sender.c" {17}
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define BROADCAST_PORT 12345

int main() {
    int sockfd;
    struct sockaddr_in broadcast_addr;
    const char *msg = "Hello, Broadcast World!";

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);

    // 启用广播选项
    int broadcastEnable = 1;
    setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadcastEnable, sizeof(broadcastEnable));

    memset(&broadcast_addr, 0, sizeof(broadcast_addr));
    broadcast_addr.sin_family = AF_INET;
    broadcast_addr.sin_port = htons(BROADCAST_PORT);
    broadcast_addr.sin_addr.s_addr = inet_addr("255.255.255.255");  // 广播地址

    sendto(sockfd, msg, strlen(msg), 0, (struct sockaddr *)&broadcast_addr, sizeof(broadcast_addr));
    printf("广播消息已发送：%s\n", msg);

    close(sockfd);
    return 0;
}
```



## UDP 广播接收端示例

然后创建一个监听广播的服务端程序：

```c showLineNumbers title="udp_broadcast_receiver.c"
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define PORT 12345
#define BUF_SIZE 1024

int main() {
    int sockfd;
    struct sockaddr_in server_addr;
    char buffer[BUF_SIZE];

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);

    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = INADDR_ANY; // 接收所有地址发来的消息

    bind(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr));
    printf("等待接收广播消息...\n");

    while (1) {
        int n = recvfrom(sockfd, buffer, BUF_SIZE - 1, 0, NULL, NULL);
        buffer[n] = '\0';
        printf("接收到广播消息：%s\n", buffer);
    }

    close(sockfd);
    return 0;
}
```



## 编译和运行

编译命令如下：

```bash
gcc udp_broadcast_sender.c -o sender
gcc udp_broadcast_receiver.c -o receiver
```

首先在终端中运行接收端：

```bash
./receiver
```

再运行发送端：

```bash
./sender
```

你应该能在接收端看到接收到的广播消息。



## 注意事项

- 广播地址应与你的本地网络环境匹配，`255.255.255.255` 是通配广播地址，有时会被路由器屏蔽。
- 某些 Linux 系统需开启网卡支持广播，或关闭防火墙阻拦。
- 广播适合在同一子网内通信，跨网段通信一般使用多播或 TCP。



## 小结

通过本文你学会了：

- 使用 `SO_BROADCAST` 启用 UDP 广播；
- 向广播地址发送消息；
- 创建服务端接收 UDP 广播消息；
- 在局域网中实现一对多消息通知机制。

UDP 广播是局域网自动发现服务、局部通知等非常实用的技术，简单高效，适合快速通信场景。



