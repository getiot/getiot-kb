---
sidebar_label: chronyc 命令
sidebar_position: 2
slug: /chronyc
---

# Linux chronyc 命令 - Chrony 服务交互工具



## 介绍

**chronyc**（英文全称：chrony command-line）命令用于设置时间与时钟服务器的同步工作。Chrony 是 Linux 系统中一个用于保持系统时间与 NTP 时钟服务器或 GPS 同步的服务，chronyc 则是 chronyd 服务的配置工具。

**语法**：

```bash
chronyc [-h HOST] [-p PORT] [-n] [-c] [-d] [-4|-6] [-m] [COMMAND]
```

**选项**：

- `-4`：使用此选项，主机名将仅解析为 IPv4 地址。
- `-6`：使用此选项，主机名将仅解析为 IPv6 地址。
- `-n`：此选项禁用将 IP 地址解析为主机名，以避免缓慢的 DNS 查找。
- `-c`：此选项允许以逗号分隔值（CSV）格式打印报告。IP 地址不会解析为主机名，时间将打印为自纪元以来的秒数，并且以秒为单位的值不会转换为其他单位。
- `-d`：如果 chronyc 编译时带有调试支持，则此选项启用调试消息的打印。
- `-m`：通常，命令行上的所有参数都被解释为一个命令。使用此选项可以指定多个命令，每个参数都将被解释为一个完整的命令。
- `-h <host>`：此选项允许用户指定要联系运行 chronyd 程序的主机（或逗号分隔的地址列表）。这允许远程监控，而无需先通过 SSH 连接到另一台主机。默认是联系在运行 chronyc 的同一主机上运行的 chronyd。
- `-p <port>`：此选项允许用户指定目标 chronyd 用于其监控连接的 UDP 端口号。默认为 323；通常不需要改变。
- `-f <file>`：此选项将被忽略，仅用于兼容性目的。
- `-a`：此选项将被忽略，仅用于兼容性目的。
- `-v`：显示其版本号并退出。

**常用命令**：

- `sources`：时间同步源
- `sourcestats`：时间同步源状态
- `-v`：详细信息模式



## 示例

查看 chronyd 的状态信息，包括系统时钟的偏移和调整信息：

```bash
$ chronyc tracking 
Reference ID    : CA760151 (time.neu.edu.cn)
Stratum         : 2
Ref time (UTC)  : Wed Apr 19 19:24:17 2023
System time     : 0.003332454 seconds slow of NTP time
Last offset     : -0.003015077 seconds
RMS offset      : 0.002894906 seconds
Frequency       : 18.189 ppm fast
Residual freq   : -0.488 ppm
Skew            : 0.811 ppm
Root delay      : 0.055464264 seconds
Root dispersion : 0.002117821 seconds
Update interval : 1031.6 seconds
Leap status     : Normal
```

显示与 chronyd 同步的 NTP 服务器的详细信息：

```bash
$ chronyc sources
210 Number of sources = 8
MS Name/IP address         Stratum Poll Reach LastRx Last sample               
===============================================================================
^- prod-ntp-3.ntp4.ps5.cano>     2  10   177   61m    -14ms[  -20ms] +/-  163ms
^? prod-ntp-4.ntp1.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^? prod-ntp-3.ntp4.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^? prod-ntp-5.ntp4.ps5.cano>     0   6     0     -     +0ns[   +0ns] +/-    0ns
^* time.neu.edu.cn               1  10   377   169  +2287us[ -728us] +/-   28ms
^+ 119.28.183.184                2  10   377   30m    +56us[-3936us] +/-   60ms
^? 2001:67c:21bc:1e::123         0   6     0     -     +0ns[   +0ns] +/-    0ns
^? 2603:c020:0:8369::feeb:d>     0   6     0     -     +0ns[   +0ns] +/-    0ns
```


