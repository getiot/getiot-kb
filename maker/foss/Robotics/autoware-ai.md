---
sidebar_position: 3
sidebar_label: Autoware.AI
slug: /autoware-ai
---

# Autoware.AI 开源自动驾驶软件栈

**Autoware.AI** 是由 Autoware Foundation 推出的全球首个“一体化”开源自动驾驶软件栈，旨在为自动驾驶系统的研究与开发提供完整的解决方案。该项目最早于 2015 年由日本名古屋大学加藤伸平教授领导的研究团队首次发布，随后由 Tier IV 公司进行维护和推广。

技术上，Autoware.AI 基于 [ROS 1](/ros/)（Robot Operating System）开发，采用 Apache 2.0 许可证。目前已被全球 100 多家公司在 30 多种车型上应用，涵盖城市道路、高速公路、园区等多种场景。



## 系统架构

Autoware.AI 的架构主要分为三个层级：Sensing（感知）、Computing（计算）和 Actuation（执行），各层级包含以下关键模块：

#### **1. 感知（Sensing）**

- **传感器支持**：支持多种传感器，包括激光雷达（LiDAR）、摄像头、毫米波雷达、GNSS 和 IMU 等。
- **数据采集**：采集原始数据，如点云、图像和位置信息，为后续处理提供基础。

#### **2. 计算（Computing）**

- **定位**（Localization）：结合 GNSS、IMU 和 3D 地图，或使用 SLAM 算法，实现高精度定位。
- **感知**（Perception）：通过传感器融合和深度学习算法，识别车辆、行人、交通标志等目标。
- **预测与规划**（Prediction & Planning）：基于感知结果，预测动态目标行为，并生成安全、平滑的行驶路径。
- **决策**（Decision）：采用基于规则的系统，决定车辆的驾驶行为，如变道、避障等。

#### **3. 执行（Actuation）**

- **控制**（Control）：将规划结果转化为车辆的速度和转向指令，控制车辆的实际运动。



## 未来发展

Autoware.AI 是基于 **ROS 1** 开发的，由于 ROS 1 的一些局限性（如缺乏实时性支持、依赖中心节点管理等），使得 Autoware.AI 在功能扩展和维护上存在一定的挑战。因此，Autoware 基金会在 2022 年底正式停止了 Autoware.AI 的维护，并推荐开发者转向基于 **ROS 2** 的后续版本，如 Autoware.Auto 和 Autoware.Universe

目前新版本 Autoware Core 和 Autoware Universe 仍在持续开发中，它们继承了 Autoware.AI 的核心理念，并在此基础上进行了优化和扩展，以满足自动驾驶技术不断发展的需求。



## 相关链接

- [Autoware 项目官网](https://autoware.org)
- [Autoware GitHub 主页](https://github.com/autowarefoundation)
- [Autoware.AI 代码仓库（已停止维护）](https://github.com/autowarefoundation/autoware_ai)
- [Autoware Core 代码仓库](https://github.com/autowarefoundation/autoware_core)
- [Autoware Universe 代码仓库](https://github.com/autowarefoundation/autoware_universe)
