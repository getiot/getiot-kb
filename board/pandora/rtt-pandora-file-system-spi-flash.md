---
sidebar_position: 18
sidebar_label: SPI Flash 文件系统
---

# 潘多拉 RT-Thread SPI Flash 文件系统



## 实验概述

本实验使用板载的 SPI Flash 作为文件系统的存储设备，在 Flash 的指定分区上创建文件系统，并挂载文件系统到 rt-thread 操作系统中。文件系统挂载成功后，就可以使用文件系统提供的功能对目录和文件进行操作。

本例程中使用的是 FAT 文件系统，也支持 Littlefs 文件系统。Littlefs 文件系统的使用可以参考《在 STM32L4 上应用 littlefs 文件系统》。由于本例程需要使用 fal 组件对存储设备进行分区等操作，所以在进行本例程的实验前，建议先阅读《[潘多拉 RT-Thread Flash 分区管理](/pandora/rtt-pandora-flash-partition/)》，以便更好地理解 fal 组件的使用。



## 硬件连接

本次示例和存储器连接通过 QSPI 接口，使用的硬件接口是 QSPI1，原理图如下所示：

![](https://static.getiot.tech/pandora-board-schematic-spi-flash.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

主程序首先使用 `fal_blk_device_create()` 函数在 spi flash 中名为 “filesystem” 的分区上创建一个块设备，作为文件系统的存储设备。然后使用 `dfs_mount()` 函数将该块设备中的文件系统挂载到根目录 / 上。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <fal.h>
#include <dfs_fs.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

#define FS_PARTITION_NAME "filesystem"

int main(void)
{
    /* 初始化 fal 功能 */
    fal_init();

    /* 在 spi flash 中名为 "filesystem" 的分区上创建一个块设备 */
    struct rt_device *flash_dev = fal_blk_device_create(FS_PARTITION_NAME);
    if (flash_dev == NULL)
    {
        LOG_E("Can't create a block device on '%s' partition.", FS_PARTITION_NAME);
    }
    else
    {
        LOG_D("Create a block device on the %s partition of flash successful.", FS_PARTITION_NAME);
    }

    /* 挂载 spi flash 中名为 "filesystem" 的分区上的文件系统 */
    if (dfs_mount(flash_dev->parent.name, "/", "elm", 0, 0) == 0)
    {
        LOG_I("Filesystem initialized!");
    }
    else
    {
        LOG_E("Failed to initialize filesystem!");
        LOG_D("You should create a filesystem on the block device first!");
    }

    return 0;
}
```

完整代码：[15_component_fs_flash](https://github.com/RT-Thread/IoT_Board/tree/master/examples/15_component_fs_flash)



## 编译运行

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
[I/FAL] The FAL block device (filesystem) created successfully
[D/main] Create a block device on the filesystem partition of flash successful.
[I/main] Filesystem initialized!
```

按下复位按键重启开发板，如果看到提示 "Failed to initialize filesystem! ，这是因为指定的挂载设备中还没有创建文件系统。在 msh 中执行下面命令，可以在名为 “filesystem” 的块设备上创建 elm-fat 类型的文件系统。

```bash
mkfs -t elm filesystem
```

按下复位按键重启开发板，尝试对文件系统进行操作。

```bash
msh />ls
Directory /:
msh />mkdir getiot
msh />echo "Hello GetIoT.tech" hello.txt
msh />cat hello.txt
Hello GetIoT.tech
msh />ls
Directory /:
getiot              <DIR>
hello.txt           17
```



## 思考总结

在 RT-Thread 中，使用 DFS、FAL 等组件可以快速地为 SPI Flash 上创建文件系统，为嵌入式设备的数据存储提供了灵活的方式。

在进行实验时，注意挂载文件系统之前一定要先在存储设备中创建相应类型的文件系统，否则会挂载失败。
