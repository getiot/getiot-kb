---
sidebar_position: 1
sidebar_label: 了解目标硬件与启动介质
slug: /target-hardware
---

# U-Boot 移植：目标硬件与启动介质

移植 U-Boot 的第一步不是写代码，而是了解目标硬件。你要先弄清楚芯片上电后会执行什么、从哪里加载固件、DRAM 如何初始化，以及启动介质有什么限制。

很多移植失败不是因为代码难，而是因为一开始就没有弄清楚启动链。Boot ROM 的加载介质、偏移、镜像格式、签名要求和恢复模式，都是你动手前必须确认的事实。

## 1. 先收集资料

建议准备：

- SoC datasheet 或 reference manual。
- 开发板原理图。
- 厂商 SDK 或 BSP。
- 原厂 U-Boot、Linux kernel、设备树。
- 启动介质说明，例如 eMMC、SD card、SPI NOR、SPI NAND。
- 串口引脚、电压和波特率。

如果资料不完整，不要急着移植。先让原厂镜像正常启动，并保存完整串口日志。

你可以建立一张硬件信息表：

```bash
SoC:
CPU 架构:
DRAM 容量:
启动介质:
串口电平:
串口波特率:
原厂 U-Boot 版本:
Linux kernel 版本:
设备树文件:
恢复模式:
```

这张表看起来朴素，但后续排查会不断用到它。

## 2. 先保存原厂基线

在移植 mainline U-Boot 前，先用原厂镜像启动一次，并保存日志：

```bash
# [Host]
script -f board-vendor-boot.log
```

然后给开发板上电，等待系统完整启动。日志中重点记录：

- Boot ROM 或 vendor loader 输出。
- SPL/TF-A/OP-TEE/OpenSBI 横幅。
- U-Boot 版本。
- DRAM size。
- 启动介质。
- kernel、DTB、rootfs 路径或分区。

原厂日志是你的对照组。以后 mainline U-Boot 启动失败时，你可以比较两边差异。

## 3. 识别启动链

常见启动链包括：

```bash
Boot ROM -> SPL -> U-Boot proper -> Linux
Boot ROM -> TF-A BL2/BL31 -> U-Boot proper -> Linux
Boot ROM -> OpenSBI -> U-Boot proper -> Linux
Boot ROM -> vendor loader -> U-Boot proper -> Linux
```

不同 SoC 差异很大。比如 ARMv8 平台经常需要 TF-A 提供 EL3 固件；RISC-V 平台经常需要 OpenSBI 提供 supervisor binary interface；有安全需求的产品可能还会加入 OP-TEE。

判断启动链时，先问几个问题：

- Boot ROM 第一个加载的文件是什么？
- 第一阶段运行在 SRAM 还是 DRAM？
- 谁负责初始化 DRAM？
- U-Boot proper 是由谁加载的？
- Linux DTB 由谁提供？
- 是否存在安全世界固件或 supervisor 固件？

这些问题答不出来，就不要急着烧录。

## 4. 启动介质决定镜像布局

启动 ROM 往往只能从固定介质、固定偏移、固定格式加载第一阶段镜像。你需要确认：

- 第一阶段镜像放在什么偏移。
- 是否需要厂商头部或签名。
- 是否要求固定大小或对齐。
- environment 存储在哪里。
- 是否有恢复模式。

:::warning
不要把 QEMU 的 `-bios u-boot.bin` 经验直接套到真实硬件。真实 SoC 的 Boot ROM 可能完全不认识裸 `u-boot.bin`。
:::

常见启动介质差异：

| 介质 | 需要关注 |
| --- | --- |
| SD card | 扇区偏移、分区布局、是否有保留区域 |
| eMMC | boot partition/user partition、写保护、启动分区选择 |
| SPI NOR | 擦除块大小、环境变量偏移、固件冗余 |
| SPI NAND/raw NAND | 坏块、ECC、OOB、UBI 布局 |
| USB/串口下载 | 是否只是临时加载，是否能写入持久介质 |

## 5. 最小移植目标

第一次移植不要试图一次完成所有功能。建议目标分层：

1. 串口有输出。
2. DRAM size 正确。
3. 进入 U-Boot 命令行。
4. 能识别启动介质。
5. 能加载 kernel 和 DTB。
6. 能手动启动 Linux。
7. 再整理自动启动和产品功能。

每过一层都保存日志。不要在没有确认前一层的情况下进入下一层。

## 本章小结

移植 U-Boot 前，先回答“谁加载谁、从哪里加载、用什么格式加载”。这三个问题没弄清楚，后面写再多代码也容易卡在最早期启动阶段。

## 思考与练习

1. 为你的目标开发板填写一张硬件信息表。
2. 保存一份原厂启动完整串口日志。
3. 画出从 Boot ROM 到 Linux 的启动链。
