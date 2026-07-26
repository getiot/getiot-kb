---
sidebar_position: 4
sidebar_label: Linux 启动所需的文件
slug: /linux-boot-files
---

# U-Boot 启动 Linux 所需的文件

U-Boot 启动 Linux 时，通常不是只加载一个文件。你至少需要 Linux kernel；大多数嵌入式系统还需要 DTB；很多实验环境还会使用 initramfs。理解这些文件的职责，是看懂启动命令的关键。

你可以先把启动 Linux 想成一次“交接”：U-Boot 负责把 Linux 所需资料准备好，Linux kernel 接手后继续完成驱动初始化、挂载 rootfs，并启动第一个用户空间程序。U-Boot 准备错了，Linux 可能根本起不来；Linux 自己缺驱动或 rootfs 错了，U-Boot 也帮不了它。

## 1. Linux kernel 镜像

kernel 是 Linux 的核心程序。在 ARM64 平台上，常见文件名是 `Image`。在 32-bit ARM 平台上，你经常会看到 `zImage` 或 `uImage`。

不同镜像需要不同启动命令：

| 镜像 | 常见平台 | 启动命令 |
| --- | --- | --- |
| `Image` | ARM64 | `booti` |
| `zImage` | 32-bit ARM | `bootz` |
| `uImage` | 旧式 U-Boot image | `bootm` |
| FIT image | 多组件打包镜像 | `bootm` |

本教程以 QEMU ARM64 为主，因此后续主要使用：

```bash
# [U-Boot]
booti ${kernel_addr_r} - ${fdt_addr_r}
```

中间的 `-` 表示不使用 initramfs。

### `Image`、`zImage`、`uImage` 有什么区别

`Image` 通常表示未带 U-Boot legacy header 的 ARM64 Linux kernel 原始镜像。它不是普通可执行文件，也不是压缩包。U-Boot 使用 `booti` 启动它。

`zImage` 常见于 32-bit ARM，通常是自解压内核镜像，U-Boot 使用 `bootz` 启动。

`uImage` 是经过 `mkimage` 添加 legacy image header 的镜像，U-Boot 使用 `bootm` 启动。旧系统和一些厂商 BSP 中仍然常见。

FIT image 则更像一个结构化容器，可以把 kernel、DTB、ramdisk、hash、签名和多个配置打包在一起，也通过 `bootm` 启动。

:::warning
不要看到文件名里有 `Image` 就一律使用 `booti`，也不要把 FIT `.itb` 当作普通 ARM64 `Image`。启动命令必须匹配镜像格式。
:::

## 2. DTB

DTB 是 Device Tree Blob，用来告诉 Linux 当前硬件长什么样。它描述 CPU、内存、串口、中断控制器、网卡、存储控制器等硬件信息。

U-Boot 自己也可能使用一份 control FDT，但这不等于 Linux 一定会使用同一份 DTB。启动 Linux 时，你通常要明确把 DTB 放到 `fdt_addr_r`：

```bash
# [U-Boot]
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
fdt addr ${fdt_addr_r}
fdt header
```

如果 DTB 错误，Linux 可能表现为串口没有输出、找不到 rootfs、设备不可用或很早 panic。

### 为什么 DTB 这么重要

同一个 ARM64 Linux kernel 可以支持许多不同开发板，但它需要 DTB 告诉自己当前板子上有哪些设备、寄存器地址在哪里、中断号是多少、内存多大、串口用哪个。没有正确 DTB，kernel 就像拿到了一份错误地图。

你可以用 `fdt print` 查看 DTB 的部分内容：

```bash
# [U-Boot]
fdt addr ${fdt_addr_r}
fdt print /chosen
fdt print /memory
```

`/chosen` 中常包含启动参数或 console 相关信息；`/memory` 描述内存范围。不同 DTB 内容差异很大，不要要求你的输出和教程完全一致。

## 3. initramfs / initrd

initramfs 是一个临时根文件系统。它可以让 Linux 在真正挂载 rootfs 之前先运行一些早期用户空间程序。实验环境常用 initramfs，因为它可以不依赖磁盘 rootfs，启动链更短。

