---
sidebar_position: 3
slug: /lshw
---

# lshw 命令



## 介绍

**lshw**（英文全拼：list hardware）命令用于检查硬件组件及其核心配置。它能为我们提供内存配置、固件版本、主板配置信息、CPU 版本和速度、cache 信息、总线速度等硬件信息。

lshw 不仅是一个可以查看硬件信息的工具，它还可以用来做一些硬件的 benchmark，用于评估计算机硬件的性能特征。lshw 工具其实就是读取 /proc 里面的一些文件来显示相关的信息，比如：

```bash
/proc/cpuinfo  # 显示CPU信息
/proc/bus/pci  # 显示pci信息
/proc/scsi     # 显示scsi信息
/proc/net/dev  # 显示网络设备信息
/proc/kcore    # 从内存映像读取相关信息
/proc/ide      # 显示IDE设备信息
/proc/devices
/proc/mounts
/proc/fstab
```

lshw 工具适用于所有 Linux 发行版，包括 Redhat、Centos、Ubuntu、Debian、Arch Linux 等。如果您的系统没有 lshw 命令，例如在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install lshw
```

**语法**：

```bash
lshw [-format] [-options ...]
```

**格式**：

- `-html` ：将硬件设备树输出为 HTML 格式
- `-xml` ：将硬件设备树输出为 XML 格式
- `-json` ：将硬件设备树输出为 JSON 格式
- `-short` ：输出硬件路径
- `-businfo` ：输出显示总线信息的设备列表，详细说明 SCSI、USB、IDE 和 PCI 地址

**选项**：

- `-c | -C | -class CLASS` ：仅显示给定的硬件类别信息，可以使用 `lshw -short` 或 `lshw -businfo` 找到 class。
- `-enable TEST` ：启动一个测试（如 pci、isapnp、cpuid 等）
- `-disable TEST` ：关闭一个测试（如 pci、isapnp、cpuid 等）
- `-quiet` ：不显示状态
- `-sanitize` ：清理输出（删除敏感信息，如序列号等）
- `-numeric` ：输出数字 ID（适用于 PCI 和 USB 等）
- `-notime` ：从输出中排除经常改变的属性（如时间戳）



## 示例

显示硬件设备列表，输出包括设备路径（path）、类别（class）以及简单描述：

```bash
debian@npi:~$ sudo lshw -short
H/W path  Device  Class      Description
========================================
                  system     Seeed NPi STM32MP157C Board
/0                bus        Motherboard
/0/0              processor  cpu
/0/1              processor  cpu
/0/2              memory     429MiB System memory
/1        usb1    bus        EHCI Host Controller
/2        usb2    bus        Generic Platform OHCI controller
/3        usb0    network    Ethernet interface
/4        eth0    network    Ethernet interface
/5        wlan0   network    Ethernet interface
```

显示硬件设备列表，输出包括总线信息、SCSI、USB、IDE、PCI 地址以及简单描述：

```bash
debian@npi:~$ sudo lshw -businfo
Bus info  Device  Class      Description
========================================
                  system     Seeed NPi STM32MP157C Board
                  bus        Motherboard
cpu@0             processor  cpu
cpu@1             processor  cpu
                  memory     429MiB System memory
usb@1     usb1    bus        EHCI Host Controller
usb@2     usb2    bus        Generic Platform OHCI controller
          usb0    network    Ethernet interface
          eth0    network    Ethernet interface
          wlan0   network    Ethernet interface
```

显示内存相关硬件信息：

```bash
debian@npi:~$ sudo lshw -C memory
[10404.990958] [dhd-wlan0] wl_run_escan : LEGACY_SCAN sync ID: 51, bssidx: 0
  *-memory
       description: System memory
       physical id: 2
       size: 429MiB
```

显示网卡相关硬件信息，并删除敏感信息：

```bash
debian@npi:~$ sudo lshw -c network -sanitize
  *-network:0
       description: Ethernet interface
       physical id: 3
       logical name: usb0
       serial: [REMOVED]
       capabilities: ethernet physical
       configuration: broadcast=yes driver=g_ether driverversion=29-May-2008 firmware=49000000.usb-otg ip=[REMOVED] link=no multicast=yes
  *-network:1
       description: Ethernet interface
       physical id: 4
       logical name: eth0
       serial: [REMOVED]
       size: 10Mbit/s
       capacity: 1Gbit/s
       capabilities: ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=st_gmac driverversion=Jan_2016 duplex=half link=no multicast=yes port=MII speed=10Mbit/s
  *-network:2
       description: Ethernet interface
       physical id: 5
       logical name: wlan0
       serial: [REMOVED]
       capabilities: ethernet physical
       configuration: broadcast=yes driver=wl driverversion=0 ip=[REMOVED] multicast=yes
```

