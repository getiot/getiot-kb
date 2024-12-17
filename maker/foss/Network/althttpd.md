---
sidebar_position: 3
slug: /althttpd
---

# Althttpd



## 项目简介

**Althttpd** 是一个开源、简单的 Web 服务器，目标是实现一个简单、安全和低资源使用率的 Web 服务。如果你阅读它的源代码，就会发现这个项目只有一个 althttpd.c 源文件。

Althttpd 的作者是大名鼎鼎的 SQLite 作者 [D. Richard Hipp](https://en.wikipedia.org/wiki/D._Richard_Hipp)，他是一个非常有个性的家伙，用到的软件工具都是自己写的。除了 SQLite 和 Althttpd，还有 Bug 追踪系统 CVSTrac、版本管理系统 Fossil 等等。

实际上，Althttpd 自 2004 年以来一直运行 [https://sqlite.org](https://sqlite.org) 网站。在 2018 年，这个网站每天要响应 50 万的 HTTP 请求，而只用了价值 40 美金的服务器，而且服务器处于很低的负载（0.1 或者 0.2），可以看出其性能还是不错的。

- 项目地址：[https://sqlite.org/althttpd](https://sqlite.org/althttpd/doc/trunk/althttpd.md)
- 作者主页：[http://www.hwaci.com/drh/](http://www.hwaci.com/drh/)



## 设计哲学

Althttpd 通常从 [xinetd](https://en.wikipedia.org/wiki/Xinetd) 或 [stunnel4](https://www.stunnel.org/) 启动。为每个进入的连接启动一个单独的进程，该进程完全专注于为该连接提供服务。单个 althttpd 进程将通过同一连接处理一个或多个 HTTP 请求。当连接关闭时，althttpd 进程退出。

当然，Althttpd 也可以独立运行。Althttpd 本身在端口 80 上监听进入的 HTTP 请求，然后 fork 一个自身的副本来处理每个入站连接。每个连接仍然使用单独的进程进行处理。唯一的区别是连接处理程序进程现在由主 althttpd 实例而不是由 xinetd 或 stunnel4 启动。

Althttpd 没有配置文件。所有配置都使用几个命令行参数处理。这有助于保持配置简单，并减少由于 Web 服务器的错误配置而引入安全漏洞的担忧。

Althttpd 本身并不处理 TLS 连接。对于 HTTPS，althttpd 依赖 stunnel4 来处理 TLS 协议协商、解密和加密。

因为每个 althttpd 进程只需要服务一个连接，所以 althttpd 是单线程的。此外，每个进程仅在单个连接期间存在，这意味着 althttpd 无需过多担心内存泄漏。这些设计因素有助于使 althttpd 源代码保持简单，从而便于安全审计和分析。



## 构建项目

Althttpd 的完整源代码包含在单个 C 文件中，且不依赖于标准 C 库之外的库。想要构建和安装 althttpd，只需要运行以下命令：

```bash
gcc -Os -o /usr/bin/althttpd althttpd.c
```

Althttpd 源代码有大量注释和可读性，它应该相对容易针对特殊需求进行定制。同时它也是一个很好的学习项目，有兴趣的朋友可以关注一下。

