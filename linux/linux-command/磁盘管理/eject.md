---
sidebar_label: eject 命令
sidebar_position: 14
slug: /eject
---

# Linux eject 命令 - 弹出可移动介质



## 介绍

**eject** 命令用于退出抽取式设备。若设备已挂载，则先将该设备卸载再退出。

eject 允许可移动介质（典型是 CD-ROM、软盘、磁带、或者 JAZ 以及 zip 磁盘）在软件控制下弹出。该命令也可以控制一些多盘片 CD-ROM 控制器，控制一些设备支持的自动弹出功能，以及控制一些 CD-ROM 驱动器磁盘托盘的关闭。

**语法**：

```bash
eject [选项] [参数]
```

详细语法格式：

```bash
eject [-vnrsfmqp] [<name>]
eject [-vn] -d
eject [-vn] -a on|off|1|0 [<name>]
eject [-vn] -c slot [<name>]
eject [-vn] -i on|off|1|0 [<name>]
eject [-vn] -t [<name>]
eject [-vn] -T [<name>]
eject [-vn] -x <speed> [<name>]
eject [-vn] -X [<name>]
```

**选项**：

- `-a <开关>` 或 `--auto <开关>`：控制设备的自动退出功能。
- `-c <光驱编号>` 或 `--changerslut <光驱编号>`：选择光驱柜中的光驱。
- `-d` 或 `--default`：显示预设的设备，而不是实际执行动作。
- `-f` 或 `--floppy`：退出抽取式磁盘。
- `-h` 或 `--help`：显示帮助。
- `-n` 或 `--noop`：显示指定的设备。
- `-q` 或 `--tape`：退出磁带。
- `-r` 或 `--cdrom`：退出光盘。
- `-s` 或 `--scsi`：以 SCSI 指令来退出设备。
- `-t` 或 `--trayclose`：关闭光盘的托盘。
- `-v` 或 `--verbose`：执行时，显示详细的说明。

**参数**：指定弹出的文件 name，可以是设备名或挂载点。



## 示例

不加参数默认弹出

```bash
$ eject
```

指定弹出设备

```bash
$ eject -r /dev/cdrom
```

