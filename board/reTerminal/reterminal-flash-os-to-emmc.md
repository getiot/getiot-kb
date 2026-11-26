---
sidebar_position: 3
---

# reTerminal 烧写系统



reTerminal 出厂自带 Raspberry Pi OS（32 bit）系统，本文以将 reTerminal 更新为 Raspberry Pi OS（64 bit）系统为例，介绍如何为你的 reTerminal 烧写系统，并完成 BSP 驱动安装。

提示：本文操作的主机系统是 Ubuntu 20.04。



## 安装 Raspberry Pi Imager

首先点击 [这里](https://www.raspberrypi.com/software/) 下载烧写工具 Raspberry Pi Imager，例如 Ubuntu 系统可以下载最新的 imager_1.7.3_amd64.deb 安装包。下载完成后，打开终端执行如下命令安装 Raspberry Pi Imager。

```bash
sudo dpkg -i imager_1.7.3_amd64.deb
```

安装完成后，执行 rpi-imager 启动程序。

```bash
$ rpi-imager
```

Raspberry Pi Imager 主界面如下：

![](https://static.getiot.tech/rpi-imager-main-ui.png#center)

提示：如果你使用 **Raspberry Pi OS**，可以执行下面命令安装 rpi-imager

```bash
sudo apt install rpi-imager
```



## 下载 OS 镜像

点击 [这里](https://www.raspberrypi.com/software/operating-systems/) 找到你想要的系统镜像，例如 Raspberry Pi OS (64-bit)，该系统兼容树莓派 3B、3B+、3A+、4、400... 以及 reTerminal 所用的 CM4 模块。点击右侧“Download”按钮，开始下载 OS 镜像。

![](https://static.getiot.tech/raspberrypi-os-64bit-download.png#center)



## 准备工作

reTerminal 拥有 32 GB 的 eMMC，我们的目标就是将新的 OS 镜像烧写到这片 eMMC 上，这一点和树莓派不同。

因此我们需要切换启动模式，切换的按键位于主板上面，所以在开始之前需要先打开 reTerminal 背面外壳。

按下图所示，拧开 reTerminal 背面的四颗橡胶螺钉，再拧下四颗金属螺钉，抠起外壳。

<img src="https://static.getiot.tech/remove-screw-1.png" width="480" />

然后卸下散热片，如下图所示。

<img src="https://static.getiot.tech/remove-screw-heatsink-2.jpg" width="480" />

Boot 模式按键就在 CM4 模块旁，按图示方向往下拨，进入 eMMC 烧录模式，如下图所示。

<img src="https://static.getiot.tech/boot-switch-2.jpg" width="480" />

注意：切换 Boot 模式前请先关机断电。



## 烧写系统

烧写系统需要使用到一个 rpiboot 工具，安装和启动步骤如下：

- 安装依赖

  ```bash
  sudo apt update
  sudo apt install git pkg-config make gcc libusb-1.0-0-dev
  ```

- 克隆 usbboot 仓库

  ```bash
  git clone --depth=1 https://github.com/raspberrypi/usbboot
  ```

- 编译安装

  ```bash
  $ cd usbboot         # 切换目录
  $ make               # 编译
  $ sudo make install  # 安装
  install -m 755 rpiboot /usr/bin/
  install -d /usr/share/rpiboot
  install -m 644 msd/bootcode.bin  /usr/share/rpiboot/
  install -m 644 msd/bootcode4.bin /usr/share/rpiboot/
  install -m 644 msd/start.elf  /usr/share/rpiboot/
  install -m 644 msd/start4.elf /usr/share/rpiboot/
  ```

- 启动 rpiboot

  ```bash
  sudo rpiboot
  ```

将 reTerminal 切换到 eMMC 烧录模式，使用 USB Type-C 连接 reTerminal 和主机（这里是 Ubuntu）。此时可以看到 rpiboot 终端打印如下内容，说明 reTerminal 已经进入 eMMC 烧录模式。

```bash
$ sudo rpiboot
RPIBOOT: build-date Oct 29 2022 version 20220815~145439 9e57f462
Waiting for BCM2835/6/7/2711...
Loading embedded: bootcode4.bin
Sending bootcode.bin
Successful read 4 bytes 
Waiting for BCM2835/6/7/2711...
Loading embedded: bootcode4.bin
Second stage boot server
Loading embedded: start4.elf
File read: start4.elf
Second stage boot server done
```

打开 Raspberry Pi Imager 软件，按 **CTRL + SHIFT + X** 组合键进入 **Advanced options** 配置窗口。设置 hostname、SSH、用户名和密码、WiFi 网络 SSID 和密码等关键配置，按 SAVE 保存。

![](https://static.getiot.tech/rpi-imager-advanced-options.png#center)

点击 Raspberry Pi Imager 主界面 Operating System 下方按钮选择 OS 镜像，Raspberry Pi Imager 工具内置了许多一些经验证的树莓派系统镜像，默认为 Raspberry Pi OS (32-bit) 系统。我们点击 **Raspberry Pi OS (other)** 选项，从中选择我们需要的 **Raspberry Pi OS (64-bit)** 系统镜像。如果想提高烧写速率，则拉到最下方选择 **Use custom** 选项，选择提前下载好的镜像（如 2022-09-22-raspios-bullseye-arm64.img.xz）。

![](https://static.getiot.tech/rpi-imager-select-os.png#center)

点击 Raspberry Pi Imager 主界面 Storage 下方按钮选择烧写的目标存储设备，选择 RPi-MSD 大容量存储设备。

![](https://static.getiot.tech/rpi-imager-select-storage.png#center)

点击 Raspberry Pi Imager 主界面的 WRITE 按钮，开始烧写镜像。

![](https://static.getiot.tech/rpi-imager-select-done.png#center)

烧写操作会擦除存储器的数据，请提前备份重要数据并确保你的 reTerminal 设备可以擦写。

![](https://static.getiot.tech/rpi-imager-write-ask.png#center)

点击 YES 开始执行，如果你选择在线下载 OS 镜像，则需要更长的时间。

![](https://static.getiot.tech/rpi-imager-writing.png#center)

等待一段时间后，烧写完成。此时可以断开 USB Type-C 连接线，将 Boot 模式切换回 eMMC 正常启动模式，然后重新启动设备。

![](https://static.getiot.tech/rpi-imager-write-done.png#center)




## 登录系统

启动 reTerminal 后，稍等一段时间，等待设备接入 Wi-Fi 网络。由于此时的系统并未适配 reTerminal，因此 LCD 屏幕没有点亮，你可以通过路由器或其他网络扫描工具确认 reTerminal 是否已连接。

提示：你还可以参考 [reTerminal 登录系统](/reterminal/reterminal-login-os/) 通过 TTL 转 USB 模块连接调试串口登录系统。

执行下面命令通过 SSH 方式登录 reTerminal 系统：

```bash
ssh pi@raspberrypi.local
```

如果一切顺利，你将看到类似提示：

```bash
pi@192.168.3.251's password: 
Linux raspberrypi 5.15.61-v8+ #1579 SMP PREEMPT Fri Aug 26 11:16:44 BST 2022 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Oct 30 18:20:07 2022
pi@raspberrypi:~ $
```

通过如下一些命令查看系统信息，可以确认当前启动的是 Raspberry Pi OS (64-bit) 系统。

```bash
$ getconf LONG_BIT
64

$ uname -a
Linux raspberrypi 5.15.61-v8+ #1579 SMP PREEMPT Fri Aug 26 11:16:44 BST 2022 aarch64 GNU/Linux
```

此时 Raspberry Pi OS 基本系统顺利启动，不过为了正常驱动 reTerminal 外设，我们还需要为其安装设备。



## 安装驱动

登录 reTerminal 系统，安装 Git 工具（如果没有）。

```bash
sudo apt install git
```

克隆 seeed-linux-dtoverlays 仓库源码：

```bash
git clone --depth 1 https://github.com/Seeed-Studio/seeed-linux-dtoverlays
```

执行驱动安装脚本：

```bash
cd seeed-linux-dtoverlays/
sudo ./scripts/reTerminal.sh
```

等待安装脚本执行完毕，重启系统。

```bash
sudo reboot
```

现在，可以看到 reTerminal 的屏幕重新点亮了！

![](https://static.getiot.tech/reTerminal-run-raspberry-pi-os-64-bit.jpeg#center)



