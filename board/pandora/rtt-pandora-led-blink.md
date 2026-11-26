---
sidebar_position: 4
sidebar_label: LED 闪烁实验
---

# 潘多拉 RT-Thread LED 闪烁

![](https://static.getiot.tech/pandora-board-led-blink.jpeg#center)

## 实验概述

本实验作为潘多拉 IoT Board 的第一个实验，也是最简单的 Hello World 实验 —— 点亮 LED。具体功能是运行 RT-Thread 操作系统，驱动板载 RGB-LED 中的红色 LED 灯，使其以 1Hz 的频率闪烁。



## 硬件连接

潘多拉 IoT Board 板载的 RGB-LED 电路如下图所示。可以看到，RGB-LED 属于共阳 LED，阴极分别与单片机的引脚连接。也就是说，当单片机引脚输出为低电平时点亮 LED，高电平时熄灭 LED。

![](https://static.getiot.tech/pandora-board-schematic-led.png#center)

查看[原理图](https://static.getiot.tech/Pandora_STM32L4_Board_V2.4_SCH.pdf)，可知 **LED_R** 引脚连接 STM32 的 38 号引脚，即 PE7。



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>

/* defined the LED0 pin: PE7 */
#define LED0_PIN    GET_PIN(E, 7)

int main(void)
{
    /* set LED0 pin mode to output */
    rt_pin_mode(LED0_PIN, PIN_MODE_OUTPUT);

    while (1)
    {
        rt_pin_write(LED0_PIN, PIN_HIGH);
        rt_thread_mdelay(500);
        rt_pin_write(LED0_PIN, PIN_LOW);
        rt_thread_mdelay(500);
    }
}
```

完整代码：[01_basic_led_blink](https://github.com/RT-Thread/IoT_Board/tree/master/examples/01_basic_led_blink)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  60728	    644	   1968	  63340	   f76c	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32

```bash
st-flash write rt-thread.bin 0x8000000
```

打开串口终端，输出如下内容

```bash
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  4 2022
 2006 - 2019 Copyright by rt-thread team
[D/main] led on, count: 1
msh >[D/main] led off
[D/main] led on, count: 2
[D/main] led off
[D/main] led on, count: 3
[D/main] led off
[D/main] led on, count: 4 
...
```

此时 RGB-LED 中的红色 LED 灯正在以 1Hz 的频率闪烁。



## 思考总结

在 main 函数中，我们需要先将 PE7 引脚配置为输出模式，再周期性地拉高或拉低该引脚电平。

`rt_pin_mode` 和 `rt_pin_write` 都是 RT-Thread 中 PIN 设备管理接口，通过这些接口函数，应用程序可以非常方便地访问 GPIO。

RT-Thread 提供的引脚编号需要和芯片的引脚号区分开来，它们并不是同一个概念，引脚编号由 PIN 设备驱动程序定义，和具体的芯片相关。通常有 3 种方式可以获取引脚编号，分别是 API 接口获取、使用宏定义、查看 PIN 驱动文件。这里使用宏定义获取 PE7 的引脚编号：

```c showLineNumbers
#define LED0_PIN    GET_PIN(E, 7)
```

