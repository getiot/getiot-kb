---
sidebar_position: 2
---

# Eigen 库安装



本文介绍 Eigen 库的几种安装方法。实际上，由于 Eigen 是一个纯头文件（header-only）的 C++ 库，因此只需将 Eigen 的头文件包含到你的 C++ 工程中，就可以直接使用 Eigen 的功能。



## Linux 系统

在 Linux 发行版中，你可以使用包管理工具直接安装，例如 Ubuntu 的 apt 命令：

```bash
$ sudo apt install libeigen3-dev
```

安装完成后通过 `apt show` 命令查看软件包版本信息：

```bash
$ apt show libeigen3-dev
Package: libeigen3-dev
Version: 3.3.7-2
Priority: extra
Section: universe/libdevel
Source: eigen3
Origin: Ubuntu
```

你也可以直接查看 /usr/include/eigen3/Eigen/src/Core/util/Macros.h 文件中的版本信息，例如：

Eigen 库版本的定义在 `/usr/include/eigen3/Eigen/src/Core/util/Macros.h` 文件中，该文件包含了 Eigen 库的所有宏定义，你也可以直接打开它查看。

```cpp
#define EIGEN_WORLD_VERSION 3
#define EIGEN_MAJOR_VERSION 3
#define EIGEN_MINOR_VERSION 7
```

例如，此处的 Eigen 版本是 3.3.7。



## 手动编译安装

如果你想安装最新版本的 Eigen，最好的方式是直接在 Eigen 的代码仓库 [https://gitlab.com/libeigen/eigen](https://gitlab.com/libeigen/eigen) 下载最新版本，例如当前最新的 eigen-3.4.0.zip。

解压缩并切换目录：

```bash
$ unzip eigen-3.4.0.zip
$ cd eigen-3.4.0/
```

执行下面命令创建构建目录，并编译、安装：

```bash
$ mkdir build
$ cd build
$ cmake ..
$ sudo make install
```

这样就可以了！

