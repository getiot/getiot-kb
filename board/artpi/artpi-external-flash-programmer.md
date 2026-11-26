---
sidebar_position: 11
---

# ART-Pi 外部 Flash 擦写



RT-Thread 官方开发板 ART-Pi 上有两片外部 Flash 存储芯片，分别是 16MB 的 W25Q128JV 和 8MB 的 W25Q64JV。其中，W25Q64JV 用于存放应用程序（称为“程序 Flash”），W25Q128JV 用于存放 WiFi 固件、蓝牙固件等，以及作为 OTA 存储区和文件系统（称为“数据 Flash”）。



## FLASH（W25Q128JV）分区

为了合理利用 Flash 存储空间，RT-Thread 官方对 W25Q128JV 进行了分区管理，具体空间划分如下：

| 分区名     | 起始地址        | 分区大小 | 用途说明             |
| ---------- | --------------- | -------- | -------------------- |
| wifi_image | 0               | 512KB    | 保存 wifi 固件       |
| bt_image   | 512 * 1024      | 512KB    | 保存 bt 固件         |
| download   | 1 * 1024 * 1024 | 2048KB   | 固件下载分区         |
| easyflash  | 3 * 1024 * 1024 | 1024KB   | easyflash 参数保存区 |
| filesystem | 4 * 1024 * 1024 | 12MB     | 文件系统分区         |

ART-Pi 出厂时数据 Flash 中已经刷入相应的数据信息，但有时我们可能意外破坏或擦除上面的数据，这时就需要重新往 Flash 写入数据。为此，官方提供了两个 Flash 的 stldr 下载算法，用户可以通过 STM32Cube Programmer 工具加载下载算法，进行 Flash 读写操作。



## STM32CubeProgrammer 下载算法加载

下载算法位于 sdk-bsp-stm32h750-realthread-artpi/debug/stldr 目录。

```bash
$ tree
.
├── ART-Pi_W25Q128JV.stldr
└── ART-Pi_W25Q64.stldr
```

将 ART-Pi_W25Q128JV.stldr 和 ART-Pi_W25Q64.stldr 拷贝到 STM32CubeProgrammer 的外部 flash 算法目录。

- Windows 目录如：`C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\ExternalLoader`；
- Linux 目录如：`~/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/ExternalLoader`

然后打开 STM32CubeProgrammer，点击左下方的“External Loaders”，选择下载算法，点击“Connect”连接 ST-Link 即可。

![](https://static.getiot.tech/artpi-stm32cube-programmer.png#center)



## STM32CubeProgrammer 擦写数据 Flash

ART-Pi_W25Q128JV.stldr 下载算法可以一次性擦除整块 Flash，也可以按 64KB 块大小分别擦除。下面以刷入 WiFi 固件为例进行演示。

注意：数据 Flash 的起始地址是 `0x70000000`，WiFi 固件分区是第一个分区，所以该分区的偏移地址是 0，因此我们要写入的地址是 `0x70000000 + 0`（分区偏移）。 

WiFi 固件位于 sdk-bsp-stm32h750-realthread-artpi/tools/firmware 目录。

```bash
$ tree
.
├── ap6212-bt-image-1.0.rbl
├── ap6212-wifi-image-1.0.rbl
└── Resource_16MB.bin
```

由于 STM32CubeProgrammer 只能打开 bin 等后缀名的文件，所以要将 ap6212-wifi-image-1.0.rbl 固件文件名后缀改成 bin，即 ap6212-wifi-image-1.0.bin。

点击 STM32CubeProgrammer 左上方的“Erasing & Programming”页面，选择刚刚修改的文件，地址为 `0x70000000`，点击“Start Programming”按钮开始烧写。

![](https://static.getiot.tech/artpi-stm32cube-programmer-erasing.png#center)

同样，我们可以将蓝牙固件 ap6212-bt-image-1.0.bin 更新到 ART-Pi，写入的地址是 `0x70080000`。




## STM32CubeProgrammer 恢复出厂 Flash 固件

出厂 Flash 固件在 `sdk-bsp-stm32h750-realthread-artpi/tools/firmware/Resource_16MB.bin` 。可以在 STM32CubeProgrammer 使用同样的方法将其烧写到 ART-Pi，写入地址是 `0x70000000`。

因为资源文件较大，下载时间会较长，请耐心等待。


