---
sidebar_position: 1
slug: /wio-terminal-io
---

# Wio Terminal IO 引脚



Wio-Terminal 预留了许多 IO 引脚供开发者使用，主要包括两组 IO 端口。一组是兼容 Raspberry Pi（树莓派）的 40 针 GPIO 扩展接口，另一组是 Wio-Terminal 底部的两个 Grove 接口。使用这两组 IO 扩展接口，即可轻松接入树莓派和 Grove 生态，创造更多有趣的项目。



## 兼容 RPI 引脚

下面是兼容 Raspberry Pi（树莓派）的 40 针 GPIO 接口的排列顺序和引脚功能：

![](https://static.getiot.tech/WioT-Pinout.jpg#center)

Wio Terminal 有 40 针 GPIO 从主控制器 SAMD51 引出，IO 引脚的排列顺序与 Raspberry Pi 兼容。要使用它们，只需使用上面定义的引脚名称即可。但是要注意，有些引脚是多功能复用的，因此可以通过不同的方式引用。

具体代码定义与使用方法，请参考 `variant.h` 以获取更多信息。



## Grove 端口

作为 SeeedStudio 出品的 Wio Terminal，自然少不了 Grove 端口。两个 Grove 端口的引脚分配如下图所示。

![](https://static.getiot.tech/wio-terminal-gpio-sch.jpg#center)

可以看到，Wio Terminal 上的两个 Grove 端口，一个是默认的 **I2C 端口**，另一个是**可配置的数字/模拟引脚**，也可以用于 PWM 输出。同时，两个 Grove 端口都可以用作数字 IO 使用。

