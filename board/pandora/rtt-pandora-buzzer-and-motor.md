---
sidebar_position: 7
sidebar_label: 蜂鸣器和电机控制
---

# 潘多拉 RT-Thread 蜂鸣器和电机控制



## 实验概述

本实验的主要功能是使用按键控制蜂鸣器和电机，当按下 KEY0 后电机左转，当按下 KEY1 后电机右转，当按下 KEY2 后电机停止，当按住 WK_UP 时蜂鸣器鸣叫，松开 WK_UP 后蜂鸣器关闭。其中 KEY0、KEY1、KEY2 三个按键会触发中断，通过 pin 设备的中断回调函数控制电机，WK_UP 按键通过轮询的方式控制蜂鸣器鸣叫。



## 硬件连接

潘多拉 IoT Board 板载的 Motor 电路如下图所示， MOTOR_A（PA1）和 MOTOR_B（PA0）分别连接电机驱动芯片 L9110S 的控制引脚。

![](https://static.getiot.tech/pandora-board-schematic-motor.png#center)

电机的控制逻辑如下表格所示。

|  IA  |  IB  |    OA     |    OB     | 电机动作 |
| :--: | :--: | :-------: | :-------: | :------: |
|  H   |  L   |     H     |     L     |   右转   |
|  L   |  H   |     L     |     H     |   左转   |
|  L   |  L   | L（刹车） | L（刹车） |   停止   |
|  H   |  H   | Z（高阻） | Z（高阻） |   停止   |

蜂鸣器的引脚 BEEP 连接到单片机的 PB2 引脚。另外，我们还会用到 4 个用户按键（参考 [潘多拉 RT-Thread 按键输入](/pandora/rtt-pandora-buttons/)）。

![](https://static.getiot.tech/pandora-board-schematic-beep.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

// MOTOR, BEEP and KEY
#define PIN_MOTOR_A     GET_PIN(A, 1)      // PA1 :  MOTOR_A      --> MOTOR
#define PIN_MOTOR_B     GET_PIN(A, 0)      // PA0 :  MOTOR_B      --> MOTOR
#define PIN_BEEP        GET_PIN(B, 2)      // PB2 :  BEEP         --> BEEP
#define PIN_KEY2        GET_PIN(D, 8)      // PD8 :  KEY2         --> KEY
#define PIN_KEY1        GET_PIN(D, 9)      // PD9 :  KEY1         --> KEY
#define PIN_KEY0        GET_PIN(D, 10)     // PD10:  KEY0         --> KEY
#define PIN_WK_UP       GET_PIN(C, 13)     // PC13:  WK_UP        --> KEY

enum
{
    MOTOR_STOP,
    MOTOR_LEFT,
    MOTOR_RIGHT
};

/* 电机控制 */
void motor_ctrl(rt_uint8_t turn)
{
    if (turn == MOTOR_STOP)
    {
        rt_pin_write(PIN_MOTOR_A, PIN_LOW);
        rt_pin_write(PIN_MOTOR_B, PIN_LOW);
    }
    else if (turn == MOTOR_LEFT)
    {
        rt_pin_write(PIN_MOTOR_A, PIN_LOW);
        rt_pin_write(PIN_MOTOR_B, PIN_HIGH);
    }
    else if (turn == MOTOR_RIGHT)
    {
        rt_pin_write(PIN_MOTOR_A, PIN_HIGH);
        rt_pin_write(PIN_MOTOR_B, PIN_LOW);
    }
    else
    {
        LOG_D("err parameter ! Please enter 0-2.");
    }
}

void beep_ctrl(rt_uint8_t on)
{
    if (on)
    {
        rt_pin_write(PIN_BEEP, PIN_HIGH);
    }
    else
    {
        rt_pin_write(PIN_BEEP, PIN_LOW);
    }
}

/* 中断回调 */
void irq_callback(void *args)
{
    rt_uint32_t sign = (rt_uint32_t)args;
    switch (sign)
    {
    case PIN_KEY0:
        motor_ctrl(MOTOR_LEFT);
        LOG_D("KEY0 interrupt. motor turn left.");
        break;
    case PIN_KEY1:
        motor_ctrl(MOTOR_RIGHT);
        LOG_D("KEY1 interrupt. motor turn right.");
        break;
    case PIN_KEY2:
        motor_ctrl(MOTOR_STOP);
        LOG_D("KEY2 interrupt. motor stop.");
        break;
    default:
        LOG_E("error sign= %d !", sign);
        break;
    }
}

int main(void)
{
    unsigned int count = 1;

    /* 设置按键引脚为输入模式 */
    rt_pin_mode(PIN_KEY0, PIN_MODE_INPUT_PULLUP);
    rt_pin_mode(PIN_KEY1, PIN_MODE_INPUT_PULLUP);
    rt_pin_mode(PIN_KEY2, PIN_MODE_INPUT_PULLUP);
    rt_pin_mode(PIN_WK_UP, PIN_MODE_INPUT_PULLDOWN);

    /* 设置电机控制引脚为输入模式 */
    rt_pin_mode(PIN_MOTOR_A, PIN_MODE_OUTPUT);
    rt_pin_mode(PIN_MOTOR_B, PIN_MODE_OUTPUT);

    /* 设置蜂鸣器引脚为输出模式 */
    rt_pin_mode(PIN_BEEP, PIN_MODE_OUTPUT);

    /* 设置按键中断模式与中断回调函数 */
    rt_pin_attach_irq(PIN_KEY0, PIN_IRQ_MODE_FALLING, irq_callback, (void *)PIN_KEY0);
    rt_pin_attach_irq(PIN_KEY1, PIN_IRQ_MODE_FALLING, irq_callback, (void *)PIN_KEY1);
    rt_pin_attach_irq(PIN_KEY2, PIN_IRQ_MODE_FALLING, irq_callback, (void *)PIN_KEY2);

    /* 使能中断 */
    rt_pin_irq_enable(PIN_KEY0, PIN_IRQ_ENABLE);
    rt_pin_irq_enable(PIN_KEY1, PIN_IRQ_ENABLE);
    rt_pin_irq_enable(PIN_KEY2, PIN_IRQ_ENABLE);

    while (count > 0)
    {
        if (rt_pin_read(PIN_WK_UP) == PIN_HIGH)
        {
            rt_thread_mdelay(50);
            if (rt_pin_read(PIN_WK_UP) == PIN_HIGH)
            {
                LOG_D("WK_UP pressed. beep on.");
                beep_ctrl(1);
            }
        }
        else
        {
            beep_ctrl(0);
        }
        rt_thread_mdelay(10);
        count++;
    }
    return 0;
}
```

完整代码：[04_basic_beep_motor](https://github.com/RT-Thread/IoT_Board/tree/master/examples/04_basic_beep_motor)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  61540	    644	   1968	  64152	   fa98	rtthread-stm32l4xx.elf
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
 / | \     4.1.0 build Jan  4 2022 22:30:24
 2006 - 2021 Copyright by rt-thread team
msh >[D/main] WK_UP pressed. beep on.
[D/main] WK_UP pressed. beep on.
[D/main] WK_UP pressed. beep on.
[D/main] KEY0 interrupt. motor turn left.
[D/main] KEY0 interrupt. motor turn left.
[D/main] KEY1 interrupt. motor turn right.
[D/main] KEY1 interrupt. motor turn right.
[D/main] KEY2 interrupt. motor stop.
```

现在，按住 WK_UP 按键后蜂鸣器开始鸣叫，松开 WK_UP 按键后蜂鸣器关闭。按下 KEY0 后电机左转，按下 KEY1 后电机右转，按下 KEY2 后电机停止。



## 思考总结

本次实验我们使用按键分别控制潘多拉 IoT Board 上的蜂鸣器和电机工作，无论是蜂鸣器还是电机，都可以通过数字 I/O 驱动。如果配合 PWM 控制，还可以调节蜂鸣器的音调和电机转速，这个知识点我们后续再介绍。

另外，本次实验使用了 `rt_pin_attach_irq` 函数分别设置 KEY0、KEY1、KEY2 按键中断为下降沿触发中断，并且绑定回调函数、设置回调函数相应的入参，使用 `rt_pin_irq_enable` 函数使能按键中断。

```c showLineNumbers
rt_pin_attach_irq(PIN_KEY0, PIN_IRQ_MODE_FALLING, irq_callback, (void *)PIN_KEY0);
rt_pin_irq_enable(PIN_KEY0, PIN_IRQ_ENABLE);
```

而 WK_UP 按键，我们通过在 while 循环里轮询的方式来检测 WK_UP 的按键状态，当成功判断 WK_UP 按键按下时控制蜂鸣器鸣叫，松开时关闭蜂鸣器。

中断和轮询是两种非常常见的编程模式，合理地使用中断处理可以增强系统的响应速度，同时可以简化程序设计。

