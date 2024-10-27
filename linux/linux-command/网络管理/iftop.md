---
sidebar_label: iftop 命令
sidebar_position: 24
slug: /iftop
---

# iftop 命令



## 介绍

**iftop** 是一个能够提供网络带宽实时监控的工具（类似于 [top](/linux-command/top) 命令实时监测进程状态）。

iftop 通过测量每个连接进入和进出的数据包的大小从而达到监控网络的目的。即它通过捕获网卡进入和进出的流量，然后对其求和从而得到正确的网络带宽数据。iftop 必须使用超级管理员权限运行，因为需要监控所有网络流量。如果没有指定接口，iftop 将监听在外部接口（使用 libcap 和 libncurses）的第一个接口上。

通常，iftop 工具系统中并不默认安装，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install iftop
```

**语法**：

```bash
iftop [选项]
```

**选项**：

- `-i <interface>` ：设定监测的网卡。
- `-B` ：以 bytes/sec 为单位显示流量（默认是 bits/sec）。
- `-n` ：使 host 信息默认直接都显示 IP 地址。
- `-N` ：使端口信息默认直接都显示端口号。
- `-F <net/mask>` ：显示特定网段的进出流量。
- `-p` ：以混杂模式运行。
- `-P` ：启用端口显示。
- `-b` ：不以流量图形条显示。
- `-f <filter> <code>` ：过滤 IP 包。
- `-m <limit>` ：设置界面最上边的刻度的最大值（刻度分五个大段显示）。
- `-h` ：显示帮助信息。



## 示例

不带任何选项，直接运行 iftop

```bash
$ sudo iftop
```

![](https://static.getiot.tech/iftop_snapshot.png#center)

窗口说明：

- 默认使用第一个网络接口（比如 eth0）；
- 默认显示 rates 的三列数据分别表示：最近2秒、10秒和40秒的平均流量；
- peak 指网络速率的尖峰值（最大）；
- cum 表示累积流量 cumulative，在交互界面时按下 `T` 键就可以看到“主机对”之间累计的网络数据流量。

网络监测时不进行 DNS 反解析，直接显示 IP，从而可以节省一定的带宽

```bash
$ sudo iftop -n
```

监测指定网卡

```bash
$ sudo iftop -i eth0
```

设置显示刻度最大值为 100M

```bash
$ sudo iftop -m 100M
```

显示特定网段的进出流量

```bash
$ sudo iftop -F 10.10.1.0/24
$ sudo iftop -F 10.10.1.0/255.255.255.0
```



