---
sidebar_label: canbusload 命令
sidebar_position: 11
slug: /canbusload
---

# Linux canbusload 命令 - 监控 CAN 总线负载



## 介绍

**canbusload** 命令用于实时监控 CAN 总线的带宽占用率。它根据接收到的报文数量和总线比特率，计算并显示各接口的负载百分比，适合评估总线利用率、排查拥塞问题。

canbusload 命令由 can-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install can-utils
```

**语法**：

```bash
canbusload [options] <CAN interface>+
```

可同时监控最多 16 个 CAN 接口，格式为 `<ifname>@<bitrate>`。比特率为必填项，用于计算负载百分比。使用 `CTRL-C` 终止程序。

**选项**：

- `-t`：在第一行显示当前时间
- `-c`：彩色显示各行
- `-b`：以 5% 分辨率显示条形图
- `-r`：重绘终端（类似 `top` 命令的刷新效果）
- `-i`：带宽计算时忽略位填充（bit stuffing）估算
- `-e`：精确计算填充位

**输出说明**：

每个接口占一行，包含：接口名、接收帧数、总使用比特数、负载数据比特数、负载百分比。由于位填充为估算值，计算出的负载可能超过 100%。

相关命令：[candump](/linux-command/candump/)、[cangen](/linux-command/cangen/)、[can-calc-bit-timing](/linux-command/can-calc-bit-timing/)



## 示例

1、监控 can0（500 kbps）的总线负载：

```bash
canbusload can0@500000
```

2、同时监控多个接口，带时间戳、彩色和条形图，并持续刷新：

```bash
canbusload can0@100000 can1@500000 can2@500000 -r -t -b -c
```

输出示例：

```
canbusload 2024-02-01 21:13:16 (worst case bitstuffing)
 can0@100000   805   74491  36656  74% |XXXXXXXXXXXXXX......|
 can1@500000   796   75140  37728  15% |XXX.................|
 can2@500000     0       0      0   0% |....................|
```

3、使用精确位填充计算：

```bash
canbusload -e can0@500000
```
