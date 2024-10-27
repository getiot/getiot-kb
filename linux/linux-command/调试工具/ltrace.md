---
sidebar_label: ltrace 命令
sidebar_position: 6
slug: /ltrace
---

# ltrace 命令



## 介绍

**ltrace**（英文全拼：library call tracer）是一个用于跟踪进程调用库函数的命令行工具。它可以显示应用程序运行时调用的共享库函数，并输出它们的参数和返回值。以帮助调试应用程序，了解其运行时行为。

ltrace 基于 ptrace 实现，而 ptrace 能够用来跟踪系统调用，ltrace 打开 elf 文件时会对其进行分析。由于在 elf 文件中，出于动态连接的需要，需要在 elf 文件中保存函数的符号以供连接器使用，因此 ltrace 就能跟踪到库函数的调用。

**语法**：

```bash
ltrace [option ...] [command [arg ...]]
```

**选项**：

- `-a, --align <column>`：对齐具体某个列的返回值。
- `-c`：统计每个库函数的调用次数和时间，并在程序退出时打印摘要。
- `-D, --debug <mask>`：打印调试信息。
- `-e <filter>`：指定要跟踪的事件，例如特定函数。
- `-f`：跟踪子进程。
- `-l, --library <library_pattern>`：只打印某个库中的调用。
- `-o, --output <filename>`：将输出保存到指定的文件中。
- `-p <pid>`：指定要跟踪的进程 ID。
- `-s <size>`：限制参数和返回值的显示大小。
- `-S`：显示系统调用（system calls）以及库调用（library calls）。
- `-T`：显示每个函数调用的耗时。



## 示例

最基本应用，不带任何参数：

```bash
$ ltrace ./a.out 
```

输出调用时间开销：

```bash
$ ltrace -T ./a.out 
```

显示系统调用：

```bash
$ ltrace -S ./a.out 
```

计算时间和调用，并在程序退出时打印摘要：

```bash
$ ltrace -c ./a.out 
```

只跟踪 `malloc` 和 `free` 函数的调用：

```bash
$ ltrace -e malloc,free ./a.out
```
