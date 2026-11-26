---
sidebar_position: 3
slug: /wio-terminal-development-environment
---

# Wio Terminal 开发环境



Wio Terminal 支持使用 Arduino IDE 进行开发。Arduino IDE 可以在[这里](https://www.arduino.cc/en/software)下载，它支持 Windows、Linux 和 MacOS 平台，本文以 Ubuntu 为例进行演示，介绍如何搭建 Wio-Terminal 的开发环境并运行 Blink 程序，具体步骤如下。

![](https://static.getiot.tech/wio-terminal-powerup.png#center)

## 安装步骤

**1、安装 Arduino IDE**

安装过程可以参考 [Arduino 开发环境](/arduino/arduino-ide/)。

**2、打开 Blink 示例**

打开 LED 闪烁示例项目，位置：*File（文件） > Examples（示例） > 01.Basics > Blink*

**3、将 Wio Terminal 添加到您的 Arduino IDE**

点击 *File（文件） > Preference（偏好设置）* ，打开“首选项”页面，将以下网址复制到“附加开发板管理器网址”（Additional Boards Manager URLs）一栏。

```bash
https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json
```

如下图所示：

![](https://static.getiot.tech/Arduino-IDE-add-Wio-Terminal.png#center)

点击 *Tools（工具） > Board（开发板）> Boards Manager...* ，打开“开发板管理器”，在搜索栏中搜索关键字 **Wio Terminal** 后，点击并安装 **Seeed SAMD Boards** 最新版本。

![](https://static.getiot.tech/Arduino-IDE-Board-Manager-add-Seeed-SAMD.png#center)

**4、设置开发板和串行端口**

在 *Tools（工具）> Board（开发板）* 菜单中选择“Seeed SAMD”项，选择 **Seeed Wio Terminal** 开发板。

从 *Tools（工具）> Serial Port（端口）* 中选择 Wio Terminal 的串行设备。在 Ubuntu 系统中通常为 /dev/ttyACM0，Windows 系统则是 COM 端口。如果你不知道具体是哪个，可以先断开 Wio Terminal 并重新打开菜单，消失的条目应该是它的串口，接着重新连接电路板并选择该串行端口即可。

**5、上传程序**

现在可以点击工具栏中的 **上传（Upload）** 按钮，Arduino IDE 会先编译 Blink 程序，编译成功后烧写到 Wio-Terminal 中。如果一切顺利，状态栏中将显示“上传成功（Done uploading）”的信息。

这时候，我们可以看到 Wio Terminal 下方的蓝色 LED 开始闪烁。这样，说明 Wio-Terminal 的开发环境已经搭建成功。

![](https://static.getiot.tech/Arduino-IDE-Wio-Terminal-Blink.png#center)

如果上传失败，遇到“Error touching serial port '/dev/ttyAMC0'”的错误，即串口通信异常，在 Ubuntu 系统中通常是权限问题导致的。执行下面命令将当前用户（非 root 用户）添加到 dialout 用户组，然后重启系统。

```bash
sudo usermod -a -G dialout $USER
```



## 资源链接

- [Seeed SAMD ArduinoCore](https://github.com/Seeed-Studio/ArduinoCore-samd)
- [Seeed AMBD Firmware](https://github.com/Seeed-Studio/seeed-ambd-firmware)
- [Seeed AMBD Flash Tool](https://github.com/Seeed-Studio/ambd_flash_tool)

