---
sidebar_label: perf 命令
sidebar_position: 11
slug: /perf
---

# Linux perf 命令 - 性能分析与剖析



## 介绍

**perf** 是 Linux 内核自带的性能分析工具，基于 perf_events 子系统，可用于统计 CPU 性能计数器、记录函数调用栈、分析热点函数、跟踪调度延迟等。广泛应用于应用性能调优、内核开发和系统瓶颈排查。

perf 命令由 linux-tools 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装（版本需与内核匹配）。

```bash
sudo apt install linux-tools-common linux-tools-$(uname -r)
```

**语法**：

```bash
perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
```

**常用子命令**：

| 子命令 | 说明 |
| ------ | ---- |
| `stat` | 运行命令并收集性能计数器统计 |
| `record` | 记录性能数据到 perf.data |
| `report` | 读取 perf.data 并显示分析报告 |
| `top` | 实时显示性能热点（类似 top） |
| `list` | 列出可用的性能事件 |
| `annotate` | 显示带注释的汇编代码 |
| `script` | 将 perf.data 转为可脚本处理的文本 |
| `diff` | 比较两次 profile 的差异 |
| `probe` | 定义动态跟踪点（kprobe/uprobe） |
| `trace` | 跟踪系统调用（类似 strace） |
| `sched` | 分析调度器相关事件 |
| `mem` | 分析内存访问 |
| `lock` | 分析锁竞争 |
| `bench` | 运行内置基准测试 |
| `version` | 显示 perf 版本 |

相关命令：[strace](/linux-command/strace/)、[crash](/linux-command/crash/)、[kdump](/linux-command/kdump/)



## 示例

1、统计命令的 CPU 周期、指令数和缓存命中率：

```bash
perf stat ls -R /usr
```

2、记录程序的调用栈（采样 10 秒）：

```bash
perf record -g -F 99 sleep 10
perf report
```

3、实时查看系统热点函数：

```bash
sudo perf top
```

4、记录指定进程的性能数据：

```bash
perf record -g -p $(pidof myapp)
perf report
```

5、列出所有可用的性能事件：

```bash
perf list
```

6、跟踪程序的系统调用：

```bash
perf trace ls
```

7、比较两次 profile 的差异：

```bash
perf record -o before.data -g ./myapp --arg1
perf record -o after.data -g ./myapp --arg2
perf diff before.data after.data
```

8、将 perf.data 导出为文本供脚本分析：

```bash
perf script -i perf.data > trace.txt
```

9、分析特定函数的汇编热点：

```bash
perf annotate main
```
