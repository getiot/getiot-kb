---
sidebar_label: taskset 命令
sidebar_position: 16
slug: /taskset
---

# Linux taskset 命令 - 设置进程的 CPU 亲和性



## 介绍

**taskset**（英文全拼：task set）命令用于绑定 Linux 进程与 CPU 核心。一般情况下，一个程序启动后，其进程会在 CPU 核心之间切换执行，在系统的调度下，每个进程平均公平地分配到一定量的计算资源。有时候，运维人员想将某个进程与指定 CPU 核心进行绑定操作，以提高性能，这就需要用到 taskset 命令。

**语法**：

```bash
taskset [options] mask command [argument...]
taskset [options] -p [mask] pid
```

**选项**：

- `-a`, `--all-tasks`：设置或检索给定 PID 的所有任务（线程）的 CPU 关联性。
- `-c`, `--cpu-list`：将掩码解释为处理器的数字列表而不是位掩码。数字以逗号分隔，并且可能包含范围。例如：0,5,8-11。
- `-p`, `--pid`：对现有 PID 进行操作并且不启动新任务。
- `-V`, `--version`：显示版本信息并退出。
- `-h`, `--help`：显示帮助信息并退出。



## 示例

查询进程 7589 当前使用的 CPU 核心信息：

```bash
$ taskset -pc 7589
pid 7589's current affinity list: 0-7
```

设置进程 7589 只可运行在编号为 7 的 CPU 核心之上：

```bash
$ taskset -pc 7 7589 
pid 7589's current affinity list: 0-7
pid 7589's new affinity list: 7
```

设置进程 7589 只可运行在编号为 6 和 7 的 CPU 核心之上：

```bash
$ taskset -pc 6-7 7589 
pid 7589's current affinity list: 0-7
pid 7589's new affinity list: 6,7
```

启动 simple_viewer 程序并限定其只能在 CPU 核心 0、1、2、3 上运行：

```bash
taskset -c 0-3 ./simple_viewer -type A1 -pcap test.pcap
```

启动后可借助 [pgrep](/linux-command/pgrep) 命令查看该进程 ID，查询当前使用的 CPU 核心信息：

```bash
taskset -pc $(pgrep simple_viewer)
```

