---
sidebar_position: 20
sidebar_label: ESP8266 模块
---

# 潘多拉 RT-Thread ESP8266 模块



## 实验概述

本实验将使用 ESP8266 模块连接到潘多拉 IoT 开发板上，并通过 RT-Thread 的 AT 组件完成对 ESP8266 AT 命令和数据的收发的，实现 WiFi 连接互联网的功能。

ESP8266 是一款集成 32 位 MCU 的 WiFi 芯片，内置 AT 指令。通过 AT 指令，用户能快速的开发网络应用，而无需关心具体的网络协议栈的内容。



## 硬件连接

这里以正点原子的 ATK-ESP8266 模块为例进行说明，将 ESP8266 模块连接到开发板左侧的 ATK MODULE 接口，实际通讯接口是 UART 串口，对应单片机的 UART2。原理图和实物图如下所示。

![潘多拉 RT-Thread ESP8266 模块](https://static.getiot.tech/pandora-ESP8266.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

在 RT-Thread 上进行网络编程推荐使用 BSD Socket API，RT-Thread 提供了数量众多的网络软件包，都是用 BSD Socket API 编写的，用户可以利用这些软件包可以快速的完成自己的网络应用开发。RT-Thread 提供的 SAL 组件和 AT 组件可以帮助开发者非常方便的将带有 AT 命令的网络模块对接到 RT-Thread 上来，所以可以看到 main 函数的应用程序非常简单。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>

int main(void)
{
    extern int netdev_ping(int argc, char **argv);

    char *cmd[] = {"esp8266_ping", "www.rt-thread.org"};

    while (1) {
        
        if (netdev_ping(2, cmd) == RT_EOK) {
            break;
        }
        else {
            rt_thread_mdelay(5000);
        }
    }

    return 0;
}
```

完整代码：[17_iot_at_wifi_8266](https://github.com/RT-Thread/IoT_Board/tree/master/examples/17_iot_at_wifi_8266)



## 编译运行

添加 ESP8266 AT 设备，具体路径如下：

```bash
RT-Thread online packages  --->
  IoT - internet of things  --->
  [*] AT DEVICE: RT-Thread AT component porting or samples for different device
  [*]   Espressif ESP8266  --->
```

修改 WiFi 网络名称和密码

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-esp8266.png#center)

下载软件包

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
 132488	   2476	   2928	 137892	  21aa4	rtthread-stm32l4xx.elf
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
[I/SAL_SKT] Socket Abstraction Layer initialize success.
[I/at.clnt] AT client(V1.2.0) on device uart2 initialize success.
[I/at.esp8266] ESP8266 WIFI is connected.
[I/at.esp8266] AT network initialize success!
msh >32 bytes from www.rt-thread.org icmp_seq=1 time=10 ms
32 bytes from www.rt-thread.org icmp_seq=2 time=10 ms
32 bytes from www.rt-thread.org icmp_seq=3 time=9 ms
32 bytes from www.rt-thread.org icmp_seq=4 time=10 ms
```

可以看到，ESP8266 模块已经自动注册好了，并且可以连接互联网！



## 思考总结

使用 RT-Thread 的 SAL 框架和 AT 组件，可以快速接入各种 AT 模块（比如 ESP8266），并向上提供同一的 Socket API 接口。具体的 AT 设备位于 packages 软件包中，默认自动完成复位和初始化工作，初始化完成后，会将 ESP8266 作为一个 AT Socket 设备注册到 SAL 组件中。这样就可以通过 BSD Socket 开发的应用就可以利用 ESP8266 来连接网络了。

