---
sidebar_label: jobs 命令
sidebar_position: 8
slug: /jobs
---

# Linux jobs 命令 - 列出当前作业



## 介绍

**jobs** 命令用于查看当前终端（tty）的任务列表及任务状态，包括后台运行的任务。

该命令可以显示任务号及其对应的进程号。其中，任务号是以普通用户的角度进行的，而进程号则是从系统管理员的角度来看的。一个任务可以对应于一个或者多个进程号。

在 Linux 系统中执行某些操作时候，有时需要将当前任务暂停调至后台（CTRL+Z），或有时需要将后台暂停的任务重启开启并调至前台，这一系列的操作将会使用到 [jobs](/linux-command/jobs)、[bg](/linux-command/bg) 和 [fg](/linux-command/fg) 三个命令以及快捷键来完成。

**语法**： 

```bash
jobs [选项] [参数]
```

**选项**： 

- `-l`：显示进程号
- `-p`：仅任务对应的显示进程号
- `-n`：显示任务状态的变化
- `-r`：仅输出运行状态（running）的任务
- `-s`：仅输出停止状态（stoped）的任务

**参数**：指定要显示的任务识别号



## 示例

打开终端，此时任务列表为空，执行 jobs 不会有任何输出。假设当前目录下有一张 GetIoT.png 图片，执行如下命令将其打开，以创建一个任务。

```bash
$ eog GetIoT.png
```

该任务将占用当前终端，按 CTRL+Z 键暂停任务，查看当前任务列表：

```bash
$ jobs
[1]+  已停止               eog GetIoT.png
```

加 `-l` 显示进程号：

```bash
$ jobs -l
[1]+ 22702 停止                  eog GetIoT.png
```

输出信息的第1列表示任务编号，第2列表示任务所对应的进程号，第3列表示任务的运行状态，第4列表示启动任务的命令。

此时任务进入处于停止状态，执行 bg 将任务从后台启动：

```bash
$ bg
[1]+ eog GetIoT.png &
```

再次查看任务列表：

```bash
$ jobs -l
[1]+ 22702 运行中               eog GetIoT.png &
```

执行 fg 将任务调到前台：

```bash
$ fg
eog GetIoT.png
```

按 CTRL+C 终止程序。

