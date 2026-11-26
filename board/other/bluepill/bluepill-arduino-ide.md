---
sidebar_position: 2
---

# Blue Pill 使用 Arduino IDE



STM32 F103C8T6开发板——也称为“Blue Pill”，翻译过来有一个好听的名字叫蓝色药丸，它是一款基于ARM Cortex M3微控制器的开发板。 “Blue Pill” 的外观看起来很像[Arduino Nano](https://www.basemu.com/servo-control-with-joystick-and-arduino-nano.html)，但是它包含了更多的功能。

![STM32 F103C8T6](https://www.basemu.com/wp-content/uploads/2019/09/STM32-F103C8T6-800x352.jpg#center)

## STM32 “Blue Pill”

当拿到STM32 “Blue pill”时，比较引人注意的是黄色的跳线针，跳线针是用来与USART转换器一起配合工作的，具体使用见下文。

![STM32 BOOT  针](https://www.basemu.com/wp-content/uploads/2019/09/stm32-flashing-pin-800x401.png#center)

板上还有一个[微型USB接口](https://www.basemu.com/usb2-0数据线接口定义及接口封装.html)，但遗憾的是，它不能像Arduino一样可用于编程，因为它没有相关的引导加载程序。STM32的开发板非常便宜，而且硬件是完全开源的。STM32开发板上除了微控制器，还包含两个晶体振荡器用来驱动内部实时时钟，一个8MHz一个32KHz，因此，MCU可以在深度睡眠的模式下运行，使得耗电量较低。

![STM32 F103C8T6 接口定义](https://www.basemu.com/wp-content/uploads/2019/09/stm32f103c8t6_pinout-800x426.png#center)

## 对STM32进行编程

要对STM32开发板进行编程，需要使用一个USB转UART转换器 FTDI。使用USB转串口线连接开发板和电脑USB，其中串口线的TX和RX分布连接开发板PA10和PA9，然后将 BOOT0 短接3.3V，BOOT1短接GND进入烧写状态。

![STM32 DFU烧写模式](https://www.basemu.com/wp-content/uploads/2019/09/stm32-DFU-mode.png#center)

串口线的VCC和GND分布连接开发板的5V和GND即可，无需另外供电。这样就可以直接从计算机通过USB接口对它进行编程了。

![STM32开发板连接USB转UART转换器](https://www.basemu.com/wp-content/uploads/2019/09/stm32-blue-pill-usb-to-uart-800x454.png#center)

## Arduino IDE设置

打开Arduino IDE，菜单File –> Preferences,

![Arduino IDE设置](https://www.basemu.com/wp-content/uploads/2019/09/Arduino-IDE-Preferences.png#center)

接着在 Additional Board URL 位置添加URL：http://dan.drown.org/stm32duino/package_STM32duino_index.json

![Additional Board URL 添加](https://www.basemu.com/wp-content/uploads/2019/09/Additional-Board-URL-707x600.png#center)

![ Additional Board URL 添加STM32支持](https://www.basemu.com/wp-content/uploads/2019/09/Additional-Board-URL-menu-744x600.png#center)

请确认后回到Arduino IDE，进入菜单Tools –> Board –> Boards manager…

![Arduino IDE添加STM32duino支持](https://www.basemu.com/wp-content/uploads/2019/09/Arduino-IDE-Add-stm32-support.png#center)

最后连接STM32到USB，在Arduino IDE的Board中就能找到对应的硬件了。

![Arduino IDE添加STM32duino](https://www.basemu.com/wp-content/uploads/2019/09/STM32-Arduino-Board-manager-665x600.png#center)

这样STM32也就可以像普通Arduino开发板一样进行编程了。



