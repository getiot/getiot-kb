---
sidebar_position: 17
---

# Ubuntu 安装 Wine 软件



**Wine** 是一个能够在多种 POSIX-compliant 操作系统（诸如 Linux，macOS 及BSD 等）上运行 Windows 应用的兼容层。简单来说，使用 Wine 就可以在非 Windows 操作系统上运行 Windows 软件。

本文将以 Ubuntu 20.04 LTS 为例，介绍如何在 Ubuntu 系统上安装 Wine，并通过 Wine 启动 Windows 程序。



## 检查系统架构

使用下面命令检查你的系统是否支持 64 位架构，如果返回 “amd64” 则说明支持。

```bash
$ dpkg --print-architecture
```

由于有相当一部分 Windows 程序依赖 win32，因此需要使用下面命令，检查我们的 64 位系统是否安装了 32 位架构支持，如果返回“i386”则说明支持。

```bash
$ dpkg --print-foreign-architectures
```

如果没有显示“i386”，那么你还需要执行下面命令安装它。

```bash
$ sudo dpkg --add-architecture i386
```

安装好之后再次检查。

```bash
$ dpkg --print-foreign-architectures
```



## 添加 WineHQ Ubuntu 仓库

执行下面命令获取并安装 WineHQ Ubuntu 仓库的 key。

```bash
$ wget -nc https://dl.winehq.org/wine-builds/winehq.key
$ sudo -H gpg -o /etc/apt/trusted.gpg.d/winehq.key.gpg --dearmor winehq.key
```

将软件仓库信息添加到 APT 包管理器。

```bash
$ sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
```

更新 APT 软件包数据库。

```bash
$ sudo apt update
```



## 安装 Wine

接下来就可以使用下面命令安装 Wine 了，我们以 Wine 稳定版为例：

```bash
$ sudo apt install --install-recommends winehq-stable
```

提示：你可以使用 `winehq-devel` 或 `winehq-staging` 安装其他版本。

使用下面命令检查是否安装成功：

```bash
$ wine --version
```



## 配置 Wine

Wine 默认配置为 Windows 7 环境，这是一个不错的选择，因为有一些较老的 Windows 软件也可以在上面运行。不过现在已经是 2022 年了，所以我还是建议你将其设置为 Windows 10 环境。下面介绍具体的配置方法。

执行下面命令打开 Wine 配置面板。

```bash
$ winecfg
```

注意，第一次打开时需要完成一些安装工作，你需要接受安装 Mono 和 Gecko 的所有提议。

![](https://static.getiot.tech/ubuntu-install-wine-01.png#center)

根据 Wine 的版本，Gecko 可能需要安装两次（对于 32 位和 64 位）或根本不需要安装。

![](https://static.getiot.tech/ubuntu-install-wine-02.png#center)

安装完 Mono 和 Gecko 之后，就可以看到 Wine 配置面板，在下方“Windows 版本”下拉框中选择“Windows 10”，点击“确认”。

![](https://static.getiot.tech/ubuntu-install-wine-03.png#center)



## 启动 Windows 程序

下面我们来看看如何使用 Wine 启动 Windows 程序，启动命令很简单，只需要在 exe 程序前加上“wine”即可。

比如：显示一个简单的时钟

```bash
$ wine clock
```

比如：打开 Wine 内置的浏览器

```bash
$ wine iexplore
```





