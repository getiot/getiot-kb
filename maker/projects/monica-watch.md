---
sidebar_position: 4
---

# Monica 开源智能手表



![Monica 开源智能手表](https://static.getiot.tech/monica-watch-cover_1080px.jpeg#center)



Monica 是一个基于 ESP32-S3 实现的开源 AMOLED 智能手表。AMOLED 是一种显示屏技术，具有反应速度较快、对比度更高、视角较广、刷新率更高、尺寸更薄等特点，常用于智能手表、平板电脑、便携式音乐播放器、游戏机等数码产品中。



## 硬件架构

- **主控**：ESP32-S3，32M 外置 Flash
- **IMU**：BMI270 + BM150 （抬手唤醒、计步器、指南针）
- **电源管理**：AXP2101
- **其他**：SD卡槽、RTC、蜂鸣器、MIC、气压传感、按键
- [**屏幕**](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.a41c2e8dNZ5GOq&id=688638221390)：1.8寸 Amoled 368*448
- **[电池](https://detail.tmall.com/item.htm?_u=42bdtj0f19f8&id=632947661144)**：402728 400毫安



## 软件架构

![Monica 开源智能手表软件架构](https://static.getiot.tech/monica-watch-firmware.png#center-500)

### 驱动层

- **HAL**：外设驱动的对象抽象。
- **Hardware Manager**：硬件管理层。负责底层的硬件初始化、运行时的状态维护更新，例如自动睡眠、抬手唤醒、计步器更新等。
- **USB MSC 模式**：为了读写 SD 卡方便，同时按「电源」和「下」按键启动时，会进入 USB MSC 模式，SD 卡会被挂载成 U盘，接上 USB 即可直接读写。

### 应用层

- **App 基类、安装卸载**框架：所有 App 的对象基类，描述了 App 的基础框架。安装卸载框架实现简单的 App 列表管理。
- **App 生命周期管理**：支持前后台的 App 运行生命周期调度器（单线程，单前台，多后台），使用状态机（FSM）实现。

### 应用和驱动层解耦

- [**SimpleKV**](https://github.com/Forairaaaaa/simplekv.git)：简单的 Key-Value（键-值）内存数据库框架，实现两层的数据交互。使用键（字符串）索引数据，切断应用层和驱动层的数据耦合。
- [**LVGL**](https://github.com/lvgl/lvgl.git)： 使用 LVGL 作上层应用默认图形库，及其文件系统接口。



## 相关链接

- 软件开源：[https://github.com/Forairaaaaa/monica](https://github.com/Forairaaaaa/monica)
- 硬件开源：[https://oshwhub.com/eedadada/monica](https://oshwhub.com/eedadada/monica)
- 视频介绍：[https://www.bilibili.com/video/BV1AP411Q7dk](https://www.bilibili.com/video/BV1AP411Q7dk)

