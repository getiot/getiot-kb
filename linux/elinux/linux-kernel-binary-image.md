---
sidebar_position: 4
---

# Linux 内核镜像

在嵌入式 Linux 或普通 Linux 系统的开发中，你经常会听到一个词：**内核镜像（Kernel Image）**。那么，Linux 内核镜像到底是什么？它是怎么来的？有哪些常见格式？本文将带你一一了解。



## 什么是内核镜像？

你可以把 Linux 内核镜像理解为一个**可供启动加载的 Linux 内核文件**，它是在内核源码编译之后生成的、可以直接被引导程序（如 U-Boot、GRUB）加载的一个二进制文件。

内核镜像的本质是经过压缩或打包处理的 ELF 格式内核或原始内核代码，它通常包含：

- Linux 内核代码（vmlinux）
- 必要的启动信息（header）
- 有时还包括设备树（Device Tree）和初始 RAM 文件系统（initramfs）



## 内核镜像的生成过程简述

当你使用如下命令构建内核时：

```bash
make zImage
# 或者
make uImage
```

Linux 内核构建系统会根据你的配置生成不同格式的内核镜像。中间流程包括：

1. 生成原始的 `vmlinux` 可执行文件（ELF 格式）；
2. 将其压缩、打包成适合加载的镜像格式（如 `zImage`、`uImage`）；
3. 可选地和设备树、initramfs 合并。



## 常见的内核镜像格式

Linux 内核支持多种镜像格式，常见的有以下几种：

### 1. `vmlinux`

- 最原始的内核文件；
- 是一个标准的 ELF 格式，未压缩；
- 一般不用于引导，但可用于调试（如使用 `gdb` 分析）。

### 2. `zImage`

- 是将 `vmlinux` 压缩后的版本，使用 gzip 压缩；
- 包含一个解压头和压缩数据；
- 常见于嵌入式系统；
- 适合内存较小的平台。

### 3. `bzImage`

- “Big zImage”的意思；
- 用于更大的内核镜像（超过 512KB）；
- 多见于 x86 平台，用于 PC 上的 Linux 启动；
- 包含了加载器、自解压代码等。

### 4. `uImage`

- 是 `zImage` 或 `bzImage` 加上 U-Boot 的镜像头（header）；
- 通过 `mkimage` 工具生成，适用于 U-Boot 引导器；
- 使用示例命令：

```bash
mkimage -A arm -O linux -T kernel -C gzip -a 0x8000 -e 0x8000 -n "Linux Kernel" -d zImage uImage
```

- 必须指定加载地址（`-a`）和入口地址（`-e`）；

### 5. `Image`

- 表示未压缩的裸内核映像；
- 用于部分平台（如 ARM64）；
- 如果空间够大，某些平台更喜欢加载未压缩镜像，因为启动更快。



## 不同平台下常见使用方式

- **x86**：常用 `bzImage` 配合 GRUB 启动；
- **ARM32**：常用 `zImage` 或 `uImage`；
- **ARM64**：多用 `Image` 或 `Image.gz`；
- **嵌入式设备**：通常配合 Bootloader（如 U-Boot）加载 `uImage`，有时还包含 `dtb` 和 `initrd`。



## 查看和验证内核镜像

**1. 查看内核镜像头（uImage）：**

```bash
hexdump -C uImage | head
```

**2. 使用 `file` 工具识别格式：**

```bash
file vmlinux
file zImage
file uImage
```

**3. 分析压缩信息：**

```bash
zcat zImage > kernel_uncompressed
```



## 如何选择使用哪种镜像？

这取决于你使用的平台和 Bootloader：

|     平台     | Bootloader |        推荐格式        |
| :----------: | :--------: | :--------------------: |
|   PC (x86)   |    GRUB    |        bzImage         |
|    ARM32     |   U-Boot   |         uImage         |
|    ARM64     |   U-Boot   |     Image / uImage     |
| Raspberry Pi | 自带 boot  | kernel.img（定制格式） |



## 小结

Linux 内核镜像是你操作系统启动的核心。它的格式因平台和需求而异，从最原始的 `vmlinux` 到适合 U-Boot 的 `uImage`，都各有用途。你需要理解这些格式的不同之处，这样才能为你的平台选择正确的启动镜像。

无论你是做嵌入式开发，还是 PC 内核调试，了解这些镜像的作用和生成方式都是必不可少的知识点。

