---
sidebar_position: 1
sidebar_label: 内存、地址与数据操作
slug: /memory-and-address
---

# U-Boot 内存、地址与数据操作

在 U-Boot 中启动 Linux，本质上是把几个文件放到内存中的合适位置，然后把控制权交给内核。这里的“合适位置”非常重要：地址放错了，轻则启动失败，重则覆盖 U-Boot 自己、覆盖设备树，或者让内核解压时踩到其他数据。

## 学习目标

读完本章后，你应该能够：

- 看懂 U-Boot 中常见的地址变量。
- 知道为什么 QEMU ARM64 的内存通常从 `0x40000000` 附近开始。
- 使用 `bdinfo`、`md`、`mw`、`cp`、`cmp` 做基本内存观察。
- 避免把内核、设备树和 initramfs 加载到互相覆盖的位置。

## 1. U-Boot 看到的是物理地址

Linux 启动后会启用 MMU，进程看到的是虚拟地址；但 U-Boot 运行时通常直接操作物理地址。你在命令行输入的地址，例如 `0x40200000`，表示内存总线上的真实地址范围。

这和你在 Linux 用户空间里写 C 程序很不一样。Linux 进程不能随便访问物理地址，访问非法地址通常会得到 segmentation fault；而 U-Boot 处在启动早期，它没有完整操作系统保护，命令行中的内存命令会直接读写目标地址。所以 U-Boot 的内存操作更接近“带电调试”，你要知道自己正在碰哪里。

先查看当前板级内存信息：

```bash
# [U-Boot]
bdinfo
```

你需要重点看这些字段：

- `dram_start`：DRAM 起始地址。
- `dram_size`：DRAM 大小。
- `relocaddr`：U-Boot 重定位后的运行位置。
- `fdt_blob`：U-Boot 当前使用的控制设备树地址。

不同版本和配置的 `bdinfo` 输出格式可能略有差异，但你可以按关键词查找。QEMU ARM64 上你通常会看到 DRAM 起点接近 `0x40000000`，这说明后续示例中的 `0x40200000` 落在 DRAM 内。

