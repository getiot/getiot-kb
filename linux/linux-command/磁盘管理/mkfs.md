---
sidebar_label: mkfs 命令
sidebar_position: 23
slug: /mkfs
---

# mkfs 命令 - 创建文件系统



## 介绍

**mkfs**（英文全拼：make file system）命令用于在特定的分区上建立 Linux 文件系统。

mkfs 本身并不执行建立文件系统的工作，而是去调用相关的程序来执行。

**语法**：

```bash
mkfs [options] [-t type] [fs-options] device [size]
```

**选项**：

- `-t <文件系统类型>`：指定要建立何种文件系统，Linux 的默认值为 ext2。
- `-c`：在制作文件系统前，检查该分区是否有坏轨。
- `-l bad_blocks_file`：将有坏轨的 block 资料加到 bad_blocks_file 里面。
- `-V`：详细显示模式（如果不带参数则显示版本信息）。

**参数**：

- `device`：指定要创建的文件系统对应的设备文件名。
- `size`：指定文件系统的磁盘块数。



## 示例

在 `/dev/hda5` 上建一个 msdos 的文件系统，同时检查是否有坏轨存在，并且将过程详细列出来：

```bash
$ sudo mkfs -V -t msdos -c /dev/hda5
```

将 sdb1 分区格式化为 ext3 格式：

```bash
$ sudo mfks -t ext3 /dev/sdb1
```

将 sdb1 分区格式化为 ext3 格式，并检查坏轨，且详细显示：

```bash
$ sudo mfks -V -t ext3 -c /dev/sdb1
```

**注意**：这里的文件系统是要指定的，比如 ext2、ext3、ext4、reiserfs、fat32、msdos 等。如果不想指定文件系统，可使用 mkfs.ext2、mkfs.ext3、mkfs.fat 等命令。

