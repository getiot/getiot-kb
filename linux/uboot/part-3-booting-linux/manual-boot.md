---
sidebar_position: 6
sidebar_label: 手动启动 Linux
slug: /manual-boot
---

# 用 U-Boot 手动启动 Linux

现在我们把前面几章连起来，手动完成一次 Linux 启动。所谓“手动启动”，就是你在 U-Boot 命令行中一步一步加载 kernel、DTB、initramfs 或 rootfs 参数，然后执行启动命令。

手动启动是学习 U-Boot 的核心练习。因为自动启动脚本会把很多细节藏起来，而手动启动会逼你看清每一步：设备是否存在、分区是否正确、文件是否能读、地址是否合适、参数是否传给 Linux。

## 1. 基本流程

以 ARM64 `Image` 为例，流程通常是：

1. 设置加载地址。
2. 扫描启动介质。
3. 加载 kernel。
4. 加载 DTB。
5. 可选：加载 initramfs。
6. 设置 `bootargs`。
7. 执行 `booti`。

你可以把这七步写在纸上。以后遇到启动失败，不要直接改最后的 `booti`，而是沿着这七步从前往后找第一处失败。

## 2. 实验前检查

进入 U-Boot 后，先确认基本环境：

```bash
# [U-Boot]
version
bdinfo
printenv kernel_addr_r fdt_addr_r ramdisk_addr_r
```

如果地址变量不存在，就先设置：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv ramdisk_addr_r 0x4fb00000
```

然后确认启动介质和文件路径：

```bash
# [U-Boot]
virtio scan
part list virtio 0
ls virtio 0:1 /boot
```

如果这里失败，不要继续执行 `booti`。先回到设备、分区或文件系统章节排查。

## 3. 不使用 initramfs

假设 virtio 磁盘第 1 个分区中有 `/boot/Image` 和 `/boot/qemu-arm64.dtb`，rootfs 位于 Linux 视角的 `/dev/vda2`：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"

virtio scan
load virtio 0:1 ${kernel_addr_r} /boot/Image
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
fdt addr ${fdt_addr_r}
booti ${kernel_addr_r} - ${fdt_addr_r}
```

如果成功，你会看到 Linux kernel 日志接管串口输出。

这组命令中最重要的是 `booti`：

- 第一个参数是 kernel 地址。
- 第二个参数是 initramfs 地址和大小；不用 initramfs 时写 `-`。
- 第三个参数是 DTB 地址。

如果你的 rootfs 不在 `/dev/vda2`，必须修改 `bootargs`。否则 U-Boot 可能成功跳转到 Linux，但 Linux 会因为找不到 rootfs 而 panic。

## 4. 使用 initramfs

如果你有 `/boot/initramfs.cpio.gz`：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv ramdisk_addr_r 0x4fb00000
setenv bootargs "console=ttyAMA0"

virtio scan
load virtio 0:1 ${kernel_addr_r} /boot/Image
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
load virtio 0:1 ${ramdisk_addr_r} /boot/initramfs.cpio.gz
setenv ramdisk_size ${filesize}

fdt addr ${fdt_addr_r}
booti ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr_r}
```

注意 `ramdisk_size` 的保存位置。因为最后一次 `load` 才对应 initramfs，所以应在加载 initramfs 后保存 `filesize`。

为什么不直接写 `${filesize}`？

因为你后面可能还会执行其他加载命令，`filesize` 会被覆盖。把它保存到 `ramdisk_size`，能让启动脚本更清楚，也减少隐蔽错误。

## 5. `booti` 参数含义

```bash
# [U-Boot]
booti <kernel_addr> <ramdisk_addr[:size] | -> <fdt_addr>
```

三个参数分别表示 kernel 所在地址、initramfs/initrd 地址和大小、DTB 所在地址。不使用 initramfs 时，中间参数写 `-`。

如果你使用的不是 ARM64 `Image`，启动命令也要换：

- 32-bit ARM `zImage` 使用 `bootz`。
- legacy `uImage` 和 FIT image 通常使用 `bootm`。
- EFI 应用使用 EFI 启动路径。

## 6. 启动前检查

```bash
# [U-Boot]
md.b ${kernel_addr_r} 10
fdt addr ${fdt_addr_r}
fdt header
echo ${bootargs}
```

如果这些检查失败，就不要继续启动。先回到加载步骤排查路径、分区、地址或文件格式。

你也可以检查刚加载文件的大小：

```bash
# [U-Boot]
echo ${filesize}
```

注意它只代表最近一次加载的文件。如果你刚加载完 DTB，这里的 `filesize` 就是 DTB 大小，不是 kernel 大小。

## 7. 读懂启动边界

执行 `booti` 后，如果 U-Boot 成功把控制权交给 Linux，你会看到输出风格变化。U-Boot 的提示符 `=>` 消失，Linux kernel 开始打印自己的日志。此后问题大多进入 Linux 阶段。

你要学会区分：

- `load` 失败：U-Boot 还没读到文件。
- `fdt header` 失败：DTB 地址或文件错误。
- `booti` 报镜像错误：kernel 格式或地址错误。
- Linux panic：U-Boot 已经跳转，问题可能在 kernel、DTB、bootargs 或 rootfs。

## 8. 常见问题

`Bad Linux ARM64 Image magic` 通常表示你加载了错误文件，或者地址不对。`ERROR: Did not find a cmdline Flattened Device Tree` 通常表示 DTB 地址错误，或者没有传第三个参数。Linux 没有串口输出时，先确认 `bootargs` 中的 `console=` 是否正确。

#### `Bad Linux ARM64 Image magic`

排查顺序：

```bash
# [U-Boot]
ls virtio 0:1 /boot
load virtio 0:1 ${kernel_addr_r} /boot/Image
md.b ${kernel_addr_r} 0x40
```

确认你加载的是 ARM64 `Image`，不是压缩包、DTB、initramfs 或空文件。

#### DTB 相关错误

```bash
# [U-Boot]
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
fdt addr ${fdt_addr_r}
fdt header
```

如果 `fdt header` 失败，先不要执行 `booti`。

#### Linux 找不到 rootfs

检查 `bootargs`：

```bash
# [U-Boot]
echo ${bootargs}
```

确认 `root=` 是 Linux 视角的设备名，并且需要时加上 `rootwait`。

## 本章小结

手动启动 Linux 的价值，不只是把系统启动起来，而是让你看清每一步：文件从哪里来、加载到哪里、以什么参数交给内核。等你理解这条链路后，再把它封装成启动脚本就很自然了。

## 思考与练习

1. 按本文流程手动加载 kernel 和 DTB，但先不要执行 `booti`，只做检查。
2. 分别解释 `booti ${kernel_addr_r} - ${fdt_addr_r}` 三个参数。
3. 故意把 DTB 路径写错，观察错误发生在启动链的哪一步。
