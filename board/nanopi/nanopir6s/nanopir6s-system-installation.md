---
sidebar_position: 3
---

# NanoPi R6S 安装系统



NanoPi R6S 支持多种方式安装操作系统，这里介绍相对简单且通用的一种方式 —— 通过 TF 卡安装。

注意：

- 此方法是通过 SD 卡启动一个小型的 Linux 系统，然后自动运行一个名为 [EFlasher](https://wiki.friendlyelec.com/wiki/index.php/EFlasher/zh) 的工具来将固件烧写到 eMMC 中。
- 可以连接 HDMI 显示器，通过图形界面来了解进展，但不是必需的，可以通过 LED 灯来掌握烧写进度。



## 固件下载

你可以通过[网盘](https://download.friendlyelec.com/NanoPiR6S)找到并下载所需的固件版本，以及 eMMC 烧写所需的文件及工具：

| **固件文件**                                               | 描述                                                         |
| ---------------------------------------------------------- | ------------------------------------------------------------ |
| rk3588-eflasher-friendlywrt-21.02-YYYYMMDD.img.gz          | FriendlyWrt 系统固件，基于 OpenWrt 21.02 构建，内核版本 5.10.y |
| rk3588-eflasher-friendlywrt-21.02-docker-YYYYMMDD.img.gz   | 预装了 Docker 的 FriendlyWrt 系统固件，基于 OpenWrt 21.02 构建，内核版本 5.10.y |
| rk3588-eflasher-friendlywrt-22.03-YYYYMMDD.img.gz          | FriendlyWrt 系统固件，基于 OpenWrt 22.03 构建，内核版本 5.10.y |
| rk3588-eflasher-friendlywrt-22.03-docker-YYYYMMDD.img.gz   | 预装了 Docker 的 FriendlyWrt 系统固件，基于 OpenWrt 22.03 构建，内核版本 5.10.y |
| rk3588-eflasher-androidtv-YYYYMMDD.img.zip                 | Android TV 系统固件                                          |
| rk3588-eflasher-ubuntu-jammy-desktop-arm64-YYYYMMDD.img.gz | Ubuntu 22.04 固件, 使用 GNOME 与 Wayland，预装网页浏览器等推荐软件, 内核版本 5.10.y |
| rk3588-eflasher-ubuntu-jammy-minimal-arm64-YYYYMMDD.img.gz | 精简版 Ubuntu 22.04 固件, 使用 GNOME 与 Wayland，不预装推荐软件，内核版本 5.10.y |

另外，Windows 用户还需要下载 win32diskimager 工具将固件写入 TF 卡，Linux 用户可以用 dd 命令完成。



## 安装步骤

使用 TF 卡为 NanoPi R6S 安装系统的详细操作步骤如下：

1、准备一张 8G 或以上容量的 SDHC 卡；

2、下载并解压固件文件 rk3588-eflasher-OSNAME-YYYYMMDD.img.gz 和工具 win32diskimager；

3、在 Windows 下以管理员身份运行 win32diskimager，在界面上选择你的 SD 卡盘符，选择解压后的 EFlasher 固件，点击 Write 按钮烧写到 SD 卡；或者在 Linux下使用 dd 命令将 rk3588-eflasher-OSNAME-YYYYMMDD.img 写入 SD 卡；

4、将 SD 卡从电脑端弹出，插入 NanoPi-R6S 的 microSD 卡槽；

5、连接 NanoPi-R6S 的电源，系统会从 SD 卡启动，并自动启动 EFlasher 烧写工具将系统安装到 eMMC，可连接 HDMI 设备来查看进度，也可以通过板载 LED 灯来了解安装进度：

|   进度   | SYS灯（红灯） | LAN灯（绿灯） | WAN灯（绿灯） |
| :------: | :-----------: | :-----------: | :-----------: |
| 上电开机 |     长亮      |      灭       |      灭       |
| 系统启动 |     慢闪      |      灭       |      灭       |
| 正在烧写 |     快闪      |      灭       |      灭       |
| 烧写完成 |     慢闪      |     长亮      |     长亮      |

6、烧写完成后，切断电源，然后从 NanoPi-R6S 端弹出 SD 卡，重新上电开机，NanoPi-R6S 会从 eMMC 启动你刚刚烧写的系统。

