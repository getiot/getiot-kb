---
sidebar_label: mmc 命令
sidebar_position: 15
slug: /mmc
---

# Linux mmc 命令 - 管理 MMC/SD 卡



## 介绍

在 Linux 系统中，**`mmc`** 命令通常用于处理嵌入式系统中的存储设备，如 SD 卡或 eMMC（嵌入式多媒体卡）。通常用于与嵌入式存储设备进行交互，进行初始化、分区、读写操作等。

mmc 命令由 mmc-utils 软件包提供，在 Debian/Ubuntu 系统上可以使用如下命令进行安装。

```shell
$ sudo apt install mmc-utils
```

:::info

mmc-utils 是一个用于管理 MMC（MultiMediaCard）和 eMMC（embedded MultiMediaCard）设备的工具包。其中，mmc 命令是 mmc-utils 工具包中的一部分，用于执行与 MMC 设备相关的操作。

:::

**语法**：

```bash
mmc [<command> [<args>]] [--help]
mmc [<command>] --help
```



## 示例

显示 `/dev/mmcblk0` 存储设备的 Extended CSD 寄存器信息：

```bash
mmc extcsd read /dev/mmcblk0
```

擦除整个 `/dev/mmcblk0` 存储设备的数据块：

```bash
mmc erase /dev/mmcblk0
```

启用 `/dev/mmcblk0` 存储设备的引导分区：

```bash
mmc bootpart enable 1 /dev/mmcblk0
```

从 `/dev/mmcblk0` 存储设备的地址 `0x1000` 处读取 `0x800` 字节的数据：

```bash
mmc read /dev/mmcblk0 0x1000 0x800
```

从 rpmb 设备读取 2 个 256 字节的块到 `/tmp/block` 文件：

```bash
mmc rpmb read-block /dev/mmcblk0rpmb 0x02 2 /tmp/block
```

