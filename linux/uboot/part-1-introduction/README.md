---
sidebar_position: 0
sidebar_label: 认识 U-Boot
---

# 认识 U-Boot

动手敲命令之前，先建立正确的心智模型：设备为什么需要 Bootloader、U-Boot 是什么、启动链如何交接、U-Boot 内部大致如何组织。读完本部分，你应能画出一条从上电到用户空间的启动链，并知道 U-Boot 通常落在哪一环。

建议按顺序阅读：

1. [嵌入式系统与 Bootloader](/uboot/embedded-system-and-bootloader/) — 为什么不能直接跑 Linux，Bootloader 做什么  
2. [U-Boot 简介](/uboot/uboot-intro/) — U-Boot 的定位、能力边界，以及 Mainline 与厂商版本的区别  
3. [从上电到 Linux 的启动过程](/uboot/boot-process/) — 按阶段拆解启动链，并用日志定位故障  
4. [U-Boot 的架构与组成](/uboot/architecture/) — 一张内部地图：配置、驱动模型、命令与启动子系统如何协作  

本部分偏概念。命令练习、在 QEMU 中运行 U-Boot，从[第二部分](/uboot/qemu-environment/)开始。
