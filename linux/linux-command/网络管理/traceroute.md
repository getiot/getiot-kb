---
sidebar_label: traceroute 命令
sidebar_position: 19
slug: /traceroute
---

# traceroute 命令 - 路由追踪显示路径



## 介绍

**traceroute** 命令用于跟踪、显示 IP 信息包至某个网络主机的路由。

也就是说，通过 traceroute 命令就可以知道信息（数据包）从你的计算机到互联网另一端的主机是走的什么路径。当然，每次数据包由某一同样的出发点（source）到达某一同样的目的地（destination）走的路径可能会不一样，但基本上来说大部分时候所走的路由是相同的。

traceroute 的工作原理是通过发送一系列的 ICMP（Internet Control Message Protocol）或 UDP（User Datagram Protocol）数据包，默认发送的数据包大小是40字节，然后观察每个数据包在网络中的传输情况，从而确定路径和测量每一跳的延迟。

一条路径上的每个设备 traceroute 要测 3 次，输出结果中包括每次测试的时间（ms）和设备的名称（如有的话）及其 IP 地址。如果探测的回答来自不同的网关，那么命令会显示各个响应系统的地址。如果在 3 秒的超时时间间隔内没有来自探测的应答，那么将对该探测输出 *（星号）。

:::info 注：

**traceroute** 命令可以用来做网络测试、测量和管理。它应主要用于手动故障隔离。由于 traceroute 命令增加了网络负载，因此不应该在正常操作期间或从自动化脚本中使用此命令。

:::

**语法**：

```bash
traceroute [-46dFITUnreAV] [-f first_ttl] [-g gate,...]
           [-i device] [-m max_ttl] [-p port] [-s src_addr]
           [-q nqueries] [-N squeries] [-t tos]
           [-l flow_label] [-w waittimes] [-z sendwait] [-UL] [-D]
           [-P proto] [--sport=port] [-M method] [-O mod_options]
           [--mtu] [--back]
           host [packet_len]
```

**选项**：

- `-m <max_ttl>`：设置用于输出探测信息包的最大存活时间（最大的跳跃数）。缺省值为 30 个跳跃（TCP 连接也使用相同的缺省值）。
- `-f <first_ttl>`：设置第一个检测数据包的存活数值 TTL 的大小。
- `-g <gate,...>`：设置来源路由网关，最多可设置 8 个。
- `-i <device>`：使用指定的网络接口送出数据包。
- `-p <port>`：设置用于探测的基本 UDP 端口号，缺省值为 33434。
- `-s <src_addr>`：设置本地主机送出数据包的 IP 地址。
- `-r`：忽略普通的 Routing Table，直接将数据包送到远端主机上。
- `-t <tos>`：设置检测数据包的 TOS（服务类型）数值。
- `-w <waittimes>`：设置等待远端主机回报的时间。
- `-n`：直接使用 IP 地址而非主机名称。
- `-v`：详细显示指令的执行过程。



## 示例

显示到主机 **getiot.tech** 的路由：

```bash
$ traceroute -i eth0 -m 10 getiot.tech
traceroute to getiot.tech (42.192.64.149), 10 hops max, 60 byte packets
 1  _gateway (192.168.1.1)  11.565 ms  11.502 ms  11.487 ms
 2  172.16.0.1 (172.16.0.1)  17.092 ms  17.371 ms  17.357 ms
 3  221.179.83.37 (221.179.83.37)  18.690 ms *  18.954 ms
 4  120.196.243.21 (120.196.243.21)  20.673 ms 120.196.243.1 (120.196.243.1)  20.989 ms 120.196.243.21 (120.196.243.21)  19.925 ms
 5  120.196.199.130 (120.196.199.130)  24.335 ms 120.196.199.114 (120.196.199.114)  24.569 ms 120.196.199.122 (120.196.199.122)  23.758 ms
 6  120.241.50.2 (120.241.50.2)  24.762 ms 120.241.50.6 (120.241.50.6)  13.892 ms  12.839 ms
 7  * * *
 8  * * *
 9  * * *
10  * * *
```

