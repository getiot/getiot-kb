---
sidebar_position: 48
slug: /tcp-udp-test-tools
---

# TCP/UDP 测试工具

本文收集一些好用的 TCP/UDP 测试工具，包括 Windows、Linux、macOS 等系统平台。



## TCP&UDP测试工具

没错，这个工具就叫「TCP&UDP测试工具」，是一款运行在 Windows 平台的 TCP/UDP 测试软件。主要用于测试 TCP 和 UDP 发送和接收，可把接收到的数据实时保存到本地文件。

![TCP&UDP测试工具](https://static.getiot.tech/windows-tcp-udp-tool.jpg#center)

TCP&UDP测试工具支持以下功能：

- 支持 TCP 协议发送和接收数据；
- 支持服务器模式和客户端模式（服务器模式主要用于测试 TCP 接收，客户端主要用于 TCP 主动请求）；
- 支持多连接，可同时对多路网络连接进行操作；
- 支持 UDP 和 UDP 广播方式发送和接收；
- 支持十六进制发送和接收方式。

👉【[下载地址](http://www.downza.cn/soft/297268.html)】



## ZapNet

ZapNet 是一个使用 Python 编写的高性能 TCP/UDP 网络测试诊断工具包，提供 TCP/UDP 服务端/客户端测试功能，支持UDP 广播，支持 UTF-8 和十六进制显示，具有良好的命令行交互界面，以及流量分析统计。

使用 pip 命令安装：

```bash
pip install zapnet
```

使用示例：

```bash
# 启动 TCP 服务端
zapnet tcp server --port 5555

# 新终端运行 TCP 客户端测试
zapnet tcp client --host 127.0.0.1 --port 5555 --data "Hello, World"
```

👉【[GitHub 地址](https://github.com/luhuadong/zapnet)】



## iperf

一个跨平台的 TCP 和 UDP 带宽测量工具，可以测试带宽、延迟和数据包损失等。

使用方法可以参考：

- [iperf 命令](/linux-command/iperf/)
- [Ubuntu 安装 Jperf 工具](/ubuntu/ubuntu-jperf/)
- [Linux 网络性能测试方法](/linux-note/linux-network-performance-testing/)

👉【[下载地址](https://iperf.fr)】



## Netcat

Netcat 又称为 nc，是一个功能强大的网络工具，可以用于 TCP 和 UDP 连接的创建、数据传输和端口扫描等。使用方法可以参考《[netcat 命令](/linux-command/netcat/)》。



## TCPing

一种简单易用的工具，可以测试 TCP 连接是否可用，包括端口开放性、延迟和丢包率等信息。

👉【[下载地址](https://www.elifulkerson.com/projects/tcping.php)】



## Nping

类似于 TCPing，是一个网络探测工具，可以测试 TCP 和 UDP 端口的开放性，还可以进行 Ping 测试等。

👉【[下载地址](https://nmap.org/nping/)】



## hping

一个灵活的网络测试工具，可以发送自定义的 TCP、UDP、ICMP 和 RAW IP 数据包，还可以进行端口扫描、防火墙测试和 DoS 攻击测试等。

👉【[下载地址](http://wiki.hping.org)】



<!--

---



## xcap



## SocketTest

一个 **java** 写的 **socket** 测试工具。它可以创建 **TCP** 和 **UDP** 客户端或服务器。它可以用来测试的任何使用 **TCP** 或 **UDP** 协议进行通信的服务器或客户端。

由于是 **java** 写的所以可以跨平台使用。注意：如果是在 **MacOS** 下使用，开启的监听端口要大于 **1024**。否则会报 **Permission denied** 错误。



**sokit**

**sokit** 是一个在 **windows** 平台下免费的 **TCP/UDP** 测试（调试）工具， 可以用来接收，发送或转发 **TCP/UDP** 数据包。

它有三种工作模式： 服务器模式、客户端模式、转发器模式。

支持发送 **ascii** 字符串数据，以及十六进制表示的原始字节，单次发送的字符数目没有限制；收到的数据会同时以这两种形式显示。



**Hercules SETUP utility**

同样是一个 **windows** 平台下的 **socket** 测试工具。工具包括了串口终端（**RS-485** 或 **RS-232** 终端），**UDP/IP** 终端，**TCP/IP** 客户或服务器终端。



## NetAssist



## Packet Sender

Packet Sender 是一个开源的发送和接收TCP/UDP包得测试工具。主线分支官方支持Windows，Mac和Ubuntu桌面Linux（开源），同时提供 Android 版本（免费）。网络应用程序调试/测试必备！

-->
