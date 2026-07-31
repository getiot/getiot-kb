---
sidebar_position: 1
sidebar_label: Shell 简介
title: Linux Shell 简介：历史、种类与运行方式
description: 介绍 Linux Shell 的概念、发展历史、在系统中的位置，以及 Bash、dash、sh 等常见种类和脚本的几种运行方式。
---

# Linux Shell 简介：历史、种类与运行方式

在学习 Linux Shell 编程之前，我们先来了解 Shell 的基本概念和发展历程。

## Shell 的历史

在计算机操作系统发展之初，便带有命令解释器（Command Interpreter），用于接受用户的命令，并解释它们，从而与计算机进行交互。受 CTSS 和 Multics 系统的影响，Dennis Ritchie 和 Ken Thompson 在设计 UNIX 系统的时候，并没有将命令解释器作为操作系统的一部分或特权任务，而是把它变成一个类似于编译器的应用程序。

因此，UNIX 中的 shell 是一个独立的程序，一个具有很少特殊权限和内核级调用的命令解释器。这个相当新颖的概念被证明是卓有成效的，并导致了一系列越来越好的 shell 被开发出来。例如 Bourne shell（`sh`）、C-shell（`csh`）、Korn shell（`ksh`），以及后来的 tcsh、bash、zsh、dash 和 Microsoft Power Shell 等等。 

Bash（全称 Bourne Again Shell）的开发是因为自由软件基金会出于意识形态的原因想寻求一个属于自由软件的 shell，作为 GNU 项目的一部分。Bash 一开始只是一个“复古”的 shell，没有引入任何创新，随着时间的推移，它得到了扩展，吸收了当时其他 shell 中某些很受欢迎的功能。Bash 最初由自由软件基金会的 Brian Fox 编写，得力于开发者们的共同努力，bash 3.2 版成为了它自己的第四代 shell，使所有其他 shell 都黯然失色。如今，bash 依然是众多 Linux 发行版默认支持并使用的 shell。



## Shell 的位置

Shell 位于 Linux 内核之上，用于接收用户输入的指令，操作 Linux 系统上的资源。可以理解为，shell 就是用户和操作系统之间的一层接口。各种 shell 程序（如 bash）本身就是一个独立的应用程序，用户可以通过 shell 的内建命令集或系统中的其他命令，由 shell 命令解释器传给 Linux 内核执行，并返回结果。

