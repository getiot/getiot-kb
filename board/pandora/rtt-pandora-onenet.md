---
sidebar_position: 29
sidebar_label: 接入 OneNET 物联网云平台
---

# 潘多拉 RT-Thread OneNET 云接入



## 实验概述

本实验使用 RT-Thread 提供的 onenet 软件包接入中国移动物联网开放平台，通过 MQTT 协议接入 OneNET 平台，初次使用 OneNET 平台的用户请先阅读《OneNET 用户手册》。

OneNET 平台是中国移动基于物联网产业打造的生态平台，具有高并发可用、多协议接入、丰富 API 支持、数据安全存储、快速应用孵化等特点。OneNET 平台可以适配各种网络环境和协议类型，现在支持的协议有 LWM2M（NB-IOT）、EDP、MQTT、HTTP、MODBUS、JT8̉̃08、TCP 透传、RGMP 等。用户可以根据不同的应用场景选择不同的接入协议。

onenet 软件包是 RT-Thread 针对 OneNET 平台做的适配，通过这个软件包可以让设备在 RT-Thread 上非常方便的连接 OneNet 平台，完成数据的发送、接收、设备的注册和控制等功能。



## 硬件连接

本实验需要依赖 IoTBoard 板卡上的 WiFi 模块完成网络通信，因此请确保硬件平台上的 WiFi 模组可以正常工作。可参考《[潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)》。



## 准备工作

