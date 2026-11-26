---
sidebar_position: 25
sidebar_label: Ymodem 协议固件升级
---

# 潘多拉 RT-Thread Ymodem 协议固件升级



## 实验概述

本实验介绍如何使用 RT-Thread Ymodem OTA 固件下载器下载固件，在潘多拉 IoT 开发板上完成 OTA 升级。Ymodem OTA 升级是 RT-Thread OTA 支持的固件下载器中的一种。在嵌入式设备中通常用于通过串口（UART）进行文件传输及 IAP 在线升级，是常用固件升级方式。

虽然 RT-Thread 提供了一些工具简化固件升级的开发工作，但这部分内容对初学者来说仍然具有挑战性。因此，在开始实验之前，建议先阅读 [RT-Thread OTA 固件升级](/rtt/rt-thread-ota/) 了解一下 OTA 固件升级的相关知识。

特别提示：实验中用到的 bootloader 程序以 bin 文件的形式提供，并且只适用于该 STM32L4 设备平台，文件位于 [/bin/bootloader.bin](https://github.com/RT-Thread/IoT_Board/tree/master/examples/30_iot_board_demo/bin)。



## 硬件说明

本实验使用到潘多拉 IoT Board 的硬件资源如下：

- UART1（Tx：PA9，Rx：PA10）
- 片内 FLASH（512 KBytes）
- 片外 Nor Flash（16 MBytes）



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
#include <fal.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define APP_VERSION "1.0.0"

/* 将中断向量表起始地址重新设置为 app 分区的起始地址 */
static int ota_app_vtor_reconfig(void)
{
    #define NVIC_VTOR_MASK 0x3FFFFF80
    #define RT_APP_PART_ADDR 0x08010000
    /* 根据应用设置向量表 */
    SCB->VTOR = RT_APP_PART_ADDR & NVIC_VTOR_MASK;

    return 0;
}
INIT_BOARD_EXPORT(ota_app_vtor_reconfig);

int main(void)
{
    fal_init();

    LOG_D("The current version of APP firmware is %s", APP_VERSION);

    return 0;
}
```

除了 main.c 文件，需要 ymodem_update.c 文件，它实现了 Ymodem OTA 固件下载的功能。ymodem_update.c 仅有三个 API 接口，介绍如下：

**update 函数**

```c showLineNumbers
void update(uint8_t argc, char **argv);
MSH_CMD_EXPORT_ALIAS(update, ymodem_start , Update user application firmware);
```

update 函数调用底层接口 `rym_recv_on_device` 启动 Ymodem 升级程序，并使用 `MSH_CMD_EXPORT_ALIAS` 函数将其导出为 ymodem_start MSH 命令。

**ymodem_on_begin 函数**

```c showLineNumbers
static enum rym_code ymodem_on_begin(struct rym_ctx *ctx, rt_uint8_t *buf, rt_size_t len);
```

这是一个回调函数，通过底层接口 `rym_recv_on_device` 注册，在 Ymodem 程序启动后，获取到通过 Ymodem 协议发送给设备的文件后执行。主要是获取到文件大小信息，为文件存储做准备，完成相应的初始化工作（如 FAL download 分区擦除，为固件写入做准备）。

**ymodem_on_data 函数**

```c showLineNumbers
static enum rym_code ymodem_on_data(struct rym_ctx *ctx, rt_uint8_t *buf, rt_size_t len);
```

这是一个数据处理回调函数，通过底层接口 `rym_recv_on_device` 注册，在接收到通过 Ymodem 协议发送给设备的数据后，执行该回调函数处理数据（这里将接收到的数据写入到 download 分区）。

完整代码：[22_iot_ota_ymodem](https://github.com/RT-Thread/IoT_Board/tree/master/examples/22_iot_ota_ymodem)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 117172	   2108	   2956	 122236	  1dd7c	rtthread-stm32l4xx.elf
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
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[D/main] The current version of APP firmware is 1.0.0
msh >
```

从以上日志里可以看到，前半部分是 bootloader 固件打印的日志，后半部分是 app 固件打印的日志，输出了 app 固件的版本号，并成功进入了 RT-Thread MSH 命令行。

如果看到串口打印的日志上对 download 分区校验失败，这是因为设备初次烧录固件，位于片外 Flash 的 download 分区内没有数据，所以会校验失败。

```bash
[E/OTA] (get_fw_hdr:149) Get firmware header occur CRC32(calc.crc: 7b93c5c8 != hdr.info_crc32: ffffffff) error on 'download' partition!
[E/OTA] (get_fw_hdr:149) Get firmware header occur CRC32(calc.crc: 7b93c5c8 != hdr.info_crc32: ffffffff) error on 'download' partition!
[E/OTA] (rt_ota_check_upgrade:464) Get OTA download partition firmware header failed!
```

现在 APP 固件的版本是 1.0.0，接下来我们就来尝试升级固件。



## 固件升级

Ymodem 固件升级流程如下：

1. Ymodem 串口终端使用 ymodem 协议发送升级固件；
2. APP 使用 Ymodem 协议下载固件到 download 分区；
3. bootloader 对 OTA 升级固件进行校验、解密和搬运（搬运到 app 分区）；
4. 程序从 bootloader 跳转到 app 分区执行新的固件；

### 打包 rbl 升级固件

首先，我们基于本实验示例程序来制作用于 Ymodem 升级演示所用到的 app 固件。将 main.c 中的 `APP_VERSION` 版本号修改为“2.0.0”。

```c showLineNumbers
#define APP_VERSION "2.0.0"
```

重新编译固件

```bash
$ scons
scons: Reading SConscript files ...
scons: done reading SConscript files.
scons: Building targets ...
scons: building associated VariantDir targets: build
CC build/applications/main.o
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 117172	   2108	   2956	 122236	  1dd7c	rtthread-stm32l4xx.elf
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

![](https://static.getiot.tech/pandora-ota-packager.png#center)

通过以上步骤制作完成的 **rt-thread.rbl** 文件即可用于后续的升级文件。

注意事项：

- **加密密钥** 和 **加密 IV** 必须与 bootloader 程序中的一致，否则无法正确加解密固件默认提供的 bootloader.bin 支持加密压缩，使用的加密密钥为 `0123456789ABCDEF0123456789ABCDEF`，使用的加密 IV 为 `0123456789ABCDEF`。
- 固件打包过程中有 **固件名称** 的填写，这里注意需要填入 Flash 分区表中对应分区的名称，不能有误。如果要升级 app 程序，则填写 app；如果升级 WiFi 固件，则填写 wifi_image 。
- 固件版本号填写 main.c 中定义的版本号 2.0.0。

### Ymodem 升级固件

许多[串口工具](/tools/all-of-serial-tools/)都支持 Ymodem 协议传输文件，Linux 系统也有不少选择（参考 [Ubuntu 传输 Ymodem 协议](/ubuntu/ubuntu-transfer-ymodem/)），不过最好用的还是 Windows 的 Xshell 工具。

在 Xshell 创建点击右键，选择 *传输 > YMODEM(Y) > 用YMODEM发送(S)...*，选择前面制作好的 rt-thread.rbl 升级固件。

![](https://static.getiot.tech/pandora-ota-ymodem-xshell.png#center)

Ymodem 下载固件完成后，会自动重启，并在串口终端打印如下 log：

```bash
Download firmware to flash success.
System now will restart...
```

设备重启后，bootloader 会对升级固件进行合法性和完整性校验，验证成功后将升级固件从 download 分区搬运到目标分区（这里是 app 分区）。设备升级完成后会自动运行新的固件，从下图中的日志上可以看到，app 固件已经从 1.0.0 版本升级到了 2.0.0 版本，说明固件升级成功。

```bash
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  8 2022
 2006 - 2019 Copyright by rt-thread team
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
[D/main] The current version of APP firmware is 2.0.0
msh >
```

2.0.0 版本的固件同样是支持 Ymodem 固件下载功能的，因此可以一直使用 Ymodem 进行 OTA 升级。用户如果需要增加自己的业务代码，可以基于该例程进行修改。



## 思考总结

通过本次实验，我们学习了如何通过 RT-Thread OTA 工具在潘多拉 IoT Board 上通过 Ymodem 串口协议完成固件升级。

在使用 RT-Thread OTA 工具时，有以下注意事项：

- 必须使用 .rbl 格式的升级固件。
- 打包 OTA 升级固件时，分区名字必须与分区表中的名字相同（升级 app 固件对应 app 分区）。
- 串口终端工具需要支持 Ymodem 协议，并使用确认使用 Ymodem 协议发送固件。
- 串口波特率 115200，无奇偶校验，无流控。
- app 固件必须从 0x08010000 地址开始链接，否则应用 bootloader 会跳转到 app 失败。

app 固件存储在 app 分区内，起始地址为 0x08010000，如果用户需要升级其他 app 程序，请确保编译器从 0x08010000 地址链接 app 固件。

OTA 的关键在于中断向量的重新设置，使用 bootloader 的时候，app 固件从 0x08010000 地址开始链接，因此需要将中断向量重新设置到 0x08010000 地址，程序如下所示：

```c showLineNumbers
/* 将中断向量表起始地址重新设置为 app 分区的起始地址 */
static int ota_app_vtor_reconfig(void)
{
    #define NVIC_VTOR_MASK 0x3FFFFF80
    #define RT_APP_PART_ADDR 0x08010000
    /* 根据应用设置向量表 */
    SCB->VTOR = RT_APP_PART_ADDR & NVIC_VTOR_MASK;

    return 0;
}
INIT_BOARD_EXPORT(ota_app_vtor_reconfig);
```

