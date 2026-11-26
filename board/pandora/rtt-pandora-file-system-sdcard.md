---
sidebar_position: 15
sidebar_label: SD 卡文件系统
---

# 潘多拉 RT-Thread SD 卡文件系统



## 实验概述

本实验我们将 TF 卡插入潘多拉 IoT 开发板上 TF 卡槽中并作为文件系统的存储设备，我们将在 TF 卡上创建文件系统（格式化卡），然后挂载文件系统到 RT-Thread 操作系统中。文件系统挂载成功后，就可以使用文件系统提供的功能对目录和文件进行读写操作了！

:::tip

SD 卡和 TF 卡的区别是：SD 卡一般是相机使用的大的内存卡，TF 就是手机使用的小的内存卡。SD 卡是 Secure Digital Card 的英文缩写，直译就是“安全数字卡”。 TF 卡即是 T-Flash 卡，又叫 micro SD 卡，即微型 SD 卡。

:::

## 硬件连接

潘多拉 IoT Board 板载的一个标准 TF 卡接口（TF_CARD），采用 SPI 方式驱动（硬件 SPI1），原理图如下所示：

![](https://static.getiot.tech/pandora-board-schematic-sdcard.png#center)



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。它的作用是将块设备 sd0 中的文件系统以 fatfs 文件系统格式挂载到根目录 `/` 上。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <dfs_fs.h>

#define DBG_TAG "main"
#define DBG_LVL DBG_LOG
#include <rtdbg.h>

int main(void)
{
#ifdef BSP_USING_TF_CARD
    /* 挂载 TF 卡中的文件系统，参数 elm 表示挂载的文件系统类型为 elm-fat 文件系统*/
    if (dfs_mount("sd0", "/", "elm", 0, 0) == 0)
    {
        LOG_I("Filesystem initialized!");
    }
    else
    {
        LOG_E("Failed to initialize filesystem!");
    }
#endif /*BSP_USING_TF_CARD*/
    return 0;
}
```

挂载操作中所用的块设备 sd0 是基于 spi10 设备而创建的，创建块设备的代码在 board/ports/drv_sdcard.c 文件中。spi10 设备是挂载在硬件 SPI1 总线上的第一个 SPI 设备，因此命名为 spi10，该设备就是本次挂载的 SD 卡。`msd_init` 函数会在 spi10 设备上进行探测，并基于该设备创建名为 sd0 的块设备，用于文件系统的挂载，代码如下所示：

```c showLineNumbers title="board/ports/drv_sdcard.c"
#ifdef BSP_USING_SDCARD

static int rt_hw_spi1_tfcard(void)
{
    __HAL_RCC_GPIOC_CLK_ENABLE();
    rt_hw_spi_device_attach("spi1", "spi10", GPIOC, GPIO_PIN_3);
    return msd_init("sd0", "spi10");
}
INIT_DEVICE_EXPORT(rt_hw_spi1_tfcard);

#endif /* BSP_USING_SDCARD */
```

完整代码：[11_component_fs_tf_card](https://github.com/RT-Thread/IoT_Board/tree/master/examples/11_component_fs_tf_card)



## 编译运行

开启 DFS（device file system）虚拟文件系统，具体路径如下：

```bash
RT-Thread Components  --->
  Device virtual file system  --->
```

配置如下：

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-dfs.png#center)

使能 SD 卡探测功能，具体路径如下：

```bash
Hardware Drivers Config  --->
  Onboard Peripheral Drivers  --->
  [*] Enable SDCARD (spi1)
```

![](https://static.getiot.tech/pandora-rtt-scons-menuconfig-enable-sdcard.png#center)

保存配置，执行下面命令下载软件包

```bash
pkgs --update
```

编译工程

```bash
$ scons
...
LINK rt-thread.elf
arm-none-eabi-objcopy -O binary rt-thread.elf rtthread.bin
arm-none-eabi-size rt-thread.elf
   text	   data	    bss	    dec	    hex	filename
 159592	   2160	   4540	 166292	  28994	rt-thread.elf
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
 / | \     4.1.0 build Jan  6 2022 01:05:59
 2006 - 2021 Copyright by rt-thread team
[I/app.card] sd card mount to '/'
[I/main] Filesystem initialized!
msh />
```

按下复位按键重启开发板，如果看到提示 "Failed to initialize filesystem! ，这是因为 TF 卡中还没有创建文件系统。如果确定自己的卡是 fat 格式，可以忽略。否则在 msh 中使用下面命令，可以在块设备 sd0 中创建 elm-fat 类型的文件系统，即对 TF 卡执行格式化。

```bash
mkfs -t elm sd0
```

注意：mkfs 操作会清空存储设备中的数据，请谨慎操作。

接下来就可以在 SD 卡中进行读写操作：

```bash
msh />ls                   # 使用 ls 命令查看文件系统目录信息
Directory /:               # 可以看到已经存在根目录 /

msh />mkdir getiot         # 创建 getiot 目录
msh />ls                   # 查看目录信息
Directory /:
getiot              <DIR>

msh />cd getiot            # 切换到 getiot 目录

msh /getiot>echo "hello rt-thread!"           # 将字符串输出到标准输出
hello rt-thread!
msh /getiot>echo "hello rt-thread!" hello.txt # 将字符串输出到 hello.txt 文件

msh /getiot>ls             # 查看目录信息
Directory /getiot:
hello.txt           16

msh /getiot>cat hello.txt  # 查看文件内容
hello rt-thread!

msh /getiot>rm hello.txt   # 删除文件

msh /getiot>cd ..          # 切换到上一级目录

msh />rm -r getiot         # 删除目录
msh />ls                   # 查看目录信息
Directory /:
msh />
```



## 思考总结

DFS 是 RT-Thread 提供的虚拟文件系统组件，全称为 Device File System，即设备虚拟文件系统，文件系统的名称使用类似 UNIX 文件、文件夹的风格，根目录使用 `/` 来表示。

挂载文件系统之前一定要确认 TF 卡被格式化为 Fat 文件系统，否则会挂载失败。

