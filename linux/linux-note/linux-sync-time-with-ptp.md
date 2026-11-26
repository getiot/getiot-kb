---
sidebar_position: 13
---

# Linux 使用 PTP 进行时间同步

![Linux 使用 PTP 进行时间同步](https://static.getiot.tech/time-sync-banner.webp#center)



## 概述

PTP（[精确时间协议](/protocol/ptp/)）是一种用于在网络中进行时钟同步的协议。当与硬件支持结合使用时，PTP 能够达到亚微秒的精度，这种精度远高于 NTP 协议。

PTP 时间同步协议的支持分为内核空间和用户空间两部分。在 Linux 系统中，PTP 协议的实际实现称为 LinuxPTP，它是 PTPv2 根据 Linux 的 IEEE 1588 标准实现的。在 LinuxPTP 软件包包括 [ptp4l](/linux-command/ptp4l/) 和 [phc2sys](/linux-command/phc2sys/) 用于时钟同步的程序，其中 ptp4l 程序实现了 PTP 边界时钟和普通时钟，支持硬件时钟同步和软件时间同步，硬件时间戳用于将 PTP 硬件时钟与主时钟同步，软件时间戳用于将系统时钟与主时钟同步。phc2sys 程序则用于将系统时钟同步到网卡上的 PTP 硬件时钟（PHC）。



## 准备工作

### 安装 LinuxPTP

首先，需要在 Linux 系统中安装 LinuxPTP。

Debian/Ubuntu 系统使用 apt 命令安装：

```bash
sudo apt install linuxptp
```

对于 RHEL/CentOS 6/7 系统，使用 yum 命令安装：

```bash
sudo yum install linuxptp
```

对于 RHEL/CentOS 8 和 Fedora 系统，使用 dnf 命令安装：

```bash
sudo dnf install linuxptp
```

如果是其他嵌入式 Linux 系统，或者你想安装最新版本的 LinuxPTP，可以采用源码编译安装方式：

```bash
sudo git clone git://git.code.sf.net/p/linuxptp/code linuxptp
cd linuxptp
sudo make
sudo make install
```

安装完成后可通过 `ptp4l -v` 命令检查是否安装成功：

```bash
$ ptp4l -v
1.92
```



### 检查网卡驱动

为了使用 PTP ，网络接口的内核网络驱动程序必须支持软件或硬件时间戳功能。除了驱动程序中存在的硬件时间戳支持之外，NIC 还必须能够在物理硬件中支持此功能。验证特定驱动程序和 NIC 的时间戳功能的最佳方法是使用 [ethtool](/linux-command/ethtool/) 查询接口。

例如：检查 eth0 网卡对硬件时间戳的支持

```bash
sudo ethtool -T eth0
```

执行上述命令后的输出结果可能如下：

```bash
Time stamping parameters for eth0:
Capabilities:
	hardware-transmit     (SOF_TIMESTAMPING_TX_HARDWARE)
	software-transmit     (SOF_TIMESTAMPING_TX_SOFTWARE)
	hardware-receive      (SOF_TIMESTAMPING_RX_HARDWARE)
	software-receive      (SOF_TIMESTAMPING_RX_SOFTWARE)
	software-system-clock (SOF_TIMESTAMPING_SOFTWARE)
	hardware-raw-clock    (SOF_TIMESTAMPING_RAW_HARDWARE)
PTP Hardware Clock: 0
Hardware Transmit Timestamp Modes:
	off                   (HWTSTAMP_TX_OFF)
	on                    (HWTSTAMP_TX_ON)
	one-step-sync         (HWTSTAMP_TX_ONESTEP_SYNC)
Hardware Receive Filter Modes:
	none                  (HWTSTAMP_FILTER_NONE)
	all                   (HWTSTAMP_FILTER_ALL)
```

对于软件时间戳支持，参数列表应包括：

- `SOF_TIMESTAMPING_SOFTWARE`
- `SOF_TIMESTAMPING_TX_SOFTWARE`
- `SOF_TIMESTAMPING_RX_SOFTWARE`

对于硬件时间戳支持，参数列表应包括：

- `SOF_TIMESTAMPING_RAW_HARDWARE`
- `SOF_TIMESTAMPING_TX_HARDWARE`
- `SOF_TIMESTAMPING_RX_HARDWARE`



## 配置文件

### ptp4l 配置文件

ptp4l 程序启动时会从 /etc/linuxptp/ptp4l.conf 文件读取配置选项，部分配置如下所示。

```ini showLineNumbers
[global]
#
# Default interface options
#
network_transport	UDPv4
delay_mechanism		E2E
time_stamping		hardware
tsproc_mode		filter
delay_filter		moving_median
delay_filter_length	10
egressLatency		0
ingressLatency		0
boundary_clock_jbod	0
```



### ptp4l 服务配置文件

`ptp4l` 可以作为服务运行，对应的配置文件是 /lib/systemd/system/ptp4l.service。

```ini showLineNumbers
[Unit]
Description=Precision Time Protocol (PTP) service
Documentation=man:ptp4l

[Service]
Type=simple
ExecStart=/usr/sbin/ptp4l -f /etc/linuxptp/ptp4l.conf -i eth0

[Install]
WantedBy=multi-user.target
```

执行以下命令即可启动 `ptp4l` 服务：

```bash
sudo systemctl start ptp4l
```

如果要永久启用 `ptp4l` 服务，可执行以下命令：

```bash
sudo systemctl enable ptp4l
```

如果要禁用 `ptp4l` 服务，可执行以下命令：

```bash
sudo systemctl disable ptp4l
```



### phc2sys 服务配置文件

`phc2sys` 也可以作为服务运行，对应的配置文件是 /lib/systemd/system/phc2sys.service。

```ini showLineNumbers
[Unit]
Description=Synchronize system clock or PTP hardware clock (PHC)
Documentation=man:phc2sys
After=ntpdate.service
Requires=ptp4l.service
After=ptp4l.service

[Service]
Type=simple
ExecStart=/usr/sbin/phc2sys -w -s eth0

[Install]
WantedBy=multi-user.target
```

执行以下命令即可启动 `phc2sys` 服务：

```bash
sudo systemctl start phc2sys
```

如果要永久启用 `phc2sys` 服务，可执行以下命令：

```bash
sudo systemctl enable phc2sys
```

如果要禁用 `phc2sys` 服务，可执行以下命令：

```bash
sudo systemctl disable phc2sys
```



## 实验

我们可以通过修改 /etc/linuxptp/ptp4l.conf 来设置 ptp4l 的模式，再通过 `systemctl start ptp4l` 启动。但为了更加直观，下面的实验我们将直接通过 `ptp4l` 命令行启动。

提示：为了完成 PTP 时间同步实验，我们需要两台 Linux 设备，其中一台作为 PTP master，另一台作为 PTP slave。



### PTP 硬件时钟同步

`ptp4l` 默认使用硬件时间戳，也可以显式指定 `-H` 选项使用硬件时间戳。`-i` 选项指定支持硬件时戳的网络接口；`-m` 指示 `ptp4l` 将其输出列显到标准输出，而不是列显到系统的日志记录工具。

PTP 主端口（Master），`-H` 选项显式指定使用硬件时间戳。

```bash
sudo ptp4l -m -H -i eth0
```

PTP 从端口（Slave），`-s` 选项设置为从端口。

```bash
sudo ptp4l -m -H -s -i eth0
```

此时终端打印的输出可能如下：

```bash
selected eth0 as PTP clock
port 1: INITIALIZING to LISTENING on INITIALIZE
port 0: INITIALIZING to LISTENING on INITIALIZE
port 1: new foreign master 00a152.fffe.0b334d-1
selected best master clock 00a152.fffe.0b334d
port 1: LISTENING to UNCALIBRATED on RS_SLAVE
master offset -25937 s0 freq +0 path delay       12340
master offset -27887 s0 freq +0 path delay       14232
master offset -38802 s0 freq +0 path delay       13847
master offset -36205 s1 freq +0 path delay       10623
master offset  -6975 s2 freq -30575 path delay   10286
port 1: UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
master offset  -4284 s2 freq -30135 path delay    9892
```

其中，`port 0` 是用于本地 PTP 管理的 Unix 域套接字。`port 1` 是 `eth0` 接口。`INITIALIZING`、`LISTENING`、`UNCALIBRATED` 和 `SLAVE` 是发生 `INITIALIZE`、`RS_SLAVE` 和 `MASTER_CLOCK_SELECTED` 事件时更改的端口状态示例。当端口状态从 `UNCALIBRATED` 更改为 `SLAVE` 时，表示计算机已与 PTP 主时钟成功同步。

`master offset` 行说明：

- `master offset` 值表示测得的与主时钟之间的偏差（以纳秒为单位）。
- `s0`、`s1`、`s2` 表示时钟伺服的不同状态。`s0` 表示已解锁（unlocked），`s1` 表示时钟步进（clock step），`s2` 表示已锁定（locked）。如果伺服处于已锁定状态（`s2`），并且 `pi_offset_const` 选项在配置文件中设置为负值，则时钟不会步进，而只会缓慢调整。
- `freq` 值表示时钟的频率调整，以十亿分率（ppb）为单位。
- `path delay` 值表示从主时钟发送的同步消息的预计延迟（以纳秒为单位）。



### PTP 软件时间同步

PTP 主端口（Master），使用 `-S` 选项启用软件时间戳。

```bash
sudo ptp4l -m -S -i eth0
```

PTP 从端口（Slave），`-s` 选项设置为从端口。

```bash
sudo ptp4l -m -S -s -i eth0
```

使用软件时间戳进行时间同步的准确度比硬件时间戳要低，这是因为 IEEE 1588 的同步原理决定了时钟同步的精度主要取决于时间戳的精度。


