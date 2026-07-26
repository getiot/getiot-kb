---
sidebar_position: 2
sidebar_label: 存储设备与分区
slug: /storage-and-partitions
---

# U-Boot 存储设备与分区

真实产品中的 Linux 通常不直接从主机目录启动，而是从 eMMC、SD card、SPI NOR、SPI NAND、NVMe、USB storage 或网络加载。U-Boot 的任务之一，就是在 Linux 启动前识别这些启动介质，并从中读取启动文件。

本章先介绍“设备”和“分区”。你不需要一次记住所有存储命令，但要建立一个清晰模型：U-Boot 先找到设备，再选择分区，最后从文件系统里加载文件。

## 1. 设备编号

U-Boot 通常用“设备类型 + 设备编号 + 分区编号”表示一个位置。例如：

```bash
# [U-Boot]
load virtio 0:1 ${kernel_addr_r} /boot/Image
```

这条命令可以拆开理解：

- `virtio`：设备类型。
- `0`：第 0 个 virtio block 设备。
- `1`：该设备上的第 1 个分区。
- `${kernel_addr_r}`：加载到内存的目标地址。
- `/boot/Image`：分区中的文件路径。

真实开发板上更常见的是：

```bash
# [U-Boot]
load mmc 0:1 ${kernel_addr_r} /boot/Image
load usb 0:1 ${kernel_addr_r} /boot/Image
load nvme 0:1 ${kernel_addr_r} /boot/Image
```

设备编号不是固定真理。换一块板子、换一个启动介质，编号都可能变化。

你可以把它和 Linux 中的 `/dev/sda1`、`/dev/mmcblk0p1` 做个类比，但不要混用。U-Boot 的 `mmc 0:1` 是 U-Boot 自己的设备和分区表达；Linux 启动后看到的 `/dev/mmcblk0p1` 是 Linux 内核枚举出的设备节点。二者经常对应，但不是同一种命名体系。

## 2. 查看可用设备

以 QEMU ARM64 常用的 virtio block 为例：

```bash
# [U-Boot]
virtio scan
virtio info
```

如果使用 SD card 或 eMMC：

```bash
# [U-Boot]
mmc list
mmc dev 0
mmc info
```

如果使用 USB storage：

```bash
# [U-Boot]
usb start
usb storage
```

这些命令的目标都是回答两个问题：U-Boot 是否识别到了设备，以及你应该用哪个设备编号访问它。

如果命令提示 `Unknown command`，通常不是你输入错了，而是当前 U-Boot 镜像没有编译该设备类型的命令。比如一个没有启用 USB 支持的 U-Boot，当然不会有完整的 `usb` 命令。遇到这种情况，先用 `help` 看当前镜像支持什么：

```bash
# [U-Boot]
help
help virtio
help mmc
```

## 3. 先扫描，再访问

有些设备在访问前需要显式扫描或初始化：

```bash
# [U-Boot]
virtio scan
usb start
mmc rescan
```

这一步很容易被忽略。你直接 `load virtio 0:1 ...` 失败，并不一定说明磁盘镜像坏了，可能只是还没有扫描 virtio 设备。

不同设备的习惯不同：

- `virtio`：QEMU 中常用 `virtio scan`。
- `usb`：通常先 `usb start`。
- `mmc`：可以用 `mmc list`、`mmc dev 0`、`mmc rescan`。
- `nvme`：常见流程是先扫描，再列出设备，具体命令取决于配置。

## 4. 查看分区表

识别设备后，下一步是查看分区：

```bash
# [U-Boot]
part list virtio 0
part list mmc 0
```

你可能看到 GPT 或 MBR 分区信息。先关注三个字段：分区编号、起始位置、分区大小。对启动来说，还要关注哪个分区存放 `/boot`，哪个分区存放 rootfs。

如果没有分区表，可能有几种情况：

- 这个介质确实没有分区，文件系统直接从整个设备开始。
- 设备编号错了。
- U-Boot 没有识别到该介质。
- 分区表损坏或格式不受当前 U-Boot 支持。

