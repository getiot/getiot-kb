---
sidebar_label: netcat 命令
sidebar_position: 28
slug: /netcat
---

# netcat 命令 - 多功能网络工具



## 介绍

**`netcat`**（别名：**`nc`**）是 Linux 下的一个多功能的网络工具，可用于与 TCP 或 UDP 相关的各种任务，例如创建连接和侦听、执行端口扫描，以及处理 IPv4 和 IPv6 等。与 [telnet](/linux-command/telnet) 不同，netcat 可以精细地编写脚本，并将错误消息分隔到标准错误中，而不是将错误消息发送到标准输出。

netcat 命令通常用于以下任务：

- 简单 TCP 代理
- 基于 HTTP 客户机和服务器的 shell 脚本
- 网络守护进程测试
- 适用于 [ssh](/linux-command/ssh) 的 SOCKS 或 HTTP `ProxyCommand`

netcat/nc 命令由 netcat 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install netcat
```

**语法**：

```bash
nc [-46bCDdFhklNnrStUuvZz] [-I length] [-i interval] [-M ttl] [-m minttl] [-O length] [-P proxy_username]
        [-p source_port] [-q seconds] [-s source] [-T keyword] [-V rtable] [-W recvlimit] [-w timeout] [-X proxy_protocol]
        [-x proxy_address[:port]] [destination] [port]
