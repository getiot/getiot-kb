---
sidebar_position: 4
authors: [luhuadong]
---

# 树莓派开发环境



树莓派是一个嵌入式 Linux 系统平台，因此开发者可以使用多种不同的编程语言和开发环境，来为你的树莓派开发所需的功能。

## GCC 编译环境

由于 Linux 内核主要是由 C 语言编写的，因此我们可以在主机系统上安装 GCC 交叉编译工具链，即可开始 C 语言程序的开发。当然，随着硬件性能的提升，你也可以直接在树莓派上安装 GCC 编译程序，无需交叉编译。

在 Ubuntu 系统中，执行下面命令安装 32 位（arm）编译工具链：

```bash
sudo apt-get install gcc-arm-linux-gnueabihf
```

执行下面命令安装 64 位（aarch64）编译工具链：

```bash
sudo apt-get install gcc-aarch64-linux-gnu
```

注意：如果是为 Pi0/1 平台构建，建议使用 `--with-arch=armv6 --with-float=hard --with-fpu=vfp` 编译选项（与此处包含的工具链的默认标志相匹配）。

