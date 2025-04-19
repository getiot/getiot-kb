---
sidebar_position: 1
slug: /all-of-serial-tools
---

# 好用的串口工具合集



在嵌入式开发中，常常需要用到串口工具，通常会分为两类：

- **串口终端工具** —— 是主机和开发板之间建立联系的桥梁，例如通过调试串口登录 Linux 控制台。
- **串口调试工具** —— 是计算机和 COM 口通信的工具，COM 口一般是 RS232 或 RS485，通常用于串口模块（例如从站模块、通信模块、传感器）的读写测试。

本文收集和介绍一些好用的串口工具，包括 Minicom、MobaXterm、Xshell、SecureCRT、Cutecom、WindTerm 等等。



## 串口终端工具

### Minicom

Minicom 是 Linux 下一款常用的命令行串口调试工具。其功能与 Windows 下的超级终端相似，可以通过串口控制外部的硬件设备，通常用于对嵌入式设备进行管理。

- 使用教程：[minicom 命令](/linux-command/minicom/)



### WindTerm

WindTerm 是一款开源的终端软件，支持 Windows、Linux 和 macOS 三大平台。WindTerm 安装体积小、性能强，支持 Shell、SSH、Telnet、TCP、Serial 等连接方式，是一个值得尝试的终端软件工具。

- 下载地址：[https://github.com/kingToolbox/WindTerm/releases](https://github.com/kingToolbox/WindTerm/releases)

和其他终端软件不同，WindTerm 的界面更像 IDE 的布局，左侧是资源管理器和文件管理器，中间是连接的目标 Shell 终端窗口，右侧是会话窗口和历史命令窗口，底部则是发送窗口和本地 Shell 窗口。

![](https://static.getiot.tech/WindTerm.png#center)



### MobaXterm

MobaXterm 是一个支持 X11 服务器、SSH 客户端，并提供多种网络工具等的增强型 Windows 终端。MobaXterm 支持插件扩展，以满足更多需求。

- 项目官网：[https://mobaxterm.mobatek.net](https://mobaxterm.mobatek.net)
- 插件：[https://mobaxterm.mobatek.net/plugins.html](https://mobaxterm.mobatek.net/plugins.html)

![](https://static.getiot.tech/mobxterm-screenshot-20210916.webp#center)



### Tera Term

Tera Term 是一款开源的远程终端操作工具，最初由日本物理学家寺西高开发并发布，之后由 Tera Term Project 项目组在 BSD 许可证下进行维护支持。

- 项目网址：[http://ttssh2.osdn.jp/](http://ttssh2.osdn.jp/)



### Xshell

Xshell 是一款远程终端工具，功能强大且安全，支持 SSH、SFTP、Telnet、rlogin 和 Serial。可通过互联网安全连接到远程主机，也可以通过串口登录本地终端。

商业版提供 30 天试用，为家庭和学校提供免费的许可证。下载地址：[https://xshell.com/zh/xshell-download/](https://xshell.com/zh/xshell-download/)



### PuTTY + Scp

PuTTY 是一款集成虚拟终端、系统控制台和网络文件传输为一体的自由及开放源代码的程序。它支持多种网络协议，包括 SCP，SSH，Telnet，rlogin 和原始的套接字连接，也可以连接到串行端口。其软件名字“PuTTY”没有特殊含义。



### MTPuTTY

MTPuTTY 是基于 PuTTY 的一款免费的远程终端管理工具，MT 是 Multi-Tabbed 的缩写。平时用 PuTTY 远程连接服务器，管理多台远程服务器需要打开多个窗口。使用 MTPuTTY 只需要打开一个窗口，通过不同标签的切换来管理多个服务器。

- 下载地址：[https://ttyplus.com/multi-tabbed-putty/](https://ttyplus.com/multi-tabbed-putty/)



### SecureCRT

SecureCRT 是 VanDyke Software 公司所开发销售的一个商业 SSH、Telnet 客户端和虚拟终端软件。SecureCRT 最初是一个 Windows 下的产品，VanDyke 软件公司于2017年6月起增加了 Mac OS X 和 Linux 下的版本。



## 串口调试工具

### Microcom

Linux 的命令行工具，参考使用教程：[microcom 命令](/linux-command/microcom/)。



### 串口调试助手

可以直接在 Microsoft Store 安装，搜索「串口调试助手」即可。主界面如下：

![](https://static.getiot.tech/windows-serial-debug-assistant.png#center)



### Cutecom

Linux 下带图形界面的串口调试工具。

![](https://static.getiot.tech/Cutecom-v5.png#center)



### QCOM

移远 Quectel 制作的串口调试工具，适合用于调试移远的通讯模块。

下载地址：[https://www.quectel.com/download/qcom_v1-6](https://www.quectel.com/download/qcom_v1-6)



### XCOM

正点原子制作的串口调试工具，适合用于单片机开发的串口收发测试。

下载地址：[http://www.openedv.com/thread-279749-1-1.html](http://www.openedv.com/thread-279749-1-1.html)



### SSCOM

- 下载地址：[http://www.daxia.com](http://www.daxia.com)
