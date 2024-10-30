---
sidebar_label: printenv 命令
sidebar_position: 4
slug: /printenv
---

# Linux printenv 命令 - 打印环境变量



## 介绍

**printenv** 命令用于显示当前环境变量的值。它在 Linux 和 Unix 系统上广泛使用，允许用户查看当前 shell 进程中定义的所有环境变量。

:::tip 注意

printenv 只能查看当前 shell 的环境变量，如果有子 shell 或新的进程，则它们将具有独立的环境。

:::

和 [env](/linux-command/env) 命令不同，`printenv` 主要用于显示环境变量，而不提供设置环境变量的功能。而 `env` 不仅可以显示环境变量，还可以在运行命令时设置环境变量。

**语法**：

```bash
printenv [选项]... [变量]...
```

**选项**：

- `-0, --null`：以空字符而非换行符结束每一输出行。
- `--help`：显示帮助信息并退出。
- `--version`：显示版本信息并退出。

如果没有指定变量，则打印出所有变量的名称和值。



## 示例

显示当前 shell 进程中定义的所有环境变量及其值：

```bash
printenv
```

显示环境变量 `PATH` 的值：

```bash
printenv PATH
```

