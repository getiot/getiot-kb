---
sidebar_label: ip 命令
sidebar_position: 3
slug: /ip
---

# ip 命令



## 介绍

**ip** 命令是 Linux 系统中的一个网络配置工具，主要用于显示或设置网络设备，功能非常全面，可完全替代 [ifconfig](/linux-command/ifconfig) 命令。

**语法**：

```shell
ip [ OPTIONS ] OBJECT { COMMAND | help }
```

**选项**：

- `-V`：显示命令的版本信息。
- `-s`：输出更详细的信息。
- `-f`：强制使用指定的协议族。
- `-4`：指定使用的网络层协议是 IPv4 协议。
- `-6`：指定使用的网络层协议是 IPv6 协议。
- `-0`：输出信息每条记录输出一行，即使内容较多也不换行显示。
- `-r`：显示主机时，不使用 IP 地址，而使用主机的域名。
- `help`：为该命令的帮助信息。

常用 OBJECT 对象及其含义如下：

| OBJECT                   | 缩写           | 描述                                     |
| ------------------------ | -------------- | ---------------------------------------- |
| `address`                | `a` 或 `addr`  | 设备上的协议（IPv4 或 IPv6）地址         |
| `addrlabel`              | `addrl`        | 用于协议地址选择的标签配置               |
| `l2tp`                   |                | IP 上的以太网隧道（L2TPv3）              |
| `link`                   | `l`            | 网络设备                                 |
| `maddress`               | `m` 或 `maddr` | 多播地址                                 |
| `monitor`                |                | 监视 netlink 消息                        |
| `mroute`                 | `mr`           | 组播路由缓存条目                         |
| `mrule`                  |                | 组播路由策略数据库中的规则               |
| `neighbour`              | `n` 或 `neigh` | 管理 ARP 或 NDISC 缓存条目               |
| `netns`                  |                | 管理网络命名空间                         |
| `ntable`                 |                | 管理邻居高速缓存（neighbor cache）的操作 |
| `route`                  | `r`            | 路由表条目                               |
| `rule`                   | `ru`           | 路由策略数据库中的规则                   |
| `tcp_metrics/tcpmetrics` |                | 管理 TCP 指标（Metrics）                 |
| `token`                  |                | 管理令牌化（tokenized）的接口标识符      |
| `tunnel`                 | `t`            | IP 上的隧道（tunnel）                    |
| `tuntap`                 |                | 管理 TUN/TAP 设备                        |
| `xfrm`                   | `x`            | 管理 IPSec 策略                          |



## 示例

显示所有网络接口的信息：

```bash
ip a
```

只显示 TCP/IP IPv4 的网络接口：

```bash
ip -4 a
```

只显示 TCP/IP IPv6 的网络接口：

```bash
ip -6 a
```

显示指定接口的 TCP/IP 详细信息，下面四个命令是等效的：

```bash
ip a show eth0
ip a list eth0
ip a show dev eth0
ip a list dev eth0
```

只显示正在运行的网络接口：

```bash
ip link show up
```

为指定网络接口设置 IP 地址的格式是 `ip a add {ip_addr/mask} dev {interface}`，例如下面两个命令是等效的：

```bash
ip a add 192.168.1.200/255.255.255.0 dev eth0
ip a add 192.168.1.200/24 dev eth0
```

为指定网络接口上添加广播地址：

```bash
ip addr add broadcast 172.20.10.255 dev eth0
```

从网络接口中删除 IP 地址：

```bash
ip a del 192.168.1.200/24 dev eth0
```

在所有 ppp（Point-to-Point）接口上禁用 IP 地址：

```bash
ip -4 addr flush label "ppp*"
```

关闭 eth1 网卡：

```bash
ip link set dev eth1 down
```

启动 eth1 网卡：

```bash
ip link set dev eth1 up
```

设置 eth0 网络接口的 txqueuelen（传输队列长度）大小为 10000：

```bash
ip link set txqueuelen 10000 dev eth0
```

设置 eth0 网络接口的 MTU 值为 9000：

```bash
ip link set mtu 9000 dev eth0
```

显示邻居（ARP）缓存：

```bash
$ ip n show
192.168.1.3 dev eth0 lladdr 86:e5:ec:b7:bd:d3 STALE
192.168.1.1 dev eth0 lladdr 3c:57:4f:f8:18:48 REACHABLE
fe80::1 dev eth0 lladdr 3c:57:4f:f8:18:48 router REACHABLE
```

输出结果的最后一个字段显示此条目的“**neighbour unreachability detection**”机器的状态，一共有 3 种状态：

- **`STALE`**：邻居是有效的（valid），但可能已经无法访问，因此内核将尝试在第一次传输时检查它。
- **`DELAY`**：一个数据包已经发送给过时的（STALE 状态）邻居，内核正在等待确认。
- **`REACHABLE`**：邻居是有效的（valid），而且显然是可以联系到的（reachable）。

添加一个 ARP 条目的格式是 `ip neigh add {IP-HERE} lladdr {MAC/LLADDRESS} dev {DEVICE} nud {STATE}`。例如，在设备 eth0 上为邻居 192.168.1.5 添加一个永久 ARP 条目：

```bash
ip neigh add 192.168.1.5 lladdr 00:1a:30:38:a8:00 dev eth0 nud perm
```

nud 邻居状态（neighbour state）有 4 种：

- **`permanent`**：邻居条目永远有效，只能由管理员指定删除。
- **`noarp`**：邻居条目是有效的，将不会尝试验证此项，但可以在其生存期过期时将其删除。
- **`stale`**：邻居的条目是有效的，但可疑。如果 `ip neigh` 选项有效且地址未被此命令更改，则该选项不会更改邻居状态。
- **`reachable`**：在可达性超时过期之前，邻居条目是有效的。

删除一个 ARP 条目的格式是 `ip neigh del {IPAddress} dev {DEVICE}`，例如：

```bash
ip neigh del 192.168.1.5 dev eth1
```

更改是设备 eth1 上邻居 192.168.1.100 的状态为 reachable：

```bash
ip neigh chg 192.168.1.100 dev eth1 nud reachable
```

刷新 ARP 记录：

```bash
ip -s -s n flush 192.168.1.5
```

显示路由表，下面几个命令是等效的：

```bash
ip r
ip r list
ip route
ip route list
```

增加一个新的路由，命令格式如下：

```bash
ip route add {NETWORK/MASK} via {GATEWAYIP}
ip route add {NETWORK/MASK} dev {DEVICE}
## Add default route using ip ##
ip route add default {NETWORK/MASK} dev {DEVICE}
ip route add default {NETWORK/MASK} via {GATEWAYIP}
```

通过网关 192.168.1.254 向网络 192.168.1.0/24 添加一个普通路由：

```bash
ip route add 192.168.1.0/24 via 192.168.1.254
```

通过 192.168.1.254 网关路由通过 eth0 网络接口连接的所有流量：

```bash
ip route add 192.168.1.0/24 dev eth0
```

删除前面添加的一条网关路由：

```bash
ip route del 192.168.1.0/24 dev eth0
```

删除默认网关路由：

```bash
ip route del default
```

更改 eth0 网卡的 MAC 地址：

```bash
## show MAC address ##
ip link show eth0
## disable interface ##
ip link set dev eth0 down
## set new MAC address ##
ip link set dev eth0 address XX:YY:ZZ:AA:BB:CC
ip link set dev eth0 up
```

