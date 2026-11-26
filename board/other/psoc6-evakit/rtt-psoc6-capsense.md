---
sidebar_position: 4
sidebar_label: PSoC6 RTT 触摸滑条
slug: /rtt-psoc6-capsense
---

# 英飞凌 PSoC6 评估板 CAPSENSE 触摸滑条



PSoC™ 62 with CAPSENSE™ evaluation kit 开发板（以下简称 PSoC 6 RTT 开发板）是英飞凌（Infineon）联合 RT-Thread 发布一款面向物联网开发者的 32 位双核 MCU 开发套件，其默认内置 RT-Thread 物联网操作系统。本文主要介绍 CAPSENSE™ 技术原理，并通过 RT-Thread Studio 快速开发触摸滑条应用程序。



## CAPSENSE 基本原理

在物联网时代，无论是家庭电器还是可穿戴式设备等众多消费类产品，触摸控制已经司空见惯了。由于不再需要传统机械按钮和开关中的活动零件，触摸传感器系统实现了高度可靠性，不太可能因磨损而发生故障。同时，触摸传感器系统可完全封装在保护材料中，因此能够在严苛环境中工作。当然，除了可靠性之外，触摸传感器可轻松满足不同的形状要求，满足客户对产品的美观精巧设计需求。

英飞凌的 CAPSENSE™ 技术就是业界领先的具有防水性能和接近感应功能的触摸感应解决方案。该方案提供完整的器件（PSoC 有专有 CapSense 功能，其中包括一个用于处理电容触摸传感器的完整信号链）、中间件和设计参考，帮助用户设计外观优雅、可靠且易于使用的电容触摸感应功能。同时，CAPSENSE 还带来了行业领先的低功耗运行，平均电流消耗为22 μA，并带来了业内最宽的电压范围（1.71-5.5 V）。并且集成了包括 Capacitive Sigma Delta（CSD）感应算法和自动调谐算法等核心算法，确保在嘈杂的环境下也可以精准触控，适应复杂的外部环境。

从技术原理来看，电容触摸传感器就是充分利用了**手指或手接近专门构建的触摸表面时电容将发生变化**的特征。触摸传感器使用自电容和互电容两种不同的方法来检测此类变化，并通过放大、滤波等信号处理的手段将其准确捕获。

![](https://static.getiot.tech/PSoC6-RTT-board-capsense-1.jpg)

用户使用英飞凌 CAPSENSE 电容式触摸传感器界面时，手指在界面上形成与嵌入式传感器的电气连接。传感器与 PSoC 器件一起工作，将有关手指位置的数据转换为各种系统控制功能。一个 PSoC 器件可以用简单的触敏控制取代几十个机械开关和控件。基于 CAPSENSE 的“按键”和滑块控件不像机械按键和开关那样容易受环境磨损影响，因此比传统按键控制更可靠。

在触摸传感器设计方面，电容式传感器板由多层板上的印制线构建而成。对于基本的自电容按钮，最简单的设计是将传感器板印制线放在板子上方，印制线四周环绕着网状接地平面。传感器板连接到控制器（通常连接在板子下方）的输入引脚，还可提供接地平面。最后，顶层覆盖着不导电保护性化合物，形成了传感器覆面。对于小键盘，工程师通过将各个传感器板加入可寻址按钮阵列来扩展此项基本设计。



## PSoC6 CAPSENSE 特性

PSoC 6 RTT 开发板配备了一个触摸滑条，方便用户评估 CapSense 功能。你可以基于 CapSense 的强大功能，做一些有趣的项目。

具体来说，PSoC6 中的 CapSense 具有以下特性：

- 支持自电容和互电容触摸感应；
- 功能强大的 CapSense Sigma Delta（CSD）和 CapSense Crosspoint（CSX）感应技术，能够为基于自电容和互电容的触摸感应提供一流的信噪比；
- 在覆盖材料和厚度不同的条件下仍能提供高性能感应（请参考 CapSense 基本原理、覆盖层材料和覆盖层厚度）；
- SmartSense™ 自动调试技术；
- 接近感应的范围较大（接近感应距离可达 30 cm）。



## CAPSENSE 应用示例

RT-Thread 提供了一个简单的触摸滑条应用示例，只需要在 RT-Thread Studio 勾选配置即可快速体验。

双击工程中的 RT-Thread Settings ，打开项目配置页面。在“硬件”选项卡中，找到 Board extended module Drivers，勾选 Enable Slider 和 Enable Slider Demo。此时会自动勾选 Slider Demo 的相关依赖，例如 PWM 功能。

![](https://static.getiot.tech/PSoC6-RTT-capsense-demo-1.jpg)

按 Ctrl + S 保持配置，会更新当前工程。然后重新编译工程，将固件下载到 PSoC 6 RTT 开发板。

在 RT-Thread Studio 打开终端，按 Tab 键可以可以看到当前系统支持的命令，如下所示。

```bash
 \ | /
- RT -     Thread Operating System
 / | \     5.0.1 build Sep 20 2024 16:17:44
 2006 - 2022 Copyright by RT-Thread team
msh >
RT-Thread shell commands:
clear            - clear the terminal screen
version          - show RT-Thread version information
list             - list objects
help             - RT-Thread shell help.
ps               - List threads in the system.
free             - Show the memory usage in the system.
pin              - pin [option]
pwm              - pwm [option]
reboot           - Reboot System
pwm_sample       - <pwm0> channel7 sample
Slider_ctrl_samp - Slider sample to ctrl led
```

其中 `Slider_ctrl_samp` 就是触摸滑条的 Demo 程序，该程序代码位于 board/ports/slider_sample.c 文件。其功能是通过触摸滑条控制 PWM 波形，从而控制 LED 灯的亮度。

为了方便查看触摸滑条对应的亮度值，我在 `update_led_state()` 函数中增加了一个打印。

```c {9} showLineNumbers
void update_led_state(led_data_t *ledData)
{
    if (ledData->brightness >= 0)
    {
        uint32_t brightness = (ledData->brightness < LED_MIN_BRIGHTNESS) ? LED_MIN_BRIGHTNESS : ledData->brightness;

        /* Drive the LED with brightness */
        rt_pwm_set(pwm_dev, PWM_DEV_CHANNEL, 1 * 1000 * 1000, GET_DUTY_CYCLE(brightness));
        rt_kprintf("brightness = %u\n", brightness);
    }
}
```

重新编译并下载到开发板，在终端执行 `Slider_ctrl_samp` 命令启动示例程序，此时用手指触摸滑条，可以看到如下打印。

```bash
brightness = 0
brightness = 2
brightness = 13
brightness = 30
brightness = 49
brightness = 71
brightness = 97
brightness = 100
```

滑条的一侧对应亮度值为 0，另一侧对应亮度值为 100。



## 资源链接

- [CAPSENSE™ 控制器 - Infineon Technologies](https://www.infineon.com/cms/cn/product/microcontroller/sensing-controller/capsense-controllers/)
- [使用 Cypress CY8CKIT 来简化电容触摸传感器的设计](https://www.digikey.sg/zh/articles/simplifying-capacitive-touch-sensor-design-cypress-cy8ckit)
- [PSoC 4 and PSoC 6 MCU CapSense Design Guide](https://www.mouser.com/pdfDocs/001-85951_AN85951_-_PSoC_R_4_and_PSoC_6_MCU_CapSense_R_Design_Guide.pdf)



