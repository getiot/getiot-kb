---
sidebar_label: mount 命令
sidebar_position: 12
slug: /mount
---

# Linux mount 命令 - 挂载文件系统



## 介绍

**mount** 命令用于挂载系统外的文件系统到指定加载点。

相关命令：[umount](/linux-command/umount)

**语法**：

```bash
mount [选项] [参数]
```

详细语法格式：

```bash
mount [-l|-h|-V]
mount -a [-fFnrsvw] [-t fstype] [-O optlist]
mount [-fnrsvw] [-o options] device|dir
mount [-fnrsvw] [-t fstype] [-o options] device dir
```

**参数**：

- `-V`：显示程序版本。
- `-h`：显示辅助信息。
- `-l`：显示以加载的文件系统列表。
- `-v`：冗长模式，输出指令执行的详细信息，通常和 `-f` 用来除错。
- `-a`：将 /etc/fstab 中定义的所有档案系统挂上。
- `-F`：这个命令通常和 `-a` 一起使用，它会为每一个 mount 的动作产生一个行程负责执行。在系统需要挂上大量 NFS 档案系统时可以加快挂上的动作。
- `-f`：通常用在除错的用途。它会使 mount 并不执行实际挂上的动作，而是模拟整个挂上的过程。通常会和 `-v` 一起使用。
- `-n`：加载没有写入文件“/etc/mtab”中的文件系统。
- `-r`：将文件系统加载为只读模式。
- `-s-r`：等于 `-o ro`
- `-w`：等于 `-o rw`
- `-L`：将含有特定标签的硬盘分割挂上。
- `-U`：将档案分割序号为 的档案系统挂下。`-L` 和 `-U` 必须在 /proc/partition 这种档案存在时才有意义。
- `-t`：指定档案系统的型态，通常不必指定。mount 会自动选择正确的型态。
- `-o async`：打开非同步模式，所有的档案读写动作都会用非同步模式执行。
- `-o sync`：在同步模式下执行。
- `-o atime`、`-o noatime`：当 atime 打开时，系统会在每次读取档案时更新档案的『上一次调用时间』。当我们使用 flash 档案系统时可能会选项把这个选项关闭以减少写入的次数。
- `-o auto`、`-o noauto`：打开/关闭自动挂上模式。
- `-o defaults`：使用预设的选项 rw, suid, dev, exec, auto, nouser, and async.
- `-o dev`、`-o nodev-o exec`、`-o noexec` 允许执行档被执行。
- `-o suid`、`-o nosuid`：允许执行档在 root 权限下执行。
- `-o user`、`-o nouser`：使用者可以执行 mount/umount 的动作。
- `-o remount`：将一个已经挂下的档案系统重新用不同的方式挂上。例如原先是只读的系统，现在用可读写的模式重新挂上。
- `-o ro`：用只读模式挂载。
- `-o rw`：用可读写模式挂载。
- `-o loop=`：使用 loop 模式用来将一个档案当成硬盘分割挂载上系统。

**参数**：

- 设备文件名：指定要加载的文件系统对应的设备名（如 /dev/sdb1）；
- 加载点：指定加载点目录。



## 示例

将 /dev/sdb1 挂载到 /mnt 目录

```bash
mount /dev/sdb1 /mnt
```

将 /dev/sdb1 以只读方式挂载到 /mnt 目录

```bash
mount -o ro /dev/sdb1 /mnt
```

挂载光盘设备到 /mnt/cdrom 目录（目录不存在，需要先创建）

```bash
mount -t auto /dev/cdrom /mnt/cdrom
```

将 /tmp/image.iso 这个光碟的 image 档使用 loop 模式挂载到 /mnt/cdrom 目录。用这种方法可以将一般网络上可以找到的 Linux 光碟 ISO 档在不烧录成光碟的情况下查看其内容。

```bash
mount -o loop /tmp/image.iso /mnt/cdrom
```

将远程 NFS 网络文件系统挂载到本地 /mnt 目录

```bash
mount -t nfs -o nolock 192.168.30.189:/srv/nfs/ /mnt/
```

