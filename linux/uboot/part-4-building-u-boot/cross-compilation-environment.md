---
sidebar_position: 1
sidebar_label: 准备交叉编译环境
slug: /cross-compilation-environment
---

# 编译 U-Boot：准备交叉编译环境

U-Boot 是运行在目标板上的程序，但你通常在 Linux PC 上编译它。主机架构和目标架构不同时，就需要交叉编译工具链。比如本教程在 x86_64 主机上编译 ARM64 U-Boot，就需要 `aarch64-linux-gnu-gcc` 这类工具。

初学者常把“我在 Ubuntu 上编译”和“我要编译给 Ubuntu 运行”混在一起。这里要分清两端：

- Host：你正在使用的开发主机，通常是 x86_64 Linux。
- Target：U-Boot 将来运行的目标平台，本教程是 ARM64 QEMU `virt`。

交叉编译工具链就是在 Host 上运行、生成 Target 程序的一组工具。

## 1. 需要哪些工具

最小构建环境通常包括：

- C 编译器和基础构建工具。
- ARM64 交叉编译器。
- `make`、`binutils`。
- Python 3。
- `bc`、`bison`、`flex`、`swig`、`device-tree-compiler` 等构建辅助工具。
- OpenSSL 开发库，用于部分镜像和签名工具。

Ubuntu/Debian 上常见安装命令如下：

```bash
# [Host]
sudo apt update
sudo apt install build-essential gcc-aarch64-linux-gnu \
  bc bison flex swig python3 python3-setuptools \
  device-tree-compiler libssl-dev
```

不同发行版包名可能不同。如果你的发行版不是 Ubuntu/Debian，请以发行版软件仓库为准。

:::note
本教程不会自动替你安装软件包。命令写在这里是为了说明环境要求，你可以根据自己的系统手动执行和调整。
:::

## 2. 交叉编译器命名前缀

工具链通常不是一个单独程序，而是一组同前缀工具。例如 `aarch64-linux-gnu-` 前缀会对应：

- `aarch64-linux-gnu-gcc`
- `aarch64-linux-gnu-ld`
- `aarch64-linux-gnu-objcopy`
- `aarch64-linux-gnu-objdump`
- `aarch64-linux-gnu-nm`

U-Boot 通过 `CROSS_COMPILE` 知道应该使用哪组工具。前缀最后的短横线不能省略：

```bash
# [Host]
make CROSS_COMPILE=aarch64-linux-gnu-
```

如果写成 `CROSS_COMPILE=aarch64-linux-gnu`，U-Boot 会尝试寻找 `aarch64-linux-gnugcc`，自然会失败。

## 3. 检查工具链

```bash
# [Host]
aarch64-linux-gnu-gcc --version
make --version
dtc --version
python3 --version
```

如果 `aarch64-linux-gnu-gcc` 找不到，说明交叉编译器没有安装，或者没有加入 `PATH`。

还可以检查工具所在路径：

```bash
# [Host]
which aarch64-linux-gnu-gcc
```

如果 `which` 没有输出，优先检查安装和 `PATH`。如果输出了路径，但编译仍失败，再看具体错误信息。

## 4. `CROSS_COMPILE` 的含义

U-Boot 使用 `CROSS_COMPILE` 前缀寻找工具链：

```bash
# [Host]
make CROSS_COMPILE=aarch64-linux-gnu-
```

这里的前缀会拼出：

- `aarch64-linux-gnu-gcc`
- `aarch64-linux-gnu-ld`
- `aarch64-linux-gnu-objcopy`
- `aarch64-linux-gnu-objdump`

如果你的工具链前缀不同，例如 `aarch64-none-elf-`，就要相应调整。

### `aarch64-linux-gnu-` 和 `aarch64-none-elf-`

这两个前缀经常让初学者困惑。粗略理解：

- `aarch64-linux-gnu-`：面向 Linux GNU 用户空间生态的交叉工具链，发行版中常见。
- `aarch64-none-elf-`：常用于 bare-metal 或无操作系统目标。

U-Boot 是裸机程序，但很多平台使用 `aarch64-linux-gnu-` 工具链也可以正常构建。本教程采用 Ubuntu/Debian 中容易安装的 `aarch64-linux-gnu-`。

## 5. 环境变量方式

如果你不想每次都在命令后写 `CROSS_COMPILE`，可以临时导出：

```bash
# [Host]
export CROSS_COMPILE=aarch64-linux-gnu-
```

只在当前终端有效。为了避免以后误编译其他项目，初学阶段不建议把它永久写入 shell 配置文件。

你也可以只对单条命令生效：

```bash
# [Host]
CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
```

这种写法不会污染当前 shell 环境，适合临时实验。

## 6. `ARCH` 要不要设置

Linux kernel 编译经常显式设置 `ARCH=arm64`。U-Boot 中很多 defconfig 已经能决定目标架构，因此本教程的 QEMU ARM64 示例主要使用：

```bash
# [Host]
make qemu_arm64_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
```

如果你在其他平台文档中看到 `ARCH=arm` 或 `ARCH=arm64`，不要惊讶。关键是以对应板级文档和当前 U-Boot 构建系统要求为准。

## 7. 常见环境错误

#### `command not found`

工具没有安装或不在 `PATH`。

#### `No rule to make target`

常见原因是当前目录不是 U-Boot 源码根目录，或者 defconfig 名称写错。先确认：

```bash
# [Host]
pwd
ls Makefile configs/qemu_arm64_defconfig
```

#### Python 模块错误

U-Boot 构建工具会使用 Python。遇到 Python 模块缺失时，优先查看官方构建文档和错误提示，不要随意全局安装一堆包。课程实验中尽量使用发行版提供的包。

## 本章小结

交叉编译环境的核心是“主机上运行的工具，生成目标板上运行的程序”。确认工具链前缀，是排查 U-Boot 编译失败的第一步。

## 思考与练习

1. 解释 Host 和 Target 的区别。
2. 使用 `which aarch64-linux-gnu-gcc` 找到交叉编译器路径。
3. 说明 `CROSS_COMPILE=aarch64-linux-gnu-` 最后一个短横线为什么不能省略。
