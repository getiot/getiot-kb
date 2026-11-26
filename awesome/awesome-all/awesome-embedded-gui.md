---
sidebar_position: 14
---

# 优秀嵌入式 GUI 项目



## LVGL

- 开源
- https://lvgl.io
- https://github.com/lvgl/lvgl



## Qt for MCU

Qt 在嵌入式领域应用非常广泛，尤其是工控、医疗、车载等行业。如果是 MCU 平台，可以使用 Qt for MCU。

Qt for MCU 是专门为 ARM Cortex-M 单片机开发的，目前支持以下测试硬件平台：

- STM32F769I-DISCO
- STM32F7508-DK
- i.MX RT1050-EVKB
- Renesas RH850

- 闭源
- [https://www.qt.io/zh-cn/produ...](https://link.segmentfault.com/?enc=pmsEVcWxGOfyGhWqE7U4qA%3D%3D.%2B%2FvT2tUQ%2F4coOpGoXF%2FfgCQNBAxryXlh5ykcPosccfVatZaSd%2F0rekyMIL9pe6i%2B8FcYlo9bHEGVcDBqGjl9rgKMCYKVLRNiuH25%2B%2BWPHYw%3D)



## ucGUI（emWin）

emWin 是德国 Segger 公司开发的嵌入式图形界面库。

ucGUI 是 Segger 为 Micrium 公司（ucOS 所属公司）定制的 emWin，需要付费才能使用。

STemWin 是 Segger 为 ST 公司定制的 emWin，如果使用 STM32 系列微控制器，可以免费使用 STemWin。

- 闭源
- [https://www.segger.com/produc...](https://link.segmentfault.com/?enc=mU86Yd6vQkwNx8%2FCTYYeRg%3D%3D.2%2F%2BCoPXJ7LX6OQKHIpsdhEDqsmMfvH91%2FnJ2TYvsvNN675V%2F%2B6tS5B76lz78fIDNgt7KyfAYj0zqvvuF%2BkgF2w%3D%3D)



## GUIX

要说 GUIX，就不得不说说 ThreadX。ThreadX 的作者是 William lamie（同样是 Nucleus RTOS 的原始作者，于 1990 年发布）。1996的时候成立了 Express Logic，并于 1997 发布首版 ThreadX RTOS。
而后，发布了它的各个关键组件。

1. FileX – ThreadX 的嵌入式文件系统于 1999 年发布首版。
2. NetX – ThreadX 的嵌入式 TCP / IP 网络协议栈于 2002 年发布首版。
3. USBX – ThreadX 的嵌入式 USB 协议栈于 2004 年发布首版。
4. GUIX – ThreadX 的嵌入式 UI 于 2014 年发布首版。

Microsoft 在2019年4月18日以未公开的价格购买了 Express Logic，也就是说，微软通过 ThreadX 完成了它的物联网闭环。所以说嘛，threadX 值得了解，而他之上的 GUIX 组件，也仍是可以和其它图形 GUI 相媲美的存在。

GUIX 成为 Azure RTOS 的一部分。

- 开源
- [https://docs.microsoft.com/zh...](https://link.segmentfault.com/?enc=ct9uNi5qT5xTDtoKrUlOUg%3D%3D.Cgm1TQm1E2NTqMEJ1w8cLOEc62CGh%2B5zGataIGme3ZQgV3iCNsUNF1%2B5QyiskTFigc4qXrMOAPZ%2FfmM%2BR9c%2F6GjP6qESH9blfK8vEZI4EGU%3D)
- https://github.com/azure-rtos/guix



## TouchGFX

TouchGFX 以界面华丽、流畅以及强劲的 TouchGFX Designer 著称。2018年被意法半导体（ST）收购，如果你的产品使用 STM32 系列微控制器（包括 MCU、MPU），则可以免费使用 TouchGFX。

目前，可以通过两种方法为 STM32 开发 TouchGFX 图形界面：

1. 利用 TouchGFX Designer 软件，支持图片和控件拖拽，可快速生成在 KEIL 或 IAR 等 IDE 中可打开的工程项目；
2. 利用 STM32CubeMX 开发 TouchGFX 应用（STM32CubeMX 5.0 版本开始增加了 TouchGFX 支持）。

- 闭源
- [https://www.touchgfx.com/](https://link.segmentfault.com/?enc=jZCDLcawUD7O1S%2BO4eRuTQ%3D%3D.IA46kLgnZgP5FjMYDKlWEy5e7GgbmAt8apnhHujI4Cw%3D)



## μGFX

- 闭源
- [http://www.ugfx.org/](https://link.segmentfault.com/?enc=8ByPduRCRXnk4cVMo6hH1w%3D%3D.L3uxFqSh0ZZsqr%2FMWSOX5rNfl4vipxDSC52hOskEelo%3D)



## 柿饼 UI

- 闭源
- [https://www.rt-thread.org/pag...](https://link.segmentfault.com/?enc=iEkl%2FlukfKJItQjSL7VZPA%3D%3D.ae%2BcwmndLN8Mj%2FlW9yHzbBXEcx%2FlwlPr42%2BlYM4i10FC6OzKsjj2ftrIIHGiEZ6%2B)



## EmbeddedWizard

EmbeddedWizard 是德国 TARA System 公司开发的一个使用舒适、灵活的嵌入式系统 GUI 开发工具。

- 闭源
- [http://www.embedded-wizard.de/](https://link.segmentfault.com/?enc=AOFfc595ztmYVOMtsuhFBQ%3D%3D.7kmtIJpimJ%2Fw0Qz%2BDPSCs8Dy4FddlzkcySRBPzMVqqM%3D)



## Storyboard

- 闭源
- [https://www.cranksoftware.com/](https://link.segmentfault.com/?enc=w4ChFfZt4ALDIeFa4tPf8w%3D%3D.GSbzoBXkwZq7b0IEi%2FTbb0v%2FR0q7AtYOA0lPSTUTpgA%3D)



## Altia

- 闭源
- [https://www.altia.com/](https://link.segmentfault.com/?enc=lzGX8Zyb%2FmQuY%2B%2FbG%2B7%2Fhw%3D%3D.m47D%2BRTLFl%2FU9VpjBChnO7plPyN17B7YuRsjh1SUa40%3D)



## AWTK

AWTK 全称 Toolkit AnyWhere，是 ZLG 开发的开源 GUI 引擎，旨在为嵌入式系统、Web、各种小程序、手机、PC 打造的通用 GUI 引擎，为用户提供一个功能强大、高效可靠、简单易用、可轻松做出炫酷效果的 GUI 引擎。

- 开源
- https://github.com/zlgopen/awtk



## 玲珑 GUI

- 开源
- [https://gitee.com/gzbkey/Ling...](https://link.segmentfault.com/?enc=vddxxcpBT%2Bj4YFd2aH%2BljA%3D%3D.ozr%2BXdP7fyuGDGdA4VlNdGC%2Bm4xQBz8zQ9Sp65jhBQ%2F72r%2BuYBoHOyHaCPz9W821)



## MiniGUI

MiniGUI 是北京飞漫软件技术有限公司创建的开源 GUI 图形界面库。经过多年的发展，MiniGUI 已经成为一个性能优良、功能丰富的跨平台嵌入式图形界面库，广泛应用于通信、医疗、工控、电子、机顶盒、多媒体等领域。

目前，MiniGUI 的最新版本为 MiniGUI 5.0，对中文支持友好，支持 GB2312 和 BIG5 字符集，其他字符集也可以轻松加入。

- 开源
- https://github.com/VincentWei/MiniGUI



## Microchip MPLAB Harmony



