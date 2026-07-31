---
sidebar_label: crash 命令
sidebar_position: 9
slug: /crash
description: "crash 是一个用于交互式分析 Linux 内核崩溃转储（vmcore）和运行中内核状态的调试工具。"
---

# Linux crash 命令 - 分析内核崩溃转储



## 介绍

**crash** 是一个用于交互式分析 Linux 内核崩溃转储（vmcore）和运行中内核状态的调试工具。它整合了 gdb 风格的命令接口和大量内核专用命令，可查看调用栈、进程列表、内存、寄存器、模块信息等，是分析 [kdump](/linux-command/kdump/) 产生的崩溃转储文件的主要工具。

crash 命令由 crash 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```bash
sudo apt install crash
```

分析 vmcore 时还需要对应内核版本的调试符号（`linux-image-*-dbg` 或 `vmlinux`）。

**语法**：

```bash
crash [options] [namelist] [system-map] [dumpfile]
crash [options] [namelist] -d dumpfile
```

**常用选项**：

- `-h`：显示帮助
- `-s`：进入 batch 模式，不显示启动信息
- `-i file`：启动时执行命令文件
- `-d dumpfile`：指定转储文件

**常用交互命令**：

| 命令 | 说明 |
| ---- | ---- |
| `help` | 显示帮助 |
| `log` | 显示内核日志缓冲区 |
| `bt` | 显示当前上下文调用栈 |
| `bt -a` | 显示所有 CPU 的调用栈 |
| `ps` | 显示进程列表 |
| `vm` | 显示虚拟内存信息 |
| `files` | 显示进程打开的文件 |
| `mount` | 显示挂载信息 |
| `mod` | 显示已加载内核模块 |
| `dev` | 显示设备信息 |
| `kmem -i` | 显示内核内存使用摘要 |
| `sys` | 显示系统信息 |
| `exit` / `q` | 退出 |

相关命令：[kdump](/linux-command/kdump/)、[perf](/linux-command/perf/)、[strace](/linux-command/strace/)



## 示例

1、分析 kdump 产生的 vmcore 文件：

```bash
sudo crash /usr/lib/debug/boot/vmlinux-$(uname -r) /var/crash/127.0.0.1-*/vmcore
```

2、分析运行中内核的实时状态（需要 root 权限）：

```bash
sudo crash /usr/lib/debug/boot/vmlinux-$(uname -r)
```

3、启动后查看崩溃时的内核日志：

```bash
crash> log
```

4、查看崩溃时所有 CPU 的调用栈：

```bash
crash> bt -a
```

5、查看崩溃时的进程列表：

```bash
crash> ps
```

6、查看指定进程（如 PID 1）的调用栈：

```bash
crash> bt 1
```

7、查看内核内存使用情况：

```bash
crash> kmem -i
```

8、以 batch 模式执行命令脚本：

```bash
crash -s -i commands.txt vmlinux vmcore
```
