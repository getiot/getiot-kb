---
sidebar_label: ethtool 命令
sidebar_position: 5
slug: /ethtool
---

# ethtool 命令



## 介绍

**ethtool**（英文全拼：ethernet tool）命令用于查看和修改网络设备（尤其是有线以太网设备）的驱动参数和硬件设置。你可以根据需要更改以太网卡的参数，包括自动协商、速度、双工和局域网唤醒等参数。

**安装**：

默认情况下，大多数 Linux 发行版应该已经安装了 ethtool 工具，如果没有，可以参考如下命令进行安装。

```bash
# 对于 RHEL/CentOS 6/7 系统，使用 yum 命令安装
sudo yum install -y ethtool

# 对于 RHEL/CentOS 8 和 Fedora 系统，使用 dnf 命令安装
sudo dnf install -y ethtool

# 对于基于 Debian/Ubuntu 的系统，使用 apt 或 apt-get 命令安装
sudo apt-get install ethtool

# 对于 openSUSE 系统，使用 zypper 命令安装
sudo zypper install -y ethtool

# 对于 Arch Linux 系统，使用 pacman 命令安装
sudo pacman -S ethtool
```

**语法**：

```bash
ethtool [选项] [devname]
```

**选项**：

- `-a` ：查看网卡中接收模块 RX、发送模块 TX 和 Autonegotiate 模块的状态（启动 on 或 停用 off）。
- `-A` ：修改网卡中接收模块 RX、发送模块 TX 和 Autonegotiate 模块的状态（启动 on 或 停用 off）。
- `-c` ：display the Coalesce information of the specified ethernet card。
- `-C` ：Change the Coalesce setting of the specified ethernet card。
- `-g` ：Display the rx/tx ring parameter information of the specified ethernet card。
- `-G` ：change the rx/tx ring setting of the specified ethernet card。
- `-i` ：显示网卡驱动的信息，如驱动的名称、版本等。
- `-d` ：显示 register dump 信息，部分网卡驱动不支持该选项。
- `-e` ：显示 EEPROM dump 信息，部分网卡驱动不支持该选项。
- `-E` ：修改网卡 EEPROM byte。
- `-k` ：显示网卡 Offload 参数的状态（on 或 off），包括 rx-checksumming、tx-checksumming 等。
- `-K` ：修改网卡 Offload 参数的状态。
- `-p` ：用于区别不同 ethX 对应网卡的物理位置，常用的方法是使网卡 port 上的 led 不断的闪；N 指示了网卡闪的持续时间，以秒为单位。
- `-r` ：如果 auto-negotiation 模块的状态为 on，则 restarts auto-negotiation。
- `-S` ：显示 NIC- and driver-specific 的统计参数，如网卡接收/发送的字节数、接收/发送的广播包个数等。
- `-t` ：让网卡执行自我检测，有两种模式（offline 或 online）。
- `-s` ：修改网卡的部分配置，包括网卡速度、单工/全双工模式、mac 地址等。

**参数**：`devname`（网卡名称，可通过 [ip](/linux-command/ip) 或 [ifconfig](/linux-command/ifconfig) 命令查看）



## 示例

查看 eth0 网卡的硬件配置信息

```bash
ethtool eth0
```

查看 eth0 网卡的驱动程序和固件版本

```bash
ethtool -i eth0
```

查看 eth0 网卡的自动协商、RX 和 TX 等详细信息

```bash
ethtool -a eth0
```

查看 eth0 网卡网络使用情况统计

```bash
ethtool -S eth0
```

从多个物理接口中识别出特定网卡（闪烁网卡上的 LED）

```bash
ethtool -p eth0
```

修改 eth0 以太网设备的速度为百兆（进行此操作时，网卡会自动掉线，您需要使用 ifup、ip 或 nmcli 命令将其重新上线）

```bash
ethtool -s eth0 speed 100
ip link set eth0 up
```

启用/禁用以太网卡的自动协商

```bash
ethtool -s eth0 autoneg off
ethtool -s eth0 autoneg on
```

同时修改多个配置参数

```bash
ethtool –s eth0 speed 1000 duplex full autoneg off
```

注意：在系统重启后，使用 ethtool 所做的更改将恢复为默认值。如果需要使设置永久生效，您需要根据您的 Linux 发行版进行操作，可能需要将这些配置更新到正确的文件中。

查看网卡是否支持 PTP 硬件

```bash
$ sudo ethtool -T eth0
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
Hardware Receive Filter Modes:
        none                  (HWTSTAMP_FILTER_NONE)
        all                   (HWTSTAMP_FILTER_ALL)
```

注意：对于 gPTP 同步，需要硬件支持，PTP Hardware Clock 选项要求为 1。