在 QEMU ARM64 `virt` 机器中，DRAM 通常从 `0x40000000` 开始。教程示例会使用下面这组地址：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
setenv fdt_addr_r 0x4fa00000
setenv ramdisk_addr_r 0x4fb00000
```

真实开发板应以板级配置、内存大小和厂商文档为准。

:::tip
刚开始学习时，不要急着背地址。你只需要先建立一个判断：这个地址是否位于 DRAM 内，是否避开了 U-Boot 自己、DTB、initramfs 和其他已经加载的数据。
:::

## 2. 常见地址变量

| 变量 | 常见用途 |
| --- | --- |
| `kernel_addr_r` | Linux kernel 镜像加载地址 |
| `fdt_addr_r` | 设备树 DTB 加载地址 |
| `ramdisk_addr_r` | initramfs/initrd 加载地址 |
| `scriptaddr` | 启动脚本加载地址 |
| `pxefile_addr_r` | PXE/extlinux 配置文件加载地址 |

查看当前值：

```bash
# [U-Boot]
printenv kernel_addr_r fdt_addr_r ramdisk_addr_r scriptaddr pxefile_addr_r
```

如果某个变量不存在，可以临时设置：

```bash
# [U-Boot]
setenv kernel_addr_r 0x40200000
```

你也可以用 `echo` 观察变量展开：

```bash
# [U-Boot]
echo ${kernel_addr_r}
```

如果变量没有定义，很多命令并不会帮你猜一个地址，而是直接失败，或者把空字符串当作参数导致语法错误。因此，每次写启动脚本前，先确认关键地址变量是否存在，是一个很好的习惯。

:::note
`setenv` 默认只修改当前运行时环境。除非你执行 `saveenv`，否则复位后通常会恢复默认值。本教程在 QEMU 中优先使用临时变量，避免把错误配置永久写入存储介质。
:::

## 3. 地址、数值和单位

U-Boot 命令中的数字通常按十六进制理解，尤其是地址和大小。你看到的 `0x40200000` 是十六进制；有些命令即使不写 `0x`，也会按十六进制解析。

这点和 Linux Shell 不同。Linux 中 `16` 通常是十进制 16；U-Boot 中很多命令里的 `10` 可能表示十六进制 `0x10`，也就是十进制 16。遇到大小参数时，你要特别小心。

例如下面这条命令显示 0x40 个 byte：

```bash
# [U-Boot]
md.b ${kernel_addr_r} 40
```

这里的 `40` 不是十进制 40，而通常按十六进制理解。为了让意图更清楚，你也可以写成：

```bash
# [U-Boot]
md.b ${kernel_addr_r} 0x40
```

## 4. 查看和修改内存

`md` 可以查看指定地址处的内存内容：

```bash
# [U-Boot]
md.b ${kernel_addr_r} 40
```

这里的 `.b` 表示按 byte 显示，`40` 表示显示 0x40 个单位。类似地，`.w` 表示 16-bit word，`.l` 表示 32-bit long。

如果你还没有加载 kernel，这个地址上的内容可能是零、随机旧数据或其他早期数据。现在我们只是练习命令，不要把输出内容解读成 Linux 镜像。

`mw` 可以写内存：

```bash
# [U-Boot]
mw.b 0x41000000 0x55 0x10
md.b 0x41000000 0x20
```

这表示从 `0x41000000` 开始写入 `0x10` 个 byte，每个 byte 的值都是 `0x55`。随后显示 `0x20` 个 byte，你应该能看到前 `0x10` 个 byte 变成 `55`。

:::warning
内存命令没有“撤销”。在真实开发板上，错误写入可能导致当前系统立即崩溃。请只在确认安全的空闲内存区域做实验。
:::

## 5. 拷贝、比较与校验

```bash
# [U-Boot]
mw.b 0x41000000 0xaa 0x20
cp.b 0x41000000 0x41000100 0x20
cmp.b 0x41000000 0x41000100 0x20
crc32 0x41000000 0x20
```

加载命令成功后，U-Boot 通常会设置 `filesize`，表示刚刚加载的文件大小。你可以用它做校验：

```bash
# [U-Boot]
crc32 ${kernel_addr_r} ${filesize}
```

`crc32` 的结果不是用来“证明文件一定正确”的安全校验，但很适合开发阶段比较两次加载结果是否一致。例如你从 TFTP 下载同一个 `Image` 两次，如果 `filesize` 和 `crc32` 都一致，至少可以排除“传输内容明显不同”这一类问题。

## 6. 认识 `filesize` 与 `fileaddr`

很多加载命令成功后，会设置一些辅助变量：

```bash
# [U-Boot]
echo ${fileaddr}
echo ${filesize}
```

常见含义是：

- `fileaddr`：最近一次加载文件的地址，是否设置取决于命令和配置。
- `filesize`：最近一次加载文件的大小。

初学者常犯的错误是：加载 kernel 后记录了 `filesize`，接着又加载 DTB，然后拿新的 `filesize` 当 kernel 大小使用。记住，`filesize` 总是“最近一次加载”的大小。后面启动 initramfs 时，我们会专门把它保存到 `ramdisk_size`，避免被覆盖。

## 7. 为什么不能随便选地址

启动 Linux 时，至少有三类数据会放入内存：kernel、DTB、initramfs。它们不能互相覆盖，也不能覆盖 U-Boot 自己。内核启动后还可能解压、移动或建立页表，所以你还要给内核留出工作空间。

一个实用原则是：

- kernel 地址靠近 DRAM 起始地址之后，但不要贴着起点。
- DTB 放在较高地址，并保持较小独立空间。
- initramfs 放在 DTB 附近或更高位置，但不能覆盖 DTB。
- 加载完成后用 `md`、`fdt addr`、`fdt header` 等命令确认数据仍然可读。

你可以把这几个对象想成桌面上摊开的几份资料：kernel 很大，要给它一张大桌子；DTB 很小，但不能被压在 kernel 下面；initramfs 可能很大，所以也要单独留空间。地址规划就是给这些资料安排位置。

## 8. 一个安全的小实验

在 QEMU 中，你可以用一段空闲内存练习写入、复制、比较：

```bash
# [U-Boot]
setenv lab_src 0x41000000
setenv lab_dst 0x41000100
mw.b ${lab_src} 0x5a 0x20
cp.b ${lab_src} ${lab_dst} 0x20
cmp.b ${lab_src} ${lab_dst} 0x20
md.b ${lab_dst} 0x20
```

如果比较成功，说明你完成了最基本的内存读写操作。实验结束后不需要清理，因为这些只是 RAM 中的临时数据，复位后会消失。

## 9. 常见问题

#### `md` 输出看起来全是零，是不是错了

不一定。如果该地址尚未写入或加载数据，显示零很正常。先用 `mw` 写入一小段，再用 `md` 观察变化。

#### 写了内存后 U-Boot 卡住

你可能写到了 U-Boot 正在使用的区域，或者覆盖了重要数据。QEMU 中可以退出后重启；真实开发板上要复位。以后先用 `bdinfo` 判断地址，再选择远离 U-Boot 重定位地址和加载文件的区域。

#### 为什么示例地址和我的板子不同

因为内存布局由平台决定。QEMU ARM64、Raspberry Pi、i.MX、Rockchip、Allwinner、RISC-V 开发板都可能不同。教程地址只适用于本文实验基准。

## 本章小结

U-Boot 启动 Linux 不是“找到文件然后执行”这么简单。你需要先把启动文件放到内存中的正确位置，再用启动命令告诉内核这些文件在哪里。后续章节中你会看到，文件系统、网络启动、环境变量和 Standard Boot 最终都会回到同一个核心问题：把正确的数据加载到正确的地址。

## 思考与练习

1. 使用 `bdinfo` 找出你的实验环境中 DRAM 起始地址和大小。
2. 选择一段空闲内存，使用 `mw`、`cp`、`cmp` 完成一次复制验证。
3. 思考：为什么 initramfs 的大小要单独保存，而不能随便使用最后一次 `filesize`？
