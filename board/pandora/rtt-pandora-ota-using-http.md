---
sidebar_position: 26
sidebar_label: HTTP 协议固件升级
---

# 潘多拉 RT-Thread HTTP 协议固件升级



## 实验概述

本实验基于 HTTP 客户端实现 RT-Thread HTTP OTA 固件下载器，通过 HTTP 协议从 HTTP 服务器下载升级固件到设备，在潘多拉 IoT 开发板上完成 OTA 升级。HTTP 客户端代码参考 [WebClient](http://packages.rt-thread.org/detail.html?package=webclient) 软件包 。

虽然 RT-Thread 提供了一些工具简化固件升级的开发工作，但这部分内容对初学者来说仍然具有挑战性。因此，在开始实验之前，建议先阅读《[RT-Thread OTA 固件升级](/rtt/rt-thread-ota/)》了解一下 OTA 固件升级的相关知识。

特别提示：实验中用到的 bootloader 程序以 bin 文件的形式提供，并且只适用于该 STM32L4 设备平台，文件位于 [/bin/bootloader.bin](https://github.com/RT-Thread/IoT_Board/tree/master/examples/30_iot_board_demo/bin)。



## 硬件说明

本实验使用到潘多拉 IoT Board 的硬件资源如下：

- UART1（Tx：PA9，Rx：PA10）
- 片内 FLASH（512 KBytes）
- 片外 Nor Flash（16 MBytes）
- AP6181 WiFi 模块



## 分区说明

在本实验中，bootloader 程序和 app 程序存放在 STM32L4 MCU 的内部 Flash 中，download 下载区域存放在外部扩展的 Nor Flash 中。Flash 分区表如下：

| 分区名称   | 存储位置   | 分区大小 | 起始地址   | 结束地址   | 说明                  |
| ---------- | ---------- | -------- | ---------- | ---------- | --------------------- |
| bootloader | 片内 Flash | 64K      | 0x08000000 | 0x0800FFFF | bootloader 程序存储区 |
| app        | 片内 Flash | 448K     | 0x08010000 | 0x0807FFFF | app 应用程序存储区    |
| easyflash  | Nor Flash  | 512K     | 0x00000000 | 0x0007FFFF | easyflash 存储区      |
| download   | Nor Flash  | 1M       | 0x00080000 | 0x0017FFFF | download 下载存储区   |
| wifi_image | Nor Flash  | 512K     | 0x00180000 | 0x001FFFFF | WiFi 固件存储区       |
| font       | Nor Flash  | 7M       | 0x00200000 | 0x008FFFFF | 字库分区              |
| filesystem | Nor Flash  | 7M       | 0x00900000 | 0x00FFFFFF | 文件系统分区          |

分区表定义在 bootloader 程序中，如果需要修改分区表，则需要修改 bootloader 程序。

注意：目前暂不支持用户自定义 bootloader，如果有商用需求，请联系 RT-Thread 获取支持。




## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include "wifi_config.h"
#include "board.h"

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define APP_VERSION  "2.0.0"

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

int main(void)
{
    wlan_autoconnect_init();

    LOG_D("The current version of APP firmware is %s", APP_VERSION);

    return 0;
}
```

除了 main.c 文件，需要 ota_http.c 文件，它实现了基于 HTTP 的 OTA 固件下载功能。另外还依赖 fal 和 webclient 软件包。ota_http.c 仅有三个 API 接口，介绍如下：

**print_progress 函数**

```c showLineNumbers
static void print_progress(size_t cur_size , size_t total_size);
```

该函数用于打印文件的下载进度。

**http_ota_fw_download 函数**

```c showLineNumbers
static int http_ota_fw_download(const char* uri);
```

该函数基于 webclient API 实现了从指定的 URL 下载文件的功能，并将下载的文件存储到 download 分区。

URL 格式示例：`http://192.168.1.10:80/rt-thread.rbl`。非 80 端口需要用户指定。如果使用了 TLS 加密连接，请使用 `https://192.168.1.10:80/rt-thread.rbl`。

**http_ota 函数**

```c showLineNumbers
void http_ota(uint8_t argc, char **argv);
MSH_CMD_EXPORT(http_ota , OTA by http client: http_ota [url]);
```

HTTP OTA 入口函数，使用 `MSH_CMD_EXPORT` 函数将其导出为 http_ota 命令。http_ota 命令需要传入固件下载地址，例如：

```bash
http_ota http://192.168.1.10:80/rt-thread.rbl
```

完整代码：[23_iot_ota_http](https://github.com/RT-Thread/IoT_Board/tree/master/examples/23_iot_ota_http)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 357752	   2460	  43680	 403892	  629b4	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32（注意地址是 0x8010000）

```bash
st-flash write rt-thread.bin 0x8010000
```

另外还要将 bootloader 上传到地址 0x8000000

```bash
st-flash write bootloader.bin 0x8000000
```

打开串口终端，输出如下内容

```basic
[SFUD]Find a Winbond W25Q128 flash chip. Size is 16777216 bytes.
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
[I/OTA] RT-Thread OTA package(V0.2.1) initialize success.
[I/OTA] Verify 'bootloader' partition(fw ver: 1.3, timestamp: 1545134551) success.
Find user application success.
The Bootloader will go to user application now.

 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  8 2022
 2006 - 2019 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[I/sal.skt] Socket Abstraction Layer initialize success.
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
msh />[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[I/WLAN.dev] wlan init success
[I/WLAN.lwip] eth device init ok name:w0
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
[D/main] The current version of APP firmware is 1.0.0
msh >
```

从以上日志里可以看到，前半部分是 bootloader 固件打印的日志，后半部分是 app 固件打印的日志，输出了 app 固件的版本号，并成功进入了 RT-Thread MSH 命令行。

如果看到串口打印的日志上对 download 分区校验失败，这是因为设备初次烧录固件，位于片外 Flash 的 download 分区内没有数据，所以会校验失败。这属于正常现象，下次使用 OTA 升级后就不会再出现该提示现象。

```bash
[E/OTA] (get_fw_hdr:149) Get firmware header occur CRC32(calc.crc: 7b93c5c8 != hdr.info_crc32: ffffffff) error on 'download' partition!
[E/OTA] (get_fw_hdr:149) Get firmware header occur CRC32(calc.crc: 7b93c5c8 != hdr.info_crc32: ffffffff) error on 'download' partition!
[E/OTA] (rt_ota_check_upgrade:464) Get OTA download partition firmware header failed!
```

现在 APP 固件的版本是 1.0.0，接下来我们就来尝试升级固件。



## 固件升级

HTTP 固件升级流程如下所示：

1. 在存放升级固件的目录启动一个 HTTP 服务器；
2. 在 MSH 中使用 http_ota 命令下载固件到 download 分区；
3. bootloader 对 OTA 升级固件进行校验、解密和搬运（搬运到 app 分区）；
4. 程序从 bootloader 跳转到 app 分区执行新的固件。



### 打包 rbl 升级固件

首先，我们基于本实验示例程序来制作用于 HTTP 升级演示所用到的 app 固件。将 main.c 中的 `APP_VERSION` 版本号修改为“2.0.0”。

```c showLineNumbers
#define APP_VERSION "2.0.0"
```

重新编译固件

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 357752	   2460	  43680	 403892	  629b4	rtthread-stm32l4xx.elf
scons: done building targets.
```

由于编译出来的应用程序 rt-thread.bin 属于原始 app 固件，并不能直接用于 RT-Thread OTA 的升级固件，需要用户使用 RT-Thread OTA 固件打包器将其打包生成 .rbl 后缀名的固件，然后才能进行 OTA 升级。

使用 /tools/ota_packager 目录下的 OTA 打包工具制作 OTA 升级固件（ .rbl 后缀名的文件）。注意，RT-Thread OTA 固件打包器只有 Windows 版本，因此你需要在 Windows 系统上使用它（也可以在 Linux 上使用 Wine 运行，参考 [Ubuntu 安装 Wine 软件](/ubuntu/ubuntu-install-wine/)）。

用户可以根据需要，选择是否对固件进行加密和压缩，提供多种压缩算法和加密算法支持，基本操作步骤如下：

- 选择待打包的固件（rt-thread.bin）
- 选择生成固件的位置
- 选择压缩算法（不压缩则留空）
- 选择加密算法（不加密则留空）
- 配置加密密钥（不加密则留空）
- 配置加密 IV （不加密则留空）
- 填写固件名称（对应分区名称，这里为 app）
- 填写固件版本（填写 main.c 中的版本号 2.0.0）
- 开始打包

![](https://static.getiot.tech/pandora-ota-packager-http.png#center)

通过以上步骤制作完成的 **rt-thread.rbl** 文件即可用于后续的升级文件。

注意事项：

- **加密密钥** 和 **加密 IV** 必须与 bootloader 程序中的一致，否则无法正确加解密固件默认提供的 bootloader.bin 支持加密压缩，使用的加密密钥为 `0123456789ABCDEF0123456789ABCDEF`，使用的加密 IV 为 `0123456789ABCDEF`。
- 固件打包过程中有 **固件名称** 的填写，这里注意需要填入 Flash 分区表中对应分区的名称，不能有误。如果要升级 app 程序，则填写 app；如果升级 WiFi 固件，则填写 wifi_image 。
- 固件版本号填写 main.c 中定义的版本号 2.0.0。

### HTTP 升级固件

要完成固件升级，我们还需要一个 HTTP 服务器，可以使用 Python 在 rt-thread.rbl 固件所在目录启动一个简单的 HTTP 服务器。

```bash
# Python 3.x
python -m http.server 
# Python 2.x
python -m SimpleHTTPServer
```

默认情况下，这将在本地 Web 服务器上的端口 8000 上运行目录的内容。也可以指定端口，例如指定 7800 端口：

```bash
# Python 3.x
python -m http.server 7800
# Python 2.x
python -m SimpleHTTPServer 7800
```

这样你就可以在 MSH 中使用本地 Web 服务器的 URL 地址下载固件：

```bash
http_ota http://192.168.1.10:8000/rt-thread.rbl
```

为了方便测试，你也可以使用我们服务器上的资源链接：

```bash
http_ota https://static.getiot.tech/rt-thread.rbl
```

输入命令后，会擦除 download 分区，下载升级固件，显示下载进度条：

```bash
msh />http_ota https://static.getiot.tech/rt-thread.rbl  
[I/http_ota] Start erase flash (download) partition!
[I/http_ota] Erase flash (download) partition success!
[I/http_ota] Download: [====================================================================================================] 100%
```

HTTP OTA 下载固件完成后，会自动重启，并在串口终端打印如下 log：

```bash
[I/http_ota] Download firmware to flash success.
[I/http_ota] System now will restart...
```

设备重启后，bootloader 会对升级固件进行合法性和完整性校验，验证成功后将升级固件从 download 分区搬运到目标分区（这里是 app 分区）。

升级成功后设备状态如下所示：

```bash
[SFUD]Find a Winbond W25Q128 flash chip. Size is 16777216 bytes.
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
[I/OTA] RT-Thread OTA package(V0.2.1) initialize success.
[I/OTA] Verify 'bootloader' partition(fw ver: 1.3, timestamp: 1545134551) success.
[I/OTA] Verify 'download' partition(fw ver: 2.0.0, timestamp: 1641624017) success.
[I/OTA] OTA firmware(app) upgrade(2.0.0->2.0.0) startup.
[I/OTA] The partition 'app' is erasing.
[I/OTA] The partition 'app' erase success.
[I/OTA] OTA Write: [====================================================================================================] 100%
[I/OTA] Verify 'app' partition(fw ver: 2.0.0, timestamp: 1641624017) success.
Find user application success.
The Bootloader will go to user application now.

 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  8 2022
 2006 - 2019 Copyright by rt-thread team
lwIP-2.0.2 initialized!
[I/sal.skt] Socket Abstraction Layer initialize success.
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
msh />[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[I/OTA] RT-Thread OTA package(V0.1.3) initialize success.
[I/OTA] Verify 'wifi_image' partition(fw ver: 1.0, timestamp: 1529386280) success.
[I/WLAN.dev] wlan init success
[I/WLAN.lwip] eth device init ok name:w0
[Flash] EasyFlash V3.2.1 is initialize success.
[Flash] You can get the latest version on https://github.com/armink/EasyFlash .
[D/main] The current version of APP firmware is 2.0.0
```

设备升级完成后会自动运行新的固件，可以看到，app 固件已经从 1.0.0 版本升级到了 2.0.0 版本。2.0.0 版本的固件同样是支持 HTTP OTA 下载功能的，因此可以一直使用 HTTP 进行 OTA 升级。用户如何需要增加自己的业务代码，可以基于该例程进行修改。



## 思考总结

通过本次实验，我们学习了如何通过 RT-Thread OTA 工具在潘多拉 IoT Board 上通过 HTTP 网络协议完成固件升级。

在使用 RT-Thread OTA 工具时，有以下注意事项：

- 必须使用 .rbl 格式的升级固件。
- 打包 OTA 升级固件时，分区名字必须与分区表中的名字相同（升级 app 固件对应 app 分区）。
- 搭建本地 HTTP 服务器时如果出现异常，请检查本地网络配置和防火墙设置等。
- app 固件必须从 0x08010000 地址开始链接，否则应用 bootloader 会跳转到 app 失败。

app 固件存储在 app 分区内，起始地址为 0x08010000，如果用户需要升级其他 app 程序，请确保编译器从 0x08010000 地址链接 app 固件。

OTA 的关键在于中断向量的重新设置，使用 bootloader 的时候，app 固件从 0x08010000 地址开始链接，因此需要将中断向量重新设置到 0x08010000 地址，程序如下所示：

```c showLineNumbers
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
```

通过 HTTP 进行 OTA 固件升级的流程和 Ymodem 类似，不同点在于固件下载所用的通道和协议不同，Bootloader 启动流程是一样的。

