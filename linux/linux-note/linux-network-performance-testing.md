---
sidebar_position: 7
---

# Linux 网络性能测试方法



在 Linux 网络设备开发过程中，我们常常需要测试网络性能指标参数，找出网络性能瓶颈，从而优化我们的软件或者硬件设计。在 Linux 环境中，我们可以使用 iperf 命令工具测试网络性能，包括网络带宽、延迟抖动和数据包丢失等参数。为了方便使用，我们还可以安装图形化界面工具 Jperf 进行测试。本文将以 Ubuntu 系统为例，介绍 iperf 和 Jperf 的使用，并完成网络性能测试。



## 安装工具

首先需要安装 iperf 命令工具，在 Ubuntu 系统中执行下列命令即可安装。

```bash
sudo apt install iperf
```

Jperf 是 iPerf 命令行图形化的 Java 程序，由于 Jperf 依赖 Java（1.5 及以上版本），因此在安装 Jperf 之前，我们还需要确保 Ubuntu 系统已经安装好了 Java 环境。你可以通过以下命令来检查是否满足要求：

```bash
$ java -version
openjdk version "11.0.13" 2021-10-19
OpenJDK Runtime Environment (build 11.0.13+8-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.13+8-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

如果满足 Java 环境的要求，接下来我们就可以在 [xjperf Google CodePage](https://code.google.com/p/xjperf/downloads/list) 下载当前最新的 *jperf-2.0.2.zip* 安装包。

打开 Shell 终端，切换到 jperf-2.0.2.zip 文件所在目录，依次执行下列命令完成解压缩等安装操作。

```bash
unzip jperf-2.0.2.zip
cd jperf-2.0.2/
chmod +x jperf.sh
```

执行脚本即可启动 Jperf 程序。

```bash
./jperf.sh
```



## 命令行测试

下面我们先利用命令行工具进行测试。iperf 支持测试 TCP 和 UDP 模式，不过为了测出极限带宽、时延抖动、丢包率等数据，我们通常采用 UDP 模式。

在进行测试时，首先以链路理论带宽作为数据发送速率进行测试，例如，从客户端到服务器之间的链路的理论带宽为 100Mbps，先用 `-b 100M` 参数进行测试，然后根据测试结果（包括实际带宽，时延抖动和丢包率），再以实际带宽作为数据发送速率进行测试，会发现时延抖动和丢包率比第一次好很多，重复测试几次，就能得出稳定的实际带宽。

PC 端作为 UDP 服务器端（IP 地址为 192.168.0.1）：

```bash
iperf -u -s
```

设备端作为 UDP 客户端：

```bash
iperf -u -c 192.168.0.1 -b 1000M -t 60
```

其中 `-u` 表示 UDP 模式，`-s` 表示服务器端，`-c` 表示客户端。另外客户端这边，`-b` 指定发送速率，这里先用 1000Mbps 作为数据发送速率；`-t` 指定测试时长（单位为秒），这里的测试时间为 60 秒。

一分钟后，服务端的打印结果如下：

```bash
rudy@Latitude-3420:~$ iperf -u -s
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 192.168.0.1 port 5001 connected with 192.168.0.2 port 39515
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0-60.0 sec  5.92 GBytes   848 Mbits/sec   0.001 ms  336/4324695 (0.0078%)
```

客户端的打印结果如下：

```bash
root@bionic-arm64:~# iperf -u -c 192.168.0.1 -b 1000M -t 60                                                        
------------------------------------------------------------
Client connecting to 192.168.0.1, UDP port 5001
Sending 1470 byte datagrams, IPG target: 11.22 us (kalman adjust)
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 192.168.0.2 port 39515 connected with 192.168.0.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-60.0 sec  5.92 GBytes   848 Mbits/sec
[  3] Sent 4324695 datagrams
[  3] Server Report:
[  3]  0.0-60.0 sec  5.92 GBytes   848 Mbits/sec   0.000 ms  336/4324695 (0.0078%)
```



## 图形工具测试

PC 端作为服务器端，启动 Jperf 图形工具：

```bash
./jperf.sh
```

设置为 Server 模式，这次我们使用 TCP 模式，点击右上方的 “Run IPerf!” 按钮启动。

![](https://static.getiot.tech/Jperf-on-ubuntu-udp-server-01.png#center)

设备端作为 TCP 客户端：

```bash
iperf -c 192.168.0.1 -b 1000M -t 60
```

运行过程中，可以在 Jperf 界面看到网络带宽的测试结果，如下图所示。

![](https://static.getiot.tech/Jperf-on-ubuntu-udp-server-02.png#center)



## 总结

iperf 是一个功能强大的网络性能测试工具，可用于测试 TCP 和 UDP 带宽质量，报告带宽、延迟抖动和数据包丢失等数据。我们常常利用 iperf 工具来来测试一些网络设备的性能，PC 端和嵌入式设备端均可作为服务器端或者客户端，分别测试上行或者下行的带宽。

