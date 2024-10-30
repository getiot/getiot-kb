---
sidebar_label: swapoff 命令
sidebar_position: 26
slug: /swapoff
---

# Linux swapoff 命令 - 禁用交换空间



## 介绍

**swapoff** 命令用于关闭 Linux 系统中用于分页和交换的设备和文件。

相关命令：[swapon](/linux-command/swapon)

**语法**：

```bash
swapoff [-va] [specialfile...]
```

**选项**：

- `-a`, `--all` ：禁用所有在 /etc/fstab 中被标记为 "swap" 的块设备。
- `-v`, `--verbose` ：详细模式。
- `-h`, `--help` ：显示帮助信息并退出。
- `-V`, `--version` ：显示版本信息并退出。

**参数**：指定的 swap 设备（分区、逻辑卷或文件）。



## 示例

查看当前 Linux 系统内存和 swap 区域情况

```bash
$ free -h
            总计         已用        空闲      共享    缓冲/缓存    可用
内存：     7.5Gi       2.8Gi       199Mi     282Mi   4.5Gi     4.1Gi
交换：      15Gi        98Mi        15Gi
```

查找 swap 对应的块设备

```bash
$ sudo fdisk -l | grep swap
/dev/sdb5       400003072  432879615   32876544  15.7G 82 Linux swap / Solaris
```

关闭该交换区域

```bash
$ sudo swapoff /dev/sdb5
```

再次查看 swap 区域情况

```bash
$ free -h
            总计         已用        空闲      共享    缓冲/缓存    可用
内存：     7.5Gi       2.8Gi       145Mi     335Mi   4.5Gi     4.1Gi
交换：        0B          0B          0B
```

