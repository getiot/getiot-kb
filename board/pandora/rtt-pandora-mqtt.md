---
sidebar_position: 22
sidebar_label: MQTT 通信
---

# 潘多拉 RT-Thread MQTT 通信



## 实验概述

本实验使用潘多拉 IoT 开发板的 WiFi 模块，并基于 Paho-MQTT 软件包，实现向服务器订阅主题和向指定主题发布消息的功能。

在开始本实验之前，请确保硬件平台上的 WiFi 模组可以正常工作，可参考《[潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)》。

[**MQTT**](/mqtt/mqtt-intro/) 是一个基于客户端-服务器的消息发布/订阅传输协议，具有轻量、简单、开放和易于实现等特点，非常适合在受限的环境中使用，在物联网、小型设备、移动应用等方面有较广泛的应用。



## 硬件连接

潘多拉 IoT Board 板载的一个 WiFi 模块，它是正基公司的 AP6181 WiFi 模组，集成了 IEEE 802.11 b/g/n MAC 、基带、射频以及功率放大器、电源管理装置、SDIO 2.0 接口，原理图如下。

![](https://static.getiot.tech/pandora-board-schematic-ap6181.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

Paho-MQTT 软件包已经实现了 MQTT 客户端的完整功能，开发者只需要设定好 MQTT 客户端的配置即可使用。本例程使用的测试服务器是 Eclipse 的测试服务器，服务器网址、用户名和密码已在 main.c 文件的开头定义，可根据需要自行修改。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "paho_mqtt.h"
#include "wifi_config.h"
#include <wlan_mgnt.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

/**
 * MQTT URI farmat:
 * domain mode
 * tcp://iot.eclipse.org:1883
 *
 * ipv4 mode
 * tcp://192.168.10.1:1883
 * ssl://192.168.10.1:1884
 *
 * ipv6 mode
 * tcp://[fe80::20c:29ff:fe9a:a07e]:1883
 * ssl://[fe80::20c:29ff:fe9a:a07e]:1884
 */
#define MQTT_URI "tcp://iot.eclipse.org:1883"
#define MQTT_USERNAME "admin"
#define MQTT_PASSWORD "admin"
#define MQTT_SUBTOPIC "/mqtt/test/"
#define MQTT_PUBTOPIC "/mqtt/test/"

/* define MQTT client context */
static MQTTClient client;
static void mq_start(void);
static void mq_publish(const char *send_str);

char sup_pub_topic[48] = {0};

int main(void)
{
    /* 注册 wlan 回调函数 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_READY, (void (*)(int, struct rt_wlan_buff *, void *))mq_start, RT_NULL);
    /* 初始化自动连接功能 */
    wlan_autoconnect_init();
    /* 使能 wlan 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);
}

static void mqtt_sub_callback(MQTTClient *c, MessageData *msg_data)
{
    *((char *)msg_data->message->payload + msg_data->message->payloadlen) = '\0';
    LOG_D("Topic: %.*s receive a message: %.*s",
          msg_data->topicName->lenstring.len,
          msg_data->topicName->lenstring.data,
          msg_data->message->payloadlen,
          (char *)msg_data->message->payload);

    return;
}

static void mqtt_sub_default_callback(MQTTClient *c, MessageData *msg_data)
{
    *((char *)msg_data->message->payload + msg_data->message->payloadlen) = '\0';
    LOG_D("mqtt sub default callback: %.*s %.*s",
          msg_data->topicName->lenstring.len,
          msg_data->topicName->lenstring.data,
          msg_data->message->payloadlen,
          (char *)msg_data->message->payload);
    return;
}

static void mqtt_connect_callback(MQTTClient *c)
{
    LOG_I("Start to connect mqtt server");
}

static void mqtt_online_callback(MQTTClient *c)
{
    LOG_D("Connect mqtt server success");
    LOG_D("Publish message: Hello,RT-Thread! to topic: %s", sup_pub_topic);
    mq_publish("Hello,RT-Thread!");
}

static void mqtt_offline_callback(MQTTClient *c)
{
    LOG_I("Disconnect from mqtt server");
}

/* 创建与配置 mqtt 客户端 */
static void mq_start(void)
{
    /* 初始 condata 参数 */
    MQTTPacket_connectData condata = MQTTPacket_connectData_initializer;
    static char cid[20] = {0};

    static int is_started = 0;
    if (is_started)
    {
        return;
    }
    /* 配置 MQTT 文本参数 */
    {
        client.isconnected = 0;
        client.uri = MQTT_URI;

        /* 生成随机客户端 ID */
        rt_snprintf(cid, sizeof(cid), "rtthread%d", rt_tick_get());
        rt_snprintf(sup_pub_topic, sizeof(sup_pub_topic), "%s%s", MQTT_PUBTOPIC, cid);
        /* 配置连接参数 */
        memcpy(&client.condata, &condata, sizeof(condata));
        client.condata.clientID.cstring = cid;
        client.condata.keepAliveInterval = 60;
        client.condata.cleansession = 1;
        client.condata.username.cstring = MQTT_USERNAME;
        client.condata.password.cstring = MQTT_PASSWORD;

        /* 配置 mqtt 参数 */
        client.condata.willFlag = 0;
        client.condata.will.qos = 1;
        client.condata.will.retained = 0;
        client.condata.will.topicName.cstring = sup_pub_topic;

        client.buf_size = client.readbuf_size = 1024;
        client.buf = malloc(client.buf_size);
        client.readbuf = malloc(client.readbuf_size);
        if (!(client.buf && client.readbuf))
        {
            LOG_E("no memory for MQTT client buffer!");
            goto _exit;
        }

        /* 设置事件回调 */
        client.connect_callback = mqtt_connect_callback;
        client.online_callback = mqtt_online_callback;
        client.offline_callback = mqtt_offline_callback;
        /* 设置要订阅的 topic 和 topic 对应的回调函数 */
        client.messageHandlers[0].topicFilter = sup_pub_topic;
        client.messageHandlers[0].callback = mqtt_sub_callback;
        client.messageHandlers[0].qos = QOS1;

        /* 设置默认订阅回调函数 */
        client.defaultMessageHandler = mqtt_sub_default_callback;
    }

    /* 启动 MQTT 客户端 */
    LOG_D("Start mqtt client and subscribe topic:%s", sup_pub_topic);
    paho_mqtt_start(&client);
    is_started = 1;

_exit:
    return;
}

/* MQTT 消息发布函数 */
static void mq_publish(const char *send_str)
{
    MQTTMessage message;
    const char *msg_str = send_str;
    const char *topic = sup_pub_topic;
    message.qos = QOS1;
    message.retained = 0;
    message.payload = (void *)msg_str;
    message.payloadlen = strlen(message.payload);

    MQTTPublish(&client, topic, &message);

    return;
}
```

完整代码：[19_iot_mqtt](https://github.com/RT-Thread/IoT_Board/tree/master/examples/19_iot_mqtt)



## 编译运行

添加 Paho-MQTT 软件包，具体路径如下：

```bash
RT-Thread online packages  --->
  IoT - internet of things  --->
  [*] Paho MQTT: Eclipse Paho MQTT C/C++ client for Embedded platforms  --->
```

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
 362628	   2460	  43840	 408928	  63d60	rtthread-stm32l4xx.elf
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

首次使用需要输入 `wifi join` 命令连接 WiFi 网络，之后开发板会自动连上 WiFi

```bash
wifi join [SSID] [PASSWORD]
```

重启开发板，可以看到，WiFi 连接成功后，MQTT 客户端就自动连接了服务器，并订阅了我们指定的主题。连接服务器成功，处于在线状态后，发布了一条 `Hello,RT-Thread!` 的消息，我们很快接收到了服务器推送过来的这条消息。

```bash
[D/main] Start mqtt client and subscribe topic:/mqtt/test/rtthread9794
[I/main] Start to connect mqtt server
[D/main] Connect mqtt server success
[D/main] Publish message: Hello,RT-Thread! to topic: /mqtt/test/rtthread9794
[D/main] Topic: /mqtt/test/rtthread9794 receive a message: Hello,RT-Thread!
```



## 思考总结

在 main 函数中，我们首先初始化 MQTT 客户端，由于 `mq_start()` 函数注册为网络连接成功的回调函数，因此需要先执行 WiFi 自动连接初始化，才会初始化 MQTT 客户端函数。

```c showLineNumbers
rt_wlan_register_event_handler(RT_WLAN_EVT_READY, 
                               (void (*)(int, struct rt_wlan_buff *, void *))mq_start,
                               RT_NULL);
```

`mq_start()` 函数主要是配置 MQTT 客户端的连接参数（客户端 ID、保持连接时间、用户名和密码等），设置事件回调函数（连接成功、在线和离线回调函数），设置订阅的主题，并为每个主题设置不同的回调函数去处理发生的事件。设置完成后，函数会启动一个 MQTT 客户端。客户端会自动连接服务器，并订阅相应的主题。

`mq_publish()` 函数用来向指定的主题发布消息。例程里的主题就是我们 MQTT 客户端启动时订阅的主题，这样，我们会接收到自己发布的消息，实现自发自收的功能。本例程在在线回调函数里调用了 `mq_publish()` 函数，发布了 "Hello,RT-Thread!" 消息，所以我们在 MQTT 客户端成功连上服务器，处于在线状态后，会收到 "Hello,RT-Thread!" 的消息。

MQTT 在物联网系统中应用非常广泛，请同学们多加练习以全面掌握 MQTT 协议。