![Linux Shell 的位置](https://static.getiot.tech/linux-shell-work.png#center)



## Shell 命令行

在 Linux 发行版中打开终端（Ubuntu 使用快捷键 Ctrl+Alt+T），可以看到一个命令行界面。

![](https://static.getiot.tech/ubuntu-terminal-shell.png#center)

左侧的 `rudy@ubuntu:~$` 被称为 shell 提示符，其中绿色部分表示是当前 shell 终端的用户名称和计算机名称，蓝色部分表示当前的目录位置（`~` 表示用户主目录），最后的 `$` 符提示用户可以在此后键入命令，如果是超级用户（root）则显示为 `#` 符号。



## Shell 的运行方式

Shell 的执行方式有两种：一种是在 shell 环境中执行，另一种是使用 shell 脚本运行。

实际上，每个 shell 命令行终端就是一个 shell 环境，我们可以直接在终端中输入 shell 命令，并获取结果。例如：

```bash
$ website="getiot.tech"
$ echo "Welcome to $website"
Welcome to getiot.tech
```

这里的 website 是一个字符串变量，它会一直存在于该 shell 环境，直到该变量被重新赋值或者关闭 shell 终端。

为了便于管理和重复执行，通常会将其编写为 shell 脚本。例如，新建 hello.sh 文件，内容为：

```bash
website="getiot.tech"
echo "Welcome to $website"
```

那么可以通过执行 shell 程序来执行该脚本，例如 bash

```bash
$ sh hello.sh
Welcome to getiot.tech
```

或者使用 source 来执行（其中 source 可以简写为 `.`）

```bash
$ source hello.sh 
Welcome to getiot.tech
$ . hello.sh 
Welcome to getiot.tech
```

指定 shell 程序执行和使用 source 执行是有区别的，前者会打开一个子 shell 去读取、执行 hello.sh 脚本，因此脚本里设置的环境变量不会影响到父 shell（当前 shell）；而后者则是直接在当前 shell 中读取、执行 hello.sh 脚本。

另外，更常见的执行方法是直接赋予 shell 脚本可执行权限，并指定 shell 命令解释器。例如在 hello.sh 脚本开头加上 `#!/bin/bash`，指定使用 bash 进行解释。

```bash showLineNumbers
#!/bin/bash

website="getiot.tech"
echo "Welcome to $website"
```

增加执行权限，并执行。

```bash
$ chmod +x hello.sh
$ ./hello.sh
Welcome to getiot.tech
```



## Shell 的种类

由于历史原因，Linux 系统上有很多种 shell，例如：

- `sh`（Bourne Shell）：由 Steve Bourne 开发，各种类 UNIX 系统都配有 `sh`。
- `csh`（C Shell）：由 Bill Joy 开发，随 BSD UNIX 发布，它的流程控制语句很像 C 语言，支持很多 Bourne Shell 所不支持的功能，如作业控制、命令历史、命令行编辑。
- `ksh`（Korn Shell）：由 David Korn 开发，向后兼容 sh 的功能，并且添加了 csh 引入的新功能，是目前很多 UNIX 系统标准配置的 Shell，在这些系统上 `/bin/sh` 往往是指向 `/bin/ksh` 的符号链接。
- `tcsh`（TENEX C Shell）：是 csh 的增强版本，引入了命令补全等功能，在 FreeBSD、Mac OS X 等系统上替代了csh。
- `bash`（Bourne Again Shell）：由 GNU 开发的 Shell，主要目标是与 POSIX 标准保持一致，同时兼顾对 sh 的兼容，bash 从 csh 和 ksh 借鉴了很多功能，是各种 Linux 发行版标准配置的 shell，在 Linux 系统上 `/bin/sh` 往往是指向 `/bin/bash` 的符号链接。虽然如此，bash 和 sh 还是有很多不同的，一方面，bash 扩展了一些命令和参数；另一方面，bash 并不完全和 sh 兼容，有些行为并不一致。所以 bash 需要模拟 sh 的行为，当我们通过 sh 这个程序名启动 bash 时，bash 可以假装自己是 sh，不认扩展的命令，并且行为与 sh 保持一致。

文件 `/etc/shells` 给出了系统中所有已知（不一定已安装）的 shell，除了上面提到的 shell 之外还有很多变种。

```bash showLineNumbers
# /etc/shells: valid login shells
/bin/csh
/bin/sh
/usr/bin/es
/usr/bin/ksh
/bin/ksh
/usr/bin/rc
/usr/bin/tcsh
/bin/tcsh
/usr/bin/esh
/bin/dash
/bin/bash
/bin/rbash
/usr/bin/screen
```

用户的默认 shell 设置在`/etc/passwd`文件中。

```bash
$ cat /etc/passwd | grep sh
root:x:0:0:root:/root:/bin/bash
rudy:x:1000:1000:rudy,,,:/home/rudy:/bin/bash
```

通过环境变量 SHELL 也可以获知当前 shell 设置。

```bash
$ echo $SHELL
/bin/bash
```

如果想要更改默认 shell 设置，可以通过 [chsh](/linux-command/chsh/) 命令修改，例如：

```bash
chsh -s /bin/dash
```

Ubuntu 的 `/bin/sh` 默认使用的是 dash，而不是 bash，两者在 shell 语法上有细微差别。如果想将 `/bin/sh` 的链接修改为 bash，可以使用下面命令：

```bash
sudo dpkg-reconfigure dash
```

选择“否”即可。

![](https://static.getiot.tech/dpkg-reconfigure-dash-no.png#center)



