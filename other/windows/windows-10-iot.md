---
sidebar_position: 1
slug: /windows-10-iot
---

# Windows 10 IoT 系统

Windows 10 IoT 是 Windows 10 版本系列，以各种物联网装置为目标，从小型的工业闸道器到较大型且更复杂的装置（例如：控制医疗设备、ATM 等），适合自动化制造、零售、医疗、军事、金融、航空、博弈等产业嵌入式装置所使用。



## Windows 10 IoT 版本

![](https://static.getiot.tech/Windows-10-IoT-Editions.png#center)

### Windows 10 IoT Enterprise

Windows 10 IoT Enterprise 是具完整 Windows 功能的操作系统，以 x86 和 x64（32 位和 64 位）处理器为目标。

它同时支持 Universal Windows App 与传统型 Windows 应用程序，并且能有效抵御现代的安全威胁，在部署、更新和支持选项上具有充分的弹性，同时还拥有全方位的嵌入式锁定功能。结合最新的 Microsoft 开发工具和 Azure 物联网服务，开发者可以获得从端到云的完整解决方案。

Windows 10 IoT Enterprise 可建立适用于所有 Windows 10 装置的 Universal Windows App，帮助开发者缩短开发时间。另外，还内置了 UnifiedPOS（POS for .NET、OPOS、JavaPOS）函数库，可以让零售应用领域开发者能够快速整合周边装置，节省装置间连接开发时间。

### Windows 10 IoT Core

Windows 10 IoT Core 是针对小型和低成本设备优化的 Windows 版本，专为物联网项目而设计。不过，它只支持 Universal Windows App，但可以利用与其他 Windows 10 版本相同的部署、设定和管理工具，使其更易整合到物联网应用情景并善用现有资源。

### 版本对比

|                | Windows 10 IoT Enterprise                                    | Windows 10 IoT Core                                          |
| -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 功能特性       | 完整功能的 Windows 操作系统<br/>支持传统 Win32 与 Universal Windows App<br/>支持 Universal Driver<br/>内建进阶嵌入式锁定功能 | 无用户界面（需自行定制）<br/>无桌面（开机直接进到 AP 画面）<br/>仅支持与执行单一 Universal Windows App<br/>支持 Universal Driver |
| 应用场景       | Industry tablets / POS / Kiosk / Digital signage / ATM / Medical / Manufacturing / Thin client | Digital signage / Smart building / IoT gateway / Smart home  |
| 产品生命周期   | 10 年供货保证<br/>10 年安全性更新                            | 10 年供货保证<br/>10 年安全性更新                            |
| 启动方式       | 离线状态：无需启动<br/>连线状态：5x5 单一（PKEA）或多重（EPKEA）启用 | 需启动                                                       |
| 嵌入式锁定功能 | EWF & Overlays<br/>USB filter<br/>Dialog and Notice filters<br/>Input Filter<br/>AppLocker and Layout Control<br/>Shell and App Launcher | USB filter<br/>Shell and App Launcher                        |



## 实践项目

### Cortana 家庭助理

此 YouTube 频道 Geek Till It Hertz 出色的教程向您展示了如何在 Raspberry Pi 上使用 Windows 10 IoT 核心构建自己的 Cortana 助手。该视频介绍了如何安装 Windows 10，因此，如果您已经完成安装，则可以在10分钟内完成该项目。

### Raspberry Pi Vehicle

在分两部分的教程的第一部分中，该自动驾驶汽车项目来自 Windows IoT YouTube 频道。甚至可以使用视频游戏控制器来控制这款酷炫的汽车。

### 闭环滚轮控制

此闭环滚轮控制也来自 Windows IoT YouTube 频道。闭环系统是那些监视诸如电动机之类的事物的状态的系统，并且可以对诸如打滑或失去牵引力之类的变化做出反应。

尽管此演示系统没有实际目的，但在构建某些东西时它的用途非常完美就像遥控车一样。

### 自定义 Visual Studio 应用程序

YouTuber 的 Pi 教程困企鹅向您展示了如何使用 Microsoft Visual Studio 创建自己的 Windows 10 IoT 应用程序。它涵盖了您入门所需的一切，包括部署到 Pi。

### LCD1602 输出

由张跃新开发，有可能在 30 分钟内完成此项目。简洁明了的说明向您展示如何使用 Raspberry Pi、Visual Studio、Windows 10 IoT 核心版和 16×2 LCD 面板连接和编程 LCD 显示器。

您将需要一块面包板这个项目，所以请确保您读懂什么是面包板！

### 互联网控制的灯光

这个由 Microsoft 创造者 Edi Wang 创建的高级项目使用 Microsoft Azure 云服务来控制 Internet 上的 LED。一旦掌握了基础知识，就可以分支到控制更复杂的硬件。

尽管该项目大约需要五个小时才能完成，但是出色的书面说明涵盖了您需要了解的所有内容。

### PiTFT 触摸屏

团队 Windows IoT 产生了此项目，您可以在一个小时内复制它。它使用 Adafruit PiTFT 触摸屏，涵盖了您需要了解的所有内容，包括所需 Windows 驱动程序的配置。

### Raspberry Pi FEZ 帽子

FEZ 帽子包含许多传感器，LED 和按钮，并提供了一种无需焊接即可将设备连接到 Pi 的简便方法。Stepan Bechynsky 的教程展示了如何使用 Windows 10 IoT 和 Azure 云计算平台链接 Pi 和 FEZ 帽子。

### Raspberry Pi Breathalyzer

此创意很酷的项目，由开发团队 Windows 设备的 IoT 设备使用 MQ2 酒精传感器。

它还使用了一个可选的 TFT 显示屏，并以清晰易读的步骤详细说明了所需的每个步骤。尽管这是一个新颖的项目，但它解释了如何计算血液酒精含量读数，这是酒精中毒的常见法律指标。

该项目再次使用 Azure 云平台存储数据以进行检查。

### 心率追踪器

该项目由 Mohamed Emam 开发，使用廉价的心率脉搏传感器测量您的心率，耗时一个小时。它使用模数转换器将模拟传感器的读数转换为数字信号。

您可以使用以前的一些项目将您的心脏数据记录到云服务中-研究长期趋势。





## 参考

- [全達國際股份有限公司 - Win10 IoT (chander.com.tw)](https://www.chander.com.tw/win10iot.html)
- [10 Cool Raspberry Pi + Windows 10 IoT Core Projects (makeuseof.com)](https://www.makeuseof.com/tag/raspberry-pi-windows-10-iot-core-projects/)
- [10个树莓派+ Windows 10 IoT核心项目的介绍-电子发烧友网 (elecfans.com)](http://m.elecfans.com/article/1123063.html)

