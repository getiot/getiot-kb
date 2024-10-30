---
sidebar_label: unset 命令
sidebar_position: 2
slug: /unset
---

# Linux unset 命令 - 取消环境变量



## 介绍

**unset** 命令用于删除已定义的 shell 变量（包括环境变量）或函数的值和属性。注意，unset 命令不能够删除具有只读属性（参考 readonly）的 shell 变量和环境变量。

**语法**：

```bash
unset [-f] [-v] [-n] [NAME ...]
```

**选项**：

- `-f`：将每个 `NAME` 视为函数。
- `-v`：将每个 `NAME` 视为变量。
- `-n`：将每个 `NAME` 视为名称引用，只取消其本身而非其指向的变量。

**参数**：对每一个 `NAME` 名称，删除对应的变量或函数。

:::tip

unset 是 bash 内建命令，相关的帮助信息可通过命令 `help unset` 查看。

:::

## 示例

先使用 [export](/linux-command/export) 创建一个环境变量 `GETIOT_ROOT` 及其对应的值：

```bash
$ export GETIOT_ROOT=/opt/getiot
```

查看 `GETIOT_ROOT` 环境变量的值：

```bash
$ echo $GETIOT_ROOT
/opt/getiot
```

取消 `GETIOT_ROOT` 环境变量定义：

```bash
$ unset GETIOT_ROOT
```

再次查看该环境变量可发现其值为空。

在 Shell 脚本编程中，通常使用 [declare](/linux-command/declare) 声明变量，例如声明一个整型变量：

```bash
$ declare -i paper_size=100
```

删除该变量：

```bash
$ unset -v paper_size
```

通过 function 创建一个 Shell 函数：

```bash
$ function show_result(){ echo 'Last Command Return: $?'; }
```

删除该函数：

```bash
$ unset -f show_result
```

