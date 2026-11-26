---
sidebar_position: 30
sidebar_label: 接入阿里云 IoT 平台
---

# 潘多拉 RT-Thread 阿里云 IoT 接入



## 实验概述

本实验使用 RT-Thread 提供的 ali-iotkit 软件包接入阿里云物联网平台（LinkPlatform 和 LinkDevelop），以 LinkDevelop 平台为例，通过 MQTT 协议接入 LinkDevelop 平台。

ali-iotkit 是 RT-Thread 移植的用于连接阿里云 IoT 平台的软件包。基础 SDK 是阿里提供的 iotkit-embedded C-SDK。ali-iotkit 为了方便设备上云封装了丰富的连接协议，如 MQTT、CoAP、HTTP、TLS，并且对硬件平台进行了抽象，使其不受具体的硬件平台限制而更加灵活。

相对传统的云端接入 SDK，RT-Thread 提供的 ali-iotkit 具有如下优势：

- 快速接入能力
- 嵌入式设备调优
- 多编译器支持（GCC、IAR、MDK）
- 多连接协议支持（HTTP、MQTT、CoAP）
- 强大而丰富的 RT-Thread 生态支持
- 跨硬件、跨 OS 平台支持
- 设备固件 OTA 升级
- TLS/DTLS 安全连接
- 高可移植的应用端程序
- 高可复用的功能组件



## 硬件连接

本实验需要依赖 IoTBoard 板卡上的 WiFi 模块完成网络通信，因此请确保硬件平台上的 WiFi 模组可以正常工作。可参考 [潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)。



## 准备工作

在使用本例程前需要先在 [阿里云 IoT 平台](https://www.aliyun.com) 注册账号，并在帐号里创建产品（使用公共实例即可），然后在产品中创建设备。创建完成后，记录下该设备的三元组信息（ProductKey、DeviceName 和 DeviceSecret）。

打开 menuconfig 配置界面，替换成你的设备三元组信息，并且使能 MQTT 示例。

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-ali-iotkit.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <wlan_mgnt.h>
#include "wifi_config.h"

int main(void)
{
    /* 初始化 wlan 自动连接 */
    wlan_autoconnect_init();

    /* 使能 wlan 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);

    return 0;
}
```

main.c 只进行 WiFi 的初始化工作，MQTT 连接的功能在 ali-iotkit 软件包的示例代码 mqtt-example.c 中实现。关键功能如下：

**1、注册 MQTT 事件回调**

MQTT 事件回调函数 `event_handle()` 用于处理 MQTT 状态事件（如上线、下线、重连等），在 MQTT 客户端创建的时候被注册，代码如下所示：

```c showLineNumbers
void event_handle(void *pcontext, void *pclient, iotx_mqtt_event_msg_pt msg)
{
    uintptr_t packet_id = (uintptr_t)msg->msg;
    iotx_mqtt_topic_info_pt topic_info = (iotx_mqtt_topic_info_pt)msg->msg;

    switch (msg->event_type) {
        case IOTX_MQTT_EVENT_UNDEF:
            EXAMPLE_TRACE("undefined event occur.");
            break;

        case IOTX_MQTT_EVENT_DISCONNECT:
            EXAMPLE_TRACE("MQTT disconnect.");
            break;

        case IOTX_MQTT_EVENT_RECONNECT:
            EXAMPLE_TRACE("MQTT reconnect.");
            break;

        /* ... */

        default:
            EXAMPLE_TRACE("Should NOT arrive here.");
            break;
    }
}
```

**2、注册 MQTT 消息接收回调**

每当 MQTT 客户端收到服务器发来的消息就会调用 `_demo_message_arrive()` 函数，将收到的消息交由用户自定义处理，代码如下所示：

```c showLineNumbers
static void _demo_message_arrive(void *pcontext, void *pclient, iotx_mqtt_event_msg_pt msg)
{
    iotx_mqtt_topic_info_pt ptopic_info = (iotx_mqtt_topic_info_pt) msg->msg;

    /* print topic name and topic message */
    EXAMPLE_TRACE("----");
    EXAMPLE_TRACE("packetId: %d", ptopic_info->packet_id);
    EXAMPLE_TRACE("Topic: '%.*s' (Length: %d)",
                  ptopic_info->topic_len,
                  ptopic_info->ptopic,
                  ptopic_info->topic_len);
    EXAMPLE_TRACE("Payload: '%.*s' (Length: %d)",
                  ptopic_info->payload_len,
                  ptopic_info->payload,
                  ptopic_info->payload_len);
    EXAMPLE_TRACE("----");
}
```

**3、初始化 iotkit 连接信息**

使用用户配置的设备激活凭证（`PRODUCT_KEY`、`DEVICE_NAME` 和 `DEVICE_SECRET`）初始化 iotkit 连接信息（pconn_info），代码如下所示：

```c showLineNumbers
iotx_conn_info_pt pconn_info;
/* Device AUTH */
if (0 != IOT_SetupConnInfo(__product_key, __device_name, __device_secret, (void **)&pconn_info)) {
    EXAMPLE_TRACE("AUTH request failed!");
    rc = -1;
    goto do_exit;
}
```

**4、配置 MQTT 客户端参数**

初始化 MQTT 客户端所必须的用户名、密码、服务器主机名及端口号等配置，代码如下所示：

```c showLineNumbers
iotx_mqtt_param_t mqtt_params;

