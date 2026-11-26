---
sidebar_label: Codecraft
sidebar_position: 16
slug: /codecraft
---

# Codecraft 图形化编程工具

![Codecraft 图形化编程工具](https://static.getiot.tech/codecraft-graphical-programming.jpeg#center)

**Codecraft** 是一款由柴火创客教育基于 Scratch 3.0 开发的图形化编程软件工具。主要面向 STEAM 教育领域，适合 6-16 岁青少年进行编程学习，用户通过简单地拖拽积木即可编程。

除了可以对舞台角色进行编程以外，更支持多款主流硬件设备接入，实现软硬件结合，让编程学习更有乐趣。通过好玩的游戏和应用，让孩子更容易理解 AI 技术背后的原理。

Codecraft 支持两种模式：**舞台模式** 和 **设备模式**。

- 在舞台模式下，可以利用图形化编程，对舞台精灵进行编程。创造出孩子们自己的故事。
- 在设备模式下，可以对多款硬件设备进行图形化编程，创造出各种天马行空的创意项目。目前支持 Grove Zero、Arduino Uno/Mega、micro:bit、M.A.R.K（CyberEye）、Grove Joint、GLINT、Bittle、Wio Terminal 等硬件。

Codecraft 虽然是图形化编程工具，但它拥有一键切换 Python/C/Javascript 功能，能够让孩子在掌握图形化编程后能轻松实现代码编程进阶学习。

Codecraft 提供 **Web 在线版** 和 **PC 客户端** 两种使用方式，其中 PC 客户端支持 Windows 和 macOS 操作系统。使用 Web 在线版连接硬件设备，需要安装 Codecraft Assistant 工具，才能连接设备并上传 Codecraft 编程文件到设备。

以 Ubuntu 为例，Codecraft Assistant 的安装步骤如下：

1. 在[这里](https://ide.tinkergen.com/download/cn/)下载 Linux 版本的 Codecraft Assistant 软件包（.deb）

2. 执行下面命令安装 Codecraft Assistant（请将 xxx 替换为对应的版本名称）

   ```bash
   sudo dpkg -i CodecraftAssistant_xxx.deb
   ```

3. 如果上一步执行失败，请执行下面命令安装相关依赖，然后重新执行上一步

   ```bash
   sudo apt install -y libdbusmenu-gtk4 gconf-service-backend 
                       gconf2-common libgconf-2-4 libappindicator1 
                       gconf-service gconf2
   ```

4. 执行下面命令切换目录并启动 Codecraft Assistant 设备助手

   ```bash
   cd /opt/CodecraftAssistant/
   ./cc-assistant
   ```



**相关链接**

- [Codecraft 在线版](https://ide.tinkergen.com/)
- [Codecraft 使用指南](https://www.yuque.com/tinkergen-help-cn/codecraft?language=zh-cn)
- [Codecraft 下载安装](https://ide.tinkergen.com/download/cn/)