如果使用 initramfs，`booti` 的第二个参数通常写成：

```bash
# [U-Boot]
booti ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
```

加载 initramfs 后应保存大小：

```bash
# [U-Boot]
load virtio 0:1 ${ramdisk_addr_r} /boot/initramfs.cpio.gz
setenv ramdisk_size ${filesize}
```

initramfs 里通常至少要有 `/init`。Linux kernel 解包 initramfs 后，会尝试执行这个程序。如果找不到可执行的 init，常见错误是 `No working init found` 或 kernel panic。

initrd 是更早的一类机制，现代系统更常说 initramfs。很多文档、命令参数和变量名仍然使用 `ramdisk` 或 `initrd`，你可以先把它们理解为“启动早期给 Linux 使用的临时根文件系统”。

## 4. rootfs

rootfs 是 Linux 启动后的根文件系统。它可以来自 initramfs、存储设备上的 ext4 分区、NFS root、UBIFS，或只读 squashfs 加 overlayfs。

如果 rootfs 不在 initramfs 中，你通常需要通过 `bootargs` 告诉 Linux 根文件系统在哪里：

```bash
# [U-Boot]
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"
```

这里的 `/dev/vda2` 是 Linux 启动后看到的设备名，不等于 U-Boot 中的 `virtio 0:2`。

### initramfs 和 rootfs 的关系

有 initramfs 不代表不需要真正 rootfs。很多发行版先进入 initramfs，在里面加载驱动、解密磁盘、查找根分区，然后切换到真正 rootfs。也有一些极简实验系统只使用 initramfs，里面直接包含 `/init` 和必要工具。

所以你要先确认自己的实验目标：

- 只是验证 kernel 能启动：initramfs 最简单。
- 验证完整系统启动：需要正确 rootfs 和 `root=` 参数。
- 做内核/驱动开发：TFTP kernel 加 NFS root 常见。

## 5. 启动配置文件

有些系统还会使用启动配置文件：

- `boot.scr`：由 U-Boot script 生成的二进制脚本。
- `extlinux.conf`：Standard Boot 常用配置。
- PXE 配置文件：网络启动常用。
- FIT `.itb`：把多个组件和配置打包在一个文件里。

它们的作用不是替代 kernel，而是告诉 U-Boot 如何加载和启动 kernel。

## 6. 文件之间如何配合

一个不使用 initramfs 的 ARM64 QEMU 启动链可以这样理解：

```bash
Image + qemu-arm64.dtb + bootargs(root=/dev/vda2) -> Linux 挂载 /dev/vda2
```

一个使用 initramfs 的启动链可以这样理解：

```bash
Image + qemu-arm64.dtb + initramfs.cpio.gz -> Linux 执行 initramfs 中的 /init
```

一个 FIT 启动链可以这样理解：

```bash
fit.itb -> U-Boot 从 FIT 配置中找到 kernel、fdt、ramdisk -> Linux
```

看到启动失败时，先问自己：kernel 是否正确加载？DTB 是否正确？initramfs 是否存在且大小正确？如果不用 initramfs，rootfs 参数是否能让 Linux 找到真正根文件系统？

## 7. 启动文件检查清单

启动前可以按这个清单检查：

- kernel 文件路径是否存在。
- kernel 镜像格式和启动命令是否匹配。
- DTB 是否能被 `fdt header` 解析。
- initramfs 是否需要，若需要是否保存了 `ramdisk_size`。
- `bootargs` 是否指定正确 console 和 rootfs。
- 地址变量是否避开互相覆盖。

## 本章小结

你可以把 Linux 启动文件分成三层：必需执行体 kernel、硬件描述 DTB、用户空间入口 initramfs 或 rootfs。启动失败时，先判断是哪一层出了问题，会比盲目修改命令高效得多。

## 思考与练习

1. 找出你实验镜像中的 kernel、DTB、initramfs 或 rootfs 分别在哪里。
2. 解释 `booti ${kernel_addr_r} - ${fdt_addr_r}` 中的 `-` 是什么意思。
3. 如果 Linux 报 `No working init found`，你会优先检查 U-Boot、kernel、DTB、initramfs 还是 rootfs？
