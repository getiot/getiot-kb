---
sidebar_position: 15
slug: /chrt
---

# chrt 命令



## 介绍

**chrt**（英文全拼：change real-time）是 Linux 系统中操作进程/线程实时属性的命令，可用于查看和设置进程/线程的调度策略。

Linux 内核有三种常见调度策略：

- `SCHED_OTHER` 分时调度策略（默认调度策略）；
- `SCHED_FIFO` 实时调度策略，先到先服务；
- `SCHED_RR` 实时调度策略，时间片轮转（RR 是 round-robin 的缩写）。

在 Linux 系统中，所有优先级值在 0-99 范围内的，都是实时进程。因此，0-99 优先级也被称为实时进程优先级，而 100-139 范围内的则是非实时进程。

相关命令：[nice](/linux-command/nice), [renice](/linux-command/renice)

**语法**：

```bash
chrt [options] [prio] [pid | command [arg]...]
```

**选项**：

- `-a`, `--all-tasks`：设置或检索给定 PID 的所有任务（线程）的调度属性。
- `-m`, `--max`：显示最小和最大有效优先级，然后退出。
- `-p`, `--pid`：操作一个已存在的 PID，不启动一个新的任务。
- `-v`, `--verbose`：显示详细状态信息。
- `-h`, `--help`：显示帮助信息。
- `-V`, `--version`：打印版本信息。

**调度策略**：

- `-o`, `--other`：设置策略调度策略为 `SCHED_OTHER`。
- `-f`, `--fifo`：设置调度策略为 `SCHED_FIFO`。
- `-r`, `--rr`：设置调度策略为 `SCHED_RR`（当未指定策略时，默认设置为该策略）。
- `-b`, `--batch`：设置调度策略为 `SCHED_BATCH`（自 2.6.16 起支持），优先级参数必须设置为零。
- `-i`, `--idle`：设置调度策略为 `SCHED_IDLE`（自 2.6.23 起支持），优先级参数必须设置为零。
- `-d`, `--deadline`：设置调度策略为 `SCHED_DEADLINE`（自 3.14 起支持），优先级参数必须设置为零。

**调度选项**：

- `-T`, `--sched-runtime <nanoseconds>`：指定 `SCHED_DEADLINE` 策略的运行时参数。
- `-P`, `--sched-period <nanoseconds>`：指定 `SCHED_DEADLINE` 策略的周期参数。
- `-D`, `--sched-deadline <nanoseconds>`：指定 `SCHED_DEADLINE` 策略的截止时间参数。
- `-R`, `--reset-on-fork`：将 `SCHED_RESET_ON_FORK` 标志添加到 `SCHED_FIFO` 或 `SCHED_RR` 调度策略（自 2.6.31 起支持）。



## 示例

查看 Linux 系统最小和最大的优先级：

```bash
$ chrt -m
SCHED_OTHER 最小/最大优先级	: 0/0
SCHED_FIFO 最小/最大优先级	: 1/99
SCHED_RR 最小/最大优先级	: 1/99
SCHED_BATCH 最小/最大优先级	: 0/0
SCHED_IDLE 最小/最大优先级	: 0/0
SCHED_DEADLINE 最小/最大优先级	: 0/0
```

查看 PID 为 137619 的进程调度信息：

```bash
$ chrt -p 137619
pid 137619 当前的调度策略︰ SCHED_OTHER
pid 137619 的当前调度优先级：0
```

将 PID 为 137619 的进程设置为 `SCHED_RR` 实时调度，且优先级为 30：

```bash
$ chrt -r -p 30 137619
```

将 PID 为 137619 的进程设置为默认的 `SCHED_OTHER` 调度策略：

```bash
$ chrt -o -p 0 137619
```

借助 [`pidof`](/linux-command/pidof) 和 [`xargs`](/linux-command/xargs) 命令可以直接使用进程名称查询 PID，并传递给 chrt 命令。例如将 rviz2 进程优先级设置为 10：

```bash
$ pidof rviz2 | sudo xargs chrt -r -p 10
```

