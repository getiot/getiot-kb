---
sidebar_position: 12
sidebar_label: 六轴传感器
---

# 潘多拉 RT-Thread 六轴传感器



## 实验概述

本实验将利用 RT-Thread 的 ICM20608 软件包，读取 icm20608 六轴传感器所测量的三轴加速度（accelerate）、三轴陀螺仪（gyroscope）数据。



## 硬件连接

潘多拉 IoT Board 板载的 icm20608 传感器采用 I2C 接口连接到 STM32。单片机通过 IIC_SDA（PC1）、IIC_SCL1（PC0） 即可对传感器发送命令、读取数据。另外，ICM_INT（PC2）为硬件中断引脚。

![](https://static.getiot.tech/pandora-board-schematic-icm20608.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

程序主要流程：初始化传感器 -> 零值校准 -> 读取三轴加速度与三轴陀螺仪

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include "icm20608.h"

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

int main(void)
{
    icm20608_device_t dev = RT_NULL;
    const char *i2c_bus_name = "i2c3";
    int count = 0;
    rt_err_t result;

    /* 初始化 icm20608 传感器 */
    dev = icm20608_init(i2c_bus_name);
    if (dev == RT_NULL)
    {
        LOG_E("The sensor initializes failure");

        return 0;
    }
    else
    {
        LOG_D("The sensor initializes success");
    }

    /* 对 icm20608 进行零值校准：采样 10 次，求取平均值作为零值*/
    result = icm20608_calib_level(dev, 10);
    if (result == RT_EOK)
    {
        LOG_D("The sensor calibrates success");
        LOG_D("accel_offset: X%6d  Y%6d  Z%6d", dev->accel_offset.x, dev->accel_offset.y, dev->accel_offset.z);
        LOG_D("gyro_offset : X%6d  Y%6d  Z%6d", dev->gyro_offset.x, dev->gyro_offset.y, dev->gyro_offset.z);
    }
    else
    {
        LOG_E("The sensor calibrates failure");
        icm20608_deinit(dev);

        return 0;
    }

    while (count++ < 100)
    {
        rt_int16_t accel_x, accel_y, accel_z;
        rt_int16_t gyros_x, gyros_y, gyros_z;

        /* 读取三轴加速度 */
        result = icm20608_get_accel(dev, &accel_x, &accel_y, &accel_z);
        if (result == RT_EOK)
        {
            LOG_D("current accelerometer: accel_x%6d, accel_y%6d, accel_z%6d", accel_x, accel_y, accel_z);
        }
        else
        {
            LOG_E("The sensor does not work");
            break;
        }

        /* 读取三轴陀螺仪 */
        result = icm20608_get_gyro(dev, &gyros_x, &gyros_y, &gyros_z);
        if (result == RT_EOK)
        {
            LOG_D("current gyroscope    : gyros_x%6d, gyros_y%6d, gyros_z%6d", gyros_x, gyros_y, gyros_z);
        }
        else
        {
            LOG_E("The sensor does not work");
            break;
        }
        rt_thread_mdelay(1000);
    }

    return 0;
}
```

完整代码：[09_driver_axis](https://github.com/RT-Thread/IoT_Board/tree/master/examples/09_driver_axis)



## 编译运行

打开 menuconfig 配置菜单，勾选 icm20608 软件包，具体路径如下：

```bash
RT-Thread online packages
  peripheral libraries and drivers  --->
  [*] icm20608: a 3-axis gyroscope and a 3-axis accelerometer driver library
```

选择 v1.0.0 版本

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-sensor-icm20608.png#center)

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
  92348	   1880	   3596	  97824	  17e20	rt-thread.elf
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
 / | \     4.1.0 build Jan  5 2022 04:01:42
 2006 - 2021 Copyright by rt-thread team
msh >[D/main] The sensor initializes success
[D/main] The sensor calibrates success
[D/main] accel_offset: X  -246  Y  -203  Z   109
[D/main] gyro_offset : X  -139  Y    52  Z    14
[D/main] current accelerometer: accel_x    -6, accel_y    63, accel_z 16419
[D/main] current gyroscope    : gyros_x   -16, gyros_y    -3, gyros_z     4
[D/main] current accelerometer: accel_x    38, accel_y    75, accel_z 16403
[D/main] current gyroscope    : gyros_x     5, gyros_y    10, gyros_z    10
[D/main] current accelerometer: accel_x    22, accel_y    31, accel_z 16315
[D/main] current gyroscope    : gyros_x   -17, gyros_y     6, gyros_z     3
```

可以看到，icm20608 六轴传感器的数据已经被读取出来了！



## 思考总结

使用 ICM20608 软件包，可以非常方便地在 RT-Thread 上使用 icm20608 的基本功能，包括读取三轴加速度（3-axis accelerometer）、三轴陀螺仪（3-axis gyroscope）、零值校准等功能。

