---
sidebar_position: 48
slug: /shutdown
---

# shutdown 命令



## 介绍

在 Linux 系统中，**shutdown** 命令用来系统关机命令。shutdown 指令可以关闭所有程序，并依用户的需要，进行重新开机或关机的动作。

**语法**：

```bash
shutdown [OPTIONS...] [TIME] [WALL...]
```

**选项**：

- `-c`：当执行 `shutdown -h 11:50` 指令时，只要按 `+` 键就可以中断关机的指令。
- `-f`：重新启动时不执行 [fsck](/linux-command/fsck)。
- `-F`：重新启动时执行 [fsck](/linux-command/fsck)。
- `-h`：将系统关机。
- `-k`：只是送出信息给所有用户，但不会实际关机。
- `-n`：不调用init程序进行关机，而由 shutdown 自己进行。
- `-r`：shutdown 之后重新启动。
- `-t`：送出警告信息和删除信息之间要延迟多少秒。



## 示例

现在立即关机：

```bash
$ sudo shutdown -h now
```

立即重新启动：

```bash
$ sudo shutdown -r now
```

指定 10 分钟后关机：

```shell
$ sudo shutdown +10
```

指定 10 分钟后关机，同时送出警告信息给登入用户：

```bash
$ sudo shutdown +10 "System will shutdown after 10 minutes"
```

指定关机时间：

```shell
$ sudo shutdown -h 22:12
```

取消按预定时间关闭系统：

```bash
$ shutdown -c
```

