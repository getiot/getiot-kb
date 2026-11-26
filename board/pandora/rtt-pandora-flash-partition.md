---
sidebar_position: 16
sidebar_label: Flash 分区管理
---

# 潘多拉 RT-Thread Flash 分区管理



## 实验概述

本例程演示如何通过 RT-Thread 提供的 FAL 软件包对 Flash 进行分区管理操作。例程中，通过调用 FAL 接口完成了对指定分区的测试工作，完成了对 Flash 读、写、擦的测试，同时也通过该例程完成了对 Flash 驱动的基本测试。

FAL 是 Flash Abstraction Layer 的缩写，即 Flash 抽象层。FAL 是 RT-Thread 的一个软件包，用于对 Flash 及基于 Flash 的分区进行管理、操作的抽象层，对上层统一了 Flash 及分区操作的 API，并具有以下特性：

- 支持静态可配置的分区表，并可关联多个 Flash 设备；
- 分区表支持 自动装载。避免在多固件项目，分区表被多次定义的问题；
- 代码精简，对操作系统 无依赖，可运行于裸机平台，比如对资源有一定要求的 bootloader；
- 统一的操作接口。保证了文件系统、OTA、NVM 等对 Flash 有一定依赖的组件，底层 Flash 驱动的可重用性；
- 自带基于 Finsh/MSH 的测试命令，可以通过 Shell 按字节寻址的方式操作（读写擦）Flash 或分区，方便开发者进行调试、测试；

本文将演示如何使用 fal 管理多个 Flash 设备，指导用户通过 fal 分区表操作 Flash 设备。这也是后续 OTA、easyflash 等例程的基础，所以务必掌握。



## 硬件连接

本例程使用到的硬件资源如下所示：

- UART1（Tx：PA9；Rx：PA10）
- 片内 FLASH（512 KB）
- 片外 Nor Flash（16 MB）