不要一看到 `part list` 失败就立刻重写分区表。先确认你访问的是正确设备。

## 5. GPT 与 MBR 简单认识

MBR 和 GPT 是两种常见分区表格式。你暂时可以这样理解：

- MBR 更旧，结构简单，传统系统常见。
- GPT 更新，支持更多分区和更大的磁盘，现代系统常见。

U-Boot 只要启用了对应分区表支持，就可以读取它们。对启动过程来说，分区表的作用是让 U-Boot 找到“第几个分区从哪里开始、大小是多少”。至于分区里面是什么文件系统，是下一章要解决的问题。

## 6. 常见启动介质

| 介质 | 常见命令 | 特点 |
| --- | --- | --- |
| SD card / eMMC | `mmc`、`load mmc` | 嵌入式 Linux 最常见 |
| SPI NOR | `sf` | 容量小，常放 SPL、U-Boot、environment |
| SPI NAND / raw NAND | `nand`、`ubi` | 容量较大，但坏块管理复杂 |
| USB storage | `usb`、`load usb` | 调试方便 |
| NVMe/SATA | `nvme`、`scsi` | 高性能设备常见 |
| virtio block | `virtio` | QEMU 实验常用 |
| Network | `dhcp`、`tftpboot` | 开发调试非常高效 |

:::warning
本章只建议使用只读命令观察设备和分区。涉及 `mmc write`、`sf erase`、`nand erase`、`gpt write` 的操作会修改存储内容，可能导致设备无法启动。真实硬件上操作前请备份原始镜像。
:::

## 7. U-Boot environment 放在哪里

除了 Linux 启动文件，U-Boot 自己的 environment 也可能保存在存储介质中。常见位置包括：

- SPI NOR 的固定偏移。
- eMMC/SD card 的固定偏移。
- FAT/ext4 文件。
- NAND/UBI volume。
- 编译进镜像的默认环境，运行时不保存。

为什么你现在要知道这件事？因为 `saveenv` 会写这个位置。如果 environment 位置配置错了，`saveenv` 可能覆盖其他重要数据。所以本教程在前期反复提醒：学习阶段尽量只临时 `setenv`，不要急着 `saveenv`。

## 8. 一个最小观察流程

如果你已经在 QEMU 中挂载了 virtio block 设备，可以按下面顺序观察：

```bash
# [U-Boot]
virtio scan
virtio info
part list virtio 0
ls virtio 0:1 /
```

如果你在真实开发板上使用 SD card：

```bash
# [U-Boot]
mmc list
mmc dev 0
mmc info
part list mmc 0
ls mmc 0:1 /
```

这组命令全部是只读操作，适合初学者先建立信心。

## 9. 常见问题

#### `part list` 没有输出

先确认设备是否存在，再确认设备编号是否正确。对 USB 和 virtio 设备，还要确认已经扫描。

#### U-Boot 能看到分区，Linux 却找不到 rootfs

这是两个阶段的问题。U-Boot 能读取分区，只说明启动前访问成功；Linux 是否能找到 rootfs，还取决于内核驱动、设备名、root 参数和文件系统支持。

#### `mmc 0:1` 对应 Linux 的哪个设备

没有通用答案。常见情况下可能对应 `/dev/mmcblk0p1`，但具体要看 Linux 内核枚举顺序。不要在 U-Boot 命令里写 Linux 设备名，也不要在 `bootargs root=` 里写 U-Boot 设备名。

## 本章小结

你现在可以把 U-Boot 访问存储的流程概括为：扫描设备、确定设备编号、查看分区表、选择分区、从文件系统加载启动文件。这条路径是移植和排查启动问题时最常用的思维框架。

## 思考与练习

1. 在 QEMU 或开发板上列出当前 U-Boot 能识别的存储设备。
2. 找到存放 `/boot` 的分区，并使用 `ls` 查看它的目录。
3. 解释 `load mmc 0:1 ${kernel_addr_r} /boot/Image` 中每个参数的含义。
