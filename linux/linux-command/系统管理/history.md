---
sidebar_label: history 命令
sidebar_position: 39
slug: /history
---

# history 命令 - 显示命令历史



## 介绍

**history** 命令用于列出当前用户的历史操作记录。可带数字参数用于指定需要查看的最近的命令条目。

history 的工作原理是启动 Shell 时读取环境变量 `HISTFILE` 文件（默认是 ~/.bash_history）中的历史记录，存储在相应内存的缓冲区中，以便于用户可以通过上下方向键或符号 `!` 指定序号查找历史命令。用户在 Shell 中的所有操作记录都会存储在缓冲区中，直到退出 Shell，或者显式执行回写。

除了 `HISTFILE` 变量，history 命令还受如下一些环境变量影响：

- `HISTSIZE` ：该变量用于控制存储历史命令的条目数量，默认为 1000，即仅能够存储 1000 条历史命令。
- `HISTFILESIZE` ：控制历史记录文件中的最大个数。
- `HISTIGNORE` ：设置哪些命令不记录到历史记录。
- `HISTTIMEFORMAT` ：设置历史命令显示的时间格式。
- `HISTCONTROL` ：扩展的控制选项。比如 ignorespace 表示忽略空格开头的命令，ignoredups 表示忽略连续重复命令，ignoreboth 表示上述两个参数都设置。

**语法**：

```bash
history [选项] [参数]
```

**选项**：

- `-c` ：清空当前历史命令。
- `-a` ：将历史命令缓冲区中命令写入历史命令文件中。
- `-r` ：将历史命令文件中的命令读入当前历史命令缓冲区。
- `-w` ：将当前历史命令缓冲区命令写入历史命令文件中。

**参数**：打印最近的 n 条历史命令。



## 示例

显示最近使用的10条历史命令

```bash
history  10
```

将当前缓冲区中的历史命令写入历史命令文件（~/.bash_history）

```bash
history  -w
```

