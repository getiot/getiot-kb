---
sidebar_position: 34
slug: /watch
---

# watch 命令



## 介绍

**watch** 命令用于在 Linux 系统中周期性地执行一个程序，并全屏显示该程序的输出信息。

默认的，watch 命令会以 2 秒一次的频率重复运行参数中指定的命令，直到运行被中断。

**语法**：

```bash
watch [options] command
```

**选项**：

- `-d`, `–differences` ：以高亮的形式显示出两次更新不同的部分，方便用户查看更改。
- `-n`, `–interval seconds` ：指定更新间隔，允许的最小时间间隔是 0.1 秒。
- `-p`, `–precise` ：尝试以 interval 间隔运行参数中的命令（默认间隔为 2 秒）。
- `-t`, `–no-title` ：不显示头部信息，包括运行间隔、运行命令、当前时间等信息。
- `-b`, `–beep` ：当命令异常退出时，发出蜂鸣声。
- `-e`, `–errexit` ：冻结命令错误的更新，并在按键后退出。
- `-g`, `–chgexit` ：当命令输出更改时，退出执行。
- `-c`, `–color` ：解释 ANSI 颜色和样式。
- `-x`, `–exec` ：此选项提供给 `sh -c`，这意味着您可能需要使用额外的引号才能获得所需的效果。

**参数**：command 命令及其选项参数



## 示例

周期显示系统内存使用情况，并高亮显示差异

```bash
watch -d  free -m
```

每秒刷新一次

```bash
watch -n 1 free -m
```

不显示头部信息

```bash
watch -t free -m
```

