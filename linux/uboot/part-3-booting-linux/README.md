---
sidebar_position: 0
sidebar_label: 使用 U-Boot 启动 Linux
---

# 使用 U-Boot 启动 Linux

前两部分你已经认识了 U-Boot，也能在 QEMU ARM64 `virt` 机器中进入命令行。接下来我们要做一件更接近真实产品的事情：让 U-Boot 把 Linux 启动起来。

这一部分不会一上来就把一长串命令丢给你。你会先理解 U-Boot 为什么要关心内存地址、启动文件、文件系统、分区、网络和环境变量，然后再把这些知识拼成一条完整的启动命令链。

学完本部分后，你应该能够：

- 说清楚 Linux 启动通常需要哪些文件。
- 看懂 `kernel_addr_r`、`fdt_addr_r`、`ramdisk_addr_r` 这类地址变量。
- 知道 `bootargs` 如何影响 Linux 内核。
- 根据镜像格式选择 `booti`、`bootm` 或 `bootz`。
- 从磁盘、文件系统或网络加载启动文件。
- 把手动命令整理成可重复执行的启动脚本。
- 理解 Standard Boot 与传统手写 `bootcmd` 的关系。

本部分仍以 Mainline U-Boot v2026.07 和 QEMU ARM64 为基准。真实开发板上的命令名称可能相同，但设备编号、分区编号、地址布局和启动文件路径往往不同。你在真实硬件上操作前，一定要先确认板级文档。
