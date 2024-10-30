---
sidebar_label: nohup 命令
sidebar_position: 11
slug: /nohup
---

# nohup 命令 - 后台运行程序



## 介绍

**nohup**（英文全拼：no hang up）命令用于在系统后台不挂断地运行命令，退出终端不会影响程序的运行。

在默认情况下（非重定向时），会输出一个名叫 nohup.out 的文件到当前目录下，如果当前目录的 nohup.out 文件不可写，输出重定向到 `$HOME/nohup.out` 文件中。

**语法**：

```bash
nohup COMMAND [ARG]...
```

**参数**：

- `COMMAND`：要执行的命令。
- `Arg`：一些参数，可以指定输出文件。



## 示例

假设当前目录下有 getiot.sh 脚本文件，内容如下：

```bash
#!/bin/bash

while [ 1 ]
do
    echo "getiot.tech"
    sleep 1
done

exit 0
```

在后台执行当前目录下的 getiot.sh 脚本：

```bash
$ nohup ./getiot.sh &
```

在终端如果看到以下输出说明运行成功：

```bash
appending output to nohup.out
```

此时，会在当前目录看到生成了 nohup.out 文件，每隔一秒会输出一行 "getiot.tech" 到 nohup.out 文件。

在后台执行当前目录下的 getiot.sh 脚本，并重定向输入到 getiot.log 文件：

```bash
nohup ./getiot.sh > getiot.log 2>&1 &
```

**2>&1** 解释：将标准错误 2 重定向到标准输出 &1 ，标准输出 &1 再被重定向输入到 getiot.log 文件中。

在 Linux 系统中，执行一个 shell 命令行时通常会自动打开三个标准文件：

- 0 – stdin（standard input，标准输入）
- 1 – stdout（standard output，标准输出）
- 2 – stderr（standard error，标准错误输出）

如果需要终止运行程序，可以使用 [ps](/linux-command/ps) 或 [jobs](/linux-command/jobs) 命令查找到 nohup 运行命令的 PID，然后使用 [kill](/linux-command/kill) 命令来删除即可。

