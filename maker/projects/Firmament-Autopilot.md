---
sidebar_position: 24
---

# FMT 开源自驾仪系统



FMT（全称 Firmament Autopilot）是首个基于模型设计的开源自驾仪系统。



## 简介

Firmament（FMT）是一款基于模型设计（Model Based Design，简称 MBD）的开源自驾仪，可被用来快速构建无人机、无人车、无人船、机器人等的无人控制系统。基于模型设计已经被广泛应用于汽车制造、航空航天等行业，当前采用基于模型设计模式开发的飞控系统凤毛麟角，而 FMT 就是为此而诞生。FMT 结合当前最先进的基于模型设计和 3D 仿真技术，构建了从嵌入式软件，建模与仿真三位一体的软件开发平台，致力于打造下一代的开源自驾仪系统。

The system is mainly composed of two parts.

- [FMT-Firmware](https://github.com/Firmament-Autopilot/FMT-Firmware): A stable and high performance embedded system designed with C/C++.
- [FMT-Model](https://github.com/Firmament-Autopilot/FMT-Model): A simulation framework with algorithm libraries designed with MATLAB/Simulink.



## 功能特性

- High development efficency achieved with model-based deisign and debug easier.
- A stable and high performance embedded system designed with C/C++.
- A powerful simulation framework with various algorithm library designed with MATLAB/Simulink.
- Auto code generation from Simulink model adapted to different hardware platforms (ARM, AMD, Intel, etc).
- Excellent real-time performance based on [RT-Thread](https://www.rt-thread.io/) RTOS with active community and large number of third-party components.
- Support with most widely used open-source hardware Pixhawk (Both FMUv2 and FMUv5 are supported).
- Cross-platform toolchain support with Windows/Linux/Mac.
- Support with Mavlink and [QGroundcontrol](https://cn.bing.com/search?form=MOZLBR&pc=MOZI&q=QGroundControl).



## 整体架构

FMT Firmware's architecture is shown in the figure below.

[![img](https://github.com/Firmament-Autopilot/FMT-Firmware/raw/master/figures/fmt_struct.png#center)](https://github.com/Firmament-Autopilot/FMT-Firmware/blob/master/figures/fmt_struct.png#center)



## 支持硬件

Current supported hardware:

- [AMOV ICF5](https://github.com/Firmament-Autopilot/FMT-Firmware/tree/master/target/amov/icf5)
- [CUAV V5+](https://github.com/Firmament-Autopilot/FMT-Firmware/tree/master/target/cuav/v5_plus)
- [Pixhawk4 (FMUv5)](https://github.com/Firmament-Autopilot/FMT-Firmware/tree/master/target/pixhawk/fmu-v5)
- [Pixhawk (FMUv2)](https://github.com/Firmament-Autopilot/FMT-Firmware/tree/master/target/pixhawk/fmu-v2)
- [HEX Cubeorange](https://github.com/Firmament-Autopilot/FMT-Firmware/tree/master/target/cubepilot/cubeorange)
- [QEMU vexpress-a9](https://github.com/Firmament-Autopilot/FMT-Firmware/tree/master/target/qemu/qemu-vexpress-a9)

The drone hardware equipped with FMT:

- [Amovlab MFP450](https://item.taobao.com/item.htm?spm=a1z10.5-c-s.w4002-22617251051.15.4b224df8j1oIGP&id=713417934359)



## 相关链接

- GitHub 主页：[https://github.com/Firmament-Autopilot](https://github.com/Firmament-Autopilot)
- 文档中心：[https://firmament-autopilot.github.io/FMT-DOCS](https://firmament-autopilot.github.io/FMT-DOCS/#/)