在使用本例程前需要在 [OneNET 平台](https://open.iot.10086.cn) 注册账号，并在帐号里创建产品，具体的流程参考《OneNET 示例说明》。产品创建完成后，记录下产品概况页面的产品 ID 和 APIKey。然后切换到设备管理界面，记录下设备注册码。

打开 rtconfig.h，找到下面三个宏定义，将其替换为设备注册码、产品 ID 和 APIKey。

```c showLineNumbers title="rtconfig.h"
#define ONENET_REGISTRATION_CODE "xxx"
#define ONENET_INFO_PROID        "yyy"
#define ONENET_MASTER_APIKEY     "zzz"
```



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

main.c 程序主要实现了每隔 5s 往 OneNET 平台上传一次环境光强度，并可以执行 OneNET 下发命令的功能。具体流程如下：

- 初始化 LED 管脚；
- 初始化 ap3216c 传感器；
- 注册 OneNET 启动函数为 WiFi 连接成功的回调函数；
- 启动 WiFi 自动连接功能。

当 WiFi 连接成功后，会调用 `onenet_mqtt_init()` 函数，该函数会获取设备信息完成设备上线的任务。如果设备未注册，会自动调用注册函数完成注册。设备上线之后，自动执行 `onenet_upload_cycle()` 函数，函数会设置命令响应的回调函数，并启动一个 onenet_send 的线程，线程会每隔 5 秒获取一次 ap3216c 传感器的环境光强度数据，并将这个数据上传到 OneNET 的 light 数据流中，发送 100 次后线程自动结束。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <wlan_mgnt.h>
#include "wifi_config.h"
#include <stdlib.h>
#include <onenet.h>
#include <string.h>
#include <ap3216c.h>
#include <easyflash.h>
#include <drv_gpio.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define I2C_BUS_NAME "i2c1"
#define LED_PIN PIN_LED_R
#define NUMBER_OF_UPLOADS 100

ap3216c_device_t dev;
static void onenet_cmd_rsp_cb(uint8_t *recv_data, size_t recv_size, uint8_t **resp_data, size_t *resp_size);

int main(void)
{
    rt_pin_mode(LED_PIN, PIN_MODE_OUTPUT);

    /* 初始化 ap3216c */
    dev = ap3216c_init(I2C_BUS_NAME);
    if (dev == RT_NULL)
    {
        LOG_E(" The sensor initializes failure");
        return 0;
    }

    /* 初始化 wlan 自动连接 */
    wlan_autoconnect_init();
    /* 使能 wlan 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);

    return 0;
}

static void onenet_upload_entry(void *parameter)
{
    int value = 0;
    int i = 0;

    /* 往 light 数据流上传环境光数据 */
    for (i = 0; i < NUMBER_OF_UPLOADS; i++)
    {
        value = (int)ap3216c_read_ambient_light(dev);

        if (onenet_mqtt_upload_digit("light", value) < 0)
        {
            LOG_E("upload has an error, stop uploading");
            break;
        }
        else
        {
            LOG_D("buffer : {\"light\":%d}", value);
        }

        rt_thread_mdelay(5 * 1000);
    }
}

void onenet_upload_cycle(void)
{
    rt_thread_t tid;

    /* 设置 onenet 回调响应函数 */
    onenet_set_cmd_rsp_cb(onenet_cmd_rsp_cb);

    /* 传创建线程 */
    tid = rt_thread_create("onenet_send",
                           onenet_upload_entry,
                           RT_NULL,
                           2 * 1024,
                           RT_THREAD_PRIORITY_MAX / 3 - 1,
                           5);
    if (tid)
    {
        rt_thread_startup(tid);
    }
}
MSH_CMD_EXPORT(onenet_upload_cycle, upload data to onenet);

rt_err_t onenet_port_save_device_info(char *dev_id, char *api_key)
{
    EfErrCode err = EF_NO_ERR;

    /* 保存设备 ID */
    err = ef_set_and_save_env("dev_id", dev_id);
    if (err != EF_NO_ERR)
    {
        LOG_E("save device info(dev_id : %s) failed!", dev_id);
        return -RT_ERROR;
    }

    /* 保存设备 api_key */
    err = ef_set_and_save_env("api_key", api_key);
    if (err != EF_NO_ERR)
    {
        LOG_E("save device info(api_key : %s) failed!", api_key);
        return -RT_ERROR;
    }

    /* 保存环境变量：已经注册 */
    err = ef_set_and_save_env("already_register", "1");
    if (err != EF_NO_ERR)
    {
        LOG_E("save already_register failed!");
        return -RT_ERROR;
    }

    return RT_EOK;
}

rt_err_t onenet_port_get_register_info(char *dev_name, char *auth_info)
{
    rt_uint32_t cpuid[2] = {0};
    EfErrCode err = EF_NO_ERR;

    /* 获取 stm32 uid */
    cpuid[0] = *(volatile rt_uint32_t *)(0x1FFF7590);
    cpuid[1] = *(volatile rt_uint32_t *)(0x1FFF7590 + 4);

    /* 设置设备名和鉴权信息 */
    rt_snprintf(dev_name, ONENET_INFO_AUTH_LEN, "%d%d", cpuid[0], cpuid[1]);
    rt_snprintf(auth_info, ONENET_INFO_AUTH_LEN, "%d%d", cpuid[0], cpuid[1]);

    /* 保存设备鉴权信息 */
    err = ef_set_and_save_env("auth_info", auth_info);
    if (err != EF_NO_ERR)
    {
        LOG_E("save auth_info failed!");
        return -RT_ERROR;
    }

    return RT_EOK;
}

rt_err_t onenet_port_get_device_info(char *dev_id, char *api_key, char *auth_info)
{
    char *info = RT_NULL;

    /* 获取设备 ID */
    info = ef_get_env("dev_id");
    if (info == RT_NULL)
    {
        LOG_E("read dev_id failed!");
        return -RT_ERROR;
    }
    else
    {
        rt_snprintf(dev_id, ONENET_INFO_AUTH_LEN, "%s", info);
    }

    /* 获取 api_key */
    info = ef_get_env("api_key");
    if (info == RT_NULL)
    {
        LOG_E("read api_key failed!");
        return -RT_ERROR;
    }
    else
    {
        rt_snprintf(api_key, ONENET_INFO_AUTH_LEN, "%s", info);
    }

    /* 获取设备鉴权信息 */
    info = ef_get_env("auth_info");
    if (info == RT_NULL)
    {
        LOG_E("read auth_info failed!");
        return -RT_ERROR;
    }
    else
    {
        rt_snprintf(auth_info, ONENET_INFO_AUTH_LEN, "%s", info);
    }

    return RT_EOK;
}

rt_bool_t onenet_port_is_registed(void)
{
    char *already_register = RT_NULL;

    /* 检查设备是否已经注册 */
    already_register = ef_get_env("already_register");
    if (already_register == RT_NULL)
    {
        return RT_FALSE;
    }

    return already_register[0] == '1' ? RT_TRUE : RT_FALSE;
}

static void onenet_cmd_rsp_cb(uint8_t *recv_data, size_t recv_size, uint8_t **resp_data, size_t *resp_size)
{
    char res_buf[20] = {0};

    LOG_D("recv data is %.*s", recv_size, recv_data);

    /* 命令匹配 */
    if (rt_strncmp((const char *)recv_data, "ledon", 5) == 0)
    {
        /* 开灯 */
        rt_pin_write(LED_PIN, PIN_LOW);

        rt_snprintf(res_buf, sizeof(res_buf), "led is on");

        LOG_D("led is on");
    }
    else if (rt_strncmp((const char *)recv_data, "ledoff", 6) == 0)
    {
        /* 关灯 */
        rt_pin_write(LED_PIN, PIN_HIGH);

        rt_snprintf(res_buf, sizeof(res_buf), "led is off");

        LOG_D("led is off");
    }

    /* 开发者必须使用 ONENET_MALLOC 为响应数据申请内存 */
    *resp_data = (uint8_t *)ONENET_MALLOC(strlen(res_buf) + 1);

    strncpy((char *)resp_data, res_buf, strlen(res_buf));

    *resp_size = strlen(res_buf);
}
```

完整代码：[26_iot_cloud_onenet](https://github.com/RT-Thread/IoT_Board/tree/master/examples/26_iot_cloud_onenet)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 373512	   2472	  44232	 420216	  66978	rtthread-stm32l4xx.elf
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
 / | \     4.1.0 build Jan  9 2022 21:24:21
 2006 - 2021 Copyright by rt-thread team
lwIP-2.0.3 initialized!
[D/drv.qspi] qspi init success!
[I/SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[I/SFUD] W25Q128 flash device is initialize success.
[D/drv.qspi] qspi init success!
[I/SFUD] Probe SPI flash W25Q128 by SPI device qspi10 success.
[I/sal.skt] Socket Abstraction Layer initialize success.
msh />[I/WWD] wifi initialize done. wiced version 3.3.1
[I/WLAN.dev] wlan init success
[I/WLAN.lwip] eth device init ok name:w0
[D/main] start to scan ap ...
```

程序运行后会进入 MSH 命令行，等待用户配置设备接入网络。第一次使用可以通过 `wifi join` 命令配置网络。

注册标志存储在 flash 中，连接之后，会保存注册信息与注册标志。第一次初始化 OneNET mqtt 客户端，返回注册的设备信息，flash 对设备信息进行保存，并且将注册标志置为 1。如果需要重新注册设备，则需要将这个标志位清零。使用命令如下：

```bash
msh />setenv already_register 0  # 清零注册标志
msh />saveenv                    # 保存设置的变量
```

在 WiFi 连接成功后，会调用 `onenet_mqtt_init()` 函数对 OneNET mqtt 客户端进行初始化，然后调用 `onenet_upload_cycle()` 函数开始上传数据。这时候，如果一切正常，你可以在 OneNET 平台的 *设备列表 -> 数据流展示* 看到潘多拉 IoT 开发板刚刚上传的 light 数据信息。

在设备列表界面，选择下发命令，点击蓝色的下发命令按纽，会弹出一个命令窗口，我们可以下发命令给开发板。例程支持 `ledon` 和 `ledoff` 两个命令，板子收到这两个命令后会打开和关闭开发板上的红色 led。



## 思考总结

在 RT-Thread 系统中，使用 onenet 软件包可以很方便的连接中国移动 OneNet 云平台。OneNet 平台不仅支持设备接入，还支持应用开发，对于物联网初学者来说，是一个很不错的选择。

