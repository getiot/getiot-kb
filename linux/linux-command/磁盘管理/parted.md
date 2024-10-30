---
sidebar_label: parted 命令
sidebar_position: 19
slug: /parted
---

# parted 命令 - 管理磁盘分区



## 介绍

**parted** 是 GNU 组织开发的一个磁盘/硬盘分区操作的程序。它支持多种分区表格式，包括 MS-DOS 和 GPT。可用于为新操作系统创建空间、重新组织磁盘使用（例如调整分区大小）以及将数据复制到新硬盘等操作。

与 [fdisk](/linux-command/fdisk) 命令不同，parted 支持调整分区的大小，作为一种设计用于 GNU/Linux 的工具，它没有构建成处理与 fdisk 关联的多种分区类型。但是，parted 可以处理最常见的分区格式，包括：ext2、ext3、fat16、fat32、NTFS、ReiserFS、JFS、XFS、UFS、HFS 以及 Linux 交换分区。

**语法**：

```bash
parted [options] [device [command [options...]...]]
```

**选项**：

- `-l`, `--list`：列出所有块设备的分区配置。
- `-m`, `--machine`：显示机器可解析的输出。
- `-s`, `--script`：从不提示用户。
- `-a`, `--align=[none|cyl|min|opt]`：新分区的对齐。
- `-h`, `--help`：打印帮助信息。
- `-v`, `--version`：显示版本信息。

**命令**：

- `align-check <type> <partition>`：检查分区是否满足类型的对齐约束。类型 type 必须是"minimal"（最小）或 "optimal"（最佳）之一。
- `mklabel <label-type>`：创建新的磁盘卷标（分区表）。
- `mkpart [part-type name fs-type] start end`：在起始点和结束点之间创建一个分区。
- `name <partition> <name>`：将指定“分区编号”的分区命名为“名称”。
- `print [devices|free|list,all|数字]`：显示分区表、可用设备、剩余空间、所有分区或特殊分区。
- `quit`：退出程序。
- `rescue <start> <end>`：挽救临近“起始点”、“终止点”的遗失的分区。
- `resizepart <partition> <end>`：改变分区的大小。
- `rm <NUMBER>`：删除编号为 `NUMBER` 的分区。
- `select <device>`：选择要编辑的设备。
- `set <partition> <flag> <state>`：改变指定“编号”分区的标志。
- `toggle <partition> <flag>`：切换“编号”分区上的“标志”状态。
- `unit <unit>`：设置缺省的“单位”。



## 示例

直接输入 `parted` 命令，默认选择系统中可用的第一个硬盘驱动器（如 /dev/sda），执行该命令需要 root 权限。

```bash
$ sudo parted 
GNU Parted 3.3
使用 /dev/sda
欢迎使用 GNU Parted！输入 'help' 来查看命令列表。
(parted) 
```

查看指定硬盘中所有可用的分区，显示硬盘属性，如型号、大小、扇区大小和分区表。

```bash
$ sudo parted /dev/sda print
型号：ATA RD-S325MMN-M01T4 (scsi)
磁盘 /dev/sda: 1014GB
扇区大小 (逻辑/物理)：512B/512B
分区表：msdos
磁盘标志：

编号  起始点  结束点  大小    类型     文件系统  标志
 1    1049kB  1014GB  1014GB  primary  ext4
```



