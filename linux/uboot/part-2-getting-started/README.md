---
sidebar_position: 0
sidebar_label: 第二部分：第一次使用 U-Boot
---

# 第二部分：第一次使用 U-Boot

本部分在 QEMU ARM64 `virt` 上动手运行 U-Boot：先搭好工具链并生成镜像，再进入命令行观察启动过程。读完后，你应能独立启动 `=>` 提示符，并完成几项只读检查。

建议按顺序阅读：

1. [搭建 QEMU 实验环境](/uboot/qemu-environment/) — 安装工具、固定 v2026.07、生成并验收 `u-boot.bin`
2. [运行 U-Boot](/uboot/first-run/) — 第一次启动、中断自动启动、复位与退出
3. [命令行与常用命令](/uboot/commands/) — 系统练习常用命令
4. [阅读 U-Boot 启动日志](/uboot/reading-boot-log/) — 用日志判断当前阶段

若尚未建立启动链心智模型，建议先浏览[第一部分](/uboot/embedded-system-and-bootloader/)。
