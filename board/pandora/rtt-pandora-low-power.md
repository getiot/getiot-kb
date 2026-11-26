---
sidebar_position: 14
sidebar_label: 低功耗实验
---

# 潘多拉 RT-Thread 低功耗



## 实验概述

随着物联网（IoT）的兴起，产品对功耗的需求越来越强烈。作为数据采集的传感器节点通常需要在电池供电时长期工作，而作为联网的 SOC 也需要有快速的响应功能和较低的功耗。

因此，本实验将**使用 WK_UP 按键唤醒处于休眠状态的 MCU**，让开发者了解嵌入式设备低功耗涉及的思路和做法。



### 电源管理框架

在产品开发的起始阶段，首先考虑是尽快完成产品的功能开发。在产品功能逐步完善之后，就需要加入电源管理功能。为了适应 IoT 的这种需求，RT-Thread 提供了电源管理框架。电源管理框架的理念是尽量透明，使得产品加入低功耗功能更加轻松。

PM 组件有以下特点：

- PM 组件是基于模式来管理功耗
- PM 组件可以根据模式自动更新设备的频率配置，确保在不同的运行模式都可以正常工作
- PM 组件可以根据模式自动管理设备的挂起和恢复，确保在不同的休眠模式下可以正确的挂起和恢复
- PM 组件支持可选的休眠时间补偿，让依赖 OS Tick 的应用可以透明使用
- PM 组件向上层提供设备接口，如果使用了设备文件系统组件，那么也可以用文件系统接口来访问

本例程演示 RT-Thread 的电源管理组件 (Power Management，以下简称 PM 组件) 的使用。基于 PM 组件，用户可以很轻松地完成低功耗的开发。



## 硬件连接

潘多拉 IoT Board 的 WK_UP 按键被连接到单片机的 7 引脚（PC13），该引脚同时也是作为单片机在休眠模式下的 WAKEUP_PIN2 引脚。

![](https://static.getiot.tech/pandora-board-schematic-wakeup.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

我们的目标是使用 WK_UP 按键来唤醒处于休眠模式的 MCU。一般情况下，在 MCU 处于比较深度的休眠模式，只能通过特定的方式唤醒。MCU 被唤醒之后，会触发相应的中断。以下程序使用 WK_UP 按键从 Timer MODE 唤醒 MCU，并点亮 LED 之 2 秒后，再次进入休眠状态。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <drv_wakeup.h>
#include <board.h>
#include <stm32l4xx.h>

#define WAKEUP_APP_THREAD_STACK_SIZE        1024
#define WAKEUP_APP__THREAD_PRIORITY         RT_THREAD_PRIORITY_MAX / 3
#define WAKEUP_EVENT_BUTTON                 (1 << 0)

static rt_event_t wakeup_event;

static void _pin_as_analog(void)
{
    GPIO_InitTypeDef GPIOInitstruct = {0};

    GPIOInitstruct.Pin    = GPIO_PIN_7;
    GPIOInitstruct.Mode   = GPIO_MODE_ANALOG;
    GPIOInitstruct.Pull   = GPIO_NOPULL;
    GPIOInitstruct.Speed  = GPIO_SPEED_FREQ_HIGH;

    HAL_GPIO_Init(GPIOE, &GPIOInitstruct);
}

static void led_app(void)
{
    rt_pm_request(PM_SLEEP_MODE_NONE);

    rt_pin_mode(PIN_LED_R, PIN_MODE_OUTPUT);
    rt_pin_write(PIN_LED_R, 0);
    rt_thread_mdelay(2000);
    rt_pin_write(PIN_LED_R, 1);
    _pin_as_analog();

    rt_pm_release(PM_SLEEP_MODE_NONE);
}

static void wakeup_callback(void)
{
    rt_event_send(wakeup_event, WAKEUP_EVENT_BUTTON);
}

static void wakeup_init(void)
{
    /* 唤醒事件的初始化 */
    wakeup_event = rt_event_create("wakup", RT_IPC_FLAG_FIFO);
    RT_ASSERT(wakeup_event != RT_NULL);

    /* 唤醒按键中断回调函数的初始化 */
    bsp_register_wakeup(wakeup_callback);
}

static void pm_mode_init(void)
{
    rt_pm_request(PM_SLEEP_MODE_DEEP);
}

int main(void)
{
    /* 唤醒回调函数初始化 */
    wakeup_init();

    /* 电源管理初始化 */
    pm_mode_init();

    while (1)
    {
        /* 等待唤醒事件 */
        if (rt_event_recv(wakeup_event, WAKEUP_EVENT_BUTTON,
                          RT_EVENT_FLAG_AND | RT_EVENT_FLAG_CLEAR,
                          RT_WAITING_FOREVER, RT_NULL) == RT_EOK)
        {
            led_app();
        }
    }
}
```

完整代码：[12_component_pm](https://github.com/RT-Thread/IoT_Board/tree/master/examples/12_component_pm)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
  69108	    688	   3552	  73348	  11e84	rtthread-stm32l4xx.elf
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
msh >
```

现在，我们按一下 WK_UP 键，可以看到板载的红色 LED 被点亮 2 秒，然后熄灭并进入休眠状态。



## 思考总结

在本实验中，main() 函数首先初始化唤醒事件、配置 PM 模式，然后在循环里等待中断里发来的唤醒事件，如果接收到一次唤醒事件，就执行一次 led_app() 。

STM32L4 系列的微控制器可实现多种不同的功耗模式，其中 7 种是低功耗的，包括低功耗运行、低功耗睡眠、Stop1、Stop2、待机、关机等。

![STM32L4 低功耗模式可能的转换](https://static.getiot.tech/pandora-stm32l4-power-mode.png#center)

`PM_SLEEP_MODE_DEEP` 是 STM32L475 的 Stop2 模式，并在进入之前打开了 LPTIM1。在该实验中，我们希望停留在 `PM_SLEEP_MODE_DEEP` 模式，所以在初始化中调用一次 `rt_pm_request()` 来请求该模式。

```c showLineNumbers
static void pm_mode_init(void)
{
    rt_pm_request(PM_SLEEP_MODE_DEEP);
}
```

led_app() 是运行函数，我们通过点亮 LED 灯来模拟，并延时足够的时间以便我们观察到现象。在延时的时候，CPU 可能处于空闲状态，如果没有任何运行模式被请求，将会进入休眠。

```c showLineNumbers
static void led_app(void)
{
    rt_pm_request(PM_SLEEP_MODE_NONE);

    rt_pin_mode(PIN_LED_R, PIN_MODE_OUTPUT);
    rt_pin_write(PIN_LED_R, 0);
    rt_thread_mdelay(2000);
    rt_pin_write(PIN_LED_R, 1);
    _pin_as_analog();

    rt_pm_release(PM_SLEEP_MODE_NONE);
}
```

在函数开头请求了 `PM_SLEEP_MODE_NONE` 模式，即该模式下 CPU 不进行休眠，并在完成 LED 闪烁完成之后释放它，这样就可以让确保请求和释放中间的代码运行在 `PM_SLEEP_MODE_NONE` 模式。而 `_pin_as_analog()` 函数是把 LED 对应的引脚设置为模拟 IO，这样可以使得 IO 的功耗达到最低。

