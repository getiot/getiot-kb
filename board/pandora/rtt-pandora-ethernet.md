---
sidebar_position: 21
sidebar_label: 以太网模块
---

# 潘多拉 RT-Thread 以太网模块



## 实验概述

本实验将使用 ENC28J60 模块连接到潘多拉 IoT 开发板上，实现以太网连接。ENC28J60 是一款带 SPI 接口的独立以太网控制器，兼容 IEEE 802.3，集成 MAC 和 10 BASE-T PHY，最高速度可达 10Mb/s。



## 硬件连接

ENC28J60 是通过开发板左侧的 WIRELESS 插座连接单片机的，利用 SPI2 和单片机进行通讯。原理图和实物图如下所示。

![潘多拉 RT-Thread 以太网模块](https://static.getiot.tech/pandora-enc28j60.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>

int main(void)
{
    extern rt_err_t ping(char* target_name, rt_uint32_t times, rt_size_t size);
    
    /* 等待网络连接成功 */
    rt_thread_mdelay(500);
    
    while(1) {
        
        if(ping("www.rt-thread.org", 4, 0) != RT_EOK) {
            rt_thread_mdelay(5000);
        }
        else {
            break;
        }
    }
    
    return 0;
}
```

完整代码：[18_iot_spi_eth_enc28j60](https://github.com/RT-Thread/IoT_Board/tree/master/examples/18_iot_spi_eth_enc28j60)



## 编译运行

添加 ENC28J60 驱动

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-enc28j60.png#center)

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 206892	   2376	  45204	 254472	  3e208	rtthread-stm32l4xx.elf
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
lwIP -2.0.2 initialized!
msh />60 bytes from 118.31.15.152 icmp_seq=0 ttl=52 time=12 ticks
60 bytes from 118.31.15.152 icmp_seq=1 ttl=52 time=16 ticks
60 bytes from 118.31.15.152 icmp_seq=2 ttl=52 time=12 ticks
60 bytes from 118.31.15.152 icmp_seq=3 ttl=52 time=12 ticks
```

现在，网络已经准备初始化成功，可以和外网进行通讯了！

联网成功后，开发者可以通过 BSD Socket API 进行网络开发了，也可以通过 ENV 选择 RT-Thread 提供的网络软件包来加速应用开发。



## 思考总结

ENC28J60 初始化的源代码位于 drivers/drv_enc28j60.c 中。因为 ENC28J60 是通过 SPI 和单片机进行通讯的，所以需要通过 `enc28j60_attach()` 函数将 ENC28J60 连接到 SPI 设备上，潘多拉 IoT Board 提供了专门的接口，对应 SPI21 设备。这样，就能利用 RT-Thread 的 SPI 框架和 ENC28J60 进行通讯了。

然后就是将 ENC28J60 的中断处理函数通过 `rt_pin_attach_irq()` 函数绑定到对应的管脚上去，这里用到的是 PD3 号管脚。

最后利用 RT-Thread 的 `INIT_COMPONENT_EXPORT` 宏定义，将 `enc28j60_init()` 函数加入开机自动初始化。这样，板子上电后，就会自动执行 ENC28J60 的初始化函数，无需用户手动调用。

drv_enc28j60.c 里面并没有真正的初始化代码，只是调用了 RT_Thread 提供的 enc28j60.c 文件里的函数来初始化的，想了解 ENC28J60 初始化和中断函数的具体实现，可以查看 rt-thread/components/drivers/spi/enc28j60.c 文件来学习。
