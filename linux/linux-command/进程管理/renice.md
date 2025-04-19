---
sidebar_label: renice 命令
sidebar_position: 14
slug: /renice
---

# Linux renice 命令 - 改变运行中进程的优先级



## 介绍

**renice** 命令用于修改 Linux 系统中正在运行的进程的调度优先级。该命令默认是以进程 PID 指定程序调整其优先权，你也可以指定程序群组或用户名称调整优先权等级，并修改所有隶属于该程序群组或用户的程序的优先级。

注意：只有系统管理员可以改变其他用户程序的优先权，也仅有系统管理员可以设置负数等级。

相关命令：[nice](/linux-command/nice/), [chrt](/linux-command/chrt/)

**语法**：

```bash
renice [-n] priority [-g|-p|-u] identifier...
```

**选项**：

- `-n`, `--priority <数字>`：指定 nice 增量。
- `-p`, `--pid <id>`：将参数解释为进程 ID（默认）。
- `-g`, `--pgrp <id>`：将参数解释为进程组 ID。
- `-u`, `--user <name>|<id>`：将参数解释为 用户名 或 用户 ID。
- `-h`, `--help`：显示此帮助信息并退出。
- `-V`, `--version`：显示版本信息并退出。



## 示例

修改指定进程（使用 PID 号）的调度优先级为 5

```bash
renice 5 -p <PID>
```

将指定进程（使用 PID 号）的调度优先级加 1

```bash
renice +1 -p <PID>
```

