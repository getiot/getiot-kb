---
sidebar_label: env 命令
sidebar_position: 3
slug: /env
---

# env 命令 - 显示环境变量



## 介绍

**env** 是一个用于显示或设置环境变量的命令。在 Linux 系统中，它通常用于在运行命令时设置临时环境变量，以影响该命令的行为。

env 命令在脚本和命令行中非常有用，特别是当你想要在执行命令时设置特定的环境变量时。它提供了一种在不改变当前 shell 环境的情况下，临时修改环境变量的方法。

**语法**：

```bash
env [选项]... [-] [名称=值]... [命令 [参数]...]
```

**选项**：

- `-i, --ignore-environment`：以空环境启动（清除所有环境变量）。
- `-0, --null`：以 `NUL` 空字符而非换行符结束每一输出行。
- `-u,  --unset=名称`：从当前环境中移除一个变量。
- `-C, --chdir=目录`：将工作目录变更为指定目录。
- `-S, --split-string=S`：处理并将 `S` 拆分为单独的参数，用于在 shebang（`#!`）行上传递多个参数。
- `-v, --debug`：打印每个处理步骤的详细信息。
- `--help`：显示帮助信息并退出。
- `--version`：显示版本信息并退出。



## 示例

显示当前 shell 的所有环境变量：

```bash
env
```

设置环境变量 `VAR` 的值为 `value`，然后运行 `command`：

```bash
env VAR=value command
```

清除所有环境变量，然后仅设置 `VAR` 变量，并运行 `command`：

```bash
env -i VAR=value command
```

移除指定环境变量，并运行 `command`：

```bash
env -u VAR command
```

