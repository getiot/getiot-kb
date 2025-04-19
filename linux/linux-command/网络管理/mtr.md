---
sidebar_label: mtr 命令
sidebar_position: 21
slug: /mtr
---

# Linux mtr 命令 - 网络诊断路由跟踪



## 介绍

**mtr**（英文全拼：my traceroute）是一个用于网络诊断和网络性能测量的命令行工具，它在单个网络诊断工具中结合了 [traceroute](/linux-command/traceroute/) 和 [ping](/linux-command/ping/) 程序的功能，提供了更全面的网络路径跟踪和性能统计。

`mtr` 命令的主要应用场景包括：

- 在网络上跟踪数据包的路径，类似于 `traceroute`。
- 连续地测量目标主机的网络性能，类似于 `ping`。
- 提供目标主机到每个中间节点的网络延迟、丢包率等信息。

当 mtr 启动时，它会通过发送故意设置低 TTL 的数据包来调查运行 mtr 的主机与 HOSTNAME 之间的网络连接。它继续发送低 TTL 的数据包，并记录中间路由器的响应时间。这允许 mtr 打印到 HOSTNAME 的互联网路由的响应百分比和响应时间。数据包丢失或响应时间突然增加通常表明链接不良（或只是过载）。

**语法**：

```bash
mtr [options] HOSTNAME
```

**选项**：

- `-r`：已报告模式显示。
- `-c`：发送多少个数据包。
- `-n`：不用主机解释。
- `--report`：结果显示，并不动态显示。
- `-s`：用来指定 ping 数据包的大小。



## 示例

使用报告模式显示：

```bash
mtr -r getiot.tech
```

设置每秒发送数据包数量：

```bash
mtr -r -c 30 getiot.tech
```

数指定 ping 数据包的大小：

```bash
mtr -r -c 30 -s getiot.tech
```

