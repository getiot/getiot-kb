---
sidebar_position: 2
slug: /boost-installation
---

# Boost 安装



Boost C++ 库均带有源代码。其中大多数库只包含头文件，可以直接使用，但也有一些库需要编译。 为了尽可能容易安装，可以使用 Boost Jam 进行自动安装。 无需逐个库进行检查和编译，Boost Jam 自动安装整个库集。 它支持许多操作系统和编译器，并且知道如何基于适当的配置文件来编译单个库。



## 命令行安装

在 Ubuntu 系统中打开终端，执行下面命令，安装最新版本的 boost 库

```bash
sudo apt install libboost-all-dev
```

例如当前 2022.09.15，对应的是 boost 1.71 版本



## 检查版本

安装完成后，可通过 dpkg 命令查看 boost 库的版本，如下所示：

```bash
$ dpkg -S /usr/include/boost/version.hpp
libboost1.71-dev:amd64: /usr/include/boost/version.hpp
```

如果没有查到，或者你所使用的系统没有包管理工具，那么可以直接通过查询某个 boost 库来获知其版本信息，例如：

```bash
$ find /usr/ -name "libboost_random.so*"
/usr/lib/x86_64-linux-gnu/libboost_random.so
/usr/lib/x86_64-linux-gnu/libboost_random.so.1.71.0
```



## 手动编译安装





