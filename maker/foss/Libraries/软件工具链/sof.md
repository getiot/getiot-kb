---
sidebar_position: 10
slug: /sof
---

# Sound Open Firmware

Sound Open Firmware（简称 SOF）是由英特尔发起，用于提供开源的音频 DSP 固件和开发工具的开源项目，旨在放弃为与声音处理相关的 DSP 芯片提供封闭固件的做法。随后，该项目转移到 Linux 基金会的领导下，得到了包括谷歌、AMD、联发科、恩智浦、Realtek 和其它厂商的支持，目前在社区的参与下和各厂商的参与下进行开发。

项目开发 SDK 以简化固件开发、Linux 内核的声音驱动程序，以及用于各种 DSP 芯片的开箱即用的固件集，其中，除其他外，生成数字签名的二进制程序集。由于其模块化结构， Sound Open Firmware 可移植到各种 DSP 架构和硬件平台。例如，在支持的平台中，支持各种 Intel（Broadwell、Icelake、Tigerlake、Alderlake 等）、Mediatek（mt8195）、NXP（i.MX8*）、AMD（Renoir）芯片搭载基于 DSP 的 Xtensa 声明了 HiFi 架构 2、3 和 4。

在开发过程中，你可以使用特殊的模拟器或 QEMU。使用面向 DSP 的开放固件可以让你更快地排除和诊断固件问题，并让用户有机会根据自己的需求独立定制固件、执行有针对性的优化，并创建仅包含产品中必要功能的轻量级固件版本。

除此之外，Sound Open Firmware 还支持 Zephyr 和 XTOS 作为固件的基础。

- 项目官网：[https://www.sofproject.org](https://www.sofproject.org)
- 文档中心：[https://thesofproject.github.io/latest/index.html](https://thesofproject.github.io/latest/index.html)
- GitHub 地址：[https://github.com/thesofproject/sof](https://github.com/thesofproject/sof)

