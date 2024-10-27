---
sidebar_label: umount 命令
sidebar_position: 13
slug: /umount
---

# umount 命令



## 介绍

**umount**（英文全拼：unmount）命令用于卸载文件系统。

利用设备名或挂载点都能 umount 文件系统，不过最好还是通过挂载点卸载，以免使用绑定挂载（一个设备，多个挂载点）时产生混乱。如果存在多个挂载点，每次执行 umount 会按先进后出的方式卸载。

相关命令：[mount](/linux-command/mount)

**语法**：

```bash
umount [选项] [参数]
```

详细语法格式：

```bash
umount -a [-dflnrv] [-t fstype] [-O option...]
umount [-dflnrv] {directory|device}...
umount -h|-V
```

**选项**：

- `-a` 卸载 /etc/mtab 中记录的所有文件系统。
- `-h` 显示帮助。
- `-n` 卸载时不要将信息存入 /etc/mtab 文件中。
- `-r` 若无法成功卸载，则尝试以只读的方式重新挂载文件系统。
- `-t <文件系统类型>` 仅卸载选项中所指定的文件系统。
- `-v` 执行时显示详细的信息。
- `-V` 显示版本信息。

**参数**：文件系统（可以是设备名或挂载点）。



## 示例

通过设备名卸载，并打印详细信息：

```bash
$ sudo umount -v /dev/sdc1
umount: /mnt (/dev/sdc1) unmounted
```

通过挂载点卸载，并打印详细信息：

```bash
$ sudo umount -v /mnt
umount: /mnt unmounted
```

注意：执行 umount 命令需要 root 权限，因此需要在命令前添加 sudo。

如果设备正忙，执行 umount 将会失败。卸载失败的常见原因是，某个打开的 shell 当前目录为挂载点里的某个目录。

```bash
$ sudo umount -v /mnt
umount: /mnt: target is busy.
```

有时，导致设备忙的原因并不好找。碰到这种情况时，可以用 [lsof](/linux-command/lsof) 列出已打开文件，然后搜索列表查找待卸载的挂载点。

```bash
$ lsof | grep mnt
bash    1894    rudy  cwd    DIR    8,33    4096    1 /mnt
```

从上面的输出可知，无法卸载的原因在于，rudy 运行的 PID 为 1894 的 bash 进程打开了挂载点 /mnt。

应对系统文件正忙的另一种方法是执行延迟卸载：

```bash
$ sudo umount -vl /mnt
```

延迟卸载（lazy unmount）会立即卸载目录树里的文件系统，等到设备不再繁忙时才清理所有相关资源。卸载可移动存储介质还可以用 [eject](/linux-command/eject) 命令。

下面命令会卸载 cdrom 分区并弹出 CD：

```bash
$ sudo eject /dev/cdrom
```

