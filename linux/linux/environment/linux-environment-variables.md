---
sidebar_position: 2
sidebar_label: 环境变量
slug: /linux-environment-variables
authors: [luhuadong]
---

# Linux 环境变量



## 什么是环境变量

环境变量是特定环境中的变量，无论是 Linux、Windows 还是其他操作系统，都有环境变量的概念。在 Linux 系统中，不同用户、不同权限、不同 Shell 终端等等都是“特定环境”，因此可以定义自己的环境变量。

在 Linux 系统中，环境变量通常用来定义系统运行环境的一些参数，比如每个用户不同的家目录（`HOME`）、当前的工作路径（`PATH`）、当前使用的 SHELL 程序、邮件存放位置（`MAIL`）等。

一般来说，Linux 系统中环境变量的名称都采用大写字母表示，这是一种约定俗成的规范。



## 常见环境变量说明

我们可以使用 [`env`](/linux-command/env/) 命令查看当前系统所有的环境变量的列表，例如：

```bash
$ env
SHELL=/bin/bash
ROS_VERSION=1
QT_ACCESSIBILITY=1
COLORTERM=truecolor
...
```

下表列出了 Linux 系统常见环境变量及其说明。

| 环境变量名称   | 作用                                   |
| -------------- | -------------------------------------- |
| `HOME`         | 用户的主目录（也称家目录）             |
| `SHELL`        | 用户使用的 Shell 解释器名称            |
| `PATH`         | 定义命令行解释器搜索用户执行命令的路径 |
| `EDITOR`       | 用户默认的文本解释器                   |
| `RANDOM`       | 生成一个随机数字                       |
| `LANG`         | 系统语言、语系名称                     |
| `HISTSIZE`     | 输出的历史命令记录条数                 |
| `HISTFILESIZE` | 保存的历史命令记录条数                 |
| `PS1`          | Bash 解释器的提示符                    |
| `MAIL`         | 邮件保存路径                           |



## 查看环境变量值

使用 `env` 命令，我们可以查看当前系统所有的环境变量。如果想查看某个环境变量的值，则可以使用 `echo` 命令，加上 `$` + 环境变量名。语法如下：

```bash
echo $ENV_NAME
```

例如：查看环境变量 SHELL 的值

```bash
$ echo $SHELL
/bin/bash
```



## 设置环境变量的值

在 Linux 系统中，设置环境变量的方式可分为两种，一种是直接设置 shell 变量，另一种是使用 export 设置变量，它们的区别是变量的作用域（Scope）不同。

### 直接设置 shell 变量

当我们直接为变量赋值时，该变量将仅在当前 shell 进程中可见，而不会传递给子 shell 进程。这意味着子 shell 和其他被调用的脚本或命令将不会继承该变量。

直接使用 `环境变量名=值` 的形式即可以设置环境变量的值，如果该环境变量未定义，则创建一个新的环境变量。

```bash
ENV_NAME=value
```

例如：使用如下命令，创建并设置环境变量 `GETIOT` 的值。

```bash
GETIOT="getiot.tech"
```

现在，我们可以使用 `echo` 命令，查看当前 `GETIOT` 环境变量的值。

```bash
$ echo $GETIOT 
getiot.tech
```

也可以在其他命令或程序中使用该环境变量，例如：

```bash
$ ping $GETIOT 
PING getiot.tech (42.192.64.149) 56(84) bytes of data.
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=1 ttl=50 时间=33.2 毫秒
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=2 ttl=50 时间=33.2 毫秒
64 比特，来自 42.192.64.149 (42.192.64.149): icmp_seq=3 ttl=50 时间=33.1 毫秒
```

### 使用 `export` 设置变量

使用 [`export`](/linux-command/export/) 命令可以将变量传递给子 shell 进程。这意味着，通过 `export` 设置的变量将在当前 shell 和其所有子 shell 中可见。

我们经常需要设置 Linux 系统的路径变量（`PATH`），指定可执行文件的搜索路径。例如，将 `/usr/local/bin` 添加到现有的 `PATH` 环境变量中：

```bash
export PATH=$PATH:/usr/local/bin
```

当我们将这条命令写到 ~/.bashrc 文件后，所有新建的 shell 终端及其子进程均可生效。
