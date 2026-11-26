---
sidebar_position: 5
authors: [luhuadong]
---

# 树莓派安装 Ubuntu 桌面系统



## 概述

本文介绍如何在树莓派上安装 Ubuntu Desktop 系统，如果你想安装的是 Ubuntu Server，可以参考[这里](https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#1-overview)。Desktop 和 Server 版本的区别是 Desktop 包含图形视窗系统和一些常用软件，因此体积比 Server 版的大了不少。

![Groovy-Gorilla_WP_4096x2304](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/2/2511fa286925ecffed668aa4580c518644f0fb01_2_690x388.jpeg#center)

视频讲解：[How to get started with Ubuntu Desktop on Raspberry Pi](https://youtu.be/ZWBe2E1Sgi0)



### 你将会学到

- 如何制作一个可以引导系统启动的 microSD 卡
- 如何设置日常使用的 Ubuntu 桌面

### 你需要准备

- 一张 microSD 卡（最小 9GB，推荐 16GB 及以上）
- 一台可以识别 microSD 卡的电脑（配合读卡器）
- 一个 Raspberry Pi 4
- 一根 micro USB-C 电源线
- 一台支持 HDMI 接口的显示器
- 一根 micro HDMI 线
- 一个 USB 键盘



## 准备 SD 卡

**警告**：以下操作会擦除 microSD 卡上的所有内容，请确保卡上重要数据以备份。

首先，将 microSD 卡插入你的电脑（你可能需要 microSD 卡的转换卡套或 USB 读卡器）。

接着你需要安装一个 Raspberry Pi Imager 工具，它是一个跨平台的烧录软件。如果你的主机是 Ubuntu，那么可以直接使用下面命令进行安装：

```bash
sudo snap install rpi-imager
```

其他操作系统可以通过下面链接下载：

- [Raspberry Pi Imager as a deb package](https://downloads.raspberrypi.org/imager/imager_latest_amd64.deb)
- [Raspberry Pi Imager for Windows](https://downloads.raspberrypi.org/imager/imager_latest.exe)
- [Raspberry Pi Imager for macOS](https://downloads.raspberrypi.org/imager/imager_latest.dmg)

下载、安装完成后，就可以启动该 Imager 工具，并打开 “CHOOSE OS” 菜单。

![Screenshot from 2021-04-28 11-15-19](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/1/1443a1624b2c3e4f48bc2ec18dbadbdfb052f636_2_690x464.png#center)

向下滚动菜单，找到 “Other general-purpose OS” 项。

![Screenshot from 2021-04-28 11-16-21](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/c/c724a796263b5d62d85e41953bb93011b626e673_2_690x438.png#center)

你可以看到 Ubuntu 下载列表，选择 “Ubuntu 21.04 Desktop (RPi 4/400)”，注意这只适合 Raspberry Pi 4 的 4GB 或 8GB 版本。

![Screenshot from 2021-04-28 11-17-56](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/c/c46b0cbcc1b6d8841c775c5439ba3b24cc949ff1_2_690x439.png#center)

接着选择 “CHOOSE STORAGE” 菜单，选择你之前插入的 microSD 卡，然后点击 “WRITE” 按钮。接下来就可以坐下来等待魔术的发生...（这个魔术需要花点时间）。

现在，你的 Ubuntu SD 卡应该制作好了，启动之前，先确认你的树莓派处于掉电状态，然后将 SD 卡插入树莓派的卡槽。这就是树莓派用来加载你将要使用的所有软件的方式。



## 启动你的桌面

现在，确认树莓派连接上 HDMI 显示器和 USB 键盘，然后接上 USB-C 电源线为其供电。你将会在显示屏上看到系统启动画面，最终，将会来到系统向导界面。

第一步，选择系统语言：

![001_setup](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/7/78fd6cda5880e299b4b985995d8b008055c971f9_2_690x388.jpeg#center)

然后设置键盘布局：

![img](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/d/d9480a7e66c26a26a3f05639b7dcb878bd4efe8a_2_690x388.jpeg#center)

接着选择你的时区，这将确保你的系统时间是正确的（包括部分地区的夏令时）：

![003_setup](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/2/22d413e93a646f273cffa8275f437cfc8bec200f_2_690x388.jpeg#center)

设置系统账户和密码：

![004_setup](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/6/633137482b30768f703cb47d32136dbfbb7007f4_2_690x388.jpeg#center)

最后，来到 “Welcom to Ubuntu”，等待系统配置完成即可。

![005-setup](https://ubuntucommunity.s3.dualstack.us-east-2.amazonaws.com/optimized/2X/c/c8ffdd34a84e9b266076ac7c669abb4c4afe0487_2_690x388.jpeg#center)



## USB 启动（可选）

你现在还可以尝试从 USB 连接的硬盘驱动器或 SSD 引导系统启动，而无须使用 microSD 卡。但必须首先从 SD 卡启动，因为所有型号的树莓派默认都在 EEPROM 中设置了仅可从 SD 卡启动，当你从 SD 卡启动系统后，你可以重新配置它。

首先执行下面命令获取最新的 rpi-eeprom 版本：

```bash
sudo apt install rpi-eeprom
```

将当前的 bootloader 配置提取到文本文件中：

```bash
sudo vcgencmd bootloader_config > bootconf.txt
```

接下来，我们需要将 `BOOT_ORDER` 选项设置为 `0xf41`（表示先尝试从 SD 卡启动，再尝试 USB 大容量存储设备，然后重复，你可以在 [pi4 bootloader configuration](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md) 找到相关信息）。

使用下面命令进行修改，如果你不喜欢 sed-hacking，也可以使用 vim 自行对 bootconf.txt 进行编辑。

```bash
sed -i -e '/^BOOT_ORDER=/ s/=.*$/=0xf41/' bootconf.txt
```

现在我们使用新的配置来生成一个 EEPROM 固件：

```bash
rpi-eeprom-config --out pieeprom-new.bin --config bootconf.txt /lib/firmware/raspberrypi/bootloader/critical/pieeprom-2020-09-03.bin
```

将系统设置为在下次启动是更新 EEPROM 固件：

```bash
sudo rpi-eeprom-update -d -f ./pieeprom-new.bin
```

重启系统（因为仅在早期引导阶段才能更新 EEPROM）：

```bash
sudo reboot
```

现在，我们需要将系统镜像保存到硬盘驱动器上。这一步骤很容易，和制作 SD 卡一样的，唯一不同是在 “CHOOSE STORAGE” 选择你的硬盘，而不是 SD 卡。

一切完成后，你就可以从 USB 硬盘启动系统啦！

**注意**：机械硬盘所需的功率比固态硬盘大得多，如果你使用机械硬盘，很可能需要额外给它供电。

树莓派论坛和 GitHub 上有很多关于调试启动问题的信息，如果你遇到问题，可以去看一下。下面是一些推荐的链接：

- [Pi Forums: Is your Pi not booting?](https://www.raspberrypi.org/forums/viewtopic.php?t=58151)
- [Pi Forums: USB MSD boot EEPROM](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=277007)
- [Pi Forums: Pi 4 USB3 SSD slow speeds?](https://www.raspberrypi.org/forums/viewtopic.php?t=245931)
- [Pi Docs: Pi 4 Bootloader Configuration](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md)
- [GitHub Issue: Enclosure doesn’t power on after reboot](https://github.com/raspberrypi/rpi-eeprom/issues/180)



## 更多

- 有关 Raspberry Pi Ubuntu 桌面系统的更详细信息，请访问 [Raspberry Pi Website](https://ubuntu.com/raspberrypi)
- 还可以看看 Raspberry Pi 的其他 Ubuntu 项目，比如 [Ubuntu Appliance portfolio](https://ubuntu.com/appliance)
- Ubuntu 提供了大量可用的存储库，你可以在 [packages.ubuntu.com](https://packages.ubuntu.com/) 找到它们
- 你还可以使用 snap 命令安装 snap 软件包，在 [Snap Store](https://snapcraft.io/store) 中找到最佳的 Linux 开源和专有应用程序，以将其安装在树莓派上开始你的任何项目。



