---
sidebar_position: 0
sidebar_label: 简介
---

# U-Boot 教程

![U-Boot 教程](https://static.getiot.tech/cover-uboot-tutorial.webp#center)

欢迎来到 U-Boot 教程！

在嵌入式 Linux 系统中，U-Boot 通常位于芯片上电启动流程与 Linux 内核之间。它负责完成必要的硬件初始化，识别存储和网络设备，加载内核、设备树等启动文件，并最终将系统控制权交给 Linux。除此之外，U-Boot 还提供命令行、环境变量、启动脚本、网络引导、固件验证和故障恢复等功能，是嵌入式系统启动与调试的重要基础。

U-Boot，全称 "Das U-Boot"，最早由 Wolfgang Denk 于 2000 年开发，现已成为许多嵌入式项目的首选启动加载程序。作为一个拥有二十多年历史的开源 Bootloader，U-Boot 支持多种处理器架构和硬件平台，广泛应用于开发板、路由器、工业设备、物联网终端和机器人等产品。理解 U-Boot，不仅能帮助你掌握嵌入式 Linux 的启动过程，也能让你在系统移植、故障排查、固件升级和产品化开发中更加得心应手。

本教程面向嵌入式 Linux 初学者，将沿着“先认识、再使用、后编译、最后移植”的路线展开。你会先在 QEMU 中运行 U-Boot，学习常用命令并亲手启动 Linux；随后进一步了解其源码结构、配置与编译方法、设备树和驱动模型，并尝试添加一个自定义命令；最后进入真实硬件移植、FIT 镜像、安全启动、A/B 升级和故障排查等实践内容。

无论你是第一次接触 U-Boot，还是希望系统梳理嵌入式 Linux 启动知识，都可以从这里开始，一步步理解从设备上电到 Linux 运行的完整过程。

:::tip

本教程以 Mainline U-Boot v2026.07 为基准，主要实验在 Ubuntu 24.04 和 QEMU ARM64 `virt` 平台上完成。不同 U-Boot 版本和硬件平台的配置、命令及启动流程可能存在差异，涉及平台特有内容时会在正文中单独说明。

:::

## 配套实验代码

本教程配套实验代码会维护在 GitHub 仓库 [getiot/uboot-courses](https://github.com/getiot/uboot-courses)。你可以先把实验仓库下载到本地，再跟随教程编译 U-Boot、运行 QEMU、测试 boot script 和 Standard Boot 配置：

```bash
# [Host]
git clone https://github.com/getiot/uboot-courses.git
cd uboot-courses
```

