---
sidebar_position: 6
sidebar_label: 按键输入实验
---

# 潘多拉 RT-Thread 按键输入



## 实验概述

本实验主要功能是运行 RT-Thread 操作系统，板载的按键 KEY0 控制 RGB-LED 中的红色 LED 的亮灭。



## 硬件连接

潘多拉 IoT Board 板载的按键部分电路如下图所示，其中 KEY0 引脚连接单片机 PD10 引脚，且外部接 10k 上拉电阻。这意味着，KEY0 按键按下为低电平，松开为高电平。

![](https://static.getiot.tech/pandora-board-schematic-key.png#center)

另外，查看[原理图](https://static.getiot.tech/Pandora_STM32L4_Board_V2.4_SCH.pdf)，可知 RGB-LED 中的红色 LED 的引脚连接到 STM32 的 38 号引脚，即 PE7。



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

/* defined the LED and KEY pin */
#define PIN_LED_R    GET_PIN(E, 7)
#define PIN_KEY0     GET_PIN(D, 10)

int main(void)
{
    unsigned int count = 1;

    /* 设置 RGB 红灯引脚的模式为输出模式 */
    rt_pin_mode(PIN_LED_R, PIN_MODE_OUTPUT);
    /* 设置 KEY0 引脚的模式为输入模式 */
    rt_pin_mode(PIN_KEY0, PIN_MODE_INPUT);

    while (count > 0)
    {
        /* 读取按键 KEY0 的引脚状态 */
        if (rt_pin_read(PIN_KEY0) == PIN_LOW)
        {
            rt_thread_mdelay(50);
            if (rt_pin_read(PIN_KEY0) == PIN_LOW)
            {
                /* 按键已被按下，输出 log，点亮 LED 灯 */
                LOG_D("KEY0 pressed!");
                rt_pin_write(PIN_LED_R, PIN_LOW);
            }
        }
        else
        {
            /* 按键没被按下，熄灭 LED 灯 */
            rt_pin_write(PIN_LED_R, PIN_HIGH);
        }
        rt_thread_mdelay(10);
        count++;
    }
    return 0;
}
```

完整代码：[03_basic_key](https://github.com/RT-Thread/IoT_Board/tree/master/examples/03_basic_key)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  60724	    644	   1968	  63336	   f768	rtthread-stm32l4xx.elf
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
 / | \     4.1.0 build Jan  4 2022 03:24:05
 2006 - 2021 Copyright by rt-thread team
msh >[D/main] KEY0 pressed!
[D/main] KEY0 pressed!
[D/main] KEY0 pressed!
```

现在，当你按下 KEY0 按键，红色 LED 将会点亮。



## 思考总结

在 main 函数中，我们需要先将 PD10 引脚（按键）配置为输入模式，PE7 引脚（LED）配置为输出模式。

`rt_pin_mode`、`rt_pin_read` 和 `rt_pin_write` 都是 RT-Thread 中 PIN 设备管理接口，通过这些接口函数，应用程序可以非常方便地控制 GPIO。

由于机械按键存在抖动的问题，因此本示例增加了 50ms 的消抖处理，如果成功判断 KEY0 为低电平状态（即按键按下）则打印输出 “KEY0 pressed!” 并且指示灯亮，否则指示灯熄灭。

潘多拉 IoT Board 提供了 4 个用户按键，我们可以修改按键引脚，引脚定义如下。要注意的是，WK_UP 按键连接 10k 下拉电阻，高电平为按键按下状态（详情请参照实际的[原理图](https://static.getiot.tech/Pandora_STM32L4_Board_V2.4_SCH.pdf)）。

```c showLineNumbers
#define PIN_KEY2 GET_PIN(D, 8)   // PD8 : KEY2 --> KEY
#define PIN_KEY1 GET_PIN(D, 9)   // PD9 : KEY1 --> KEY
#define PIN_KEY0 GET_PIN(D, 10)  // PD10: KEY0 --> KEY
#define PIN_WK_UP GET_PIN(C, 13) // PC13: WK_UP --> KEY
```

在这个例子中，我们通过轮询的方式检测 KEY0 按键状态，这是检测 GPIO 电平状态最直接的一种方式，但效率不高。因此我们将会在后续的实验尝试另一种方式 —— 外部中断。
