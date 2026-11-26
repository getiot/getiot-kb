---
sidebar_position: 5
sidebar_label: 驱动三色 LED
---

# 潘多拉 RT-Thread 三色 LED



## 实验概述

本实验主要功能是运行 RT-Thread 操作系统，驱动板载 RGB 三色 LED 灯，使其周期性地变换颜色。



## 硬件连接

潘多拉 IoT Board 板载的 RGB-LED 电路如下图所示。可以看到，RGB-LED 属于共阳 LED，阴极分别与单片机的引脚连接。也就是说，当单片机引脚输出为低电平时点亮 LED，高电平时熄灭 LED。

![](https://static.getiot.tech/pandora-board-schematic-led.png#center)

查看[原理图](https://static.getiot.tech/Pandora_STM32L4_Board_V2.4_SCH.pdf)，可知 **LED_R** 引脚连接 STM32 的 38 号引脚，即 PE7；**LED_G** 引脚连接 STM32 的 39 号引脚，即 PE8；**LED_B** 引脚连接 STM32 的 40 号引脚，即 PE9。



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

/* defined the LED pin */
#define PIN_LED_R    GET_PIN(E, 7)
#define PIN_LED_G    GET_PIN(E, 8)
#define PIN_LED_B    GET_PIN(E, 9)


/* 定义 LED 亮灭电平 */
#define LED_ON  (0)
#define LED_OFF (1)

/* 定义 8 组 LED 闪灯表，其顺序为 R G B */
static const rt_uint8_t _blink_tab[][3] =
{
    {LED_ON, LED_ON, LED_ON},
    {LED_OFF, LED_ON, LED_ON},
    {LED_ON, LED_OFF, LED_ON},
    {LED_ON, LED_ON, LED_OFF},
    {LED_OFF, LED_OFF, LED_ON},
    {LED_ON, LED_OFF, LED_OFF},
    {LED_OFF, LED_ON, LED_OFF},
    {LED_OFF, LED_OFF, LED_OFF},
};

int main(void)
{
    unsigned int count = 1;
    unsigned int group_num = sizeof(_blink_tab)/sizeof(_blink_tab[0]);
    unsigned int group_current;

    /* 设置 RGB 灯引脚为输出模式 */
    rt_pin_mode(PIN_LED_R, PIN_MODE_OUTPUT);
    rt_pin_mode(PIN_LED_G, PIN_MODE_OUTPUT);
    rt_pin_mode(PIN_LED_B, PIN_MODE_OUTPUT);

    while (count > 0)
    {
        /* 获得组编号 */
        group_current = count % group_num;

        /* 控制 RGB 灯 */
        rt_pin_write(PIN_LED_R, _blink_tab[group_current][0]);
        rt_pin_write(PIN_LED_G, _blink_tab[group_current][1]);
        rt_pin_write(PIN_LED_B, _blink_tab[group_current][2]);

        /* 输出 LOG 信息 */
        LOG_D("group: %d | red led [%-3.3s] | green led [%-3.3s] | blue led [%-3.3s]",
            group_current,
            _blink_tab[group_current][0] == LED_ON ? "ON" : "OFF",
            _blink_tab[group_current][1] == LED_ON ? "ON" : "OFF",
            _blink_tab[group_current][2] == LED_ON ? "ON" : "OFF");

        /* 延时一段时间 */
        rt_thread_mdelay(500);
        count++;
    }
    return 0;
}
```

完整代码：[02_basic_rgb_led](https://github.com/RT-Thread/IoT_Board/tree/master/examples/02_basic_rgb_led)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  60960	    644	   1968	  63572	   f854	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32

```bash
st-flash write rt-thread.bin 0x8000000
```

打开串口终端，输出如下内容

```basic
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  4 2022
 2006 - 2019 Copyright by rt-thread team
[D/main] group: 1 | red led [OFF] | green led [ON ] | blue led [ON ]
msh >[D/main] group: 2 | red led [ON ] | green led [OFF] | blue led [ON ]
[D/main] group: 3 | red led [ON ] | green led [ON ] | blue led [OFF]
[D/main] group: 4 | red led [OFF] | green led [OFF] | blue led [ON ]
[D/main] group: 5 | red led [ON ] | green led [OFF] | blue led [OFF]
[D/main] group: 6 | red led [OFF] | green led [ON ] | blue led [OFF]
[D/main] group: 7 | red led [OFF] | green led [OFF] | blue led [OFF]
[D/main] group: 0 | red led [ON ] | green led [ON ] | blue led [ON ]
```

现在，你应该可以看到 RGB-LED 灯正在循环变换颜色。



## 思考总结

在 main 函数中，我们需要先将 PE7、PE8、PE9 引脚配置为输出模式，再分别控制组合成不同颜色。

`rt_pin_mode` 和 `rt_pin_write` 都是 RT-Thread 中 PIN 设备管理接口，通过这些接口函数，应用程序可以非常方便地访问 GPIO。

RT-Thread 提供的引脚编号需要和芯片的引脚号区分开来，它们并不是同一个概念，引脚编号由 PIN 设备驱动程序定义，和具体的芯片相关。通常有 3 种方式可以获取引脚编号，分别是 API 接口获取、使用宏定义、查看 PIN 驱动文件。这里使用宏定义获取引脚编号：

```c showLineNumbers
#define PIN_LED_R    GET_PIN(E, 7)
#define PIN_LED_G    GET_PIN(E, 8)
#define PIN_LED_B    GET_PIN(E, 9)
```
