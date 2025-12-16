---
sidebar_position: 19
slug: /frp
---

# FRP 反向代理



## 介绍

Frp 是一个可用于内网穿透的高性能的反向代理应用，支持 tcp, udp 协议，为 http 和 https 应用协议提供了额外的能力，且尝试性支持了点对点穿透。

GitHub 仓库：[https://github.com/fatedier/frp](https://github.com/fatedier/frp)

Frp 包括服务端 frps 和客户端 frpc 两部分。使用前需要将 frps 及 frps.ini 放到具有公网 IP 的机器上，将 frpc 及 frpc.ini 放到处于内网环境的机器上。frp 的工作原理及架构如下图所示。

![](https://static.getiot.tech/frp-working-diagram.png#center)



## 使用

### 使用 frp 反向代理访问内网树莓派

如果想从外网访问内网的树莓派，可以使用 SSH 反向隧道（Reverse Tunneling）技术。

首先，让树莓派主动向公网服务器的某个端口发起 SSH 连接，形成一个 SSH 隧道。当互联网上的其他电脑通过 SSH 连接到公网服务器的这一端口时，服务器会把通信内容接力到与树莓派 SSH 隧道中，从而达到私网穿透的目的。

![](https://static.getiot.tech/ssh-reverse-tunneling.jpg#center)

这种方式操作起来还有些繁琐，所以我们尝试使用 Frp 来达到这个目的。**下面以通过 ssh 访问内网树莓派为例进行说明。**

准备工作：

- 一台具有公网 IP 的服务器。
- 获取 frps 和 frpc 可执行文件，可以自行编译 frp 工程，也可以在 [releases 页面](https://github.com/fatedier/frp/releases) 下载对应平台的可执行文件。

步骤：

1. 将 frps 和 frps.ini 复制到服务器。修改 frps.ini 文件，这里使用了最简化的配置，设置了 frp 服务器端接收客户端流量的端口。

   ```ini
   # frps.ini
   [common]
   bind_port = 7000
   ```

2. 启动 frps。

   ```shell
   ./frps -c ./frps.ini
   ```

3. 将 frpc 和 frpc.ini 复制到树莓派。修改 frpc.ini 文件，假设 frps 所在服务器的公网 IP 为 x.x.x.x。

   ```ini
   # frpc.ini
   [common]
   server_addr = x.x.x.x
   server_port = 7000
   
   [ssh]
   type = tcp
   local_ip = 127.0.0.1
   local_port = 22
   remote_port = 6000
   ```

   注意，`local_port`（客户端侦听）和 `remote_port`（服务器端暴露）是用来出入 frp 系统的两端，`server_port` 则是服务器用来与客户端通讯的。

4. 启动 frpc。

   ```shell
   ./frpc -c ./frpc.ini
   ```

5. 在另一台机器上通过 ssh 访问内网的树莓派。

   ```shell
   ssh -oPort=6000 pi@x.x.x.x
   ```

OK，这样我们就可以在外网访问内网的树莓派啦！

当然，除了 ssh 穿透，frp 还有很多功能，比如 web、dns、Unix 域套接字、静态文件访问服务等，小伙伴们可以根据自己的需要进行探索～

