---
sidebar_position: 1
slug: /dropbear
---

# Dropbear SSH



**Dropbear** 是由 Matt Johnston 开发的一款相对较小的 Secure Shell 开源软件（包括服务端与客户端），其目标是在存储器与运算能力有限的情况下取代 OpenSSH，尤其是嵌入式系统领域。它可以运行在各种基于 POSIX 的平台上，例如 Linux、macOS、FreeBSD、Solaris、Cygwin 等。

Dropbear 实现了 SSH 协议第二版（SSH-2），加密算法则是采用了其他第三方的实现。Dropbear 项目本身采用 MIT 许可证，但由于项目中还包含了多个不同来源的组件，因此涉及一些许可证和作者，这些组件的许可证将遵循源项目的许可。 

功能方面，Dropbear 实现了完整的 SSH-2 协议（包含了服务端与客户端），但因资源与安全性所以选择不实现 SSH-1 协议。从 2013.62 版后增加了对 ECC（椭圆曲线密码学）的支持。同时，Dropbear 也支持 SCP，而 SFTP 则需要通过其他程序支持。

- 项目主页：[https://matt.ucc.asn.au/dropbear/dropbear.html](https://matt.ucc.asn.au/dropbear/dropbear.html)
- 源码仓库：[https://github.com/mkj/dropbear](https://github.com/mkj/dropbear)

