---
sidebar_label: nice 命令
sidebar_position: 13
slug: /nice
---

# Linux nice 命令 - 设置进程优先级



## 介绍

**nice** 命令用于指定 Linux 系统进程的调度优先级，即以更改过的优先序来执行程序。如果未指定程序，则会印出目前的排程优先序。nice 值的范围是 [-20, 19]，其中 -20 是最高优先级，19 是最低优先级。Linux 进程的默认 nice 值为 0。

优先级（priority）是操作系统用来决定 CPU 调度的一个重要参数，Linux 使用 Round-Robin 算法来处理 CPU 调度，优先级越高，所可能获得的 CPU 时间就越多。

相关命令：[renice](/linux-command/renice/), [chrt](/linux-command/chrt/)

**语法**：

```bash
nice [OPTION] [COMMAND [ARG]...]
```

**选项**：

- `-n`, `--adjustment=N`：在优先级数值上加上数字 N（默认为 10）。
- `--help`：显示此帮助信息并退出。
- `--version`：显示版本信息并退出。



## 示例

以指定进程优先级启动 vim 程序

```bash
nice -n 19 vim
```

通过 ps 命令查看 vim 进程的 nice 值

```bash
$ ps -efl
F S UID          PID    PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
...
0 S rudy     2768147 1831616  0  99  19 -  6985 do_sel 17:20 pts/14   00:00:00 vim
```

字段说明：

- `NI` 是优先值，是用户层面的概念；
- `PR` 是进程的实际优先级，是给内核（kernel）看（用）的。
