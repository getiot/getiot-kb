---
sidebar_label: lsusb 命令
sidebar_position: 1
slug: /lsusb
---

# Linux lsusb 命令 - 列出 USB 设备信息



## 介绍

**lsusb** 命令用于显示当前主机的 USB 设备列表，以及 USB 设备的详细信息。

lsusb 命令由 usbutils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
$ sudo apt install usbutils
```

lsusb 命令是一个学习 USB 驱动开发，认识 USB 设备的助手，推荐大家使用！

**语法**：

```bash
lsusb [ options ]
```

**选项**：

- `-v` ：显示 USB 设备的详细信息。
- `-s [[bus]:][devnum]` ：仅显示指定的总线和（或）设备号的设备。
- `-d [vendor]:[product]` ：仅显示指定厂商和产品编号的设备。
- `-D device` ：显示指定 device 的信息，而不使用预设的 /dev/bus/usb 目录。
- `-t` ：以树状结构显示物理 USB 设备的层次，可与 `v` 选项一起使用以显示详细信息。
- `-V` ：显示命令的版本信息。



## 示例

插入 usb 鼠标后执行 lsusb 查看当前设备列表

```bash
$ lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 005: ID 0424:2840 Standard Microsystems Corp.
Bus 003 Device 004: ID 10c4:ea71 Cygnal Integrated Products, Inc.
Bus 003 Device 002: ID 0424:2806 Standard Microsystems Corp. USB2806 Smart Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 1c4f:0034 SiGma Micro Usb Mouse
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

说明：

- **Bus 004** 表示第四个 usb 主控制器（机器上总共有四个 usb 主控制器，可以通过命令 `lspci | grep USB` 查看）。
- **Device 006** 表示系统给 usb 鼠标分配的设备号（devnum），同时也可以看到该鼠标是插入到了第一个 usb 主控制器。
- **ID 1c4f:0034** 表示 usb 设备的 ID（这个 ID 由芯片制造商设置，可以唯一表示该设备）。可在 `/sys/devices/pci0000:00/0000:[<bus>]:][<slot>][.[<func>]/usbx/x-x/` 目录下查看 devnum、idVendor、idProduct 等信息。

以树状形式查看 USB 设备列表

```bash
$ lsusb -t
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 480M
        |__ Port 5: Dev 4, If 1, Class=Vendor Specific Class, Driver=cp210x, 12M
        |__ Port 5: Dev 4, If 2, Class=Vendor Specific Class, Driver=cp210x, 12M
        |__ Port 5: Dev 4, If 0, Class=Vendor Specific Class, Driver=cp210x, 12M
        |__ Port 5: Dev 4, If 3, Class=Vendor Specific Class, Driver=cp210x, 12M
        |__ Port 7: Dev 5, If 0, Class=Vendor Specific Class, Driver=, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 7, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
```

每一行末尾的数字表示 USB 类型的传输速率，例如：

- 12M 意味着 USB 1.0/1.1 的速率是 12Mbit/s
- 480M 意味着 USB 2.0 的速率是 480Mbit/s
- 5000M 意味着 USB 3.0 的速率是 5Gbit/s