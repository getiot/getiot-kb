---
sidebar_label: lspci 命令
sidebar_position: 2
slug: /lspci
---

# Linux lspci 命令 - 列出 PCI 设备信息



## 介绍

**lspci** 命令用于显示当前主机的所有 PCI 总线信息，以及所有已连接的 PCI 设备信息。

lspci 命令由 pciutils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install pciutils
```

**语法**：

```bash
lspci [options]
```

**选项**：

- `-n` ：以数字方式显示 PCI 生产厂商和设备代码。
- `-t` ：以树状结构显示 PCI 设备的层次关系，包括所有的总线、桥、设备以及它们之间的联接。
- `-b` ：以总线为中心的视图。显示所有 IRQ 号和记忆体地址，就像 PCI 总线上的卡看到的一样，而不是系统内核看到的内容。
- `-d [<vendor>]:[<device>]` ：仅显示给定厂商和设备的信息。这两个 ID 都以十六进制表示，可以忽略或者以「`*`」代替（意味著所有值）。
- `-s [[<bus>]:][<slot>][.[<func>]]` ：仅显示指定总线、插槽上的设备和设备上的功能块信息。设备地址的任何部分都可以忽略，或以「`*`」代替（意味著所有值）。所有数字都是十六进制，例如：
  - 「`0:`」指的是在0号总线上的所有设备；
  - 「`0`」指的是在任意总线上0号设备的所有功能块；
  - 「`0.3`」选择 了所有总线上0号设备的第三个功能块；
  - 「`.4`」则是只列出每一设备上的第四个功能块。
- `-i <file>` ：指定 PCI 编号列表文件，而不使用默认的文件。
- `-p <dir>` ：指定包含 PCI 总线信息的目录，而不使用预设的目录 /proc/bus/pci。
- `-m` ：以机器可读方式显示 PCI 设备信息。
- `-M` ：使用总线映射模式，这种模式对总线进行全面地扫描以查明总线上的所有设备，包括配置错误的桥之后的设备。请注意，此操作只应在调试时使用，并可能造成系统崩溃（只在设备有错误的时候，但是不幸的是它们存在），此命令只有 root 可以使用。同时，在不直接接触硬件的 PCI 访问模式中使用 `-M` 参数没有意义，因为显示的结果（排除 lspci 中的 bug 的影响）与普通的列表模式相同。
- `-x` ：以十六进制显示 PCI 配置空间（configuration space）的前64个字节映像（标准头部信息）。此参数对调试驱动和 lspci 本身很有用。
- `-v` ：使得 lspci 以冗余模式显示所有设备的详细信息。
- `-vv` ：使得 lspci 以过冗余模式显示更详细的信息（事实上是 PCI 设备能给出的所有东西）。这些数据的确切意义没有在此手册页中解释，如果你想知道更多，请参照 /usr/include/linux/pci.h 或者 PCI 规范。



## 示例

不必添加任何选项，就能够显示出目前的硬件配备

```bash
$ lspci
00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0b)
00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated Graphics Controller (rev 0b)
00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev 04)
00:16.0 Communication controller: Intel Corporation 8 Series HECI #0 (rev 04)
00:19.0 Ethernet controller: Intel Corporation Ethernet Connection I218-V (rev 04)
......
```

查看一般详细信息

```bash
$ lspci -v
00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0b)
        Subsystem: Lenovo Haswell-ULT DRAM Controller
        Flags: bus master, fast devsel, latency 0
        Capabilities: <access denied>
        Kernel driver in use: hsw_uncore

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated Graphics Controller (rev 0b) (prog-if 00 [VGA controller])
        Subsystem: Lenovo Haswell-ULT Integrated Graphics Controller
        Flags: bus master, fast devsel, latency 0, IRQ 49
        Memory at d0000000 (64-bit, non-prefetchable) [size=4M]
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 5000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: i915
        Kernel modules: i915
......
```

查看网卡详细信息（-s 后面接的是每个设备的总线、插槽与相关函数功能）

```bash
$ lspci -s 00:19.0 -vv
00:19.0 Ethernet controller: Intel Corporation Ethernet Connection I218-V (rev 04)
        Subsystem: Lenovo Ethernet Connection I218-V
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 44
        Region 0: Memory at d0700000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at d073e000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 5080 [size=32]
        Capabilities: <access denied>
        Kernel driver in use: e1000e
        Kernel modules: e1000e
```

查看网卡的厂商和设备代码

```bash
$ lspci -nn | grep Eth
00:19.0 Ethernet controller [0200]: Intel Corporation Ethernet Connection I218-V [8086:1559] (rev 04)
```



