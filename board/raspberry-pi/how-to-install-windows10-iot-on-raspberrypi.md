---
sidebar_position: 6
authors: [luhuadong]
---

# 树莓派安装 Windows 10 IoT



## 准备工作

### 硬件部分

- 一台安装 Windows 系统的电脑
- 树莓派 4B（4GB 或 8GB 版本）
- Micro SD 卡（容量 16GB 以上）

其他可选硬件包括

- USB 转以太网或 WiFi dongle
- 蓝牙 dongle（如果你想测试蓝牙功能的话）
- 键盘、鼠标、HDMI 线以及显示器



### 软件部分

- Windows on Raspberry imager（简称 WoR）
- Windows images（ISO 镜像）



## 安装步骤

### 下载 WoR 工具

打开 [Windows on Raspberry](https://www.worproject.ml/downloads) 网站下载页面，点击 Download 下载当前最新的 2.12 版本。解压缩刚下载的 WoR_Release_2.1.2.zip 文件，待用。

![](https://static.getiot.tech/windows-on-raspberry-imager-download.png)

### 下载 ISO 镜像

接着打开 [UUP dump](https://uupdump.net/) 网站，在「**Latest Dev Channel build**」 一栏选择 **arm64** 架构。

![](https://static.getiot.tech/windows10-iot-image-arm64-download.png)

在响应页面中点击当前最新的「Cumulative Update for Windows 11」。

![](https://static.getiot.tech/windows10-iot-image-arm64-download-22000.51.png)

进入配置页面，选择语言（例如：简体中文），点击 Next。选择版本（例如：Windows Pro），点击 Next。在下一页点击「Create download package」即可下载。

![](https://static.getiot.tech/windows10-iot-image-arm64-download-edition.png)

下载的 22000.51_arm64_zh-cn_multi_a83f77ff_convert.zip 并非镜像，我们还有解压缩该文件，并执行其中的下载脚本。

- Windows ：`uup_download_windows.cmd`
- Linux ：`uup_download_linux.sh`
- macOS ：`uup_download_macos.sh`

对于 Windows 平台，右击 `uup_download_windows.cmd` 文件，选择“以管理员身份运行”，之后会打开一个命令行终端，等待下载完成即可。



### 制作 SD 卡

![](https://static.getiot.tech/windows-on-raspberry-imager-01.png)



![](https://static.getiot.tech/windows-on-raspberry-imager-02.png)

[https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md](https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md)

![](https://static.getiot.tech/windows-on-raspberry-imager-02-warning.png)



![](https://static.getiot.tech/windows-on-raspberry-imager-03.png)



![](https://static.getiot.tech/windows-on-raspberry-imager-04.png)



![](https://static.getiot.tech/windows-on-raspberry-imager-05.png)

分区表选择

- GPT（GUID Partition Table）
- MBR（Master Boot Record），选择 MBR 分区方案会阻止您使用恢复环境或进行系统更新。

![](https://static.getiot.tech/windows-on-raspberry-imager-06-MBR.png)

启动选项

```shell
arm_64bit=1
enable_uart=1
uart_2ndstage=1
enable_gic=1
armstub=RPI_EFI.fd
disable_commandline_tags=1
disable_overscan=1
device_tree_address=0x1f0000
device_tree_end=0x200000
dtoverlay=miniuart-bt
```



![](https://static.getiot.tech/windows-on-raspberry-imager-07.png)



![](https://static.getiot.tech/windows-on-raspberry-imager-08.png)



![](https://static.getiot.tech/windows-on-raspberry-imager-09.png)



SD 卡分区情况

![](https://static.getiot.tech/windows-on-raspberry-partition.png)



## 启动 Windows 10 IoT

### 配置

按 ESC，Device Manager -> Raspberry Pi Configuration -> Advanced Configuration，将 Limit RAM to 3 GB 切换成 Disabled，按 ESC 退出保存配置。

接着，请耐心等待 Windows 10 IoT 的界面。

### 初始化设置



如果无法启动，请更新 boot EEPROM！参考：[Raspberry Pi 4 boot EEPROM - Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md)



