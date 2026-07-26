---
sidebar_position: 5
sidebar_label: 内核启动参数 bootargs
slug: /bootargs
---

# U-Boot 与内核启动参数 bootargs

`bootargs` 是 U-Boot 传给 Linux kernel 的命令行参数。它不决定 U-Boot 自己怎么运行，而是决定 Linux 启动后如何选择 console、rootfs、日志级别以及一些内核行为。

如果你有 Linux 使用经验，可以把 `bootargs` 理解成 kernel 的启动命令行。它不是 Shell 命令，也不会由 U-Boot 逐个解释。U-Boot 只是把这串文本交给 Linux，真正解释这些参数的是 Linux kernel。

## 1. 查看当前 bootargs

```bash
# [U-Boot]
printenv bootargs
```

如果变量不存在，说明当前启动流程可能会在脚本中动态生成，或者使用 Standard Boot 从配置文件读取参数。

你还可以直接输出：

```bash
# [U-Boot]
echo ${bootargs}
```

如果输出为空，不一定表示不能启动。有些启动方式会从 `extlinux.conf` 的 `append` 行读取参数，或者在执行启动脚本时才设置 `bootargs`。

## 2. 最小可用参数

对于 QEMU ARM64 `virt`，一个常见的最小参数是：

```bash
# [U-Boot]
setenv bootargs "console=ttyAMA0"
```

`console=ttyAMA0` 告诉 Linux 把内核日志输出到 ARM PL011 串口。没有正确的 console 参数时，Linux 可能已经启动了，但你在终端看不到输出。

### console 参数为什么排第一

启动调试时，你最需要的是日志。没有 console 输出，你不知道 Linux 是没启动、启动早期崩溃，还是已经进入用户空间。因此本教程会反复把 `console=` 放在最小参数里。

QEMU ARM64 `virt` 常用 `ttyAMA0`。真实开发板可能是：

- `ttyS0`
- `ttyS2`
- `ttyFIQ0`
- `ttymxc0`
- `ttySTM0`

具体名称取决于 Linux 串口驱动和设备树。不要把 U-Boot 的 `serial` 设备名直接写成 Linux console 名称。

如果 rootfs 在 virtio block 的第二个分区，可以写：

```bash
# [U-Boot]
setenv bootargs "console=ttyAMA0 root=/dev/vda2 rw rootwait"
```

其中：

- `root=/dev/vda2`：Linux 根文件系统设备。
- `rw`：以可读写方式挂载。
- `rootwait`：等待 root 设备出现。

:::note
`bootargs` 中的设备名是 Linux 视角，不是 U-Boot 视角。U-Boot 中的 `mmc 0:2` 到 Linux 里可能是 `/dev/mmcblk0p2`；QEMU virtio block 常见为 `/dev/vda2`。
:::

## 3. root 参数怎么选

`root=` 告诉 Linux 挂载哪个设备作为根文件系统。常见写法包括：

```bash
root=/dev/vda2
root=/dev/mmcblk0p2
root=PARTUUID=<partition-uuid>
root=UUID=<filesystem-uuid>
root=/dev/nfs
```

设备名方式直观，但可能受枚举顺序影响。`UUID` 或 `PARTUUID` 更稳定，但你需要在制作镜像时知道对应值。NFS root 则用于网络根文件系统，通常还需要 `nfsroot=` 和 `ip=` 参数。

初学阶段可以先使用设备名，等你理解启动链后再学习 UUID/PARTUUID。

## 4. 使用 initramfs 时的参数

如果你使用 initramfs，通常可以暂时不指定 `root=`，让内核直接进入 initramfs 中的 `/init`：

```bash
# [U-Boot]
setenv bootargs "console=ttyAMA0"
```

如果 initramfs 中没有 `/init`，Linux 会报错，常见信息类似 `No working init found`。这时问题不在 U-Boot，而在 initramfs 内容。

如果你既传了 initramfs，又设置了 `root=`，Linux 可能会先进入 initramfs，再由 initramfs 中的脚本挂载真正 rootfs。这是很多发行版的常见流程。不要简单认为“有 initramfs 就一定不需要 root 参数”。

## 5. 常见参数

| 参数 | 作用 |
| --- | --- |
| `console=ttyAMA0` | 指定串口 console |
| `root=/dev/vda2` | 指定根文件系统设备 |
| `rootwait` | 等待 root 设备出现 |
| `rw` / `ro` | 根文件系统读写或只读挂载 |
| `init=/bin/sh` | 指定第一个用户空间程序，常用于排障 |
| `loglevel=7` | 提高内核日志详细程度 |
| `earlycon` | 尽早输出内核早期日志，具体参数与平台相关 |

还有一些调试时常用的参数：

| 参数 | 作用 |
| --- | --- |
| `panic=5` | kernel panic 后 5 秒自动重启 |
| `ignore_loglevel` | 尽量输出更多内核日志 |
| `printk.time=1` | 为 printk 日志增加时间戳 |
| `initcall_debug` | 输出内核 initcall 调试信息，日志会很多 |

这些参数适合排障，不一定适合产品默认启用。

## 6. bootargs 从哪里来

`bootargs` 可以来自多个地方：

- 你手动 `setenv bootargs ...`。
- `bootcmd` 或其他脚本变量动态拼接。
- `extlinux.conf` 中的 `append` 行。
- 设备树 `/chosen/bootargs`，具体是否使用取决于启动流程。

如果你发现手动设置不生效，先查看：

```bash
# [U-Boot]
printenv bootcmd
printenv bootargs
```

如果使用 Standard Boot，再查看 `extlinux.conf`：

```bash
# [U-Boot]
ls virtio 0:1 /boot/extlinux
load virtio 0:1 ${pxefile_addr_r} /boot/extlinux/extlinux.conf
md.b ${pxefile_addr_r} ${filesize}
```

`md.b` 只能以十六进制显示，不适合舒服阅读配置文件；这里只是验证文件确实被加载。更方便的方式是在主机上直接打开 `extlinux.conf`。

## 7. 常见错误

console 写错时，U-Boot 可能成功执行 `booti`，但 Linux 没有任何输出。root 设备写错时，Linux 常见报错是 `VFS: Unable to mount root fs`。如果你手动设置 `bootargs` 后没有生效，检查 `bootcmd` 是否在启动前重新拼接了参数：

```bash
# [U-Boot]
printenv bootcmd
printenv bootargs
```

### rootfs 相关错误怎么判断

如果你看到类似：

```bash
VFS: Cannot open root device "vda2" or unknown-block(0,0)
```

优先检查：

- `root=` 写的设备名是否正确。
- 是否需要 `rootwait`。
- kernel 是否启用了 virtio、MMC、USB、SCSI 等对应驱动。
- kernel 是否支持 rootfs 的文件系统，例如 ext4。
- rootfs 分区是否真的存在。

如果 kernel 能识别设备，但挂载失败，错误信息可能会从 `unknown-block(0,0)` 变成具体设备号。这时更可能是文件系统、分区内容或挂载参数问题。

## 本章小结

`bootargs` 是 U-Boot 与 Linux 之间最重要的接口之一。你可以把它理解成“U-Boot 写给 Linux 的启动说明”。启动 Linux 前，请至少确认 console 和 rootfs 两类参数是否正确。

## 思考与练习

1. 在你的实验环境中输出当前 `bootargs`。
2. 解释为什么 U-Boot 的 `virtio 0:2` 不能直接写成 Linux 的 `root=virtio 0:2`。
3. 如果 Linux 没有任何串口输出，你会优先检查哪个参数？
