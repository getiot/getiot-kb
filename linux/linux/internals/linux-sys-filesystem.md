---
sidebar_position: 2
sidebar_label: Sys 文件系统
slug: /linux-sys-filesystem
authors: [luhuadong]
---

# Linux Sys 文件系统

`/sys` 是 Linux 提供的一个虚拟文件系统，通常称为 sysfs。它把内核中的设备、驱动、总线、类、模块等信息，以目录和文件的形式暴露给用户空间。

你可以把 `/sys` 理解成内核设备模型的一扇窗口。很多硬件相关信息，不需要写程序，直接读 `/sys` 下的文件就能看到。

## /sys 不是普通磁盘目录

`/sys` 中的内容不是存放在磁盘上的普通文件。它由内核动态生成，系统启动后挂载。

查看挂载信息：

```bash
mount | grep sysfs
```

你可能会看到：

```text
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
```

这说明 `/sys` 的文件系统类型是 `sysfs`。

## /sys 和 /proc 的区别

`/proc` 更偏进程和内核运行状态，例如进程、内存、CPU、内核参数等。

`/sys` 更偏设备模型，例如：

- 设备。
- 驱动。
- 总线。
- 设备类别。
- 内核模块。
- 电源管理。

二者都属于虚拟文件系统，但关注点不同。

## 常见目录

查看 `/sys` 顶层目录：

```bash
ls /sys
```

常见目录包括：

| 目录 | 含义 |
| --- | --- |
| `/sys/block` | 块设备，例如磁盘、分区 |
| `/sys/bus` | 总线类型，例如 USB、PCI、I2C |
| `/sys/class` | 按设备类别组织的视图 |
| `/sys/devices` | 按设备层级组织的真实设备树 |
| `/sys/module` | 已加载内核模块 |
| `/sys/kernel` | 内核相关接口 |
| `/sys/power` | 电源管理相关接口 |

## 查看块设备

```bash
ls /sys/block
```

你可能会看到：

```text
loop0  sda  sr0
```

查看某个设备大小：

```bash
cat /sys/block/sda/size
```

这里的单位通常是 512 字节扇区。日常查看磁盘信息更推荐使用 [lsblk](/linux-command/lsblk/)；直接读 `/sys` 更适合理解系统内部机制或写脚本获取底层信息。

## 查看网络接口

```bash
ls /sys/class/net
```

输出可能包括：

```text
eth0  lo  wlan0
```

查看网卡 MAC 地址：

```bash
cat /sys/class/net/eth0/address
```

查看接口状态：

```bash
cat /sys/class/net/eth0/operstate
```

实际网卡名要以你的系统为准。

## 查看内核模块

```bash
ls /sys/module | head
```

这里列出当前加载的内核模块。更常用的命令是：

```bash
lsmod
```

但 `/sys/module` 能看到模块暴露出来的参数和状态。

## /sys 中有些文件可以写

`/sys` 中很多文件是只读的，但也有一些可写接口，用于调整设备或内核行为。

例如某些 LED、GPIO、CPU 调频、电源管理接口可能通过 `/sys` 暴露控制文件。

:::warning
不要在不了解含义时向 `/sys` 写入内容。写错可能导致设备异常、网络断开、系统不稳定，甚至影响硬件。
:::

## sysfs 与 udev

udev 会监听内核设备事件，并结合 `/sys` 中的设备信息，在 `/dev` 下创建设备节点、设置权限和符号链接。

简单说：

- `/sys` 提供设备信息。
- udev 根据设备事件和规则处理设备。
- `/dev` 提供用户空间访问设备的入口。

你可以继续阅读 [Linux udev 简介](linux-udev.md) 和 [Dev 文件系统](linux-dev-filesystem.md)。

## 小结

`/sys` 是理解 Linux 设备模型的重要入口：

- 它是虚拟文件系统，不是普通磁盘目录。
- 它暴露设备、驱动、总线、模块等信息。
- 日常查看设备优先用 `lsblk`、`ip`、`lsmod` 等命令。
- 深入硬件和驱动时，`/sys` 会非常常见。
- 向 `/sys` 写入内容要非常谨慎。
