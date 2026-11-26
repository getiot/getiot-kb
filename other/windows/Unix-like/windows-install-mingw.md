---
sidebar_position: 3
slug: /windows-install-mingw
sidebar_label: Windows 安装 MinGW
---

# Windows 安装 MinGW 详细步骤



## MinGW 是什么？

**MinGW**（Minimalist GNU for Windows），又称 mingw32，是一种用于开发原生 Windows 应用的最小化 GNU 开发环境，可以理解为开发 Windows 程序的 GCC。也就是说，这个“GCC”就是专门编译出能在 Windows 平台运行的 Linux 程序的编译器。

MinGW 是将 GCC 编译器和 GNU Binutils 移植到 Win32 平台下的产物，它包括一系列头文件、库和可执行文件。另有可用于产生 32 位及 64 位 Windows 可执行文件的 MinGW-w64 项目，是从原本 MinGW 产生的分支，如今已经独立发展。



## 安装 MinGW-w64

MinGW 将其托管到 sourceforge 上，因此你可以在 [sourceforge](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/?tdsourcetag=s_pctim_aiomsg) 下载最新的 MinGW-w64 安装包，例如 MinGW-W64-install.exe。

安装步骤如下：

1. 下载完成后双击 install.exe 文件开始安装。
2. 点击 next 进入安装配置，选择要安装的 MinGW 版本号。
3. 没有特殊要求的话（如果只是为了学习），选择最新版本即可。
4. 选择系统架构：64 位系统选择 x86_64（现在大多数电脑都是 64 位的），32 位系统选择 i686。 
5. 选择操作系统接口协议：开发类 Unix 系统（Linux/macOS）的程序选择 posix，开发 Windows 程序的选择 win32；
6. 选择异常处理类型：异常处理在开发中非常重要，在开发的过程中，大部分的时间会耗在处理各种异常情况上。seh 是新发明的，而 sjlj 则是古老的。seh 性能比较好，但不支持 32 位。 sjlj 稳定性好，支持 32 位。建议 64 位操作系统选择 seh。
7. 选择安装路径，点击 next 即可进入安装过程（需要联网下载 MinGW 的相应数据）。

安装完成后还需要配置环境变量，在 `path` 变量中添加 MinGW 安装目录中的 bin 目录即可。

现在，你可以打开 CMD 或 PowerShell 命令行终端，输入 `gcc -v` 或者 `g++ -v` 验证是否安装成功。



## 相关链接

- [MinGW 项目官网（已废弃）](http://www.mingw.org/)
- [MinGW-w64 项目官网](https://www.mingw-w64.org)
- [MinGW-w64 下载地址](https://www.mingw-w64.org/downloads/)
