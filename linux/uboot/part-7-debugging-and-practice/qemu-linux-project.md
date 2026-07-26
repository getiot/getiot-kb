---
sidebar_position: 3
sidebar_label: 综合实践：在 QEMU 中启动 Linux
slug: /qemu-linux-project
---

# 综合实践：用 U-Boot 在 QEMU 中启动 Linux

这个实践把前面学过的内容串起来。你将在 QEMU ARM64 中使用 U-Boot 加载 Linux kernel、DTB 和可选 initramfs。

这个实践的价值不只是“把 Linux 启动起来”，而是把启动链拆成可验证的步骤。即使你暂时没有完整 rootfs，也可以先完成 U-Boot 编译、QEMU 启动、文件加载、DTB 验证和 bootargs 理解。

## 1. 实验目录

配套实验代码会维护在 GitHub 仓库 [getiot/uboot-courses](https://github.com/getiot/uboot-courses)。你可以这样下载：

```bash
# [Host]
git clone https://github.com/getiot/uboot-courses.git
cd uboot-courses
```

推荐结构：

```bash
uboot-courses/
├── u-boot-v2026.07/
├── scripts/
├── experiments/qemu-arm64/
└── tftpboot/
```

## 2. 准备 U-Boot

```bash
# [Host]
cd /home/rudy/workspace/Projects/GetIoT/uboot-courses/u-boot-v2026.07
make qemu_arm64_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
```

本教程不会替你运行构建命令；你可以在本机准备好依赖后自行执行。

## 3. 启动 U-Boot 并保存日志

如果使用配套脚本：

```bash
# [Host]
cd /home/rudy/workspace/Projects/GetIoT/uboot-courses
script -f logs/qemu-uboot.log
./scripts/run-qemu-uboot.sh
```

进入 U-Boot 后按键中断自动启动，看到 `=>` 提示符。退出 QEMU 通常使用 `Ctrl+A` 然后按 `x`。

## 4. 准备启动文件

把下面文件放入实验 boot 分区、TFTP 目录或你自己的镜像中：

- `Image`
- `qemu-arm64.dtb`
- 可选：`initramfs.cpio.gz`
- 可选：`extlinux/extlinux.conf`

这些文件可以来自你自己编译的 Linux，也可以来自适合 ARM64 QEMU virt 的实验镜像。文件来源不同，路径和 rootfs 参数也要相应调整。

如果使用 TFTP，把文件放入 `uboot-courses/tftpboot`；如果使用 virtio 磁盘镜像，则要确保镜像中存在 `/boot/Image` 和 `/boot/qemu-arm64.dtb`。

## 5. 手动启动验收

进入 U-Boot 后执行：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"

virtio scan
load virtio 0:1 ${kernel_addr_r} /boot/Image
load virtio 0:1 ${fdt_addr_r} /boot/qemu-arm64.dtb
booti ${kernel_addr_r} - ${fdt_addr_r}
```

如果你使用 initramfs，把 rootfs 参数和 `booti` 第二个参数按前面章节调整。

启动前建议先做检查：

```bash
# [U-Boot]
md.b ${kernel_addr_r} 0x10
fdt addr ${fdt_addr_r}
fdt header
echo ${bootargs}
```

如果这些检查失败，先不要执行 `booti`。

## 6. TFTP 启动验收

如果你使用 QEMU 用户网络和 `tftpboot/` 目录：

```bash
# [U-Boot]
setenv serverip 10.0.2.2
setenv ipaddr 10.0.2.15
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000

tftpboot ${kernel_addr_r} Image
tftpboot ${fdt_addr_r} qemu-arm64.dtb
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"
booti ${kernel_addr_r} - ${fdt_addr_r}
```

如果你使用 initramfs，把 `initramfs.cpio.gz` 也放入 TFTP 目录，并按前文保存 `ramdisk_size`。

## 7. Standard Boot 验收

准备 `extlinux.conf` 后，尝试：

```bash
# [U-Boot]
bootflow scan -lb
bootflow list
bootflow boot
```

能扫描到 bootflow，并进入 Linux，说明你已经完成从手动启动到配置化启动的迁移。

## 8. 实验验收清单

完成本实践后，你应该能证明：

- QEMU 能进入 U-Boot 命令行。
- `version` 显示 U-Boot v2026.07。
- `bdinfo` 能显示 DRAM 信息。
- 能加载 kernel 和 DTB。
- `fdt header` 能解析 DTB。
- 能解释当前 `bootargs`。
- 至少完成一次手动启动或明确知道卡在哪一步。

## 9. 常见卡点

#### 没有 Linux 启动文件

可以先做 U-Boot 编译、QEMU 启动、TFTP 文件下载和 DTB 验证。没有 rootfs 时，不要强求完整进入 Linux 用户空间。

#### `virtio scan` 找不到磁盘

确认 QEMU 命令是否挂载了 virtio block 设备。本教程配套脚本默认更偏向 U-Boot 和 TFTP 实验，磁盘镜像需要你自己添加。

#### TFTP 找不到文件

确认文件位于 `tftpboot/` 根目录，且文件名大小写和 U-Boot 命令一致。

## 本章小结

这个实践的验收标准不是“复制命令不报错”，而是你能解释每个文件、每个地址、每个参数的作用。做到这一点，你才真正掌握了 U-Boot 启动 Linux 的基本链路。

## 思考与练习

1. 保存一次 QEMU U-Boot 启动日志。
2. 分别尝试从 virtio 和 TFTP 加载 DTB。
3. 把手动启动命令整理成 `boot.env.txt` 或 `extlinux.conf`。
