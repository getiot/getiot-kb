---
sidebar_label: ping 命令
sidebar_position: 15
slug: /ping
---

# ping 命令



## 介绍

**ping** 是一个非常常用的计算机网络测试工具，用于测试数据包能否透过 IP 协议到达特定主机，从而判断网络的连通性。无论是 Linux、Windows、macOS 还是嵌入式 RTOS 都会提供 ping 命令。ping 的运作原理是向目标主机传出一个 ICMP 的请求回显数据包，并等待接收回显回应数据包。程序会按时间和成功响应的次数估算丢失数据包率（丢包率）和数据包往返时间（网络时延，Round-trip delay time）。

**语法**：

```bash
ping [options] <destination>
```

**选项**：

- `<destination>`：IP 地址或 DNS 域名。
- `-a`：使用听得见的（audible）ping。
- `-A`：使用自适应（adaptive）ping。
- `-B`：粘性源地址（sticky source address）。
- `-c <count>`：在 `<count>` 个回复后停止。
- `-D`：打印时间戳。
- `-d`：使用 `SO_DEBUG` 套接字选项。
- `-f`：flood ping。
- `-h`：打印帮助信息。
- `-I <interface>`：指定网卡接口名称或 IP 地址。
- `-i <interval>`：指定发送每个数据包之间的时间间隔（秒数）。
- `-L`：抑制组播（multicast）数据包的环回（loopback）。
- `-l <preload>`：在等待回复时发送 `<preload>` 个包数。
- `-m <mark>`：标记发出的数据包。
- `-M <pmtud opt>`：定义 mtu 发现，可以是 `<do|dont|want>` 之一。
- `-n`：没有 DNS 名称解析。
- `-O`：报告未完成的答复。
- `-p <pattern>`：填充字节的内容。
- `-q`：安静的输出。
- `-Q <tclass>`：使用服务质量 `<tclass>` 位。
- `-s <size>`：使用 `<size>` 作为要发送的数据字节数。
- `-S <size>`：使用 `<size>` 作为 `SO_SNDBUF` 套接字选项的值。
- `-t <ttl>`：定义生存时间。
- `-U`：打印用户到用户（user-to-user）的延迟（latency）。
- `-v`：详细输出。
- `-V`：打印版本信息并退出。
- `-w <deadline>`：回复等待 `<deadline>` 秒。
- `-W <timeout>`：等待响应的时间。

**IPv4 专用选项**：

- `-4`：使用 IPv4。
- `-b`：允许 ping 广播。
- `-R`：记录路由。
- `-T <timestamp>`：定义时间戳，可以是 `<tsonly|tsandaddr|tsprespec>` 之一。

**IPv6 专用选项**：

- `-6`：使用 IPv6。
- `-F <flowlabel>`：定义流标签，默认为随机。
- `-N <nodeinfo opt>`：使用 icmp6 节点信息查询。



## 示例

测试本机与「人人都懂物联网」网站的连通情况

```bash
ping getiot.tech
```

测试本机与 192.168.0.2 设备的网络连通情况

```bash
ping 192.168.0.2
```

指定网卡进行 ping 测试（网卡名称可通过 [ifconfig](/linux-command/ifconfig) 命令查看）

```bash
ping -I eth0 192.168.0.2
```

测试 1000 次

```bash
ping -c 1000 192.168.0.2
```

以时间间隔 2 秒测试 1000 次

```bash
ping -i 2 -c 1000 192.168.0.2
```

