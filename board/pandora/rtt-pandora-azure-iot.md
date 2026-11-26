---
sidebar_position: 31
sidebar_label: 接入 Azure IoT 平台
---

# 潘多拉 RT-Thread Azure IoT 接入



## 实验概述

本实验使用 RT-Thread 提供的 azure-iot-sdk 软件包接入微软物联网平台。Azure 是 RT-Thread 移植的用于连接微软 Azure IoT 中心的软件包，原始 SDK 为 azure-iot-sdk-c。通过该软件包，可以让运行 RT-Thread 的设备轻松接入 Azure IoT Central。

Azure IoT Central 运行在微软云服务器上，充当中央消息中心，用于 IoT 应用程序与其管理的设备之间的双向通信。通过 Azure IoT Central，可以在数百万 IoT 设备和云托管解决方案后端之间建立可靠又安全的通信，生成 IoT 解决方案。几乎可以将任何设备连接到 IoT Central。

使用 Azure 软件包连接 IoT Central 可以实现如下功能：

- 轻松连入 Azure IoT Central，建立与 Azure IoT 的可靠通讯；
- 为每个连接的设备设置标识和凭据，并帮助保持云到设备和设备到云消息的保密性；
- 管理员可在云端大规模地远程维护、更新和管理 IoT 设备；
- 从设备大规模接收遥测数据；
- 将数据从设备路由到流事件处理器；
- 设备上传文件到 IoT Central；
- 将云到设备的消息发送到特定设备。

可以使用 Azure IoT Central 来实现自己的解决方案后端。此外，IoT Central 还包含标识注册表，可用于预配设备、其安全凭据以及其连接到 IoT Central 的权限。



## 硬件连接

本实验需要依赖 IoTBoard 板卡上的 WiFi 模块完成网络通信，因此请确保硬件平台上的 WiFi 模组可以正常工作。可参考 [潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)。



## 准备工作

在使用本例程之前，需要先在 [Azure IoT Central](https://apps.azureiotcentral.com) 注册账号，并在帐号里创建应用（选择免费试用版），然后创建新设备。创建完成后，记录下该设备的三元组信息（ProductKey、DeviceName 和 DeviceSecret）。

![RT-Thread 接入 Azure IoT Central](https://static.getiot.tech/azure-iot-central-create-application.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <wlan_mgnt.h>
#include "wifi_config.h"

int main(void)
{
    /* Config the dependencies of the wlan autoconnect function */
    wlan_autoconnect_init();

    /* Enable wlan auto connect function */
    rt_wlan_config_autoreconnect(RT_TRUE);

    return 0;
}
```

完整代码：[28_iot_cloud_ms_azure](https://github.com/RT-Thread/IoT_Board/tree/master/examples/28_iot_cloud_ms_azure)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 489060	   3024	  44528	 536612	  83024	rtthread-stm32l4xx.elf
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
```



## 思考总结

RT-Thread 提供的 azure-iot-sdk 软件包比较旧，Azure 官方推出了新的 [Azure SDK for Embedded C](https://github.com/Azure/azure-sdk-for-c)，这部分改动比较大，后续有进展再更新本次实验。

