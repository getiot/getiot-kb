---
sidebar_position: 26
authors: [luhuadong]
---

# Linux 获取 socket 信息

在网络编程中，有时候你需要了解当前 socket 的状态、配置，或者获取某个网络接口的详细信息，比如 IP 地址、MAC 地址、接口状态等。幸运的是，Linux 提供了两个强大的系统调用：`getsockopt()` 和 `ioctl()`，你可以通过它们来查询这些信息。

本文将教你如何使用这两个函数，并给出对应的示例，帮你轻松掌握获取 socket 信息的方法。



## getsockopt 函数

### 函数原型

```c
int getsockopt(int sockfd, int level, int optname, void *optval, socklen_t *optlen);
```

- `sockfd`：套接字描述符；
- `level`：协议层，一般为 `SOL_SOCKET`；
- `optname`：要获取的选项名，如 `SO_TYPE`、`SO_ERROR` 等；
- `optval`：用于保存结果的缓冲区；
- `optlen`：`optval` 缓冲区的长度，函数返回时会被实际写入的长度替代。

### 常用选项

| 选项名         | 含义                    |
| -------------- | ----------------------- |
| `SO_TYPE`      | 套接字类型（流/数据报） |
| `SO_ERROR`     | 最近发生的错误          |
| `SO_RCVBUF`    | 接收缓冲区大小          |
| `SO_SNDBUF`    | 发送缓冲区大小          |
| `SO_REUSEADDR` | 地址复用标志            |

### 示例：获取 socket 类型

```c showLineNumbers
int type;
socklen_t len = sizeof(type);
getsockopt(sockfd, SOL_SOCKET, SO_TYPE, &type, &len);
printf("Socket 类型: %s\n", (type == SOCK_STREAM) ? "SOCK_STREAM" : "SOCK_DGRAM");
```



## ioctl 函数

`ioctl` 是一个多功能的系统调用，主要用于设备控制，但在网络中你也可以用它来获取或设置网络接口的信息。

### 函数原型

```c
int ioctl(int fd, unsigned long request, ...);
```

- `fd`：套接字描述符；
- `request`：请求命令；
- 后面是一个变参，通常是指向 `ifreq` 结构的指针。

### 常用命令（网络相关）

| 命令            | 含义                        |
| --------------- | --------------------------- |
| `SIOCGIFADDR`   | 获取接口 IP 地址            |
| `SIOCGIFHWADDR` | 获取接口 MAC 地址           |
| `SIOCGIFFLAGS`  | 获取接口状态（UP、RUNNING） |
| `SIOCGIFMTU`    | 获取接口 MTU                |

### 示例：获取本地网卡 IP 地址

```c showLineNumbers
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <unistd.h>

int main() {
    int sockfd;
    struct ifreq ifr;

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    strncpy(ifr.ifr_name, "eth0", IFNAMSIZ);  // 替换成你自己的接口名

    if (ioctl(sockfd, SIOCGIFADDR, &ifr) == 0) {
        struct sockaddr_in *ipaddr = (struct sockaddr_in*)&ifr.ifr_addr;
        printf("eth0 IP 地址: %s\n", inet_ntoa(ipaddr->sin_addr));
    } else {
        perror("ioctl");
    }

    close(sockfd);
    return 0;
}
```



## 更多 ioctl 示例

### 获取 MAC 地址

```c showLineNumbers
if (ioctl(sockfd, SIOCGIFHWADDR, &ifr) == 0) {
    unsigned char *mac = (unsigned char *)ifr.ifr_hwaddr.sa_data;
    printf("eth0 MAC 地址: %02x:%02x:%02x:%02x:%02x:%02x\n",
           mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
}
```

### 获取接口状态（是否 UP）

```c showLineNumbers
if (ioctl(sockfd, SIOCGIFFLAGS, &ifr) == 0) {
    if (ifr.ifr_flags & IFF_UP) {
        printf("接口已启动\n");
    } else {
        printf("接口未启动\n");
    }
}
```



## 小结

在这篇文章中，你学会了：

- 如何使用 `getsockopt` 获取 socket 的状态与配置；
- 如何使用 `ioctl` 获取网络接口的信息，如 IP、MAC、状态等；
- 掌握了 socket 编程中常见的两种系统接口，用于提升你的网络通信程序的功能性和健壮性。

下一次你需要动态获取网卡信息或调试 socket 状态时，不妨试试这些方法。它们是你写出更复杂网络工具的基础！

 
