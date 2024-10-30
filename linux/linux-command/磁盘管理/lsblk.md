---
sidebar_label: lsblk 命令
sidebar_position: 2
slug: /lsblk
---

# lsblk 命令 - 列出块设备信息



## 介绍

**lsblk**（英文全拼：list block devices）命令用于列出所有可用块设备的信息，而且还能显示他们之间的依赖关系，但是它不会列出 RAM 盘的信息。常见的块设备包括硬盘、闪存盘、CD-ROM 等等。

**语法**：

```bash
lsblk [options] [device...]
```

**选项**：

```bash
-a, --all            显示所有设备。
-b, --bytes          以bytes方式显示设备大小。
-d, --nodeps         不显示 slaves 或 holders。
-D, --discard        print discard capabilities。
-e, --exclude <list> 排除设备 (default: RAM disks)。
-f, --fs             显示文件系统信息。
-h, --help           显示帮助信息。
-i, --ascii          use ascii characters only。
-m, --perms          显示权限信息。
-l, --list           使用列表格式显示。
-n, --noheadings     不显示标题。
-o, --output <list>  输出列。
-P, --pairs          使用key="value"格式显示。
-r, --raw            使用原始格式显示。
-t, --topology       显示拓扑结构信息。
```



## 示例

列出系统所有块设备（默认以树状展示）

```bash
$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0    7:0    0   9.1M  1 loop /snap/canonical-livepatch/97
...
sda      8:0    0 931.5G  0 disk
├─sda1   8:1    0 930.9G  0 part
└─sda2   8:2    0   642M  0 part
sdb      8:16   0   944G  0 disk
├─sdb1   8:17   0 190.8G  0 part /
├─sdb2   8:18   0     1K  0 part
├─sdb5   8:21   0  15.7G  0 part [SWAP]
└─sdb6   8:22   0 737.6G  0 part /home
sdc      8:32   1  29.7G  0 disk
├─sdc1   8:33   1  1023M  0 part
└─sdc2   8:34   1  28.7G  0 part
```

指定块设备：

```bash
$ lsblk /dev/sdc
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sdc      8:32   1 29.7G  0 disk
├─sdc1   8:33   1 1023M  0 part
└─sdc2   8:34   1 28.7G  0 part
```

七个栏目说明如下：

| 序号 |     字段     | 描述                                                         |
| :--: | :----------: | ------------------------------------------------------------ |
|  1   |    `NAME`    | 这是块设备名。                                               |
|  2   |  `MAJ:MIN`   | 本栏显示主要和次要设备号。                                   |
|  3   |     `RM`     | 本栏显示设备是否可移动设备。例如，在本例中设备 sdc 的 RM 值为1，表明它是可移动设备。 |
|  4   |    `SIZE`    | 本栏列出设备的容量大小信息。例如，190.8G 表明该设备大小为 190.8GB，而 1K 表明该设备大小为 1KB。 |
|  5   |     `RO`     | 该项表明设备是否为只读。例如，loop0 设备的 RO 值为1，表明它是只读的。 |
|  6   |    `TYPE`    | 本栏显示块设备是否是磁盘或磁盘上的一个分区。                 |
|  7   | `MOUNTPOINT` | 本栏指出设备挂载的挂载点。                                   |

默认选项不会列出所有空设备。要查看这些空设备，请使用以下命令：

```bash
lsblk -a
```

lsblk命令也可以用于列出一个特定设备的拥有关系，同时也可以列出组和模式。可以通过以下命令来获取这些信息：

```bash
lsblk -m
```

该命令也可以只获取指定设备的信息。这可以通过在提供给lsblk命令的选项后指定设备名来实现。例如，你可能对了解以字节显示你的磁盘驱动器大小比较感兴趣，那么你可以通过运行以下命令来实现：

```bash
lsblk -b /dev/sda

# 等价于

lsblk --bytes /dev/sda
```

你也可以组合几个选项来获取指定的输出。例如，你也许想要以列表格式列出设备，而不是默认的树状格式。你可能也对移除不同栏目名称的标题感兴趣。可以将两个不同的选项组合，以获得期望的输出，命令如下：

```bash
lsblk -nl
```

要获取 SCSI 设备的列表，你只能使用 -S 选项。该选项是大写字母 S，不能和 -s 选项混淆，该选项是用来以颠倒的顺序打印依赖的。

```bash
lsblk -S
```

lsblk 列出 SCSI 设备，而 -s 是逆序选项（将设备和分区的组织关系逆转过来显示），其将给出如下输出。输入命令：

```bash
lsblk -s
```

列出块设备的 LABLE、UUID 等信息

```bash
lsblk -f
```