```

**选项**：

- `-4`：强制 `nc` 仅使用 IPv4 地址。

- `-6`：强制 `nc` 仅使用 IPv6 地址。

- `-b bufsize`：为读取操作指定缓冲区大小。缺省值为 `1024` 字节。

- `-D`：启用对套接字的调试。

- `-d`：不尝试从 `stdin` 进行读取。

- `-E`：使用独占绑定来侦听 TCP 或 UDP 套接字。在没有 `-l` 选项的情况下单独使用此选项是错误的。此选项与 `-U` 选项结合使用时，不会产生任何影响。

- `-e program`：接受连接或建立连接之后执行外部程序。在执行之前，`stdin`, `stdout`, `stderr` 会重定向到网络描述符。仅有一个端口可供该选项使用。此选项与 `-R`、`-k` 或 `-i` 选项结合使用是错误的。

- `-F`：在 `stdin` 上看到 `EOF` 后，不要关闭网络套接字以进行写入。

- `-h`：输出 `nc` 帮助。

- `-I bufsize`：设置接收（输入）套接字缓冲区大小。此选项与 `-U` 选项结合使用时，不会产生任何影响。

- `-i interval`：指定发送和接收的文本行之间的延迟时间 interval。以秒为单位指定时间间隔，可能包含小数。此选项还会导致与多个端口的连接之间产生延迟时间，因而也会影响端口扫描模式。

- `-k`：强制 `nc` 在其当前连接关闭后侦听另一连接。在没有 `-l` 选项的情况下单独使用此选项是错误的。此选项与 `-e` 选项结合使用是错误的。

- `-L timeout`：在关闭时逗留（Linger on close）－在网络描述符关闭后直到指定的超时时间（以秒为单位），等待消息发送。

- `-l`：侦听传入连接，而不是启动到远程主机的连接。此选项与 `-s` 或 `-z` 选项结合使用是错误的。如果 `-l` 选项与通配符套接字（未指定任何 IP 地址或主机名）一起使用，但不与 `-4/-6` 选项一起使用，则既可接受 IPv4 连接也可接受 IPv6 连接。

- `-m byte_count`：接收至少 `byte_count` 字节后退出。当与 `-l` 选项结合使用时，`byte_count` 会与从客户机接收的字节数进行比较。`byte_count` 必须大于 `0`，而小于 `INT_MAX`。

- `-N file`：在 UDP 端口扫描模式下指定文件。此文件的内容用作每个发出的 UDP 包的有效载荷。在没有 `-u` 和 `-z` 选项的情况下单独使用此选项是错误的。

- `-n`：不对任何地址、主机名或端口执行任何命名或服务查找操作。使用此选项意味着 hostname 和 port 参数被限制为数字值。除了对参数施加限制外，与 `-v` 选项一起使用时，所有地址和端口都将以数字形式输出。此选项与 `-U` 选项结合使用时，不会产生任何影响。

- `-O bufsize`：设置发送（输出）套接字缓冲区大小。此选项与 `-U` 选项结合使用时，不会产生任何影响。

- `-P proxy_username`：指定提供给要求验证的代理服务器的一个用户名（proxy_username）。如果未指定 proxy_username，则不会尝试进行验证。目前仅 `HTTP CONNECT` 代理支持代理验证。此选项与 `-l` 选项结合使用是错误的。

- `-p port`：未与 `-l` 选项结合使用时，根据特权限制和可用性指定 `nc` 应使用的源端口。与 `-l` 选项结合使用时，设置侦听端口。仅当未指定全局端口参数时，此选项可与 `-l` 选项结合使用。

- `-q timeout`：在 `stdin` 上接收到 `EOF` 后，等待指定的秒数，然后退出。

- `-R addr/port[/proto]`：对指定的 host 和 port 执行端口重定向。接受连接后，`nc` 会连接到远程 host/port，并在客户机与远程主机之间传递所有数据。重定向规范的 proto（协议）部分可以是 `tcp` 或 `udp`。如果未指定 proto，`redirector` 将使用与服务器相同的协议。此选项与 `-z` 选项结合使用是错误的。

- `-r`：在由 port_list 参数指定的所有端口中随机（而非按顺序）选择目标端口。此选项与 `-l` 选项结合使用是错误的。

- `-s source_ip_address`：指定用于发送数据包的接口的 IP。此选项与 `-l` 选项结合使用是错误的。

- `-S sla-prop`：指定为套接字创建的 MAC 流的属性。sla-prop 以属性的 'name=value' 逗号分隔列表的形式提供。当前支持的属性名称为 `maxbw`、`priority` 和 `inherit`。`maxbw` 和 `priority` 来自 flowadm(1M) 中定义的属性，表示流的最大带宽和优先级。`maxbw` 的允许值为整数加上可选的后缀（缺省为 Mega）。`priority` 的值可以为 'high'、'medium' 和 'low'。在创建流时，必须至少指定 `maxbw` 和 `priority` 之一。`inherit` 的值可以为 'on' 和 'off'，缺省值为 'off'。缺省情况下，接受的/新的套接字（由 accept 返回）不会继承侦听器套接字的属性。当将其设置为 'on' 时，新的套接字将继承侦听器套接字的属性。当需要对新套接字实施属性时，这对于 `-l` 选项很有用。此选项需要 `SYS_FLOW_CONFIG` 特权。此选项还要求指定 IP 地址或主机名。

- `-T dscp`：为连接指定区分服务代码点。对于 IPv4，此选项指定 IP 服务类型（Type of Service, ToS）IP 标题字段，参数的有效值为字符串标记 `lowdelay`、`throughput`、`reliability` 或前面带有 `0x` 的 8 位十六进制值。对于 IPv6（通信流量类），只能使用十六进制值。

- `-t`：使 `nc` 将 *RFC 854* `DON'T` 和 `WON'T` 响应发送到 *RFC 854* `DO` 及 `WILL` 请求。这样就可以使用 `nc` 编写 `telnet` 会话脚本。

- `-U`：指定使用 Unix 域套接字。如果不与 `-l`、`nc` 一起指定此选项，则它将变成 `AF_UNIX` 客户机。如果与 `-l` 选项一起指定此选项，则会创建 `AF_UNIX` 服务器。使用此选项要求必须向 `nc` 提供单个有效的 Unix 域路径参数，而不是提供主机名或端口。

- `-u`：使用 UDP，而不是缺省选项 TCP。

- `-v`：指定详细输出。

- `-w timeout`：如果连接和 `stdin` 空闲超过了 timeout 秒，则无提示地关闭连接。缺省设置是没有超时。此选项对客户机模式下的连接建立阶段或服务器模式下的等待连接过程没有任何影响。

- `-X proxy_protocol`：与代理服务器通信时，使用该指定协议。受支持的协议为 `4`（SOCKS v.4）、`5`（SOCKS v.5）和 `connect`（HTTP 代理）。如果未指定协议，则使用 SOCKS v. 5。此选项与 `-l` 选项结合使用是错误的。

- `-x proxy_address[:port]`：使用 proxy_address 和 port 上的代理请求到 hostname 的连接。如果未指定 port，则使用代理协议的已知端口（SOCKS 为 1080，HTTP 为 3128）。此选项与 `-l` 选项结合使用是错误的。此选项不适用于 IPv6 地址的数字表示形式。

- `-Z`：在侦听模式下，使用 `SO_ALLZONES` 套接字选项绑定到所有区域中的地址/端口。此选项需要 `SYS_NET_CONFIG` 特权。

- `-z`：执行端口扫描。对于 TCP 端口（缺省），尝试在不发送数据的情况下执行连接扫描（完整三路信号握手）。对于 UDP（`-u`），缺省情况下会发送空 UDP 包。要指定 UDP 有效载荷，可以使用 `-N` 选项。UDP 扫描模式具有估计能力，如果它没有接收到否定响应（"ICMP Destination Port Unreachable"（无法访问 ICMP 目标端口）消息），它会考虑打开一个端口。对于这种模式，使用 `-w` 选项设置的超时时间将用来等待来自远程节点的 ICMP 消息或数据。通过 `-v`，接收到的任何数据都会作为十六进制字节转储到 `stderr`。由于大多数操作系统会限制发送 ICMP 消息（以响应输入包）的速率，所以有必要在执行 UDP 扫描时使用 `-i`，否则结果会不可靠。此选项与 `-l` 选项结合使用是错误的。

**参数**：

- `hostname` 指定主机名。

  hostname 可以是数字 IP 地址或者符号主机名（除非已指定 `-n` 选项）。通常，除非已指定 `-l` 选项或者使用了 `-U`（在此情况下，参数是一个路径），否则必须指定 hostname。如果随 `-l` 选项指定了 hostname 参数，则还必须给定 port 参数，并且 `nc` 会尝试绑定到该地址和端口。如果没有随 `-l` 选项指定 hostname 参数，则 `nc` 会尝试在给定 port 的通配符套接字上侦听。

- `path` 指定路径名。

- `port <port_list>` 指定端口。

  `port_list` 可以指定为单个整数、范围或两者的组合。请以 `nn-mm` 形式指定范围。`port_list` 至少必须有一个成员，但可以有多个以逗号分隔的端口/范围。

  通常，除非已指定 `-U` 选项（在此情况下，必须指定 Unix 域套接字路径，而不指定 hostname），否则必须指定目标端口。

  将包含多个端口的端口列表与 `-e` 选项结合使用是错误的。



## 示例

打开到 `host.example.com` 的端口 42 的 TCP 连接，使用端口 3141 作为源端口，超时为 5 秒：

```bash
nc -p 3141 -w 5 host.example.com 42
```

打开到 `host.example.com` 的端口 7777 的 TCP 连接，对套接字设置最大 50Mbps 的带宽：

```bash
nc -M maxbw=50M host.example.com 7777
```

打开到 `host.example.com` 的端口 53 的 UDP 连接：

```bash
nc -u host.example.com 53
```

打开到 `host.example.com` 的端口 42 的 TCP 连接，使用 `10.1.2.3` 作为连接的本地端的 IP：

```bash
nc -s 10.1.2.3 host.example.com 42
```

将一个包含端口和端口范围的列表用于针对各种端口的端口扫描：

```bash
nc -z host.example.com 21-25,53,80,110-120,443
```

在某个 Unix 域套接字上创建连接并侦听：

```bash
nc -lU /var/tmp/dsocket
```

在关联端口为 8888 的 UDP 套接字上创建连接并侦听：

```bash
nc -u -l -p 8888
```

这等效于：

```bash
nc -u -l 8888
```

在关联端口为 2222 的 TCP 套接字上创建连接并侦听，并且只绑定到地址 `127.0.0.1`：

```bash
nc -l 127.0.0.1 2222
```

在关联端口 2222 上创建 TCP 套接字并进行侦听，并在侦听器和连接的套接字上创建高优先级的 MAC 流：

```bash
nc -l -M priority=high,inherit=on host.example.com 2222
```



