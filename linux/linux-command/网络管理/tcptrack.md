---
sidebar_label: tcptrack 命令
sidebar_position: 31
slug: /tcptrack
---

# tcptrack 命令



## 介绍

**tcptrack** 是一个用于实时监视 TCP 连接的命令行工具。它可用于实时监视系统中活动的 TCP 连接，显示源和目标 IP 地址、端口以及连接的状态，并以图形化的方式显示每个连接的实时流量统计信息。

**语法**：

```bash
tcptrack [ -dfhvp ] [ -r seconds ] -i interface [ filter expression ]
```

**选项**：

- `-d`：仅跟踪 tcptrack 启动后启动的连接，不要尝试检测已有连接。
- `-f`：启用快速平均重新计算。TCPTrack 将使用运行平均值来计算连接的平均速度，这将使用更多内存和 CPU 时间，但结果更接近实时情况。在快速模式下每秒重新计算平均值的次数是编译时设置，默认为每秒 10 次。
- `-i [interface]`：嗅探来自指定网络接口的数据包。
- `-T [pcap file]`：从指定 pcap 文件中读取数据包，而不是从网络中嗅探。这个选项对于测试很有用。
- `-p`：不要将被嗅探的接口置于混杂模式。
- `-r [seconds]`：等待 seconds 秒后从显示屏上删除关闭的连接，默认为 2 秒。
- `-h`：显示帮助信息。
- `-v`：显示版本信息。

**交互命令**：

当 tcptrack 运行时，还可以通过键盘快捷键进行交互。

- `p`：暂停/取消暂停显示。不会将新连接添加到显示屏中，并且所有当前显示的连接将保留在显示屏中。
- `s`：循环切换排序选项，包括：未排序（unsorted）、按速率排序（sorted by rate）、按总字节排序（sorted by total bytes）。
- `q`：退出 tcptrack 程序。

**过滤表达式**：

tcptrack 还可以将 pcap 过滤器表达式作为参数。过滤器表达式的格式与 [tcpdump](/linux-command/tcpdump) 和其他基于 libpcap 的嗅探器的格式相同。



## 示例

监视 eth0 网络接口的 TCP 连接：

```bash
$ sudo tcptrack -i eth0
```

使用 pcap 过滤器表达式，仅显示来自主机 10.45.165.2 的连接：

```bash
$ sudo tcptrack -i eth0 src or dst 10.45.165.2
```

仅显示 Web 流量（指定 80 端口）：

```bash
$ sudo tcptrack -i eth0 port 80
```
