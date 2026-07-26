---
sidebar_position: 5
sidebar_label: U-Boot 源码结构
slug: /source-tree
---

# U-Boot 源码结构

U-Boot 源码树很大，但它不是无序堆叠。你可以先从“板级、架构、命令、驱动、启动、文档”几个入口理解它。

读 U-Boot 源码不要一开始就从第一行启动汇编追到底。更适合初学者的方法是带着一个具体问题进入源码，比如“`booti` 命令在哪里实现”“QEMU ARM64 defconfig 打开了什么”“virtio 驱动在哪里”。

## 1. 顶层目录

| 目录 | 作用 |
| --- | --- |
| `arch/` | CPU 架构相关代码，例如 ARM、RISC-V、x86 |
| `board/` | 具体开发板支持代码 |
| `cmd/` | U-Boot 命令实现 |
| `common/` | 通用初始化、主循环、环境等逻辑 |
| `drivers/` | 设备驱动 |
| `dts/` | U-Boot 使用的设备树 |
| `env/` | environment 存储后端 |
| `fs/` | 文件系统支持 |
| `include/` | 头文件 |
| `net/` | 网络协议与网络启动相关代码 |
| `boot/` | bootm、bootflow、FIT 等启动框架 |
| `doc/` | 官方文档 |
| `configs/` | 各板级 defconfig |

你可以先用 `rg --files` 建立感觉：

```bash
# [Host]
rg --files | sed -n '1,40p'
```

如果你的系统没有 `rg`，可以使用 `find`，只是速度和输出体验差一些。

## 2. 从 defconfig 追踪

QEMU ARM64 的入口配置是：

```bash
# [Host]
configs/qemu_arm64_defconfig
```

执行 `make qemu_arm64_defconfig` 后，Kconfig 系统会生成 `.config`。再由 `.config` 控制哪些源码参与编译。

你可以用下面命令寻找某个配置：

```bash
# [Host]
grep CONFIG_BOOTSTD .config
rg "config BOOTSTD" .
```

你还可以看这个 defconfig 到底写了什么：

```bash
# [Host]
sed -n '1,120p' configs/qemu_arm64_defconfig
```

defconfig 通常很短，因为大量选项来自默认值和依赖关系。不要误以为 defconfig 里没写的功能就一定没启用。

## 3. Kconfig 与 Makefile 怎么配合

U-Boot 的构建大致由 Kconfig 决定“是否启用”，Makefile 决定“哪些文件参与编译”。

例如你想看 `bootflow` 相关配置：

```bash
# [Host]
rg "BOOTFLOW|BOOTSTD" boot cmd common include Kconfig
```

想看命令是否参与构建，可以看 `cmd/Makefile`：

```bash
# [Host]
rg "bootflow|booti|bootm" cmd/Makefile
```

很多 Makefile 会写成 `obj-$(CONFIG_XXX) += xxx.o`。这表示只有 `CONFIG_XXX=y` 时，对应对象文件才会编译进来。

## 4. 命令在哪里

U-Boot 命令大多位于 `cmd/`。例如：

- `cmd/booti.c`
- `cmd/bootm.c`
- `cmd/bootflow.c`
- `cmd/mem.c`
- `cmd/load.c`
- `cmd/virtio.c`

当你在 U-Boot 中输入 `help booti`，背后通常就是这些命令文件注册的帮助信息和处理函数。

一个命令文件里常见 `U_BOOT_CMD` 或 `U_BOOT_CMD_WITH_SUBCMDS` 宏。你可以搜索：

```bash
# [Host]
rg "U_BOOT_CMD.*booti|U_BOOT_CMD_WITH_SUBCMDS.*bootflow" cmd
```

这能帮助你从命令行名称反向找到 C 代码入口。

## 5. 启动框架在哪里

与启动 Linux 相关的通用逻辑主要在：

- `boot/`
- `cmd/booti.c`
- `cmd/bootm.c`
- `cmd/bootflow.c`
- `common/bootm.c` 或相关平台代码，具体路径随版本变化

Standard Boot 的开发文档在：

```bash
# [Host]
ls doc/develop/bootstd
```

读源码前先读文档，会少绕很多路。

## 6. 驱动在哪里

驱动位于 `drivers/`，并按子系统组织：

- `drivers/serial/`
- `drivers/net/`
- `drivers/block/`
- `drivers/mmc/`
- `drivers/virtio/`
- `drivers/core/`

现代 U-Boot 驱动大多接入 Driver Model。你可以在 U-Boot 命令行中用 `dm tree` 观察设备树上的设备如何绑定成运行时设备。

如果你想找 virtio 驱动：

```bash
# [Host]
rg "virtio" drivers include cmd
```

如果你想找串口驱动：

```bash
# [Host]
ls drivers/serial
```

读驱动时，先看 `compatible` 匹配、probe 函数和 uclass，而不是先钻进所有寄存器操作。

## 7. 文档在哪里

U-Boot 官方文档在 `doc/`。本教程常参考：

- `doc/board/emulation/qemu-arm.rst`
- `doc/develop/bootstd/`
- `doc/develop/driver-model/`
- `doc/develop/devicetree/`
- `doc/develop/environment.rst`

你可以直接在本地搜索文档：

```bash
# [Host]
rg "QEMU ARM" doc
rg "Standard Boot" doc/develop
```

## 8. 一条命令的源码阅读路线

以 `bootflow scan -l` 为例：

1. 在 `cmd/` 中搜索 `bootflow`。
2. 找到命令注册宏和 `scan` 子命令处理函数。
3. 顺着处理函数看它调用的 bootstd/bootflow API。
4. 到 `boot/` 目录看启动框架实现。
5. 回到文档确认概念。

这比从 `main_loop()` 开始一路追调用链更高效。

## 本章小结

读 U-Boot 源码时，不要从入口函数一路硬啃到底。更实用的方法是带着问题找目录：命令去 `cmd/`，驱动去 `drivers/`，启动框架去 `boot/`，板级配置从 `configs/` 和 `board/` 开始。

## 思考与练习

1. 找到 `booti` 命令的源码文件。
2. 找到 `qemu_arm64_defconfig` 中与 Standard Boot 相关的配置。
3. 使用 `rg` 搜索 `U_BOOT_CMD`，观察一个命令如何注册。
