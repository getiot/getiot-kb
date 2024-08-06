---
sidebar_position: 17
slug: /pidof
---

# pidof 命令



## 介绍

**pidof** 命令用于查找 Linux 系统中指定名称的进程的进程号（PID），功能类似 [pgrep](/linux-command/pgrep) 和 [ps](/linux-command/ps)。

**语法**：

```bash
pidof [options] <program-name>
```

**选项**：

- `-c`：仅显示具有相同“root”目录的进程号。
- `-d <sep>`：使用提供的字符作为输出分隔符。
- `-n`：避免在网络共享上使用 stat 系统函数。
- `-o <pid>`：指定不显示的进程号。
- `-q`：安静模式，不显示输出。
- `-s`：仅返回一个进程号。
- `-x`：显示由脚本开启的进程。
- `-z`：列出僵尸进程和 I/O 等待进程。可能会导致 pidof 挂起。
- `-h`：显示帮助信息。

**参数**：

- `program-name`：指定要查找的进程名称。



## 示例

查询 apache2 进程的 PID：

```bash
$ pidof apache2 
232746 232745 232744 232743 232742 2157
```

以逗号分隔：

```bash
$ pidof -d ','  apache2 
232746,232745,232744,232743,232742,2157
```

只返回一个进程号：

```bash
$ pidof -s apache2 
232746
```

