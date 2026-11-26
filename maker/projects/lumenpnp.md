---
sidebar_position: 3
---

# 开源贴片机 LumenPnP

![开源贴片机 LumenPnP](https://static.getiot.tech/lumenPnP-banner.webp#center)

**LumenPnP** 是由 [Opulo](https://opulo.io/) 推出的一个开源桌面贴片机（Pick-and-Place Machine）项目，它旨在为个人制造者、小型企业、创客空间等提供一个可负担、易组装、可维护的 SMT 自动化贴片解决方案。

简而言之：LumenPnP 可以帮助你自动地将元件贴装在 PCB 上，就像工厂里的自动化 SMT 产线那样。



## 谁适合使用 LumenPnP

LumenPnP 适合以下人群：

- 电子制造爱好者
- 独立开发者和小批量生产者
- 创客空间和教学机构
- 对自动化制造感兴趣的技术人员

你可以用 LumenPnP 完成一些小批量商业电子产品的生产，例如 Arduino 扩展板、ESP32 模块开发板、自定义传感器板、灯板等。



## 项目亮点

- 完全开源硬件和软件
- 支持 DIY 半组装和全组装版本
- 基于标准机械结构和模块化设计
- 由社区驱动并持续更新
- 使用常见的控制系统（如 Raspberry Pi + OpenPnP）



## 主要组成

LumenPnP 的主要组成部分包括：

1. **机械结构：**
   - 使用 **V-slot 铝型材** 作为框架
   - 配有直线导轨、步进电机、同步带
   - Z轴吸嘴用于吸取和放置元件
2. **控制系统：**
   - Raspberry Pi（运行 OpenPnP 控制软件）
   - 使用 PiCam 或 USB 相机进行定位识别
   - 控制板连接步进驱动器和端传感器
3. **喂料系统**（Feeder，俗称“飞达”）：
   - 支持卷带元件（使用 DIY 或商业喂料器）
   - 还可搭配手动托盘或吸嘴更换系统
4. **软件系统：**
   - 基于 OpenPnP 开源软件
   - 提供摄像头校准、视觉识别、贴装路径规划等功能



## 如何开始

官方提供了**两种组装方式**：

**① Semi-Assembly（半组装版本）**

特点：

- 部分机械结构已预装好
- 用户主要负责电子线缆和最终组装
- 官方文档提供详细图示和视频

适合：希望自己动手并节省成本的用户

**② Fully Assembled（全组装版本）**

- 工厂预装完毕，开箱即用
- 调试和软件设置由用户完成
- 比较适合初次接触贴片机但希望快速上手的用户



## 搭建流程

下面以 Semi-Assembly 方式为例，介绍搭建一台 LumenPnP 贴片机的大致步骤，完整细节请参考官方文档。

1. **准备工具和材料**
   - 六角扳手、螺丝刀、卡尺、电烙铁
   - Raspberry Pi 4、SD 卡、相机模组
   - 需要组装的半成品结构
2. **安装并固定机械结构**
   - 确保 XYZ 三轴结构平整且移动顺畅
   - 安装电机和皮带驱动
3. **连接电气线路**
   - 接好步进驱动器、电源线、传感器线
   - 将 Raspberry Pi 与主控板连接
4. **软件安装与配置**
   - 安装 OpenPnP 和系统依赖
   - 校准坐标系统、相机视野和吸嘴偏移
   - 加载元件库和贴装任务
5. **测试贴片与调试**
   - 使用简单的 PCB 项目测试贴片准确性
   - 调整吸嘴高度、喂料器位置等参数



## 控制软件

LumenPnP 是基于 **OpenPnP** 实现贴装控制逻辑的。OpenPnP 本身是一个**开源贴片机控制系统**，用于控制 DIY 或商用贴片机执行元件贴装任务。但 OpenPnP 不包含硬件部分，它目标是为开发者和制造者提供一个灵活、强大、可扩展的贴片控制平台。

OpenPnP 通常运行在一台 **PC** 或**树莓派**（如 LumenPnP 用的是 Raspberry Pi 4） 上，系统结构如下：

```bash
[ OpenPnP 软件 ]
       |
       v
[ Gcode 控制接口 / JSON-Serial ]
       |
       v
[ 主控板（如 Smoothieboard、Opulo 控制器）]
       |
       v
[ 电机、传感器、摄像头、吸嘴等硬件 ]
```

OpenPnP 的主要功能包括：

- 🎯 **视觉识别**：通过摄像头识别元件、Mark 点、PCB 定位等。
- 🧠 **路径规划**：自动规划吸取和贴放元件的最优路径。
- 🧲 **吸嘴控制**：控制贴片机吸嘴的上下动作、旋转角度。
- 🔢 **元件数据库**：管理所有元件信息（封装类型、吸取偏移等）。
- 🧰 **喂料器管理**：配置卷带喂料器、托盘、托盘槽等信息。
- 📦 **贴装任务管理**：加载 Pick & Place 文件（如 .csv）执行贴装作业。

OpenPnP 是基于 Java 的开发的一个模块化、插件化、跨平台的应用程序，因此需要安装 JDK 环境才能运行。

![OpenPnP 软件界面](https://static.getiot.tech/OpenPnP-UI-01.webp)

OpenPnP 提供一个图形化桌面应用，主要界面包括：

- 元件视图：查看所有贴装元件和参数
- 视觉调试：实时显示上下相机画面，调试定位功能
- 机器控制：移动 XYZ 轴、旋转吸嘴、吸放元件
- 路径仿真：可视化贴装流程，预防出错
- 配置向导：引导用户完成首次配置流程

OpenPnP 还提供了一套强大的插件框架，支持：

- 加载外部 `.jar` 插件
- 实现定制的视觉算法（如 blob detection、边缘检测）
- 接入第三方 AI 模块（如 TensorFlow 图像识别）
- 开发自定义驱动（用于非标准控制器）

可以说软件的完整性和可玩性都非常高，喜欢 DIY 的朋友可以开始动手了！



## 资源链接

- 🌐 官网主页：[https://opulo.io](https://opulo.io)
- 📘 官方文档：[https://docs.opulo.io/semi-assembly-4-0/](https://docs.opulo.io/semi-assembly-4-0/)
- 🧠 软件平台：[http://openpnp.org](http://openpnp.org)
- 📂 LumenPnP 源码库：[https://github.com/opulo-inc/lumenpnp](https://github.com/opulo-inc/lumenpnp)
- 📂 OpenPnP 源码库：[https://github.com/openpnp/openpnp](https://github.com/openpnp/openpnp)
