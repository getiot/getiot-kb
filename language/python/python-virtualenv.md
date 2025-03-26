---
sidebar_position: 6
---

# Python 虚拟环境

本文以 Python3.12 为例，介绍在 Ubuntu 系统中如何安装 Python 虚拟环境。

## venv 虚拟环境

虚拟环境是一个 Python 环境，安装到其中的 Python 解释器、库和脚本与其他虚拟环境中的内容是隔离的，且（默认）与“系统级” Python（操作系统的一部分）中安装的库是隔离的。

`venv` 模块支持使用自己的站点目录创建轻量级“虚拟环境”，可选择与系统站点目录隔离。每个虚拟环境都有自己的 Python 二进制文件（与用于创建此环境的二进制文件的版本相匹配），并且可以在其站点目录中拥有自己独立的已安装 Python 软件包集。



## 安装和使用

实际上，Python 3.12 已经包含了 venv 模块，如果没有，在 Ubuntu 中可以执行下面命令安装 venv 模块。

```bash
$ sudo apt install python3.12-venv
```

接着，执行下面命令将会在 ~/.venv 目录创建一个 python 虚拟环境。

```bash
$ python3.12 -m venv ~/.venv
```

激活虚拟环境：

```bash
$ source ~/.venv/bin/activate
```

退出虚拟环境：

```bash
$ deactivate
```

