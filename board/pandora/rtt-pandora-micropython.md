---
sidebar_position: 33
sidebar_label: MicroPython 编程
---

# 潘多拉 RT-Thread MicroPython 使用



## 实验概述

本实验将在 RT-Thread 上使用 MicroPython，通过命令行展示 MicroPython 代码的输入与运行，并通过一个示例演示如何使用 MicroPython 控制硬件。

MicroPython 是 Python 3 编程语言的一种精简而高效的实现，它包含 Python 标准库的一个子集，并被优化为在微控制器和受限环境中运行。它具有交互式提示、任意精度整数、闭包函数、列表解析、生成器、异常处理等高级特性，具有很强的可移植性。它能够帮助开发者快速控制各种硬件外设，不用再去研究底层硬件模块的使用方法，翻看寄存器手册。降低了开发难度，而且减少了重复开发工作，可以加快开发速度，提高开发效率。



## 硬件连接

本实验将使用 MicroPython 控制 IoT Board 上的各种硬件，请确保开发板上的相关硬件可以正常工作。参考《[潘多拉 IoT Board 硬件概述](/pandora/rtt-pandora-hardware-overview/)》。



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <stdio.h>
#include <rtthread.h>
#include <string.h>
#include <rthw.h>
#include <fal.h>
#include <dfs_fs.h>
#include <rtdevice.h>

#define LOG_TAG               "main"
#include <ulog.h>

#define FS_PARTITION_NAME     "filesystem"

int main(void)
{
    /* 分区表初始化 */
    fal_init();

    /* 在文件系统分区上创建块设备*/
    struct rt_device *flash_dev = fal_blk_device_create(FS_PARTITION_NAME);
    if (flash_dev == NULL)
    {
        LOG_E("Can't create a block device on '%s' partition.", FS_PARTITION_NAME);
    }

    /* 在文件系统分区上挂载文件系统 */
    if (dfs_mount(FS_PARTITION_NAME, "/", "elm", 0, 0) == 0)
    {
        LOG_I("Filesystem initialized!");
    }
    else
    {
        /* 创建文件系统 */
        dfs_mkfs("elm", FS_PARTITION_NAME);
        /* 重新挂载文件系统 */
        if (dfs_mount(FS_PARTITION_NAME, "/", "elm", 0, 0) == 0)
        {
            LOG_E("Failed to initialize filesystem! The mpy fs module is not available.");
        }
    }

    /* 配置 wifi 工作模式 */
    rt_wlan_set_mode(RT_WLAN_DEVICE_STA_NAME, RT_WLAN_STATION);
    rt_wlan_set_mode(RT_WLAN_DEVICE_AP_NAME, RT_WLAN_AP);

    extern void wlan_autoconnect_init(void);
    /* 自动连接初始化 */
    wlan_autoconnect_init();
    /* 打开自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);

    /* 等待系统初始化完毕 */
    rt_thread_mdelay(100);
    
    while(1)
    {
        /* 打开 MicroPython 命令交互界面 */
        extern void mpy_main(const char *filename);
        mpy_main(NULL);
    }
}
```

main 函数的功能是为 MicroPython 的提供必要的运行环境。主要完成以下几个任务：

- 创建 block 设备
- 挂载 FAT 文件系统
- 启动自动连接
- 打开 MicroPython 命令交互界面

完整代码：[31_micropython](https://github.com/RT-Thread/IoT_Board/tree/master/examples/31_micropython)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 464680	   3596	  46420	 514696	  7da88	rtthread-stm32l4xx.elf
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
 / | \     4.0.1 build Jan 10 2022
 2006 - 2019 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
[I/FAL] RT-Thread Flash Abstraction Layer (V0.3.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[I/FAL] The FAL block device (filesystem) created successfully
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .

MicroPython v1.10-145-ged1a88e-dirty on 2019-02-27; Universal python platform with RT-Thread
Type "help()" for more information.
>>> 
```

