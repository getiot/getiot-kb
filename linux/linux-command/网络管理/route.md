---
sidebar_label: route 命令
sidebar_position: 4
slug: /route
---

# route 命令



## 介绍

**route** 命令用于显示和操作 Linux 内核 IP 路由表。它的主要用途是在使用 ifconfig 程序配置后，设置一个网络接口（网卡）到特定主机或网络的静态路由。当使用 add 或 del 选项时，route 会修改路由表，如果没有这些选项，则会显示路由表的当前内容。也可通过 /proc/net/route 查看路由表信息。

:::tip

基础知识：要实现两个不同的子网之间的通信，需要一台连接两个网络的路由器，或者一个同时位于两个网络的网关来实现。

:::

在 Linux 系统中，设置路由通常是为了解决以下问题：该 Linux 系统在一个局域网中，局域网中有一个网关，能够让机器访问 Internet，那么就需要将这台机器的 IP 地址设置为 Linux 机器的默认路由。要注意的是，直接在命令行下执行 route 命令来添加路由，不会永久保存，当网卡重启或者机器重启之后，该路由就失效了。可以在 /etc/rc.local 中添加 route 命令来保证该路由设置永久有效。

**语法**：

```shell
route [-nNvee] [-FC] [<AF>]           # 显示核心路由表
route [-v] [-FC] {add|del|flush} ...  # 为AF修改路由表
route {-h|--help} [<AF>]              # Detailed usage syntax for specified AF
route {-V|--version}                  # 显示版本和作者信息并退出
```

**选项**：

- `-v`, `--verbose` ：显示详细的处理信息。
- `-n`, `--numeric` ：不解析名称。
- `-e`, `--extend` ：显示更多信息。
- `-F`, `--fib` ：显示发送信息（默认）。
- `-C`, `--cache` ：显示路由缓存，而不是 FIB。
- `add` ：添加一条路由。
- `del` ：删除一条路由。
- `-net` ：目标地址是一个网络（network）。
- `-host` ：目标地址是一个主机（host）。
- `netmask NM` ：当添加一个网络路由时，需要使用网络掩码。
- `gw GW` ：路由数据包通过网关。注意，你指定的网关必须能够到达。
- `metric M` ：设置路由跳数。
- `mss M` ：将路由的 MTU（最大传输单元）设置为 M 字节。MTU 即 Maximum Transmission Unit，MSS 即 Maximum Segment Size。
- `window W` ：将此路由上的连接的 TCP 窗口大小设置为 W 字节。这通常仅用于 AX.25 网络并且驱动程序无法处理背靠背帧（back to back frames）。
- `irtt I` ：将此路由上 TCP 连接的初始往返时间（initial round trip time）设置为 I 毫秒 (1-12000)。这通常仅用于 AX.25 网络。如果省略，则使用 RFC 1122 默认值 300 毫秒。 
- `reject` ：安装阻塞路由，这将强制路由查找失败，以达到屏蔽该路由的效果。例如，这用于在使用默认路由之前屏蔽网络。注意，这不适用于防火墙。
- `mod, dyn, reinstate` ：安装动态或修改过的路由。这些标志用于诊断目的，通常仅由路由守护程序设置。
- `dev If` ：强制路由与指定的设备相关联，否则内核将尝试自行确定设备（通过检查现有路由和设备规范，以及路由添加到的位置）。在大多数普通网络中，您不需要这个。如果 `dev If` 是命令行上的最后一个选项，则可以省略 `dev` 这个词，因为它是默认值。否则，路由修饰符（公制网络掩码 `gw dev`）的顺序无关紧要。



## 示例

显示当前路由：

```shell
$ route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         *               0.0.0.0         U     0      0        0 ppp0
10.64.64.64     *               255.255.255.255 UH    0      0        0 ppp0
192.168.30.0    *               255.255.254.0   U     0      0        0 eth0
```

显示当前路由（不解析名称，列出速度会比 route 快）：

```shell
$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         0.0.0.0         0.0.0.0         U     0      0        0 ppp0
10.64.64.64     0.0.0.0         255.255.255.255 UH    0      0        0 ppp0
192.168.30.0    0.0.0.0         255.255.254.0   U     0      0        0 eth0
```

各字段说明如下：

| 字段        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| Destination | 目标网段或者主机                                             |
| Gateway     | 网关地址，`*` 表示目标是本主机所属的网络，不需要路由         |
| Genmask     | 子网掩码                                                     |
| Flags       | 路由标志，用于标记当前网络节点的状态，各标记说明如下：<br/>- `U` 即 Up，表示此路由当前为启动状态<br/>- `H` 即 Host，表示此网关为一主机<br/>- `G` 即 Gateway，表示此网关为一路由器<br/>- `R` 即 Reinstate Route，使用动态路由重新初始化的路由<br/>- `D` 即 Dynamically，此路由是动态性地写入<br/>- `M` 即 Modified，此路由是由路由守护程序或导向器动态修改<br/>- `!` 表示此路由当前为关闭状态 |
| Metric      | 跃点（路由距离），到达指定网络所需的中转数（Linux 内核暂时没有使用） |
| Ref         | 路由项引用次数（Linux 内核暂时没有使用）                     |
| Use         | 此路由项被路由软件查找的次数                                 |
| Iface       | 该路由表项对应的输出接口                                     |

增加到主机的路由信息：

```shell
route add -host 192.16.128.1 dev eth0
route add -host 192.16.128.1 gw 192.16.128.254
```

添加网关/设置网关（增加一条到达 224.0.0.0 的路由）：

```shell
route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0
```

屏蔽一条路由（增加一条屏蔽的路由，目的地址为 224.x.x.x 将被拒绝）：

```shell
route add -net 224.0.0.0 netmask 240.0.0.0 reject
```

删除路由记录：

```shell
route del -net 224.0.0.0 netmask 240.0.0.0
route del -net 224.0.0.0 netmask 240.0.0.0 reject
```

删除和添加设置默认网关：

```shell
route del default gw 192.168.120.240
route add default gw 192.168.120.240
```


