---
sidebar_label: uname 命令
sidebar_position: 20
slug: /uname
---

# uname 命令



## 介绍

**uname** 是一个 Linux 命令，用于显示操作系统和内核的相关信息，包括内核名称、操作系统类型、内核版本等。它是一个非常有用的工具，可以快速获取关于系统的基本信息。

**语法**：

```shell
uname [OPTION]...
```

**选项**：

- `-a`, `--all`：显示所有信息，包括内核名称、主机名、内核版本、内核发布号、机器硬件名称、处理器类型、硬件平台和操作系统。
- `-s`, `--kernel-name`：显示内核名称。
- `-n`, `--nodename`：显示网络节点主机名。
- `-r`, `--kernel-release`：显示内核发布号。
- `-v`, `--kernel-version`：显示内核版本。
- `-m`, `--machine`：显示机器硬件名称。
- `-p`, `--processor`：显示处理器类型（有时是“unknown”）。
- `-i`, `--hardware-platform`：显示硬件平台（有时是“unknown”）。
- `-o`, `--operating-system`：显示操作系统名称。
- `--help`：显示帮助信息并退出。
- `--version`：显示版本信息并退出。



## 示例

显示所有信息：

```bash
$ uname -a
Linux Latitude-3420 5.15.0-107-generic #117~20.04.1-Ubuntu SMP Tue Apr 30 10:35:57 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
```

显示操作系统名称：

```bash
$ uname -o
GNU/Linux
```

显示内核名称：

```bash
$ uname -s
Linux
```

显示内核发布号：

```bash
$ uname -r
5.15.0-107-generic
```

显示内核版本：

```bash
$ uname -v
#117~20.04.1-Ubuntu SMP Tue Apr 30 10:35:57 UTC 2024
```

显示网络节点主机名：

```bash
$ uname -n
Latitude-3420
```

显示机器硬件名称：

```bash
$ uname -m
x86_64
```

显示处理器类型：

```bash
$ uname -p
x86_64
```

显示硬件平台：

```bash
$ uname -i
x86_64
```

