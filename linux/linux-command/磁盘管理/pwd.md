---
sidebar_label: pwd 命令
sidebar_position: 11
slug: /pwd
---

# Linux pwd 命令 - 显示当前工作目录



## 介绍

**pwd**（英文全拼：print working directory） 命令用于显示用户当前所在的工作目录（以绝对路径显示）。

**语法**：

```bash
pwd [选项]
```

**选项**：

- `-L` 或 `--logical`：使用 PWD 环境变量，即使它包含符号链接
- `-P` 或 `--physical`：避免使用符号链接
- `--help`：查看帮助
- `--version`：显示版本信息



## 示例

查看当前所在目录

```bash
$ pwd
/home/rudy/workspace
```

在 workspace 下创建一个 dir 目录，并创建一个 dir_link 软链接指向 dir 目录

```bash
mkdir dir
ln -s dir/ dir_link
```

切换到 dir_link 目录

```bash
cd dir_link
```

查看当前所在目录

```bash
$ pwd
/home/rudy/workspace/dir_link
```

以 logical 方式查看当前所在目录

```bash
$ pwd -L
/home/rudy/workspace/dir_link
```

以 physical 方式查看当前所在目录

```bash
$ pwd -P
/home/rudy/workspace/dir
```

