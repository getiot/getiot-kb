---
sidebar_position: 10
authors: [luhuadong]
---

# RT-Thread 搭建 Linux 开发环境

![RT-Thread 搭建 Linux 开发环境](https://static.getiot.tech/rt-thread-env-for-ubuntu.png#center)



## 概述

本文主要介绍如何在 Linux 操作系统（以 Ubuntu 为例）中搭建 RT-Thread 的开发环境。同时，嵌入式软件开发离不开硬件开发板，因此我们还会介绍如何使用 QEMU 来模拟开发板，在 QEMU 中启动 RT-Thread 操作系统。

QEMU 是一个支持跨平台虚拟化的虚拟机，它可以虚拟很多开发板。为了方便大家在没有开发板的情况下体验 RT-Thread，RT-Thread 使用 QEMU 模拟了 ARM vexpress A9 开发板，并提供了相关的板级支持包（BSP）。本文将介绍在 Linux 平台使用 RT-Thread 提供的 qemu-vexpress-a9 BSP。



## 安装依赖

**安装 GCC 编译器**

```bash
sudo apt install gcc-arm-none-eabi
sudo apt install gdb-arm-none-eabi
sudo apt install binutils-arm-none-eabi
```

**安装 QEMU 虚拟机**

```bash
sudo apt install qemu
sudo apt install qemu-system-arm
```

**安装 Scons 构建工具**

```bash
sudo apt install scons
```

**安装 ncurses 库**

```bash
sudo apt install libncurses5-dev
```



## 获取源码

我们有多种获取 RT-Thread 源代码的方式，可以参考官方[下载页面](https://www.rt-thread.org/page/download.html)选择适合你的方式。

由于 RT-Thread 是完全开源，因此这里推荐使用 Git 方式获取 RT-Thread 源代码。

```bash
git clone https://github.com/RT-Thread/rt-thread.git
```



## 构建工程

获取 RT-Thread 源码后，进入对应的 bsp 目录。

```bash
cd rt-thread/bsp/qemu-vexpress-a9/
```

执行 `scons --dist` 命令搭建项目框架，执行完后会生成 dist 目录，接下来我们会下该目录下进行操作，这样就不会破坏原有的 RT-Thread 仓库。当然，你也可以把 dist 工程目录拷贝到任意磁盘位置。

进入工程目录：

```bash
cd dist/qemu-vexpress-a9/
```

构建工程：

```bash
scons
```

看到如下提示则说明构建成功。

```bash
LINK rtthread.elf
arm-none-eabi-objcopy -O binary rtthread.elf rtthread.bin
arm-none-eabi-size rtthread.elf
   text	   data	    bss	    dec	    hex	filename
 581110	   2092	  85532	 668734	  a343e	rtthread.elf
scons: done building targets.
```

如果想要配置 RT-Thread 工程，可以执行下面命令：

```bash
scons --menuconfig
```

**注意**：如果是第一次执行该命令，会自动安装 Env 工具（安装目录为 ~/.env），运行 `source ~/.env/env.sh` 可使 Env 工具生效。为了方便在 Shell 终端使用 Env 工具，我们可以将其添加到 ~/.bashrc 文件末尾。



## 启动系统

编译完成后，执行 qemu.sh 脚本启动虚拟机。

```bash
./qemu.sh
```

如下：

![Linux QEMU 启动 RT-Thread](https://static.getiot.tech/rt-thread-ubuntu-qemu.png#center)



## 其他工具

- ST-Link：[Linux 安装 stlink 工具](/stm32/stm32-install-stlink-tools/)

