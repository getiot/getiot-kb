---
sidebar_position: 28
sidebar_label: 接入 RT-Thread 设备维护云
---

# 潘多拉 RT-Thread 设备维护云接入



## 实验概述

本实验使用 RT-Thread 提供的 CloudSDK 库接入 RT-Thread 云平台，实现远程 Shell 控制、远程 Log 存储和 OTA 升级功能。

[RT-Thread 云平台](http://iot.rt-thread.com) 是由上海睿赛德电子科技有限公司开发的一套物联网设备维护云平台。其目的是帮助开发者搭建安全有效的数据传输通道，方便设备终端和云端的双向通讯，在云端实现设备的升级、维护与管理功能。初次使用建议先阅读《RT-Thread 云平台用户手册》。

RT-Thread 设备维护云主要功能：

- **Web Shell 功能**

  RT-Thread 云平台实现远程 Shell 控制功能，用户无需连接串口设备即可完成对设备的控制、管理，满足用户对设备远程管理的需求。

- **Web Log 功能**

  RT-Thread 云平台实现设备日志的实时显示和存储功能，方便设备数据的采集以及设备状态的查看功能，用户可以通过 Web Log 随时查看设备动态及设备日志历史记录。

- **OTA 升级功能**

  RT-Thread 云平台实现设备远程升级功能，OTA 功能支持加密压缩升级、多固件升级、断点续传，满足用户对多种设备的 OTA 升级需求。



## 硬件连接

本实验需要依赖 IoTBoard 板卡上的 WiFi 模块完成网络通信，因此请确保硬件平台上的 WiFi 模组可以正常工作。可参考《[潘多拉 RT-Thread WiFi 管理](/pandora/rtt-pandora-wifi-manager/)》。



## 准备工作

在开始之前，我们需要先在 [RT-Thread 云平台](http://iot.rt-thread.com)注册账号，使用该账号在云平台中创建新产品，然后使用设备唯一标识符 SN（SN 可以由用户自定义）在云端创建新设备。

产品和设备创建完成后，在 *产品管理 > 潘多拉魔盒 > 产品信息* 页面中找到 ProductID 和 ProductKey（产品密钥需要手动点开查看）。

![RT-Thread 设备维护云](https://static.getiot.tech/pandora-rtt-cloud-add-product.png#center)

记下 ProductID、ProductKey 和 SN 值，修改例程 /ports/cloudsdk/rt_cld_port.c 文件中宏定义。

```c showLineNumbers
/* Must be configured custom device and RTT cloud configuration  */
#define CLD_SN               "123456789"
#define CLD_PRODUCT_ID       "abcdefghi"
#define CLD_PRODUCT_KEY      "abcdefghiihgfedcba"
```



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

在 main 函数中，主要完成了以下两个任务：

- 注册 CloudSDK 启动函数为 WiFi 连接成功的回调函数；
- 启动 WiFi 自动连接功能，当 WiFi 连接成功后，会调用 `rt_cld_sdk_init()` 云端初始化函数，完成设备自动连接云端任务。

```c  showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <wlan_mgnt.h>
#include <wifi_config.h>
#include <board.h>

#include <rt_cld.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define APP_VERSION  "1.0.0"

/* 将中断向量表起始地址重新设置为 app 分区的起始地址 */
static int ota_app_vtor_reconfig(void)
{
    #define NVIC_VTOR_MASK   0x3FFFFF80
    #define RT_APP_PART_ADDR 0x08010000
        /* 根据应用设置向量表 */
    SCB->VTOR = RT_APP_PART_ADDR & NVIC_VTOR_MASK;

    return 0;
}
INIT_BOARD_EXPORT(ota_app_vtor_reconfig);

void wlan_ready_handler(int event, struct rt_wlan_buff *buff, void *parameter)
{
    rt_cld_sdk_init();
}

int main(void)
{
    /* 注册 wlan 回调函数 */
    rt_wlan_register_event_handler(RT_WLAN_EVT_READY, wlan_ready_handler, RT_NULL);
    
    /* 初始化 wlan 自动连接 */
    wlan_autoconnect_init();
    /* 使能wlan 自动连接 */
    rt_wlan_config_autoreconnect(RT_TRUE);
    
    LOG_D("The current version of APP firmware is %s", APP_VERSION);

    return 0;
}
```

另外，我们还需要在 /ports/cloudsdk/rt_cld_port.c 文件中实现几个用户自定义函数。

**1、SN 获取接口实现**

获取 SN（设备唯一标识符），注意与云端新建设备时使用的 SN 一致，格式为不大于 32 字节长的随机字符串形式，例如： EF4016D6658466CA3E3610。

```c showLineNumbers
void cld_port_get_device_sn(char *sn)
{
    rt_strncpy(sn, CLD_SN, rt_strlen(CLD_SN));
}
```

**2、产品 ID 获取接口实现**

获取产品 ID（ProductID），产品 ID 可以产品信息页面查询。

```c showLineNumbers
void cld_port_get_product_id(char *id)
{
    rt_strncpy(id, CLD_PRODUCT_ID, rt_strlen(CLD_PRODUCT_ID));
}
```

**3、产品密钥获取接口实现**

获取产品密钥（ProductKey），产品密钥可以产品信息页面查询。

```c showLineNumbers
void cld_port_get_product_key(char *key)
{
    rt_strncpy(key, CLD_PRODUCT_KEY, rt_strlen(CLD_PRODUCT_KEY));
}
```

**4、OTA 启动接口实现**

用于 OTA 升级任务启动前，配置相关参数或执行相关操作，若不需要可置为空。

```c showLineNumbers
void cld_port_ota_start(void)
{
    
}
```

**5、OTA 结束接口实现**

用于 OTA 升级结束后，根据 OTA 升级状态进行相应处理，例如：OTA 成功后设备复位进入 bootloader。

```c showLineNumbers
void cld_port_ota_end(enum cld_ota_status status)
{
    //Reset the device
    if(status == CLD_OTA_OK)
    {
        NVIC_SystemReset();
    }
}
```

OTA 升级状态：

- `CLD_OTA_OK`：OTA 升级成功
- `CLD_OTA_ERROR`：OTA 升级失败
- `CLD_OTA_NOMEM`：OTA 升级内存不足

完整代码：[25_iot_cloud_rtt](https://github.com/RT-Thread/IoT_Board/tree/master/examples/25_iot_cloud_rtt)



## 编译运行

因为本次实验需要演示 OTA 升级，所以在烧录应用程序之前我们先烧录 bootloader 程序：

```bash
st-flash write bootloader.bin 0x8000000
```

修改 ProductID、ProductKey 和 SN 值之后，编译工程：

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 421336	   2512	  45548	 469396	  72994	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32（注意地址是 0x8010000）：

```bash
st-flash write rt-thread.bin 0x8010000
```

打开串口终端，输出如下内容：

```bash
[SFUD]Find a Winbond W25Q128 flash chip. Size is 16777216 bytes.
[SFUD](..\components\sfud\src\sfud.c:724) Flash device reset success.
[SFUD]norflash0 flash device is initialize success.
RT-Thread Bootloader Starting...
[D/FAL] (fal_flash_init:61) Flash device |             onchip_flash | addr: 0x08000000 | len: 0x00080000 | blk_size: 0x00000800 |initialized.
[D/FAL] (fal_flash_init:61) Flash device |                nor_flash | addr: 0x00000000 | len: 0x01000000 | blk_size: 0x00001000 |initialized.
[I/FAL] ==================== FAL partition table ====================
[I/FAL] | name         | flash_dev    |   offset   |    length  |
[I/FAL] -------------------------------------------------------------
[I/FAL] | bootloader   | onchip_flash | 0x00000000 | 0x00010000 |
[I/FAL] | app          | onchip_flash | 0x00010000 | 0x00070000 |
[I/FAL] | easyflash    | nor_flash    | 0x00000000 | 0x00080000 |
[I/FAL] | download     | nor_flash    | 0x00080000 | 0x00100000 |
[I/FAL] | wifi_image   | nor_flash    | 0x00180000 | 0x00080000 |
[I/FAL] | font         | nor_flash    | 0x00200000 | 0x00700000 |
[I/FAL] | filesystem   | nor_flash    | 0x00900000 | 0x00700000 |
[I/FAL] =============================================================
[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.2) initialize success.
[I/OTA] Verify 'bootloader' partition(fw ver: 0.1.0, timestamp: 1535697252) success.
[I/OTA] Verify 'app' partition(fw ver: 1.0.0, timestamp: 1539410981) success.
Find user application success.
The Bootloader will go to user application now. # bootloader 跳转到 app
\ | /
- RT - Thread Operating System
/ | \ 4.0.1 build Jan  4 2022
2006 - 2019 Copyright by rt-thread team
lwIP -2.0.2 initialized!
[I/SAL_SKT] Socket Abstraction Layer initialize success.
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
msh />[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[I/WICED] wifi initialize done. wiced version 3.3.1
[I/WLAN.dev] wlan init success
[I/WLAN.lwip] eth device init ok name:w0
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
[D/main] The current version of APP firmware is 1.0.0
```

现在，使用 `wifi join` 命令连接 WiFi 网络：

```bash
msh />wifi join ssid_test 12345678
join ssid:ssid_test
[I/WLAN.mgnt] wifi connect success ssid:ssid_test
.......
msh />[I/WLAN.lwip] Got IP address : 152.10.200.224
```

网络连接成功，程序会自动进行 RT-Thread 云平台初始化，设备自动上线，如下所示：

```bash
[I/cld] The device has been activated successfully!
[I/cld.mqtt] CloudSDK MQTT server is startup!
[I/cld] RT-Thread CloudSDK package(V2.0.0) initialize success.
[I/WLAN.lwip] Got IP address : 192.168.1.123
[I/MQTT] MQTT server connect success
[I/MQTT] Subscribe #0 /device/12345678/abcdefgh/# OK!
```



## 设备维护

设备连接成功，接下来我们就可以通过 RT-Thread 云平台实现远程 Shell 控制、远程 Log 存储和 OTA 升级功能。

### Web Shell 功能

Web Shell 的实现基于 TCP/IP 协议和 MQTT 协议，主要作用是实现远程 Shell 控制功能，用户无需连接串口设备即可在云端完成设备的管理和调试，并且实时显示设备打印信息。

设备上线成功，云端点击 *设备信息 ->（设备) 详情 -> shell：连接*，在云端实现 Shell 控制台功能：

![](https://static.getiot.tech/pandora-rtt-cloud-web-shell.png#center)

点击连接之后，设备端控制台将切换到云端显示。类似于 Shell 控制台，此时在云端输入命令可以得到相应响应。

```bash
\ | /
- RT - Thread Operating System
/ | \ 4.0.1 build Jan  4 2022
2006 - 2019 Copyright by rt-thread team
msh />
```



### Web Log 功能

Web Log 与 Web Shell 类似，主要作用是实现对 Shell 控制台输入输出日志的存储和查询功能。它与 Web Shell 主要的区别是 Web Shell 功能是对 Shell 控制台输入输出的实时显示与管理控制，Web Log 功能是对 Shell 控制台输入输出的记录存储，方便后期查看。

设备上线成功，云端点击 *设备信息 -> 设备详情 -> 开启日志功能：开启*，云端开启设备 Web Log 日志记录功能，设备控制台的输入输出日志会发送到云端记录保存，再次点击 *开启日志功能：关闭* 可关闭日志功能。

Web Log 功能自带超时处理机制，开启 Web Log 功能后 5 分钟内无数据传输，服务器会主动关闭 Web Log 功能。

![](https://static.getiot.tech/pandora-rtt-cloud-web-log-01.png#center)

开启 Web Log 功能后，可在本地 MSH 命令行中输入 `ps` 命令查看当前线程状态，显示的日志会发送到云端并存储在 *日志列表* 中，之后在云端点击 *查看设备日志：日志列表*，可以查看历史日志信息。

![](https://static.getiot.tech/pandora-rtt-cloud-web-log-02.png#center)



### OTA 升级功能

RT-Thread 云平台 OTA 升级功能可以实现设备远程升级。相比于其他的设备升级方式，RT-Thread 云平台具有以下特点：

- 可适配不同型号的 flash 或文件系统
- 支持云端加密数据传输
- 支持固件加密和压缩功能
- 支持断点续传功能
- 支持多固件升级功能

参考《[RT-Thread OTA 固件升级](/rtt/rt-thread-ota/)》制作升级固件。假设我们现在得到了一个固件 rtthread.rbl，固件分区名称为 app，固件版本为 2.0.0，压缩算法为 FastLZ，加密算法为 AES256。

将生成的固件上传到 RT-Thread 设备维护云，用于在云端新建升级任务。点击 *模块管理 -> 添加固件*，选择 OTA 打包工具生成的 rtthread.rbl 文件，上传到云端，如下图所示方式：

![](https://static.getiot.tech/pandora-rtt-cloud-ota-01.png#center)

填写固件信息：

- 固件类型：固件分区名称，与工具生成固件时填入固件名称一致；
- 固件版本号：需要与工具生成固件时填入固件版本一致，且不同于云端最新版本号；

固件上传成功后，可以通过云端新建 OTA 升级任务（支持多固件升级），云端点击 *固件升级 -> 新建 OTA 版本* 选出刚才上传的固件建立 OTA 升级任务，之后云端会向设备推送升级请求，对设备进行升级。

![](https://static.getiot.tech/pandora-rtt-cloud-ota-02.png#center)

选项说明：

- 升级模式：
  - 强制升级：下发升级任务，设备立刻执行下载升级；
  - 可选升级：下发升级任务，用户可自定义执行下载升级的条件；
  - 静默升级：下发升级任务，设备无提示执行下载升级。
- 升级顺序：多个固件升级时，用户可自定义多个固件的升级顺序，云端下发升级任务，设备会根据固件升级顺序依次来升级固件。
- 可升级列表：用户可自定义添加需要升级的设备到设备列表中，云端将下发本次升级任务到设备列表中的设备上。

云端升级任务创建成功之后，云端会通过 MQTT 协议下发固件升级信息，设备获取升级信息后会下载新的固件。若为多固件升级，设备每次升级完一个固件会重启一次，直到最后一个固件升级成功。如果升级过程中若出现断电或者下载失败，设备支持断点续传功能，避免固件重复下载，减少固件升级时间。

设备固件下载完成之后，程序会自动跳转到 bootloader 中运行，bootloader 会对固件进行解压解密，并将固件拷贝到指定的应用分区（这里是 app 分区）。



## 思考总结

基于 RT-Thread 良好的组件框架，以及它所提供的 CloudSDK 库和 RT-Thread 云平台，可以快速建立物联网设备的管理系统，实现远程 Shell 控制、远程 Log 存储和 OTA 固件升级等实用功能。不过也可以看到，目前这种方式的限制还比较明显，后面我们将介绍其他云平台的设备维护功能。

设备维护是一项长期工作，使用什么工具和平台进行管理，取决于你的产品。

