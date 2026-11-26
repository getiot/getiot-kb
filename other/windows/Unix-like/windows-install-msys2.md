---
sidebar_position: 4
slug: /windows-install-msys2
sidebar_label: Windows 安装 MSYS2
---

# Windows 安装 MSYS2 详细步骤



## MSYS2 是什么？

**MSYS**（Minimal SYStem）是一系列 GNU 工具（bash、make、gawk、grep 等）的集合，而 **MSYS2** 是一个 MSYS 的独立改写版本。其主要用于在 Windows 系统中提供了一个类 Unix 的开发环境，兼容 Linux Shell 命令行，从而弥补 Windows cmd shell 的不足。

实际上，MSYS2 的诞生源于 MinGW 和 MSYS 更新缓慢，因此一些开发者基于新一代 Cygwin （POSIX 兼容性层） 和 MinGW-w64（从 MinGW 演进）进一步开发，提供更多 API 支持和 64 位应用开发，并实现具有更好的互操作性的 Windows 软件。因此，建议新手直接安装使用 MSYS2，而不是 MSYS。



## MSYS2 和 MinGW

MSYS2 和 MinGW 工具集有很多相似的地方，但又有所区别。你可以简单地将 MSYS2 理解为相当于一个简单的操作系统（如 Windows），这个操作系统提供的软件、接口等和 Linux 相似。而 MinGW 相当于开发工具包（如 MSVC），这个开发工具包可以运行在 MSYS 下，包里的工具也可以运行在 Windows 下，编译结果是 Windows 程序。

- `MSYS2` 是一个包含 MinGW-w64 工具链、GNU 工具集和一些开源库的平台，它提供了一种在 Windows 上编译和运行 Unix/Linux 程序的方式。MSYS2 与 MinGW-w64 相似，但比 MinGW-w64 更完整和稳定，提供了 Pacman 包管理器以方便用户安装和管理软件包。
- `MinGW-w64` 是一个 Windows 下的 C/C++ 编程工具集，它提供了运行在 Windows 上的 GNU 工具集和 GCC 编译器。MinGW-w64 与 MSYS2 类似，但主要用于编译 Windows 本地应用程序，而非 Unix/Linux 程序。MinGW-w64 也可以用于交叉编译，为其他平台生成 Windows 可执行文件。

另外，Cygwin 是一个在 Windows 平台上运行的兼容性层，提供了类 Unix 环境的工具和开发库。Cygwin 将 Unix 程序编译为 Windows 本地代码，然后在 Windows 上运行。它提供了最完整的 Linux/Unix 环境，但相对于 MSYS2 和 MinGW-w64，Cygwin 的性能比较差。



## MSYS2 安装方法

MSYS2 的安装包有三种：

- `msys2-x86_64-*.exe` 是带图形界面（GUI）的安装程序（Windows 推荐这种)。
- `msys2-base-x86_64-*.sfx.exe` 只是自解压归档中的文件（缺少 Windows 集成，如快捷方式、卸载入口）。
- `msys2-base-x86_64-*. tar.xz` 和 `.sfx.exe` 相同，但以 xz 方式压缩。

你可以在 [官网](https://repo.msys2.org/distrib/) 或 [GitHub](https://github.com/msys2/msys2-installer/releases) 下载最新的安装包，例如 `msys2-x86_64-latest.exe`，双击该文件开始安装。注意安装路径不要有中文和空格，等待安装完成即可。

安装好以后，建议修改软件包下载的镜像源，可以加快软件包的下载速度。例如，修改 `D:\msys64\etc\pacman.d` 目录下的所有 `mirrorlist.*` 文件，将原来的内容注释掉，添加如下内容：

```ini
#清华源
Server = http://mirrors.tuna.tsinghua.edu.cn
#中科大源
Server = http://mirrors.ustc.edu.cn
#北理源
Server = http://mirror.bit.edu.cn
```

保存文件，执行下面命令更新依赖（第一次执行更新 MSYS2 核心包，第二次执行更新 MSYS2 非核心包）：

```bash
pacman -Suy
```

安装 64 位 Windows 编译工具链：

```bash
pacman -S mingw-w64-x86_64-gcc
pacman -S mingw-w64-x86_64-cmake-gui
pacman -S mingw-w64-x86_64-gdb
pacman -S mingw-w64-x86_64-make
```

以及安装一些你需要的软件包，例如：

```bash
pacman -S mingw-w64-x86_64-boost
pacman -S mingw-w64-x86_64-opencv
```

最后，建议将 MSYS2 相关工具添加到系统环境变量 `PATH` 中，例如：

```bash
;D:\msys64\mingw64\bin;D:\msys64;
```



## pacman 命令说明

| 命令                                      | 描述                                       |
| ----------------------------------------- | ------------------------------------------ |
| `pacman -Q`                               | 查询已安装的软件包（简单信息）             |
| `pacman -Qs`                              | 查询已安装的软件包（详细信息）             |
| `pacman -Qe`                              | 查询从 Arch Linux 官方软件仓库安装的软件包 |
| `pacman -Qi 完整包名`                     | 查询某个软件包详细信息                     |
| `pacman -Ss 关键字`                       | 搜索软件包                                 |
| `pacman -S 包名`                          | 安装软件包                                 |
| `pacman -Sw 包名`                         | 下载软件包但不安装                         |
| `pacman -U [包名.tar.zst \| 包名.tar.xz]` | 从归档包安装                               |
| `pacman -R 包名`                          | 卸载软件包（不卸载依赖）                   |
| `pacman -Sg`                              | 列出所有的软件包组                         |
| `pacman -Sg 组名`                         | 列出某个软件包组中所有的软件包             |



## 相关链接

- [MSYS2 项目官网](https://www.msys2.org)
- [MSYS2 GitHub 主页](https://github.com/msys2)
- [MSYS2 安装包下载（GitHub）](https://github.com/msys2/msys2-installer/releases)
- [MSYS2 安装包下载（官网）](https://repo.msys2.org/distrib/)
- [MSYS2 软件包查询网站](https://packages.msys2.org/queue)

