---
sidebar_label: sfdisk 命令
sidebar_position: 18
slug: /sfdisk
---

# sfdisk 命令 - 管理磁盘分区表



## 介绍

**sfdisk** 命令用于显示或操作磁盘分区表。

与 [fdisk](/linux-command/fdisk) 菜单式交互操作不同，sfdisk 是一个面向脚本的工具，由命令驱动（从文件或 stdin 读取输入），因此通常用于在 shell 脚本中对硬盘进行分区或对分区表进行备份和恢复。

**语法**：

```bash
sfdisk [options] device [-N partition-number]
sfdisk [options] command
```

**选项**：

- `-d` ：显示硬盘分区的设置。
- `-g` ：输出模块的载入信息。
- `-l` ：显示后硬盘分区的相关设置。
- `-s` ：显示分区的大小，单位为区块。
- `-T` ：显示所有 sfdisk 能辨识的文件系统 ID。
- `-V` ：检查硬盘分区是否正常。
- `-x` ：显示扩展分区中的逻辑分区。
- `-N` ：按照从标准输入读取的分区表，在指定的块设备上创建分区表。
- `-A` ：打开指定分区的启动标记（仅可用于 MBR 分区表）。
- `--delete` ：删除指定/全部的分区。
- `-J` ：按照 JSON 格式导出指定块设备的现有分区表。
- `-F` ：列出指定/全部块设备上尚未被分区的剩余空间。
- `-r` ：按照各分区的起始扇区，对现有分区进行重新编号。
- `-a` ：仅在现有的分区表上添加新分区，而不是创建一个全新的分区表。
- `-f` ：禁用所有一致性检查，强制执行看上去明显的错误动作。
- `-n` ：模拟操作（并不真正写入块设备）。
- `-o` ：仅输出指定的字段。
- `-q` ：不显示所有多余的信息。
- `-X` ：指定分区表的类型。如果未明确指定此选项，那么表示使用块设备上的现有类型。 如果现有块设备上不存在分区表，那么默认为 dos 类型（MBR）。
- `-h`, `--help` ：显示帮助信息。
- `-v`, `--version` ：显示版本信息。



## 示例

sfdisk 读取以下形式的行，每行填充一个分区描述符。当字段不存在或为空时，将使用默认值。

```bash
<start> <size> <id> <bootable> <c,h,s> <c,h,s>
```

例如，文件 emmc_partition_table.txt 记录 eMMC 分区信息：

```bash
# partition table of /dev/mmcblk0
unit: sectors

/dev/mmcblk0p1 : start=    20480, size=  2097152, Id= c, bootable
/dev/mmcblk0p2 : start=  2117632, size= 46137344, Id=83
/dev/mmcblk0p3 : start= 48254976, size= 10485760, Id=83
/dev/mmcblk0p4 : start= 58740736, size=122142719, Id= 5  # extended partition
/dev/mmcblk0p5 : start= 58741736, size= 41943040, Id=83
/dev/mmcblk0p6 : start=100684776, size= 20971520, Id=83
```

使用该分区表对块设备 /dev/mmcblk0 进行分区

```bash
sfdisk /dev/mmcblk0 < emmc_partition_table.txt
```

查看指定硬盘分区的信息

```bash
sfdisk -l /dev/mmcblk0
```

输出内容如下：

```bash
Disk /dev/mmcblk0: 58.25 GiB, 62537072640 bytes, 122142720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x1bbe4bb6

Device         Boot     Start       End  Sectors  Size Id Type
/dev/mmcblk0p1 *        20480   2117631  2097152    1G  c W95 FAT32 (LBA)
/dev/mmcblk0p2        2117632  48254975 46137344   22G 83 Linux
/dev/mmcblk0p3       48254976  58740735 10485760    5G 83 Linux
/dev/mmcblk0p4       58740736 122142719 63401984 30.2G  5 Extended
/dev/mmcblk0p5       58741736 100684775 41943040   20G 83 Linux
/dev/mmcblk0p6      100684776 121656295 20971520   10G 83 Linux
```

查看指定硬盘分区的设置

```bash
sfdisk -d /dev/mmcblk0
```

输出内容如下：

```bash
label: dos
label-id: 0x1bbe4bb6
device: /dev/mmcblk0
unit: sectors

/dev/mmcblk0p1 : start=       20480, size=     2097152, type=c, bootable
/dev/mmcblk0p2 : start=     2117632, size=    46137344, type=83
/dev/mmcblk0p3 : start=    48254976, size=    10485760, type=83
/dev/mmcblk0p4 : start=    58740736, size=    63401984, type=5
/dev/mmcblk0p5 : start=    58741736, size=    41943040, type=83
/dev/mmcblk0p6 : start=   100684776, size=    20971520, type=83
```

删除 /dev/mmcblk0 块设备上的所有分区

```bash
sfdisk --delete /dev/mmcblk0
```