![](https://static.getiot.tech/pandora-board-schematic-spi-flash.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <fal.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define BUF_SIZE 1024

static int fal_test(const char *partiton_name);

int main(void)
{
    fal_init();

    if (fal_test("param") == 0) {
        LOG_I("Fal partition (%s) test success!", "param");
    }
    else {
        LOG_E("Fal partition (%s) test failed!", "param");
    }

    if (fal_test("download") == 0) {
        LOG_I("Fal partition (%s) test success!", "download");
    }
    else {
        LOG_E("Fal partition (%s) test failed!", "download");
    }
		
    return 0;
}

static int fal_test(const char *partiton_name)
{
    int ret;
    int i, j, len;
    uint8_t buf[BUF_SIZE];
    const struct fal_flash_dev *flash_dev = RT_NULL;
    const struct fal_partition *partition = RT_NULL;

    if (!partiton_name) {
        LOG_E("Input param partition name is null!");
        return -1;
    }

    partition = fal_partition_find(partiton_name);
    if (partition == RT_NULL) {
        LOG_E("Find partition (%s) failed!", partiton_name);
        ret = -1;
        return ret;
    }

    flash_dev = fal_flash_device_find(partition->flash_name);
    if (flash_dev == RT_NULL) {
        LOG_E("Find flash device (%s) failed!", partition->flash_name);
        ret = -1;
        return ret;
    }

    LOG_I("Flash device : %s, Flash size : %dK, Partition : %s, Partition size: %dK", 
           partition->flash_name, flash_dev->len/1024, partition->name, partition->len/1024);

    /* 擦除 `partition` 分区上的全部数据 */
    ret = fal_partition_erase_all(partition);
    if (ret < 0) {
        LOG_E("Partition (%s) erase failed!", partition->name);
        ret = -1;
        return ret;
    }
    LOG_I("Erase (%s) partition finish!", partiton_name);

    /* 循环读取整个分区的数据，并对内容进行检验 */
    for (i = 0; i < partition->len;) {

        rt_memset(buf, 0x00, BUF_SIZE);
        len = (partition->len - i) > BUF_SIZE ? BUF_SIZE : (partition->len - i);

        /* 从 Flash 读取 len 长度的数据到 buf 缓冲区 */
        ret = fal_partition_read(partition, i, buf, len);
        if (ret < 0) {
            LOG_E("Partition (%s) read failed!", partition->name);
            ret = -1;
            return ret;
        }
        for(j = 0; j < len; j++) {
            /* 校验数据内容是否为 0xFF */
            if (buf[j] != 0xFF) {
                LOG_E("The erase operation did not really succeed!");
                ret = -1;
                return ret;
            }
        }
        i += len;
    }

    /* 把 0 写入指定分区 */
    for (i = 0; i < partition->len;) {

        /* 设置写入的数据 0x00 */
        rt_memset(buf, 0x00, BUF_SIZE);
        len = (partition->len - i) > BUF_SIZE ? BUF_SIZE : (partition->len - i);

        /* 写入数据 */
        ret = fal_partition_write(partition, i, buf, len);
        if (ret < 0) {
            LOG_E("Partition (%s) write failed!", partition->name);
            ret = -1;
            return ret;
        }
        i += len;
    }
    LOG_I("Write (%s) partition finish! Write size %d(%dK).", partiton_name, i, i / 1024);

    /* 从指定的分区读取数据并校验数据 */
    for (i = 0; i < partition->len;) {

        /* 清空读缓冲区，以 0xFF 填充 */
        rt_memset(buf, 0xFF, BUF_SIZE);
        len = (partition->len - i) > BUF_SIZE ? BUF_SIZE : (partition->len - i);

        /* 读取数据到 buf 缓冲区 */
        ret = fal_partition_read(partition, i, buf, len);
        if (ret < 0) {
            LOG_E("Partition (%s) read failed!", partition->name);
            ret = -1;
            return ret;
        }
        for(j = 0; j < len; j++) {
            /* 校验读取的数据是否为步骤 3 中写入的数据 0x00 */
            if (buf[j] != 0x00) {
                LOG_E("The write operation did not really succeed!");
                ret = -1;
                return ret;
            }
        }
        i += len;
    }

    ret = 0;
    return ret;
}
```

完整代码：[13_component_fal](https://github.com/RT-Thread/IoT_Board/tree/master/examples/13_component_fal)

### 代码说明

本实验除了 applications/main.c 代码，还依赖 fal 软件包（提供 Flash 抽象层实现）以及 port/fal 目录下的几个文件（通常 ports 存放移植文件）。

| 文件                     | 说明                                                         |
| ------------------------ | ------------------------------------------------------------ |
| fal_cfg.h                | fal 配置文件（Flash 设备配置和分区表配置）                   |
| fal_flash_sfud_port.c    | fal 操作片外 Nor Flash 的移植文件（将 Flash 读写擦接口注册到 fal） |
| fal_flash_stm32l4_port.c | fal 操作片内 Flash 的移植文件（将 Flash 读写擦接口注册到 fal） |

fal_cfg.h 文件中，主要包括 Flash 设备的配置、分区表的配置。

本例程的 Flash 设备列表定义如下所示：

```c showLineNumbers title="fal_cfg.h"
extern const struct fal_flash_dev stm32_onchip_flash;
extern const struct fal_flash_dev nor_flash0;

/* flash device table */
#define FAL_FLASH_DEV_TABLE    \
{                              \
    &stm32_onchip_flash,       \
    &nor_flash0,               \
}
```

其中，`stm32l4_onchip_flash` 是 STM32L4 片内 Flash 设备，定义在 ports/fal_flash_stm32l4_port.c 文件中；`nor_flash0` 是外部扩展的 Nor FLASH 设备，定义在 ports/fal_flash_sfud_port.c 文件中。

分区表配置如下：

```c showLineNumbers title="fal_flash_stm32l4_port.c"
/* ====================== Partition Configuration ========================== */
#ifdef FAL_PART_HAS_TABLE_CFG
/* partition table */
#define FAL_PART_TABLE                                                                                              \
{                                                                                                                   \
    {FAL_PART_MAGIC_WROD,        "app", "onchip_flash",                                    0,       384 * 1024, 0}, \
    {FAL_PART_MAGIC_WROD,      "param", "onchip_flash",                           384 * 1024,       128 * 1024, 0}, \
    {FAL_PART_MAGIC_WROD,  "easyflash",    "nor_flash",                                    0,       512 * 1024, 0}, \
    {FAL_PART_MAGIC_WROD,   "download",    "nor_flash",                           512 * 1024,      1024 * 1024, 0}, \
    {FAL_PART_MAGIC_WROD, "wifi_image",    "nor_flash",                  (512 + 1024) * 1024,       512 * 1024, 0}, \
    {FAL_PART_MAGIC_WROD,       "font",    "nor_flash",            (512 + 1024 + 512) * 1024,  7 * 1024 * 1024, 0}, \
    {FAL_PART_MAGIC_WROD, "filesystem",    "nor_flash", (512 + 1024 + 512 + 7 * 1024) * 1024,  7 * 1024 * 1024, 0}, \
}
#endif /* FAL_PART_HAS_TABLE_CFG */
```

这里有一个宏定义 `FAL_PART_HAS_TABLE_CFG`，如果有定义则表示应用程序使用 fal_cfg.h 文件中定义的分区表。

是否使用 fal_cfg.h 文件中定义的分区表，有这样一个准则：

- 如果使用 bootloader 则不定义 `FAL_PART_HAS_TABLE_CFG` 宏，而使用 bootloader 中定义的分区表；
- 如果不使用 bootloader 则需要用户定义 `FAL_PART_HAS_TABLE_CFG` 宏，从而使用 fal_cfg.h 文件中定义的分区表。

fal_cfg.h 文件中定义的分区表最终会注册到 `fal_partition` 结构体数组中。结构体定义如下：

```c showLineNumbers title="fal_cfg.h"
struct fal_partition
{
    uint32_t magic_word;

    /* partition name */
    char name[FAL_DEV_NAME_MAX];
    /* flash device name for partition */
    char flash_name[FAL_DEV_NAME_MAX];

    /* partition offset address on flash device */
    long offset;
    size_t len;

    uint32_t reserved;
};
```

`fal_partition` 结构体成员简要介绍如下：

| 成员变量   | 说明                                             |
| ---------- | ------------------------------------------------ |
| magic_word | 魔法数，系统使用，用户无需关心                   |
| name       | 分区名字，最大 23 个 ASCII 字符                  |
| flash_name | 分区所属的 Flash 设备名字，最大 23 个 ASCII 字符 |
| offset     | 分区起始地址相对 Flash 设备起始地址的偏移量      |
| len        | 分区大小，单位字节                               |
| reserved   | 保留项                                           |



### Flash 设备对接说明

fal 是 Flash 抽象层，要操作 Flash 设备必然要将 Flash 的读、写、擦接口对接到 fal 抽象层中。在 fal 中，使用 `fal_flash_dev` 结构体来让用户注册该 Flash 设备的操作接口。结构体定义如下：

```c showLineNumbers
struct fal_flash_dev
{
    char name[FAL_DEV_NAME_MAX];

    /* flash device start address and len  */
    uint32_t addr;
    size_t len;
    /* the block size in the flash for erase minimum granularity */
    size_t blk_size;

    struct
    {
        int (*init)(void);
        int (*read)(long offset, uint8_t *buf, size_t size);
        int (*write)(long offset, const uint8_t *buf, size_t size);
        int (*erase)(long offset, size_t size);
    } ops;

    /* write minimum granularity, unit: bit. 
       1(nor flash)/ 8(stm32f4)/ 32(stm32f1)/ 64(stm32l4)
       0 will not take effect. */
    size_t write_gran;
};
```

`fal_flash_dev` 结构体成员简要介绍如下：

| 成员变量   | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| name       | Flash 设备名字，最大 23 个 ASCII 字符                        |
| addr       | Flash 设备的起始地址（片内 Flash 为 0x08000000，片外 Flash 为 0x00） |
| len        | Flash 设备容量，单位字节                                     |
| blk_size   | Flash 设备最小擦除单元的大小，单位字节                       |
| ops        | Flash 设备的操作函数（init：初始化，read：读取，write：写入，erase：擦除） |
| write_gran | Flash 设备的写入最小粒度                                     |

片内 Flash 设备实例定义在 ports/fal_flash_stm32l4_port.c 文件中，Flash 设备名称为 **onchip_flash** ，设备容量为 512K，最小擦除单元为 2K，无初始化接口。

```c showLineNumbers
const struct fal_flash_dev stm32l4_onchip_flash = { \
    "onchip_flash", \
    0x08000000, \
    (512 * 1024), \
    2048, \
    {NULL, read, write, erase} \
};
```

片外 Nor Flash 设备实例定义在 ports/fal_flash_sfud_port.c 文件中，使用了 RT-Thread 内置的 SFUD 框架。Flash 设备名称为 **nor_flash**，设备容量为 16M，最小擦除单元为 4K。这里使用的 read、write、erase 接口最终调用 SFUD 框架中的接口，无需用户进行驱动开发。

```c showLineNumbers
const struct fal_flash_dev nor_flash0 = { \
    "nor_flash", \
    0, \
    (16 * 1024 * 1024), \
    4096, \
    {fal_sfud_init, read, write, erase} \
};
```



## 编译运行

使能 QSPI Flash 选项

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-enable-qspi-flash.png#center)

使能片上 Flash

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-enable-onchip-flash.png#center)

开启 FAL 软件包

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-fal.png#center)

保存配置，执行下面命令下载软件包

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
  60960	    644	   1968	  63572	   f854	rtthread-stm32l4xx.elf
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
[SFUD] Find a Winbond flash chip. Size is 16777216 bytes.
[SFUD] w25q128 flash device is initialize success.
[D/FAL] (fal_flash_init:63) Flash device |             onchip_flash | addr: 0x08000000 | len: 0x00080000 | blk_size: 0x00000800 |initialized.
[D/FAL] (fal_flash_init:63) Flash device |                nor_flash | addr: 0x00000000 | len: 0x01000000 | blk_size: 0x00001000 |initialized.
[I/FAL] ==================== FAL partition table ====================
[I/FAL] | name       | flash_dev    |   offset   |    length  |
[I/FAL] -------------------------------------------------------------
[I/FAL] | app        | onchip_flash | 0x00000000 | 0x00060000 |
[I/FAL] | param      | onchip_flash | 0x00060000 | 0x00020000 |
[I/FAL] | easyflash  | nor_flash    | 0x00000000 | 0x00080000 |
[I/FAL] | download   | nor_flash    | 0x00080000 | 0x00100000 |
[I/FAL] | wifi_image | nor_flash    | 0x00180000 | 0x00080000 |
[I/FAL] | font       | nor_flash    | 0x00200000 | 0x00700000 |
[I/FAL] | filesystem | nor_flash    | 0x00900000 | 0x00700000 |
[I/FAL] =============================================================
[I/FAL] RT-Thread Flash Abstraction Layer (V0.2.0) initialize success.
```

示例代码调用 `fal_test()` 分别测试 param 和 download 分区。`fal_test` 函数输入参数为 Flash 分区的名字，功能是对输入分区进行完整的擦、读、写测试，覆盖整个分区。

```bash
[I/main] Flash device : onchip_flash, Flash size : 512K, Partition : param, Partition size: 128K
[I/main] Erase (param) partition finish!
[I/main] Write (param) partition finish! Write size 131072(128K).
[I/main] Fal partition (param) test success!
[I/main] Flash device : nor_flash, Flash size : 16384K, Partition : download, Partition size: 1024K
[I/main] Erase (download) partition finish!
[I/main] Write (download) partition finish! Write size 1048576(1024K).
[I/main] Fal partition (download) test success!
```



## MSH 命令

为了方便用户验证 fal 功能是否正常，以及 Flash 驱动是否正确工作，分区表配置是否合理，RT-Thread 为 fal 提供了一套测试命令。

fal 测试命令如下：

```bash
msh />fal
Usage:
fal probe [dev_name|part_name]   - probe flash device or partition by given name
fal read addr size               - read 'size' bytes starting at 'addr'
fal write addr data1 ... dataN   - write some bytes 'data' starting at 'addr'
fal erase addr size              - erase 'size' bytes starting at 'addr'
fal bench <blk_size>             - benchmark test with per block size
```

**探测设备**

使用 `fal probe` 命令探测指定的 Flash 设备或者 Flash 分区，当探测到指定的 Flash 设备或分区后，会显示其属性信息。例如：

```bash
msh />fal probe nor_flash
Probed a flash device | nor_flash | addr: 0 | len: 16777216 |.
msh />fal probe download 
Probed a flash partition | download | flash_dev: nor_flash | offset: 524288 | len: 1048576 |.
```

**擦除数据**

首先选择要擦除数据的分区，演示使用的是 download 分区，然后使用 `fal erase` 命令擦除。例如：

```bash
msh />fal probe download 
Probed a flash partition | download | flash_dev: nor_flash | offset: 524288 | len: 1048576 |.
msh />fal erase 0 4096
Erase data success. Start from 0x00000000, size is 4096.
```

其中，使用擦除命令时，addr 为相应探测 Flash 分区的偏移地址，size 为不超过该分区的值，以下写入数据、读取数据与此类似。

**写入数据**

在完成擦除操作后，才能在已擦除区域写入数据，先输入 `fal write`，后面跟着 N 个待写入的数据，并以空格隔开（能写入的数据数量取决与 MSH 命令行的配置）。

下面演示从地址 0x00000008 的位置开始写入数据 1 2 3 4 5 6 7 ，共 7 个数据。

```bash
msh />fal write 8 1 2 3 4 5 6 7
Write data success. Start from 0x00000008, size is 7.
Write data: 1 2 3 4 5 6 7 .
```

**读取数据**

先输入 `fal read`，后面跟着待读取数据的起始地址以及长度。下面演示从 0 地址开始读取 64 字节数据，读取前面写入的数据。

```bash
msh />fal read 0 64
Read data success. Start from 0x00000000, size is 64. The data is:
Offset (h) 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
[00000000] FF FF FF FF FF FF FF FF 01 02 03 04 05 06 07 FF ................
[00000010] FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
[00000020] FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
[00000030] FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF ................
```

**性能测试**

性能测试将会测试 Flash 的擦除、写入及读取速度，同时将会测试写入及读取数据的准确性，保证整个 Flash 或整个分区的写入与读取数据的一致性。

先输入 `fal bench`，后面跟着待测试 Flash 的扇区大小（请查看对应的 Flash 手册，SPI Nor Flash 一般为 4096）。由于性能测试将会让整个 Flash 或者整个分区的数据丢失，所以命令最后必须跟 yes 。

```bash
msh />fal bench 4096
DANGER: It will erase full chip or partition! Please run 'fal bench 4096 yes'.
msh />fal bench 4096 yes
Erasing 1048576 bytes data, waiting...
Erase benchmark success, total time: 2.379S.
Writing 1048576 bytes data, waiting...
Write benchmark success, total time: 4.097S.
Reading 1048576 bytes data, waiting...
Read benchmark success, total time: 1.248S.
```

从日志上可以看到，`fal bench` 命令将 download 分区 1048576 字节大小的区域进行了擦、写、读测试，并给出了测试时间。



## 思考总结

本实验使用了 FAL 软件包和 SFUD 框架来管理和操作 STM32 片内 Flash 和扩展 Flash 分区。我们学习了如何使用 fal 管理多个 Flash 设备、创建分区表、使用 fal 操作分区表。同时使用了 SFUD 串行 SPI Flash 通用驱动库，它覆盖市面上绝大多数串行 Flash 型号，无需软件开发就能驱动 Flash 设备。

在本实验中，如果要修改分区表，请正确配置起始地址和分区大小，不要有分区重叠。另外，在使用 `fal` 测试命令的时候，请先使用 `fal probe` 命令选择一个 Flash 分区。

对初学者来说，Flash 分区管理可能比较难理解，建议多加练习和思考。