现在，MicroPython 命令交互界面就已经启动，可以通过命令行与 MicroPython 进行交互。下面将使用一个示例展示如何使用 MicroPython 控制硬件。



## MicroPython 基本功能

下面介绍如何使用 MicroPython 与潘多拉 IoT Board 进行交互。

### 使用 python 交互命令行

MicroPython 是 Python 3 编程语言的一种精简而高效的实现，语法和 Python 3 相同，并带有丰富的内建函数。我们可以在 RT-Thread 的交互终端直接输入 Python 代码。

例如在交互命令行输入 `print('hello GetIoT.tech!')` ，然后输入回车，将运行这行语句。运行效果如下：

```python
>>> print('hello GetIoT.tech!')
hello GetIoT.tech!
>>> 
```

### 交互命令行的粘贴模式

MicroPython 比一般的 Python 交互环境多了一个特别的粘贴模式，可以一次粘贴输入多行 Python 代码。

- 按下 `Ctrl-E` 组合键，进入粘贴模式，界面上会出现提示“paste mode; Ctrl-C to cancel, Ctrl-D to finish”。该模式下使用鼠标右键进行粘贴，可一次粘贴多行代码。
- 按下 `Ctlr-D` 组合键，退出粘贴模式。同时粘贴输入的代码也会自动执行。
- 按下 `Ctrl-C` 组合键，终止正在执行的程序。

**注意**：进入粘贴模式后，不要使用 `Ctrl-C` 粘贴代码！

使用粘贴模式执行下面代码：

```python
for i in range(1,10):
    print(i)
```

运行效果如下：

```python
paste mode; Ctrl-C to cancel, Ctrl-D to finish
=== for i in range(1,10):
===     print(i)
1
2
3
4
5
6
7
8
9
>>>
```

### MicroPython 内建模块

MicroPython 提供丰富的内建模块用来完成相关的程序功能。同时 RT-Thread 也提供了 rtthread 模块用来返回系统运行相关的信息。

例如，使用 rtthread 模块查看当前运行线程：

```python showLineNumbers
import rtthread
rtthread.stacks_analyze()
```

使用 time 模块延时 2 秒：

```python showLineNumbers
import time
time.sleep_ms(2000)
```

### MicroPython 控制硬件

下面通过一个简单的示例，演示如何使用 MicroPython 来控制开发板的硬件资源，让 LED 灯闪烁。MicroPython 代码如下：

**提示**：在潘多拉 IoT Board 上，PE7 引脚连接 LED 灯，PE7 引脚对应的引脚号为 71。

```python showLineNumbers
import utime as time
from machine import Pin

PIN_LED_R = 71

led = Pin(("led_red", PIN_LED_R), Pin.OUT_PP)

while True:
    led.value(0)
    time.sleep(0.5)
    led.value(1)
    time.sleep(0.5)
```

将以上脚本使用粘贴模式输入，即可看到 LED 灯按照指定的频率闪烁。使用 `Ctrl-C` 可以取消当前正在运行程序。



## 思考总结

RT-Thread 对 MicroPython 做了许多支持，除了上述的 LED 示例之外，还可以使用 MicroPython 控制各种各样的硬件模块，如 Pin、I2C、SPI、UART、LCD、RTC、PWM、ADC、WDT、TIMER 等，想要了解这些硬件的详细控制方式，可以查阅《MicroPython 用户手册》，里面有详细的介绍。

除了可以通过阅读用户手册来了解 MicroPython 的使用方式，还可以直接在 VScode 中搜索 **RT-Thread MicroPython** 来使用 RT-Thread 推出的 MicroPython 开发环境，在开发环境中直接运行示例程序来学习 MicroPython 开发。

另外，除了潘多拉 IoT Board，RT-Thread 的其他几款开发板也支持 MicroPython，比如麻雀一号音视频开发板。

