---
sidebar_position: 0
slug: /rust-network-programming-intro
---

# 网络编程简介

网络编程的核心是让不同进程通过网络交换数据。Rust 标准库提供了 TCP、UDP、IP 地址等基础能力，更高级的 HTTP、WebSocket、MQTT 通常使用第三方 crate。

## 你需要先理解什么

开始写网络程序前，至少要知道：

- IP 地址用来定位主机
- Port 用来定位主机上的进程
- TCP 是面向连接的字节流
- UDP 是无连接的数据报
- Client 主动连接，Server 监听请求

## Rust 的网络模块

标准库网络能力在 `std::net` 中，常用类型包括：

- `TcpListener`：监听 TCP 连接
- `TcpStream`：读写 TCP 连接
- `UdpSocket`：发送和接收 UDP 数据报
- `IpAddr`、`SocketAddr`：表示地址

## 同步和异步

标准库的 TCP/UDP API 主要是同步阻塞模型。它简单直观，适合初学者理解网络基本过程。

当你需要同时处理大量连接时，可以学习 async/await 和 Tokio。异步不是网络编程的起点，而是规模变大后的工具。

## 小结

本章会先从地址、TCP、UDP 开始，再进入 HTTP、JSON 和异步编程。你先把“连接、监听、读写、错误处理”这些动作想清楚，后面学框架就容易多了。

