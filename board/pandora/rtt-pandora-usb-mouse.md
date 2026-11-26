---
sidebar_position: 13
sidebar_label: 模拟 USB 鼠标
---

# 潘多拉 RT-Thread 模拟 USB 鼠标

![](https://static.getiot.tech/pandora-board-3D-mouse.jpeg#center)

## 实验概述

本实验使用潘多拉 IoT Board 板载的六轴传感器 icm20608 获取开发板的旋转方向及角度，然后转换为鼠标的位移信息。同时使用板载按键实现鼠标的左右键，最后将这些鼠标信息通过 RT-Thread 的 USB 组件发送至电脑，从而实现开发板模拟 USB 鼠标的功能。

### RT-Thread USB 组件

RT-Thread USB 组件位于 rt-thread/components/drivers/usb，是 RT-Thread 依据 USB2.0 协议规范将 USB 协议栈逻辑高度抽象，支持 host（主机）和 device（从机）模式。

该组件允许用户通过宏 `RT_USB_DEVICE_COMPOSITE` 开启复合功能，无需额外的代码即可对多个设备类型进行复合，虚拟串口、以太网卡、人体学输入设备、大容量存储设备、微软通用 USB 等。

该组件在驱动移植方面提供了非常友好的移植接口，用户可将厂商 SDK（软件开发工具包）中 PCD（端口连接检测）驱动直接接入到 RT-Thread，实现 0 代码使用 USB。

### ICM20608 软件包

ICM20608 软件包是 RT-Thread 针对六轴传感器 icm20608 功能使用的实现，使用这个软件包，可以让该传感器在 RT-Thread 上非常方便使用 icm20608 的基本功能，包括读取三轴加速度（3-axis accelerometer）、三轴陀螺仪（3-axis gyroscope）、零值校准等功能。可参考《[潘多拉 RT-Thread 六轴传感器](/pandora/rtt-pandora-sensor-icm20608/)》。



## 硬件连接

要实现 3D 鼠标，需要用到潘多拉 IoT Board 上的 USB OTG，其原理图如下图所示：

![](https://static.getiot.tech/pandora-board-schematic-usb.png#center)

如上图所示，单片机通过以下管脚来控制 LCD 显示屏输出。

本实验使用到两个 USB 接口。其中，USB1 为 ST-Link，主要用于程序的下载与调试。USB2 是模拟鼠标使用的 USB OTG 接口，引脚 USB_D-（PA11）和 USB_D+（PA12）为 USB 主机与从机的数据交互接口，在本实验中开发板作为从机（USB Device），电脑作为主机（USB Host）。

另外，我们还使用潘多拉 IoT Board 上的 KEY2 模拟鼠标左键，KEY0 模拟鼠标右键。



## 示例代码

程序主要流程如下：
1. **初始化设备或者查找设备**

  查找设备名称为 hidd 的 hid 设备，初始化 icm20608 传感器，初始化鼠标按键。

2. **打开设备**

   打开查找到的 hid 设备。

3. **创建线程**

   分别创建鼠标数据发送处理线程、传感器数据读取与处理线程、按键检测线程，并且启动这些创建的线程。

完整代码：[10_component_usb_mouse](https://github.com/RT-Thread/IoT_Board/tree/master/examples/10_component_usb_mouse)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 108804	    804	  22168	 131776	  202c0	rtthread-stm32l4xx.elf
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
 / | \     4.0.1 build Jan  4 2022
 2006 - 2019 Copyright by rt-thread team
[D/3D_mouse] The 3D mouse initializes success
msh >
```

移动潘多拉 IoT Board，可以看到串口终端打印出鼠标的模拟数据

```bash
[D/3D_mouse] move_max :  10, x:    2, y :  10
[D/3D_mouse] move_max :  10, x:    2, y :  10
[D/3D_mouse] move_max :   5, x:    0, y :   5
[D/3D_mouse] move_max :  12, x:    1, y :  12
[D/3D_mouse] move_max :  12, x:    1, y :  12
[D/3D_mouse] move_max :  18, x:    1, y :  18
[D/3D_mouse] move_max :  18, x:    1, y :  18
[D/3D_mouse] move_max :  18, x:    1, y :  18
[D/3D_mouse] move_max :  25, x:    0, y :  25
[D/3D_mouse] move_max :  25, x:    0, y :  25
```

此时，可以看到电脑屏幕上的鼠标光标随着开发板移动而移动，按下 KEY2 键相当于鼠标左键，KEY0 键相当于鼠标右键。

提示：需要使用 Micro USB 线连接开发板的 USB OTG 接口到电脑。



## 思考总结

本实验涉及 USB 设备、IMU 六轴传感器以及 RT-Thread 线程等多个知识点，是 RT-Thread 进阶学习的一个项目，想要掌握所有知识点，还请多加练习和思考。

