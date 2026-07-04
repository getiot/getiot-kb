---
sidebar_position: 2
slug: /cmake-installation
authors: [luhuadong]
---

# CMake 安装

![](https://static.getiot.tech/cmake-the-ultimate-build-system.png#center)

## Linux 安装 CMake

要想在 Linux 上使用 CMake，通常需要先安装 C/C++ 编译器以及 make 构建工具。因为 CMake 会生成 Makefile 文件，而执行 Makefile 则需要 make 工具以及相应的编译工具链。

就 CMake 而言，在 Linux 中通常有两种安装方式：通过包管理器自动安装，以及手动下载安装。

### 包管理器自动安装

在开始之前，我们不妨先用 `apt show` 命令来查看 cmake 包的描述信息及其依赖。

```shell
apt show cmake
```

如输出中所示，cmake 推荐安装 gcc 和 make，当然也建议安装其他一些软件包，您可以根据需要选择安装。因为 CMake 通常用于构建 C/C++ 工程，为了保证对 C 和 C++ 的支持，我们需要安装 g++ 而不是仅安装 gcc 软件包（请放心，g++ 软件包中已经包含了 gcc）。

对于 Ubuntu/Debian 系统，执行下面一行命令，即可安装 cmake、g++ 和 make：

```shell
sudo apt install cmake g++ make
```

对于 Fedora/CentOS 系统，则使用下面命令：

```shell
sudo dnf install cmake gcc-c++ make
```

另外，CMake 有提供一些 GUI 工具，您也可以选择安装：

```shell
sudo apt install cmake-qt-gui        # cmake-gui 命令
sudo apt install cmake-curses-gui    # ccmake 命令
```

安装完成后，可以通过 `cmake --version` 来确认是否安装成功：

```shell
$ cmake --version
cmake version 3.16.3

CMake suite maintained and supported by Kitware (kitware.com/cmake).
```

### 手动下载安装

对于手动安装，在 [CMake 官网](https://cmake.org/download/) 上也提供了两种方式：

- 使用 shell 脚本（`.sh` 文件）
- 使用 `.tar.gz` 归档文件

手动安装的好处是可以使用最新版本的 CMake，而不用依赖包管理器的软件源。不过，还是要先安装编译工具（gcc / g++）和 make。这里可以借助包管理器完成这一步骤，在 Ubuntu/Debian 系统执行下面命令：

```shell
sudo apt install g++ make
```

Fedora/CentOS 系统使用下面命令：

```shell
sudo dnf install gcc-c++ make
```

下面以在 Ubuntu 20.04 系统使用 shell 脚本方式安装为例。首先，使用 wget 命令下载当前最新版本的 cmake，并修改脚本名字为 cmake.sh：

```shell
wget https://github.com/Kitware/CMake/releases/download/v3.21.0/cmake-3.21.0-linux-x86_64.sh -O cmake.sh
```

在运行之前先检查一下脚本是个好习惯，可以使用您习惯的编辑器打开它，例如 vim 或者 nano：

```shell
vi cmake.sh
```

实际上，该文件包含了一段 shell 脚本，以及 CMake 二进制文件的 `.tar.gz` 压缩包。也就是说，它是一个能自己解压缩执行的 cmake 安装包。

在运行之前，先执行下面命令为脚本添加可执行权限：

```shell
chmod +x cmake.sh
```

接下来就可以运行 cmake.sh 了：

```shell
sudo sh cmake.sh --prefix=/usr/local/ --exclude-subdir
```

上面的命令将为所有用户全局安装 cmake 到 `/usr/local/bin` 目录，而 `--exclude-subdir` 选项表示删除在解压 `.tar.gz` 存档时产生的额外目录。

以这种方式安装时，cmake 不会由系统包管理器管理。也就是说，以后要更新 cmake，只需要对任何新版本重复此过程即可。

### 手动编译安装

除此之外，如果您真的有需要，还可以下载源代码进行手动编译安装。

下面是源码下载、配置、编译、安装过程的简短示例：

```shell
git clone https://github.com/Kitware/CMake.git
cd CMake
./configure --qt-gui
make -j4
make install
```

