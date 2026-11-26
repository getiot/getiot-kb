---
sidebar_position: 10
sidebar_label: 温度传感器
---

# 潘多拉 RT-Thread 温度传感器



## 实验概述

本实验利用 RT-Thread 的 AHT10 软件包，读取 aht10 传感器所测量的温度（temperature）与湿度（humidity）。AHT10 软件包提供了使用温度与湿度传感器 aht10 基本功能，并且提供了软件平均数滤波器可选功能，使用软件包可加快项目开发速度。

AHT10 传感器的输入电压范围为 1.8v - 3.3v，可测量温度范围为 -40 至 85 ℃（精度 ±0.5 ℃），相对湿度的量程为 0 至 100 % rH（精度 ±3 %）。



## 硬件连接

潘多拉 IoT Board 板载的 AHT10 传感器采用 I2C 接口连接到 STM32。单片机通过 IIC_SDA（PC1）、IIC_SCL2（PD6） 即可对传感器 aht10 发送命令、读取数据。

![](https://static.getiot.tech/pandora-board-schematic-aht10.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include "aht10.h"

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

int main(void)
{
    float humidity, temperature;
    aht10_device_t dev;

    /* 总线名称 */
    const char *i2c_bus_name = "i2c4";
    int count = 0;

    /* 等待传感器正常工作 */
    rt_thread_mdelay(2000);

    /* 初始化 aht10 */
    dev = aht10_init(i2c_bus_name);
    if (dev == RT_NULL)
    {
        LOG_E(" The sensor initializes failure");
        return 0;
    }

    while (count++ < 100)
    {
        /* 读取湿度 */
        humidity = aht10_read_humidity(dev);
        LOG_D("humidity   : %d.%d %%", (int)humidity, (int)(humidity * 10) % 10);

        /* 读取温度 */
        temperature = aht10_read_temperature(dev);
        LOG_D("temperature: %d.%d", (int)temperature, (int)(temperature * 10) % 10);

        rt_thread_mdelay(1000);
    }
    return 0;
}
```

完整代码：[07_driver_temp_humi](https://github.com/RT-Thread/IoT_Board/tree/master/examples/07_driver_temp_humi)



## 编译运行

打开 menuconfig 配置菜单，勾选 AHT10 软件包，具体路径如下：

```bash
RT-Thread online packages  --->
  peripheral libraries and drivers  --->
    sensors drivers  --->
    [*]   aht10: digital humidity and temperature sensor aht10 driver library. 
```

选择 v1.0.0 版本（不依赖 Sensor 框架），并开启软件滤波

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-aht10-v1.png#center)

开启 I2C 总线驱动，具体路径如下：

```bash
Hardware Drivers Config  --->
  On-chip Peripheral Drivers  --->
  [*] Enable I2C BUS  --->
```

保持默认配置就可以了

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-aht10-i2c4-bus.png#center)

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
  83904	   1880	   3588	  89372	  15d1c	rt-thread.elf
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
[I/sensor] rt_sensor[temp_aht10] init success
[I/sensor] rt_sensor[humi_aht10] init success
msh >[D/main] humidity   : 64.4 %
[D/main] temperature: 22.5
[D/main] humidity   : 64.3 %
[D/main] temperature: 22.5
[D/main] humidity   : 64.2 %
[D/main] temperature: 22.5
```

可以看到，AHT10 传感器的湿度和温度数据已经被读取出来了！



## 思考总结

本实验通过 I2C 总线读取 AHT10 温湿度传感器数据，得益于 RT-Thread 对 I2C 总线驱动和 AHT10 软件包的支持，我们只需要写少量代码（甚至不用写代码）即可完成本实验。可以看到，使用 RT-Thread 的软件包真的非常的方便，大大加快了我们的开发速度。

