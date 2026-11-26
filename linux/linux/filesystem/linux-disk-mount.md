---
sidebar_position: 7
sidebar_label: 磁盘、分区与挂载
slug: /linux-disk-mount
---

# Linux 磁盘、分区与挂载：lsblk、mount、umount

在 Linux 中，磁盘、U 盘、SD 卡、网络文件系统通常不会以 `C:`、`D:` 这种盘符出现，而是被挂载到目录树中的某个位置。

这一篇会介绍 [lsblk](/linux-command/lsblk/)、[mount](/linux-command/mount/) 和 [umount](/linux-command/umount/) 的基本用法。

## 设备、分区和挂载点

先运行：

```bash
lsblk
```

输出类似：

```text
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   50G  0 disk
├─sda1   8:1    0  512M  0 part /boot/efi
└─sda2   8:2    0 49.5G  0 part /
sdb      8:16   1   16G  0 disk
└─sdb1   8:17   1   16G  0 part
```

你可以这样读：

- `sda` 是一块磁盘。
- `sda1`、`sda2` 是这块磁盘上的分区。
- `MOUNTPOINTS` 显示分区挂载到了哪个目录。
- `sdb` 可能是一块 U 盘或 SD 卡。

## 查看文件系统信息

[blkid](/linux-command/blkid/) 可以查看文件系统类型和 UUID：

```bash
sudo blkid
```

输出可能包含：

```text
/dev/sda2: UUID="..." TYPE="ext4"
```

UUID 是文件系统的唯一标识，写 `/etc/fstab` 时常用。

## 挂载是什么

挂载就是把一个文件系统接到 Linux 目录树上。

比如把 `/dev/sdb1` 挂载到 `/mnt/usb`：

```bash
sudo mkdir -p /mnt/usb
sudo mount /dev/sdb1 /mnt/usb
```

之后访问 `/mnt/usb`，就是访问这个分区里的内容。

:::warning
设备名可能随插拔顺序变化。实际操作前一定要用 `lsblk` 确认目标设备，不要凭记忆操作 `/dev/sdb1`。
:::

## 卸载文件系统

使用完成后，应当先卸载：

```bash
sudo umount /mnt/usb
```

如果提示设备忙，说明有进程正在使用这个挂载点。常见原因是：

- 你的终端当前就在 `/mnt/usb` 目录里。
- 有文件管理器打开了这个目录。
- 有程序正在读写里面的文件。

先离开目录：

```bash
cd ~
sudo umount /mnt/usb
```

## 查看当前挂载

查看所有挂载点：

```bash
mount
```

输出很多时，可以配合 `grep`：

```bash
mount | grep /mnt
```

更友好的方式是：

```bash
findmnt
```

如果系统没有 `findmnt`，使用 `mount` 和 `lsblk` 也足够入门。

## /etc/fstab 简介

`/etc/fstab` 用于配置开机自动挂载。它通常包含设备、挂载点、文件系统类型和挂载选项。

查看：

```bash
cat /etc/fstab
```

初学阶段不建议随意修改它。错误的 `fstab` 配置可能导致系统启动时进入维护模式。

如果需要修改，建议先备份：

```bash
sudo cp /etc/fstab /etc/fstab.bak
```

修改后可以用下面命令测试：

```bash
sudo mount -a
```

如果有错误，应立即修正或恢复备份。

## 不要混淆格式化和挂载

挂载只是“接入已有文件系统”。格式化会创建新的文件系统，通常会清空原有数据。

像 [mkfs](/linux-command/mkfs/)、[fdisk](/linux-command/fdisk/)、[parted](/linux-command/parted/) 这类命令属于高风险操作。入门阶段你只需要认识它们，不要在真实磁盘上随意尝试。

## 小结

你需要记住：

- `lsblk` 查看磁盘、分区和挂载点。
- `mount` 挂载文件系统。
- `umount` 卸载文件系统。
- `/etc/fstab` 控制开机自动挂载。
- 格式化和挂载不是一回事，格式化有数据丢失风险。
