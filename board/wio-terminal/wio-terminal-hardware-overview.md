---
sidebar_position: 2
slug: /wio-terminal-hardware-overview
---

# Wio Terminal 硬件概述



本节详细介绍 Wio Terminal 的硬件情况，包括硬件资源分布、规格参数、IO 管脚等。你可以先大致浏览一遍，在后面章节的学习和实验中使用到具体硬件资源时，再回过头来仔细查看。



## 硬件分布

![](https://static.getiot.tech/WioT-Hardware-Overview.png#center)



## 规格参数

**主芯片**

- 型号：ATSAMD51P19
- 内核：ARM® Cortex®-M4F
- 频率：120MHz（最高可达 200MHz）
- 程序存储大小：512KB（外置内存：4MB）
- RAM大小：192KB
- 工作温度：-40°C ~ 85°C (TA)

**LCD屏**

- 分辨率：320 x 240
- 显示屏尺寸：2.4英寸
- 驱动器 IC：ILI9341

**无线连接**

- 型号：RTL8720DN
- KM4 CPU：ARM® Cortex®-M4F
- KM0 CPU：ARM® Cortex®-M0
- Wi-Fi：802.11 a/b/g/n 1x1, 2.4GHz & 5GHz
- 蓝牙：支持 BLE5.0
- 硬件引擎：AES/DES/SHA

**内置模块**

- 加速计：LIS3DHTR
- 麦克风：1.0V-10V -42dB
- 扬声器：≥78dB @10cm 4000Hz
- 光传感器：400-1050nm
- 红外发射器：940nm

**扩展接口**

- microSD 卡槽：最大 16GB
- GPIO：40-PIN（与 Raspberry Pi 兼容）
- Grove：2（多功能）
- FPC：20-PIN
- USB Type-C：供电 & USB-OTG

**操作界面**

- 5向开关
- 电源/重置开关
- 用户自定义按钮 x 3

**外壳**

- 尺寸：72mm x 57mm x 12mm
- 材质：ABS+PC



## 引脚描述

![](https://static.getiot.tech/WioT-Pinout.jpg#center)



## 更多

- [Wio Terminal IO 引脚](/wiot/wio-terminal-io/)
- [Wio Terminal 数字引脚](/wiot/wio-terminal-digital/)
- [Wio Terminal 模拟引脚](/wiot/wio-terminal-analog/)
- [Wio Terminal 按键](/wiot/wio-terminal-buttons/)
- [Wio Terminal 五向开关](/wiot/wio-terminal-5-way-switch/)
- [Wio Terminal 蜂鸣器](/wiot/wio-terminal-buzzer/)
- [Wio Terminal Grove 接口规范](/wiot/wio-terminal-grove/)



## 资源下载

- [Wio-Terminal 原理图](https://files.seeedstudio.com/wiki/Wio-Terminal/res/Wio-Terminal-Schematics.pdf)

