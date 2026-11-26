---
sidebar_position: 11
sidebar_label: 接近感应与光传感器
---

# 潘多拉 RT-Thread 接近感应与光传感器



## 实验概述

本实验利用 RT-Thread 的 AP3216C 软件包，读取 ap3216c 光环境传感器所测量的接近感应（ps，proximity sensor）与光照强度（als，ambient light sensor）。

AP3216C 软件包提供了使用接近感应（ps）与光照强度（als）传感器 ap3216c 基本功能，并且提供了硬件中断的可选功能，使用软件包可加快项目开发速度。

AP3216C 软件包支持如下功能：

- 光照强度：支持 4 个量程；
- 接近感应：支持 4 种增益；
- 中断触发：光照强度及接近感应同时支持“高于阈值”或“低于阈值”的两种硬件中断触发方式。



## 硬件连接

潘多拉 IoT Board 板载的 AHT10 传感器采用 I2C 接口连接到 STM32。单片机通过 IIC_SDA（PC1）、IIC_SCL1（PC0） 即可对传感器 ap3216c 发送命令、读取数据。另外，AP_INT（PC13）为硬件中断引脚。

![](https://static.getiot.tech/pandora-board-schematic-ap3216c.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

程序主要流程：首先初始化传感器 ap3216c ，传入参数 i2c3 为该传感器挂载的 i2c 总线的名称；然后将返回设备对象分别传入获取 als 与 ps 函数，获取测量的 als 与 ps 值，打印到串口。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include "ap3216c.h"

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

int main(void)
{
    ap3216c_device_t dev;
    const char *i2c_bus_name = "i2c3";
    int count = 0;

    /* 初始化 ap3216c */
    dev = ap3216c_init(i2c_bus_name);
    if (dev == RT_NULL) {
        LOG_E("The sensor initializes failure.");
        return 0;
    }

    while (count++ < 100)
    {
        rt_uint16_t ps_data;
        float brightness;

        /* 读接近感应值 */
        ps_data = ap3216c_read_ps_data(dev);
        if (ps_data == 0) {
            LOG_D("object is not proximity of sensor.");
        }
        else {
            LOG_D("current ps data   : %d.", ps_data);
        }

        /* 读光照强度值 */
        brightness = ap3216c_read_ambient_light(dev);
        LOG_D("current brightness: %d.%d(lux).", (int)brightness, ((int)(10 * brightness) % 10));

        rt_thread_mdelay(1000);
    }
    return 0;
}
```

完整代码：[08_driver_als_ps](https://github.com/RT-Thread/IoT_Board/tree/master/examples/08_driver_als_ps)



## 编译运行

打开 menuconfig 配置菜单，勾选 ap3216c 软件包，具体路径如下：

```bash
RT-Thread online packages  --->
  peripheral libraries and drivers  --->
    sensors drivers  --->
    [*]   ap3216c: a digital ambient light and a proximity sensor ap3216c driver library.
```

选择 v1.0.0 版本（不依赖 Sensor 框架）

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-sensor-ap3216c.png#center)

开启 I2C3 总线驱动（软件模拟），具体路径如下：

```bash
Hardware Drivers Config  --->
  On-chip Peripheral Drivers  --->
  [*] Enable I2C BUS  --->
```

保持默认配置就可以了

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-enable-i2c3-bus.png#center)

保存配置，执行下面命令下载软件包

```bash
pkgs --update
```

编译工程

```bash
$ scons
...
LINK rt-thread.elf
arm-none-eabi-objcopy -O binary rt-thread.elf rtthread.bin
arm-none-eabi-size rt-thread.elf
   text	   data	    bss	    dec	    hex	filename
  86416	   1880	   3588	  91884	  166ec	rt-thread.elf
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
 / | \     4.1.0 build Jan  5 2022 02:24:55
 2006 - 2021 Copyright by rt-thread team
msh >
[D/main] current ps data   : 1.
[D/main] current brightness: 1.7(lux).
[D/main] current ps data   : 4.
[D/main] current brightness: 3.5(lux).
[D/main] current ps data   : 9.
[D/main] current brightness: 1318.8(lux).
[D/main] current ps data   : 13.
[D/main] current brightness: 1922.9(lux).
```

可以看到，ap3216c 光环境传感器所测量的接近感应（ps data）与光照强度（brightness）已经被读取出来了！



## 思考总结

本实验通过 I2C 总线读取 ap3216c 光环境传感器数据，得益于 RT-Thread 对 I2C 总线驱动和 ap3216c 软件包的支持，我们只需要写少量代码（甚至不用写代码）即可完成本实验。可以看到，使用 RT-Thread 的软件包真的非常的方便，大大加快了我们的开发速度。

