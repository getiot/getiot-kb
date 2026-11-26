---
sidebar_position: 28
authors: [luhuadong]
---

# Linux C 设置网卡参数

在实际开发中，你可能需要在程序中动态修改某个网卡的配置，例如设置 IP 地址、MAC 地址，或启用/关闭网卡。这在构建嵌入式设备、自动化运维工具或网络配置器时尤为常见。

在 Linux 下，你可以使用 `ioctl` 函数结合 `ifreq` 结构体，直接操作网络接口。本教程将带你了解如何通过 C 语言设置网卡参数。



## 准备工作：socket + ifreq

你需要一个原始的 socket，用于向内核发送控制命令。例如我们创建一个 UDP socket 接口：

```c
int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
```

在 Linux 中，`ifreq` 是一个用于描述网络接口配置的结构体，定义在 `<net/if.h>` 中。你可以通过它配合 `ioctl()` 系统调用读取或设置网卡的各种参数。

`ifreq` 的结构大致如下：

```c showLineNumbers
struct ifreq {
    char ifr_name[IFNAMSIZ]; // 网卡名称，例如 "eth0"
    union {
        struct sockaddr ifr_addr;       // IP 地址等信息
        struct sockaddr ifr_netmask;    // 子网掩码
        struct sockaddr ifr_hwaddr;     // MAC 地址
        struct sockaddr ifr_broadaddr;  // 广播地址
        short           ifr_flags;      // 启用/禁用标志（网卡状态）
        int             ifr_mtu;        // MTU（最大传输单元）
        unsigned char   ifr_hwaddr[14]; // MAC 地址
    };
};
```

注意：你必须首先填好 `ifr_name` 字段，再调用 `ioctl()` 传入不同的命令（如 `SIOCGIFADDR`、`SIOCSIFADDR` 等）来读取或设置。



## 设置 IP 地址

你可以使用 `SIOCSIFADDR` 命令来设置 IP 地址。例如：

```c showLineNumbers {20}
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <unistd.h>

void set_ip(const char* ifname, const char* ip_str) {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    struct ifreq ifr;
    struct sockaddr_in sa;

    strncpy(ifr.ifr_name, ifname, IFNAMSIZ);
    sa.sin_family = AF_INET;
    inet_pton(AF_INET, ip_str, &sa.sin_addr);

    memcpy(&ifr.ifr_addr, &sa, sizeof(struct sockaddr));
    if (ioctl(sockfd, SIOCSIFADDR, &ifr) < 0) {
        perror("设置 IP 失败");
    } else {
        printf("已成功设置 %s 的 IP 为 %s\n", ifname, ip_str);
    }

    close(sockfd);
}
```



## 设置子网掩码

你可以使用 `SIOCSIFNETMASK` 命令来设置子网掩码。例如：

```c showLineNumbers {5}
sa.sin_family = AF_INET;
inet_pton(AF_INET, "255.255.255.0", &sa.sin_addr);
memcpy(&ifr.ifr_netmask, &sa, sizeof(struct sockaddr));

if (ioctl(sockfd, SIOCSIFNETMASK, &ifr) < 0) {
    perror("设置子网掩码失败");
}
```



## 设置网卡状态（UP/DOWN）

你可以通过 `ifr_flags` 设置或清除标志位，如 `IFF_UP`：

```c showLineNumbers {4}
if (ioctl(sockfd, SIOCGIFFLAGS, &ifr) < 0) {
    perror("获取网卡状态失败");
}
ifr.ifr_flags |= IFF_UP; // 开启网卡
// ifr.ifr_flags &= ~IFF_UP; // 关闭网卡

if (ioctl(sockfd, SIOCSIFFLAGS, &ifr) < 0) {
    perror("设置网卡状态失败");
}
```

通过 `SIOCGIFFLAGS` 获取网卡状态，可以看到多个标志位组合，常见的有：

- `IFF_UP`：接口已启用。
- `IFF_RUNNING`：物理层设备正常工作。
- `IFF_BROADCAST`：支持广播。
- `IFF_LOOPBACK`：回环接口。
- `IFF_PROMISC`：混杂模式（接收所有流量）。
- `IFF_MULTICAST`：支持组播。



## 设置 MAC 地址

MAC（Media Access Control）地址是网络接口在局域网中的唯一标识，通常由 6 个字节组成，形如 `00:1A:2B:3C:4D:5E`。每块网卡都有一个全球唯一的 MAC 地址，通常存储在硬件中，你可以通过 `SIOCGIFHWADDR` 来获取它。例如：

```c showLineNumbers {6}
struct sockaddr *hwaddr = &ifr.ifr_hwaddr;
hwaddr->sa_family = ARPHRD_ETHER;
unsigned char new_mac[6] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
memcpy(hwaddr->sa_data, new_mac, 6);

if (ioctl(sockfd, SIOCSIFHWADDR, &ifr) < 0) {
    perror("设置 MAC 地址失败");
}
```

⚠️ 注意：设置 MAC 地址通常要求 root 权限。



## 设置 MTU

MTU 指最大传输单元，是网卡一次传输的最大数据长度，单位是字节。典型值为 1500 字节（以太网默认），如果你设置得过小，可能导致大量分片；过大又可能在某些链路中失败。

你可以通过 `SIOCGIFMTU` 和 `SIOCSIFMTU` 获取和设置。例如：

```c showLineNumbers {3}
ifr.ifr_mtu = 1400;

if (ioctl(sockfd, SIOCSIFMTU, &ifr) < 0) {
    perror("设置 MTU 失败");
}
```



## 小结

在本教程中，你学习了如何通过 `ioctl` 函数配合 `ifreq` 结构体设置：

- IP 地址（`SIOCSIFADDR`）
- 子网掩码（`SIOCSIFNETMASK`）
- 网卡启用/禁用（`SIOCSIFFLAGS`）
- MAC 地址（`SIOCSIFHWADDR`）
- MTU（`SIOCSIFMTU`）

通过掌握这些操作，你可以直接在 C 语言中编写网络配置工具。记得，大多数操作都需要 root 权限，运行前请确保使用 `sudo` 执行。
