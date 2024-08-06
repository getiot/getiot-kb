---
sidebar_position: 6
slug: /command
---

# command 命令



## 介绍

**command** 命令用于执行一个简单命令或者显示命令的相关信息。command 命令可带 ARGS 参数运行指定的命令且抑制 shell 函数查询或显示。也就是说，当系统内定义了与 Linux 命令相同的函数时，使用 command 命令忽略 shell 函数，而执行相应的 Linux 命令。

**语法：**

```bash
command [-pVv] 命令 [参数 ...]
```

**选项：**

- `-p`：搜索命令对应的路径，使用 PATH 变量的一个默认值以确保所有的标准工具都能被找到。
- `-V`：不执行命令，而是搜索命令并打印命令的详细描述。
- `-v`：不执行命令，但搜索命令和打印命令的描述，和 [type](/linux-command/type) 内建命令相似。



## 示例

使用 command 命令调用执行 echo 命令

```bash
$ command echo GetIoT.tech
GetIoT.tech
```

搜索 nvm 命令，可用作检查 nvm 是否安装成功

```bash
$ command -v nvm
nvm
```

搜索 free 命令并显示详细信息

```bash
$ command -V free
free 是 /usr/bin/free
```

搜索 fdisk 命令对应的路径

```bash
$ command -p fdisk
命令 'fdisk' 可在以下位置找到
 * /sbin/fdisk
 * /usr/sbin/fdisk
fdisk：未找到命令
```

