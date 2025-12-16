---
sidebar_position: 20
slug: /quagga
---

# Quagga 路由软件包



Quagga 中文翻译斑驴，是一种先进的路由软件包，提供一套基于 TCP/IP 的路由协议。

实际上，Quagga 是 [GNU Zebra](/foss/zebra/) 的一个分支，它为类 Unix 平台提供了所有主流路由协议的实现，例如开放最短路径优先（OSPF），路由信息协议（RIP），边界网关协议（BGP）和中间系统到中间系统协议（IS-IS）。尽管 Quagga 实现了 IPv4 和 IPv6 的路由协议，但它并不是一个完整的路由器。一个真正的路由器不仅实现了所有路由协议，而且还有转发网络流量的能力。 Quagga 仅仅实现了路由协议栈，而转发网络流量的工作则由 Linux 内核处理。

![](https://static.getiot.tech/quagga-logo.png#center)

Quagga 通过特定协议的守护程序实现不同的路由协议。守护程序名称与路由协议相同，加了字母“d”作为后缀。Zebra 是核心，也是与协议无关的守护进程，它为内核提供了一个抽象层，并通过 TCP 套接字向 Quagga 客户端提供 Zserv API。每个特定协议的守护程序负责运行相关的协议，并基于交换的信息来建立路由表。

```shell
+----+  +----+  +-----+  +-----+
|bgpd|  |ripd|  |ospfd|  |zebra|
+----+  +----+  +-----+  +-----+
                            |
+---------------------------|--+
|                           v  |
|  UNIX Kernel  routing table  |
|                              |
+------------------------------+

    Quagga System Architecture
```

Quagga 的架构如上图所示：

- ripd，负责处理 RIP 协议
- ospfd，负责处理 ospf v2 协议
- bgpd，负责处理 BGP v4 协议
- zebra，作为内核路由表管理器

其他守护进程：

- ripngd
- ospf6d



## 参考

- [Quagga Software Routing Suite](https://www.quagga.net/)
- [如何实现基于Linux的路由之Quagga？ – cmdSchool](https://www.cmdschool.org/archives/1220)
- [在 Linux 上使用开源软件创建 SDN | Linux 中国 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/139170224)
