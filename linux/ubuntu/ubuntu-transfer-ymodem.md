---
sidebar_position: 19
---

# Ubuntu 使用 Ymodem 协议传输文件



YMODEM 协议是一个文件传输协议，由 Chuck Forsberg 于上世纪 90 年代开发完成，通常用于资源受限的设备。在 Windows 系统中，很多[串口工具](/tools/all-of-serial-tools/)如 SecureCRT 和 Xshell 等都支持 ASCII、Xmodem、Ymodem、Zmodem 传输协议。

那么，本文就来介绍在 Linux 系统中（以 Ubuntu 为例），如何使用 Ymodem 协议传输文件。本文用到的工具有 Cutecom 和 minicom，这些工具都依赖 lrzsz 库。

```bash
sudo apt install lrzsz
```



## Cutecom

可参考 [Ubuntu 安装最新版本 Cutecom](/ubuntu/ubuntu-install-cutecom-latest/) 安装最新版本。打开 Cutecom，连接串口设备之后，就可以选择 YModem 协议发送文件。

![](https://static.getiot.tech/cutecom-ymodem.png#center)



## minicom

指定串口设备启动 minicom，例如：

```bash
sudo minicom -D /dev/ttyACM0
```

按 CTRL + A 然后 'o'，选择“File transfer protocols”可以看到 ymodem 的使用依赖于 /usr/bin/sb（由 lrzsz 软件包提供）。

![](https://static.getiot.tech/minicom-config-file-transfer-protocols.png#center)

按 CTRL + A 然后 's'，选择 ymodem，选择文件传输即可。

![](https://static.getiot.tech/minicom-upload-ymodem.png#center)



