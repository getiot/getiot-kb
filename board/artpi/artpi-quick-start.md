---
sidebar_position: 3
---

# ART-Pi 快速上手



## 简介

ART-Pi 出厂自带一个好玩的例程，可通过蓝牙对开发板进行配网，内置一个 web 服务器，配网成功后能够通过网页显示开发板的基本信息，并对开发板的板载 LED 进行简单的控制。



## 硬件连接

使用包装盒里附带的 USB Type-C 线连接 ART-Pi 与 PC，如下图所示：

![](https://static.getiot.tech/artpi-board-connect-to-pc2.png#center)

## 运行示例

开发板上电后请按以下步骤进行配网：

1、**微信** 扫描二维码打开 **WIFI 配网助手**

![](https://static.getiot.tech/artpi-wifi-miniapp-qrcode.jpg#center)

2、设备选择 **ART-Pi**，输入所要连接的 WIFI SSID 和密码，输入完成后点击 **蓝牙配网** 按钮进行配网。

3、配网成功后小程序会跳出成功页面，并且显示开发板获取到的 IP 地址。

![](https://static.getiot.tech/artpi-miniapp-config-bt-wifi.png#center)

4. 此时点击 **一键复制** 将 IP 地址复制到剪切板并粘贴到浏览器中即可打开开发板主页。

![](https://static.getiot.tech/artpi-sample-web.gif#center)



## FAQs

### 1、烧写出厂例程

ART-Pi 的出厂固件源代码在 [RT-Thread ART-Pi SDK](https://github.com/RT-Thread-Studio/sdk-bsp-stm32h750-realthread-artpi) 中有提供，具体位置是 `/projects/art_pi_factory` 目录。如果不小心损坏了出厂固件，可以自行编译此工程，重新烧写到 ART-Pi 开发板上。

### 2、固件或网页丢失

开发板主页依赖于外网资源，请确保开发板连接的无线网能够接入互联网。

**注意：出厂例程的正常运行需要蓝牙固件、WiFi 固件以及网页文件的支持，如果开发板缺少这些文件，则需要参照下方注意事项上传固件及网页。**

- 出厂默认刷好了 WiFi 和蓝牙固件和网页文件，若固件丢失，可以按照文档《UM5003-RT-Thread ART-Pi BT_WIFI 模块固件下载手册》所描述方法重新传入。
- 网页文件存在于 `/projects/art_pi_factory/applications/web_dist` 目录下，不同于 WIFI 及蓝牙固件的上传，网页文件需要联网后通过 **adb** 工具进行上传，需要将 `webnet` 目录上传到开发板的 `/flash` 目录下。（具体的使用方法可参考 [ADB 使用说明](https://github.com/heyuanjie87/adbd#readme)）

![](https://static.getiot.tech/artpi-sample-adb.gif#center)

另外，需要注意的是，本例程中包含了蓝牙协议栈 BTstack，它在非商业用途是免费的。对于商业用途，请联系 <a href="mailto:contact@bluekitchen-gmbh.com">  BTstack 官方 </a > 以获得商业授权。

