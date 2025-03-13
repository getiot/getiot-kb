---
sidebar_position: 18
---

# 镜像烧录工具



本文收集常用的镜像/固件烧录工具（又称“烧写工具”），包括 Win32DiskImager、Rufus、balenaEtcher、UNetbootin、Clonezilla 以及 Raspberry Pi Imager 等。这些工具通常用于将 OS 镜像写入 U 盘或 SD 卡，是嵌入式工程师常用的工具。



## Win32 Disk Imager

Win32 Disk Imager 是一款开源的可移动存储设备镜像制作及写入工具（例如 U 盘或 SD 卡），可用于镜像制作、镜像烧录、镜像恢复、备份信息存储等场合，在嵌入式开发常常被用到。

Win32 Disk Imager 界面简洁，简单易用。用户插入存储设备，在右上角「设备」选框中选择该设备，然后在「映像文件」中选择镜像的存放路径，点击下方的「读取」即可开始制作镜像文件，点击「写入」则开始往存储设备烧录镜像。「校验值」一栏可以对映像文件进行校验，支持 MD5、SHA1、SHA256 校验方式。

- 支持系统：Windows 7/8/10
- 下载地址：[https://win32diskimager.org](https://win32diskimager.org)

![](https://static.getiot.tech/Win32DiskImager.png#center)



## Rufus

Rufus 是一个开源的镜像烧录实用工具，可以帮助格式化和创建可引导 USB 闪存盘，比如 USB 随身碟、记忆棒等。Rufus 的体积非常小、但功能全面、速度较快。

- 支持系统：Windows 7/8/10
- 源码仓库：[https://github.com/pbatard/rufus](https://github.com/pbatard/rufus)

![](https://static.getiot.tech/rufus-icon.png#center)



## balenaEtcher

balenaEtcher 是一个免费、开源、跨平台的镜像烧录程序，它使 USB 和 SD 卡镜像写入尽可能简单和快速。 

- 支持系统：Windows、macOS 和 GNU/Linux
- 下载地址：[https://www.balena.io/etcher/](https://www.balena.io/etcher/)
- 源码仓库：[https://github.com/balena-io/etcher](https://github.com/balena-io/etcher)

![](https://static.getiot.tech/etcher-icon.png#center)



## UNetbootin

UNetbootin（Universal Netboot Installer）为一个跨平台的镜像制作与烧录工具软件，可以用来建立 Live USB 系统，也可以加载各种系统工具，或安装各种 Linux 操作系统（Linux 套件）和其他操作系统，不需使用安装光碟（自动通过网络下载）。

- 支持系统：Windows、macOS 和 GNU/Linux
- 下载地址：[https://unetbootin.github.io](https://unetbootin.github.io)

![](https://static.getiot.tech/unetbootin-icon.png#center)



## Clonezilla

Clonezilla（再生龙）是一个免费的灾难恢复、硬盘克隆、硬盘映像档制作的部署和解决方案，由台湾的国家高速网络与计算中心（国网中心）所开发，以 GNU 通用公共许可协议（GPL）发布。

Clonezilla 基于 Partimage，吸取了 Norton Ghost 和 Partition Image 的优点。即不仅支持对整个硬盘系统进行克隆，而且也可以克隆单个的分区，支持多播，可同时克隆 40 多台计算机，这种灵活性更能满足各种使用者的需要。此外，支持多种的操作系统与文件系统也是其强大之处。官方推荐 tuxboot 工具制作启动 U 盘。

- 支持系统：Windows、GNU/Linux
- 项目主页：[http://clonezilla.nchc.org.tw](http://clonezilla.nchc.org.tw)
- 下载地址：[https://clonezilla.org/downloads.php](https://clonezilla.org/downloads.php)

![](https://static.getiot.tech/clonezilla-icon.png#center)

扩展阅读：[利用 Clonezilla 备份还原 Linux 系统](https://blog.csdn.net/lu_embedded/article/details/58703899)



## Raspberry Pi Imager

Raspberry Pi Imager 是树莓派基金会新推出的镜像烧录工具，用户可以使用该工具来为树莓派烧录系统镜像，其用法和 Etcher 与 win32diskimager 类似。

- 支持系统：Windows、macOS 和 Ubuntu
- 下载地址：[https://www.raspberrypi.org/software/](https://www.raspberrypi.org/software/)
- 源码仓库：[https://github.com/raspberrypi/rpi-imager](https://github.com/raspberrypi/rpi-imager)

![](https://static.getiot.tech/Raspberry-Pi-Imager.png#center)





## 参考

- [Win32 Disk Imager 1.0.0 Download](https://win32diskimager.org/)
- [Rufus - 轻松创建USB启动盘](https://rufus.ie/zh/)
- [Clonezilla再生龙备份与还原linux系统_FlyWine的博客-CSDN博客_再生龙备份linux](https://blog.csdn.net/wf19930209/article/details/100012611)
- [clonezila再生龙使用教程 | Leo's Blog (leooo48.github.io)](https://leooo48.github.io/2018/07/13/clonezila/)
- [Raspberry Pi Imager 镜像烧录工具 | 树莓派实验室 (nxez.com)](https://shumeipai.nxez.com/2020/03/07/raspberry-pi-imager-imaging-utility.html)

