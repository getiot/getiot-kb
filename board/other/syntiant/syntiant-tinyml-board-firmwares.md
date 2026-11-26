---
sidebar_position: 3
---

# Syntiant TinyML Board 固件下载



## 烧写官方固件

Syntiant TinyML 板配备了一个 SPH0641LM4H 麦克风和一个 BMI160 六轴运动传感器，因此官方针对声音和动作的识别，分别提供了两个固件：

- [Audio firmware](https://cdn.edgeimpulse.com/firmware/syntiant-tinyml.zip)
- [IMU firmware](https://cdn.edgeimpulse.com/firmware/syntiant-tinyml-imu.zip)

点击上方链接即可下载对应固件的 zip 包，解压缩后执行其中的 flash 烧录脚本即可更新 Syntiant TinyML 板的固件。例如，在 Ubuntu 系统中执行 `flash_linux.sh` 脚本：

```bash
$ ./flash_linux.sh
Finding Arduino SAMD core v1.8.9...
Installing Arduino SAMD core...
正在下载 1package_index.tar.bz2 索引已下载                                                                                                     
工具arduino:arm-none-eabi-gcc@7-2017q4已经安装
工具arduino:bossac@1.7.0-arduino3已经安装
工具arduino:openocd@0.10.0-arduino7已经安装
工具arduino:CMSIS@4.5.0已经安装
工具arduino:CMSIS-Atmel@1.2.0已经安装
工具arduino:arduinoOTA@1.2.1已经安装
下载软件包...
arduino:samd@1.8.9已下载                                                                                                                       
用arduino:samd@1.8.9升级平台arduino:samd@1.8.13...
配置平台。...
已安装平台arduino:samd@1.8.9
Installing Arduino SAMD core OK
Finding Arduino MKRZero...
Finding Arduino MKRZero OK
Flashing Arduino firmware...

...

Verify 100988 bytes of flash with checksum.
Verify successful
done in 0.090 seconds
CPU reset.
Flashed your Arduino MKRZero development board. Board restarting...
Writing NN model to flash...
Program : 100% [============================================================]
sum = 02160 (0x0870) 313608 bytes written in 14.056 sec, 178490 bits/s
Read    : 100% [============================================================]
sum = 02160 (0x0870) 313608 bytes read in 1.975 sec, 1270310 bits/s
Writing NN model OK

Press reset button to start the application
```

看到 OK 说明固件烧写成功。如果烧写失败，出现 `read 0xff != expected 0x00` 等信息，则说明 Flash 存在异常。解决方法是打开串口终端，进入 Syntiant TinyML Board，输入 `:F` 命令，这样会擦除 Flash，从而修复异常。



## 制作自己的固件

针对声音识别训练，官方发布了一个 [Syntiant-RC-Go-Stop](https://studio.edgeimpulse.com/public/42868/latest) 项目，将该项目克隆到我们自己的 Edge Impulse 空间，这样就可以修改模型的参数，重新训练并生成我们自己的固件。



![](https://static.getiot.tech/Syntiant-TinyML-Built-firmware.png#center)

这样就会重新生成 syntiant-rc-go-stop-syntiant-ndp101-v41.zip 包，其内容如下所示。

```bash
├── ei_model.bin
├── ei_model.synpkg
├── firmware.ino.bin
├── firmware.ino.with_bootloader.bin
├── flash_linux.sh
├── flash_mac.command
├── flash_windows.bat
└── ndp10x_flash
    ├── ndp10x_flash
    ├── ndp10x_flash.exe
    └── ndp10x_flash_mac
```

解压后执行对应操作系统的 flash 脚本，即可重新烧写固件到 Syntiant TinyML 板。
