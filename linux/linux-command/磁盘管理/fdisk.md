---
sidebar_label: fdisk 命令
sidebar_position: 17
slug: /fdisk
---

# fdisk 命令



## 介绍

**fdisk** 是一个创建和维护分区表的程序，它兼容 DOS 类型的分区表、BSD 或者 SUN 类型的磁盘列表。

fdisk 命令可用于观察硬盘实体使用情况，也可对硬盘分区。它采用传统的问答式界面，而非类似 DOS fdisk 的 cfdisk 互动式操作界面，因此在使用上较为不便，但功能却丝毫不打折扣。

**语法**： 

```bash
fdisk [选项] [参数]
```

**选项**： 

- `-b <分区大小>`：指定每个分区的大小。
- `-l`：列出指定的外围设备的分区表状况。
- `-s <分区编号>`：将指定的分区大小输出到标准输出上，单位为区块。
- `-u`：搭配 "`-l`" 参数列表，会用分区数目取代柱面数目，来表示每个分区的起始地址。
- `-v`：显示版本信息。

**参数**： 指定要进行分区或者显示分区的硬盘设备文件。

**分区菜单操作说明**：

- `m` ：显示菜单和帮助信息
- `a` ：活动分区标记/引导分区
- `d` ：删除分区
- `l` ：显示分区类型
- `n` ：新建分区
- `p` ：显示分区信息
- `q` ：退出不保存
- `t` ：设置分区号
- `v` ：进行分区检查
- `w` ：保存修改
- `x` ：扩展应用，高级功能



## 示例

显示当前分区情况：

```bash
$ sudo fdisk -l

Disk /dev/sda: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

  Device Boot   Start     End   Blocks  Id System
/dev/sda1  *      1     13   104391  83 Linux
/dev/sda2       14    1305  10377990  8e Linux LVM

Disk /dev/sdb: 5368 MB, 5368709120 bytes
255 heads, 63 sectors/track, 652 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

Disk /dev/sdb doesn't contain a valid partition table
```

对磁盘进行分区，首先选择要进行操作的磁盘（如 /dev/sdb）：

```bash
$ sudo fdisk /dev/sdb
```

输入 `m` 列出可以执行的命令：

```bash
command (m for help): m
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)
```

输入`p`列出磁盘目前的分区情况：

```bash
Command (m for help): p

Disk /dev/sdb: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1           1        8001   8e  Linux LVM
/dev/sdb2               2          26      200812+  83  Linux
```

输入`d`然后选择分区，删除现有分区：

```bash
Command (m for help): d
Partition number (1-4): 1

Command (m for help): d
Selected partition 2
```

查看分区情况，确认分区已经删除：

```bash
Command (m for help): print

Disk /dev/sdb: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System

Command (m for help):
```

输入`n`建立新的磁盘分区，首先建立两个主磁盘分区：

```bash
Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p    # 建立主分区
Partition number (1-4): 1  # 分区号
First cylinder (1-391, default 1):  # 分区起始位置
Using default value 1
last cylinder or +size or +sizeM or +sizeK (1-391, default 391): 100  # 分区结束位置，单位为扇区

Command (m for help): n  # 再建立一个分区
Command action
   e   extended
   p   primary partition (1-4)
p 
Partition number (1-4): 2  # 分区号为2
First cylinder (101-391, default 101):
Using default value 101
Last cylinder or +size or +sizeM or +sizeK (101-391, default 391): +200M  # 分区结束位置，单位为M
```

确认分区建立成功：

```bash
Command (m for help): p

Disk /dev/sdb: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         100      803218+  83  Linux
/dev/sdb2             101         125      200812+  83  Linux
```

再建立一个逻辑分区：

```bash
Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
e  # 选择扩展分区
Partition number (1-4): 3
First cylinder (126-391, default 126):
Using default value 126
Last cylinder or +size or +sizeM or +sizeK (126-391, default 391):
Using default value 391
```

确认扩展分区建立成功：

```bash
Command (m for help): p

Disk /dev/sdb: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         100      803218+  83  Linux
/dev/sdb2             101         125      200812+  83  Linux
/dev/sdb3             126         391     2136645    5  Extended
```

在扩展分区上建立两个逻辑分区：

```bash
Command (m for help): n
Command action
   l   logical (5 or over)
   p   primary partition (1-4)
l # 选择逻辑分区
First cylinder (126-391, default 126):
Using default value 126
Last cylinder or +size or +sizeM or +sizeK (126-391, default 391): +400M    

Command (m for help): n
Command action
   l   logical (5 or over)
   p   primary partition (1-4)
l
First cylinder (176-391, default 176):
Using default value 176
Last cylinder or +size or +sizeM or +sizeK (176-391, default 391):
Using default value 391
```

确认逻辑分区建立成功：

```bash
Command (m for help): p

Disk /dev/sdb: 3221 MB, 3221225472 bytes
255 heads, 63 sectors/track, 391 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         100      803218+  83  Linux
/dev/sdb2             101         125      200812+  83  Linux
/dev/sdb3             126         391     2136645    5  Extended
/dev/sdb5             126         175      401593+  83  Linux
/dev/sdb6             176         391     1734988+  83  Linux

Command (m for help):
```

从上面的结果我们可以看到，在硬盘sdb我们建立了2个主分区（sdb1，sdb2），1个扩展分区（sdb3），2个逻辑分区（sdb5，sdb6）

注意：主分区和扩展分区的磁盘号位1-4，也就是说最多有4个主分区或者扩展分区，逻辑分区开始的磁盘号为5，因此在这个实验中试没有 sdb4 的。

最后对分区操作进行保存：

```bash
Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
```

建立好分区之后我们还需要对分区进行格式化才能在系统中使用磁盘。

在 sdb1 上建立 ext2 分区：

```bash
$ sudo mkfs.ext2 /dev/sdb1
```

在 sdb6 上建立 ext3 分区：

```bash
$ sudo mkfs.ext3 /dev/sdb6
```

建立两个目录 `/oracle` 和 `/web`，将新建好的两个分区挂载到系统：

```bash
$ sudo mkdir /oracle
$ sudo mkdir /web
$ sudo mount /dev/sdb1 /oracle
$ sudo mount /dev/sdb6 /web
```

查看分区挂载情况：

```bash
$ df -h
文件系统              容量  已用 可用 已用% 挂载点
/dev/mapper/VolGroup00-LogVol00
                      6.7G  2.8G  3.6G  44% /
/dev/sda1              99M   12M   82M  13% /boot
tmpfs                 125M     0  125M   0% /dev/shm
/dev/sdb1             773M  808K  733M   1% /oracle
/dev/sdb6             1.7G   35M  1.6G   3% /web
```

如果需要每次开机自动挂载则需要修改 `/etc/fstab` 文件，加入两行配置：

```bash
/dev/sdb1       /oracle    ext2    defaults      0 0
/dev/sdb6       /web       ext3    defaults      0 0
```

