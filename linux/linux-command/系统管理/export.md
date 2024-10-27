---
sidebar_label: export 命令
sidebar_position: 1
slug: /export
---

# export 命令



## 介绍

**export** 是 Linux 系统中用于设置环境变量的命令，也是一个重要系统命令。环境变量是一种在操作系统级别上保存配置信息和可在不同进程之间共享的变量。使用 `export` 可以将变量从当前 shell 传递到其子 shell。

**语法**：

```bash
export [-fn] [NAME[=VALUE] ...]
export -p
```

**选项**：

- `-f`：指 shell 函数。
- `-n`：删除每个 `NAME` 名称的导出属性。
- `-p`：显示所有导出的变量和函数的列表。

`export` 将标记每个 `NAME` 名称为自动导出到后续命令执行的环境。如果提供了 `VALUE` 则导出前将其作为赋值。



## 示例

创建一个名为 `MY_VARIABLE` 的环境变量，并将其值设置为 "Hello"：

```bash
export MY_VARIABLE="Hello"
```

设置路径变量（`PATH`），将 `/usr/local/bin` 添加到现有的 `PATH` 环境变量中：

```bash
export PATH=$PATH:/usr/local/bin
```

