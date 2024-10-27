---
sidebar_label: nmap 命令
sidebar_position: 27
slug: /nmap
---

# nmap 命令



## 介绍

**nmap**（英文全拼：Network Mapper）是一个开源的网络探测工具和安全/端口扫描器，由 Fyodor 编写并维护。它的设计目标是快速地扫描大型网络，当然用它扫描单个主机也没有问题。由于品质卓越、使用灵活，nmap 已经成为渗透测试人员必备的工具之一。

在实现原理方面，nmap 以新颖的方式使用原始 IP 报文来发现网络上有哪些主机，这些主机提供什么服务（应用程序名和版本），这些服务运行在什么操作系统（包括版本信息），它们使用什么类型的报文过滤器/防火墙，以及一堆其它功能。

虽然 nmap 通常用于安全审核，但许多系统管理员和网络管理员也用它来做一些日常的工作，比如查看整个网络的信息、管理服务升级计划，以及监视主机和服务的运行。

nmap 输出的是扫描目标的列表（端口号、协议、服务名称和状态。），以及每个目标的补充信息，至于是哪些信息则依赖于所使用的选项。其中，状态可能是 open、filtered、closed 或者 unfiltered 中的一种或两种组合。 

- open（开放的）意味着目标机器上的应用程序正在该端口监听连接/报文。
- filtered（被过滤的）意味着防火墙、过滤器或者其它网络障碍阻止了该端口被访问，nmap 无法得知它是 open 还是 closed 的。
- closed（关闭的）端口没有应用程序在它上面监听，但是他们随时可能开放。
- 当端口对 nmap 的探测做出响应，但是 nmap 无法确定它们是关闭还是开放时，这些端口就被认为是 unfiltered（未被过滤的）。

如果 nmap 报告状态组合 open|filtered 和 closed|filtered 时，那说明 nmap 无法确定该端口处于两个状态中的哪一个状态。

**语法**：

```bash
nmap [Scan Type(s)] [Options] {target specification}
nmap [扫描类型...] [选项] {扫描目标说明}
```

其中 Target（扫描目标）可以传入主机名称、IP 地址或网络。

**选项**：

- `-sS`：TCP SYN 扫描（又称半开放或隐身扫描）。 
- `-P0`：允许你关闭 ICMP pings。
- `-sV`：打开系统版本检测。
- `-O`：尝试识别远程操作系统。
- `-A`：同时打开操作系统指纹和版本检测。
- `-v`：详细输出扫描情况。



## 示例

扫描出指定 IP（域名）其对外开放的服务

```bash
$ nmap getiot.tech
Starting Nmap 7.80 ( https://nmap.org ) at 2022-10-30 23:13 CST
Nmap scan report for getiot.tech (42.192.64.149)
Host is up (0.058s latency).
Not shown: 997 filtered ports
PORT    STATE SERVICE
80/tcp  open  http
443/tcp open  https

Nmap done: 1 IP address (1 host up) scanned in 6.72 seconds
```

判断目标 IP（域名）是否开放指定端口

```bash
nmap -p 80 getiot.tech
```

扫描指定网络中的所有在线主机

```bash
nmap -sP 192.168.3.*
nmap -sP 192.168.3.0/24
```

扫描指定网络中的所有在线主机的指定端口

```bash
nmap -p 22,80,443 192.168.3.0/24
```

扫描指定网段中在线主机的指定端口

```bash
nmap -p 22,80,443 192.168.3.30-100
```

扫描指定网段，但是排除某个 IP 地址

```bash
nmap 192.168.3.30-100 --exclude 192.168.3.30.66
```

扫描多个地址时排除文件里的 IP 地址

```bash
cat ex.txt 
192.168.3.30.66
192.168.3.30.88

nmap 172.17.120.11-14 --excludefile ex.txt
```

在某段子网上查找未占用的 IP

```bash
nmap -T4 -sP 192.168.3.0/24 && egrep “00:00:00:00:00:00″ /proc/net/arp
```

服务版本识别（-sV），nmap 可以在进行端口扫描的时候检测服务端软件的版本信息

```bash
nmap -sV 192.168.3.66 -p 80
```

操作系统检测（-O），nmap 还能识别目标主机的操作系统

```bash
nmap -O 192.168.3.66
```

找到目标主机开放了哪些 UDP 端口。为提高扫描速度，我们仅扫描 53 端口（DNS）和 161 端口（SNMP）

```bash
nmap -sU 192.168.3.66 -p 53,161
```

启用 nmap 的 -6 选项即可扫描 IPv6 的目标主机

```bash
nmap -6 fe80::a00:27ff:fe43:1518
```

在局域网上扫找 Conficker 蠕虫病毒

```bash
nmap -PN -T4 -p139,445 -n -v –script=smb-check-vulns –script-args safe=1 192.168.3.1-254
```

扫描网络上的恶意接入点（rogue APs）

```bash
nmap -A -p1-85,113,443,8080-8100 -T4 –min-hostgroup 50 –max-rtt-timeout 2000 –initial-rtt timeout 300 –max-retries 3 –host-timeout 20m –max-scan-delay 1000 -oA wapscan 192.168.3.0/24
```

使用诱饵扫描方法来扫描主机端口

```bash
nmap -sS 192.168.3.12 -D 192.168.3.20
```

显示网络上共有多少台 Linux 及 Win 设备

```bash
nmap -F -O 192.168.3.0-255 | grep "Running: " > /tmp/os; echo "$(cat /tmp/os | grep Linux \| wc -l) Linux device(s)"; echo "$(cat /tmp/os | grep Windows | wc -l) Window(s) device"
```

