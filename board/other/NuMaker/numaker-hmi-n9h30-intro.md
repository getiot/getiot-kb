---
sidebar_position: 1
---

# NuMaker-HMI-N9H30 开发板



NuMaker-HMI-N9H30 是新唐科技（nuvoton）推出的一款开发平台（评估板），带有 HMI 人机交互界面，支持多种 GUI 图形库，如 LVGL、emWin、Qt 等。该开发板已通过 LVGL 官方认证，这意味着它能很好地支持 LVGL 丰富的模组化图形组件以及功能，如动画、抗锯齿、透明度、平滑滚动、图层混合等效果，帮助开发者轻松地建构动态 GUI 效果。

![NuMaker-HMI-N9H30 开发板](https://static.getiot.tech/numaker-hmi-n9h30.jpg#center)

## 板卡简介

NuMaker-HMI-N9H30 开发板采用新唐科技的 N9H 系列微处理器，是一套完整的人机显示界面解决平台。N9H30 系列采用 ARM926EJ-S 为内核，运行速度达 300 MHz，内置 TFT-LCD 显示控制器、2D 图形加速器及 JPEG 解码器，最高可驱动彩色 1024 x 768 像素并行端口（Parallel Port），色彩深度可达 16.7 百万（24 位），可为人机界面提供更顺畅与华丽的显示效果。同时，该系列开发板最高内置了 128 MB DDR SDRAM 存储器，充裕的硬件存储和运算空间，让开发者在使用不同 GUI 图形库时更具设计弹性。

**NuMaker-HMI-N9H30 开发板硬件特性如下：**

- 32 位 ARM926EJ-S [N9H30系列](https://www.nuvoton.com/products/microprocessors/arm9-mpus/-n9h-series/)微处理器核心，工作频率最高可达 300 MHz
- 内置 64MB DDR 存储器
- 7 寸 LCD（800x480）RGB 24-bit 含4线式电阻式触控
- USB 2.0 高速主机 x 1
- USB 2.0 高速设备 x 1
- 10/100 Mbps 以太网 x 2
- RS-232 x 2（其中 1 路用于系统开发和调试）
- RS-485 x 1
- CAN x 1
- 22 GPIO 扩展接口，其中包含 7 组 UART 功能
- Micro-SD/TF 卡插槽 x 1
- 32MB SPI Flash
- 128MB NAND Flash
- 麦克风输入 x 1
- 耳机/喇叭输出 x 1



## 图形界面

NuMaker-HMI-N9H30 开发板的最大特点就是配备了一个 7 寸的 LCD 显示屏，可作为人机交互界面（HMI）使用。在 GUI 库支持方面，NuMaker-HMI-N9H30 不仅支持历史悠久的 emWin 库，也支持其他流行的嵌入式图形界面库，如 [LVGL](/lvgl/lvgl-intro/) 等。利用这些优秀的 GUI 图形库，用户可以为设备开发出美观、流畅的图形界面。

![](https://static.getiot.tech/NuMaker-HMI-N9H30-show-01.jpeg#center)



## 相关资料

- [NuMaker-HMI-N9H30 板卡介绍](https://direct.nuvoton.com/tw/numaker-hmi-n9h30)
- [硬件原理图 Schematic](https://www.nuvoton.com/resource-download.jsp?tp_GUID=HL1020201117191514)
- [NuMaker-HMI-N9H30 用户手册](https://www.nuvoton.com/resource-download.jsp?tp_GUID=UG1320210329155300)
- [固件下载工具 NuWriter](https://github.com/OpenNuvoton/NUC970_NuWriter)
- [编译工具链 Windows 32-bit 6-2017-q1-update ARM GCC](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads/6-2017-q1-update)



旧的

- 资源下载：[https://www.nuvoton.com/products/gui-solution/gui-platform/numaker-hmi-n9h30](https://www.nuvoton.com/products/gui-solution/gui-platform/numaker-hmi-n9h30)
- RT-Thread BSP：[https://github.com/RT-Thread/rt-thread/bsp/nuvoton/nk-n9h30](https://github.com/RT-Thread/rt-thread/tree/master/bsp/nuvoton/nk-n9h30)
- LVGL 官方认证：[https://blog.lvgl.io/2022-02-18/numaker-hmi-n9h30-review](https://blog.lvgl.io/2022-02-18/numaker-hmi-n9h30-review)

