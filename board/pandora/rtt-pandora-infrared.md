---
sidebar_position: 8
sidebar_label: 红外遥控实验
---

# 潘多拉 RT-Thread 红外遥控

![潘多拉 IoT Board RT-Thread 红外遥控](https://static.getiot.tech/pandora-board-infrared.jpeg#center)

## 实验概述

本实验的主要功能是通过潘多拉 IoT Board 板载的红外接收头接收红外遥控器信号，以及通过板载的红外发射头发送红外信号。

提示：请使用 38kHz 载波的红外遥控器进行实验。



## 硬件连接

潘多拉 IoT Board 板载一个红外发射头（IR1）和一个红外接收头（IR2），其中红外发射脚 EMISSION 接单片机引脚 PB0，红外接收头引脚 RECEPTION 接单片机引脚 PB1（TIM3_CH4 通道）。

![](https://static.getiot.tech/pandora-board-schematic-ir.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

程序主要流程：选择 NEC 解码器（依赖 infrared 软件包），初始化 GPIO 引脚。然后在 while 循环中扫描按键、打印输出接收到的红外数据，当 KEY0 按下后将会把最近一次接收到的红外数据通过红外发射头发送出去。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include "infrared.h"

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

rt_int16_t key_scan(void)
{
    if (rt_pin_read(PIN_KEY0) == PIN_LOW)
    {
        rt_thread_mdelay(50);
        if (rt_pin_read(PIN_KEY0) == PIN_LOW)
        {
            return PIN_KEY0;
        }
    }
    return -RT_ERROR;
}

int main(void)
{
    unsigned int count = 1;
    rt_int16_t key;
    struct infrared_decoder_data infrared_data;

    /* 选择 NEC 解码器 */
    ir_select_decoder("nec");

    /* 设置按键引脚为输入模式 */
    rt_pin_mode(PIN_KEY0, PIN_MODE_INPUT);

    /* 设置 RGB 引脚为输出模式*/
    rt_pin_mode(PIN_LED_R, PIN_MODE_OUTPUT);
    rt_pin_mode(PIN_LED_B, PIN_MODE_OUTPUT);

    rt_pin_write(PIN_LED_R, PIN_HIGH);
    rt_pin_write(PIN_LED_B, PIN_HIGH);

    while (count > 0)
    {
        /* 按键扫描 */
        key = key_scan();
        if(key == PIN_KEY0)
        {
            /* 有按键按下，蓝灯亮起 */
            rt_pin_write(PIN_LED_B, PIN_LOW);
            infrared_data.data.nec.repeat = 0;
            /* 发送红外数据 */
            infrared_write("nec",&infrared_data);
            rt_thread_mdelay(200);
            LOG_I("SEND    OK: addr:0x%02X key:0x%02X repeat:%d",
                infrared_data.data.nec.addr, infrared_data.data.nec.key, infrared_data.data.nec.repeat);
        }
        else if(infrared_read("nec",&infrared_data) == RT_EOK)  
        {
            /* 读取到红外数据，红灯亮起 */
            rt_pin_write(PIN_LED_R, PIN_LOW);
            LOG_I("RECEIVE OK: addr:0x%02X key:0x%02X repeat:%d",
                infrared_data.data.nec.addr, infrared_data.data.nec.key, infrared_data.data.nec.repeat);
        }
        rt_thread_mdelay(10);

        /* 熄灭蓝灯 */
        rt_pin_write(PIN_LED_B, PIN_HIGH);
        /* 熄灭红灯 */
        rt_pin_write(PIN_LED_R, PIN_HIGH);
        count++;
    }
    return 0;
}
```

完整代码：[05_basic_ir](https://github.com/RT-Thread/IoT_Board/tree/master/examples/05_basic_ir)



## 编译运行

本实验依赖 [**infrared**](https://github.com/RT-Thread-packages/infrared_framework) 红外框架软件包，所以在编译之前需要确保已添加该软件包，menuconfig 配置路径如下：

```bash
RT-Thread online packages  --->
  peripheral libraries and drivers  ---> 
  [*] infrared : infrared is base on rt-thread pin,hwtimer and pwm.  ---> 
```

infrared 软件包具体配置如下：

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-infrared.png#center)

保存配置，执行下面命令下载软件包

```bash
pkgs --update
```

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  79012	   1124	   6124	  86260	  150f4	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32

```bash
st-flash write rt-thread.bin 0x8000000
```

打开串口终端，按下红外遥控器的任意按键，输出如下内容

```bash
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  4 2022
 2006 - 2019 Copyright by rt-thread team
msh >[I/main] RECEIVE OK: addr:0x00 key:0xA2 repeat:0
[I/main] RECEIVE OK: addr:0x00 key:0x68 repeat:0
[I/main] RECEIVE OK: addr:0x00 key:0x98 repeat:0
[I/main] RECEIVE OK: addr:0x00 key:0xB0 repeat:0
...
[I/main] RECEIVE OK: addr:0x00 key:0x38 repeat:0
[I/main] RECEIVE OK: addr:0x00 key:0x5A repeat:0
[I/main] RECEIVE OK: addr:0x00 key:0x42 repeat:0
[I/main] SEND    OK: addr:0x00 key:0x42 repeat:0
[I/main] RECEIVE OK: addr:0x00 key:0x42 repeat:0
```

按下 KEY0 按键将最近一次接收到的红外数据通过红外发射头发送出去，同时红外接收头立即收到该信号。



## 思考总结

本实验融合了按键、LED 和红外发送、接收器等多个部件，其中红外的功能由 infrared 红外框架软件包提供。可以看到，使用 RT-Thread 的软件包真的非常的方便，大大加快了我们的开发速度。
