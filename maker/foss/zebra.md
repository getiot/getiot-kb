---
sidebar_position: 27
slug: /zebra
---

# Zebra 开源路由软件



[GNU Zebra](https://www.gnu.org/software/zebra/) 是一个多服务器路由软件，它提供基于 TCP/IP 的路由协议。Zebra 能将你的机器变成一台全功能的路由器。

Zebra 开源路由软件，结构清晰、架构简洁。不过，到 2005 年发行 zebra-0.95a 之后便停止更新。后来修改版本将 zebra 作为守护进程，发行新的版本改名 Quagga，由 savannah.gnu.org 这个组织维护。

Zebra 的整体架构如下：

![](https://static.getiot.tech/gnu-zebra-overview.png#center)

Zebra 支持如下一些特性：

- 支持 RIP、OSPF、BGP 等常见路由协议；
- 支持 RIPng 和 BGP-4+ 等 IPv6 路由协议；
- 用户可以从终端界面（命令行接口）动态更改配置；
- 用户可以在终端界面中使用命令行补全和历史记录；
- 支持基于 IP 地址的过滤、基于 AS 路径的过滤、通过路由映射修改属性。

Zebra 支持以下系统平台：

- GNU/Linux
- FreeBSD
- NetBSD
- OpenBSD

Zebra 可在以下通用 IPv6 协议栈上运行：

- GNU/Linux 2.2 IPv6
- NRL IPv6
- KAME
- INRIA IPv6

有关 Zebra 的其他信息，请访问 [http://www.zebra.org](http://www.zebra.org)



## 参考

- [Zebra - GNU Project - Free Software Foundation](https://www.gnu.org/software/zebra/)
- [Zebra – multi-server routing software](http://www.zebra.org/)

