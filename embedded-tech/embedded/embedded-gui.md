---
sidebar_position: 5
slug: /embedded-gui
---

# 嵌入式 GUI 图形界面

![嵌入式 GUI 图形界面](https://static.getiot.tech/Embedded-GUI-banner_processed.webp#center)

嵌入式开发中的 GUI（图形用户界面）是指在嵌入式系统中用于实现图形化操作的用户界面，通常可以通过触摸屏、按钮、鼠标或其他输入设备与系统进行交互。例如智能家居控制面板、汽车导航仪、医疗仪器、游戏机等等，都可以看到 GUI 的身影。

简单来说，使用 GUI 图形界面库，可以帮助开发者快速设计和实现一个具有操作界面的程序，例如绘制窗口、按钮等，而不需要弄清楚底层原理。下面介绍一些在嵌入式系统中常用的 GUI 图形用户界面库/框架。



## Qt

Qt 是奇趣科技自1991年起开发的跨平台 C++ 图形用户界面应用程序开发框架。

Qt 框架非常适合为嵌入式系统创建跨平台应用程序。嵌入式应用程序通常是用 C/C++ 编写的。C++ 是一种面向对象的编程语言（OOP），OOP 使应用程序工程过程更快、更容易和更安全。同时，C++ 也支持 WOCA（Write Once, Compile Anywhere）原则。

Qt 支持多种平台，包括移动设备（Android、iOS）、桌面（Windows、Linux、macOS）、嵌入式（Embedded Linux、Embedded Android、Windows Embedded、QNX 等）。Qt 在工业控制、医疗、车载等领域，有着非常广泛的应用。

网址：[https://www.qt.io](https://www.qt.io)



<!--

## GTK

你可以使用 GTK+ 创建 GUI 程序。

小部件工具包的主要特点：

- 开源；
- 多平台；
- C是使用的语言；
- 有可用的 C++、dotNet 和 Python 绑定。
- 对强大主题的良好支持；
- 与 Windows、Linux 和 macOS 兼容。



## SDL

**Simple DirectMedia Layer (SDL)**是一个跨平台库。

SDL的主要特点：

- 开源（在 zlib 许可下）；
- 取决于目标平台，用 C、C++ 或 Objective-C 编写；
- 也有其他语言的绑定可用。
- 支持多窗口；
- 硬件加速的 2D 图形；
- 广泛用于跨平台多媒体程序（主要是游戏）；
- 以其令人难以置信的翻译功能而闻名。

-->



## LVGL

LVGL（原名 LittlevGL） 是一款开源的嵌入式图形用户界面库，专为嵌入式系统设计。LVGL 以其轻量级、灵活性和强大的功能而备受开发者青睐，资源够的情况下可移植到所有 MCU。

LVGL 是完全开源的，可以查看、修改、编译和调试底层源代码，附带 30 多个内置小部件，绘制画面非常的方便，配备强大的软件渲染引擎，可以使用最少的资源以矢量图形方式绘制抗锯齿小部件。

由于其轻量级设计，LVGL非常适用于那些资源受限的嵌入式系统，例如微控制器（MCU）和嵌入式 Linux 系统。同时，LVGL 的灵活性使其能够满足对 GUI 高度定制的需求。开发者可以轻松地调整和定制界面元素，以适应特定项目的设计要求。

GitHub 仓库：[https://github.com/lvgl/lvgl](https://github.com/lvgl/lvgl)



## MiniGUI

MiniGUI 是一款轻量级的开源图形用户界面库，专为嵌入式系统设计。MiniGUI 以其高度可定制和适应性强的特点而备受开发者推崇。资源够的情况下可移植到所有 MCU。免费用于非商业用途，使用部分指定的 SOC 可免费使用。

MiniGUI 不仅支持嵌入式 Linux 系统，还可以运行在其他嵌入式平台上。eCos 和其他传统 RTOS（RT-Thread、RTEMS、FreeRTOS、VxWorks、ThreadX、Nucleus、pSOS、uC/OS-II、OSE 等），特别是 MiniGUI 作为 HybridOS 的窗口系统运行，这使得 MiniGUI 成为一个具有广泛可移植性的选择。

GitHub 仓库：[https://github.com/VincentWei/MiniGUI](https://github.com/VincentWei/MiniGUI)



## uGUI

uGUI 是一款轻量级的开源图形用户界面库，专为资源受限的嵌入式系统设计。其注重简洁性和易用性，使其成为开发者在嵌入式环境下构建用户友好界面的理想选择。资源够的情况下可移植到所有 MCU。

uGUI 支持 LCD、TFT、E-Paper、LED 或 OLED 等显示技术。可以说，只要显示器能够显示图形，μGUI 就不受特定显示技术的限制。另外，uGUI 整个模块由两个文件组成 —— ugui.c 和 ugui.h，因此移植起来非常的方便。

主要特点：

- 轻量级设计：uGUI 的设计目标是在资源有限的环境中运行，因此具有小巧的体积和较低的内存占用。这使其适用于单片机等资源受限的嵌入式系统。
- 易于集成和使用：uGUI 的 API 设计简单直观，易于学习和使用。开发者可以迅速集成 uGUI 到他们的项目中，并通过简单的 API 调用实现基本的 GUI 功能。
- 可扩展性：虽然 uGUI 的核心设计简单，但它仍提供了一些可扩展的特性，如支持多种字体和颜色配置。这使得开发者可以通过简单的配置满足一些基本的定制需求。

总的来说，uGUI 是一款适用于资源受限嵌入式系统的轻量级 GUI 库。其简洁的设计和易用的 API 使其在简单项目或需要快速原型设计的情况下表现出色。然而，对于一些复杂的 GUI 需求，可能需要考虑更为功能丰富的 GUI 库。对于初学者或对资源有严格要求的项目，uGUI 是一个简单而可靠的选择。

GitHub 仓库：[https://github.com/achimdoebler/UGUI](https://github.com/achimdoebler/UGUI)



## GUISlice

GUISlice 是一款轻量级的开源嵌入式图形用户界面库，专为资源受限的系统设计。它注重简洁性和易用性，旨在帮助开发者快速实现基本的嵌入式用户界面。资源够的情况下可移植到所有 MCU。

GUISlice 以小巧的体积和低内存占用著称，纯 C 库，无动态内存分配。另外，还提供了一个用于生成布局的跨平台 GUIslice Builder 应用程序，帮助开发者迅速上手使用。

GitHub 仓库：[https://github.com/ImpulseAdventure/GUIslice](https://github.com/ImpulseAdventure/GUIslice)



<!--

## 参考

- [MCU 的 TOP 15 图形GUI库：选择最适合你的图形用户界面（一）](https://mp.weixin.qq.com/s/6Pgq5A4o2RVdV2Fje7rzgg)

-->