/* Initialize MQTT parameter */
memset(&mqtt_params, 0x0, sizeof(mqtt_params));
mqtt_params.port = pconn_info->port;
mqtt_params.host = pconn_info->host_name;
mqtt_params.client_id = pconn_info->client_id;
mqtt_params.username = pconn_info->username;
mqtt_params.password = pconn_info->password;
mqtt_params.pub_key = pconn_info->pub_key;
mqtt_params.request_timeout_ms = 2000;
mqtt_params.clean_session = 0;
mqtt_params.keepalive_interval_ms = 60000;
mqtt_params.pread_buf = msg_readbuf;
mqtt_params.read_buf_size = MQTT_MSGLEN;
mqtt_params.pwrite_buf = msg_buf;
mqtt_params.write_buf_size = MQTT_MSGLEN;
mqtt_params.handle_event.h_fp = event_handle;
mqtt_params.handle_event.pcontext = NULL;
```

**5、创建 MQTT 客户端**

使用 `IOT_MQTT_Construct` 函数构建一个 MQTT 客户端，代码如下所示：

```c showLineNumbers
/* Construct a MQTT client with specify parameter */
pclient = IOT_MQTT_Construct(&mqtt_params);
if (NULL == pclient) {
    EXAMPLE_TRACE("MQTT construct failed");
    rc = -1;
    goto do_exit;
}
```

**6、订阅指定的 Topic**

使用 `IOT_MQTT_Subscribe` 函数订阅指定的 Topic（`TOPIC_DATA`），代码如下所示：

```c showLineNumbers
#define TOPIC_DATA              "/"PRODUCT_KEY"/"DEVICE_NAME"/data"

/* Subscribe the specific topic */
rc = IOT_MQTT_Subscribe(pclient, TOPIC_DATA, IOTX_MQTT_QOS1, _demo_message_arrive, NULL);
if (rc < 0) {
    IOT_MQTT_Destroy(&pclient);
    EXAMPLE_TRACE("IOT_MQTT_Subscribe() failed, rc = %d", rc);
    rc = -1;
    goto do_exit;
}
```

**7、循环等待 MQTT 消息通知**

使用 `IOT_MQTT_Yield` 函数接收来自云端的消息。

```c showLineNumbers
IOT_MQTT_Yield(pclient, 200);
```

**8、发布测试消息**

本例程中构建一个 RGB 灯设备需要的 Alink 协议格式的数据包，使用 `IOT_MQTT_Publish` 接口向 MQTT 通道发送 Alink 协议格式的消息。

```c showLineNumbers
rc = IOT_MQTT_Publish(pclient, TOPIC_DATA, &topic_msg);
if (rc < 0) {
    EXAMPLE_TRACE("error occur when publish");
    rc = -1;
    break;
}
```

完整代码：[27_iot_cloud_ali_iotkit](https://github.com/RT-Thread/IoT_Board/tree/master/examples/27_iot_cloud_ali_iotkit)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 365072	   2516	  46080	 413668	  64fe4	rtthread-stm32l4xx.elf
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
 / | \     4.0.1 build Jan  9 2022
 2006 - 2019 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
msh />[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
```

程序运行后会进入 MSH 命令行，等待用户配置设备接入网络。第一次使用可以通过 `wifi join` 命令配置网络。

网络连接成功之后，就可以通过下面 MSH 命令连接阿里云 IoT 平台，进行数据交互。

```bash showLineNumbers
ali_mqtt_test start       # 启动 MQTT 示例
ali_mqtt_test pub open    # 开灯，并向云端同步开灯状态
ali_mqtt_test pub close   # 关灯，并向云端同步关灯状态
ali_mqtt_test stop        # 停止 MQTT 示例
```



## 思考总结

本次实验，我们通过 RT-Thread 的 ali-iotkit 软件包及其提供的示例，不用写任何代码即可实现设备连接阿里云 IoT 平台并进行数据收发功能，真的非常方便！

更多玩法，有待小伙伴们自行探索！

