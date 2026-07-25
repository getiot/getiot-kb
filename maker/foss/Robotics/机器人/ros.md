---
sidebar_position: 11
sidebar_label: ROS/ROS2
slug: /ros
---

# ROS/ROS2 机器人操作系统

**ROS** 是 **Robot Operating System** 的缩写，通常译为“机器人操作系统”。严格来说，ROS 不是传统意义上的操作系统，而是一套用于构建机器人应用的软件库、通信机制、工具链和生态系统。

ROS 的核心价值是：把机器人系统拆成多个相对独立的节点，让传感器、算法、控制器、可视化工具和仿真环境可以通过标准接口协同工作。

## ROS 和 ROS 2 的区别

ROS 最早主要指 ROS 1。随着机器人系统对实时性、可靠性、分布式部署和工业化能力的要求提高，社区推出了 ROS 2。

你可以这样理解：

| 项目 | ROS 1 | ROS 2 |
| --- | --- | --- |
| 通信机制 | 自研通信机制，依赖 roscore | 基于 DDS，不依赖 roscore |
| 分布式能力 | 可用，但工程化能力有限 | 原生面向分布式系统 |
| 实时性 | 支持有限 | 更适合实时和工业场景 |
| 安全机制 | 较弱 | 支持 DDS Security 等机制 |
| 当前状态 | 仍有大量历史项目使用 | 新项目通常优先选择 ROS 2 |

如果你是新项目或刚开始学习，建议优先学习 ROS 2；如果你维护旧机器人项目，仍然可能遇到 ROS 1。

## 核心概念

学习 ROS/ROS 2 时，你会反复遇到这些概念：

- **Node**：节点，机器人应用中的一个独立功能模块。
- **Topic**：话题，用于发布和订阅连续数据，例如相机图像、点云、里程计。
- **Message**：消息，Topic 中传输的数据结构。
- **Service**：服务，用于请求-响应式调用。
- **Action**：动作，用于长时间任务，例如导航到某个目标点。
- **Parameter**：参数，用于配置节点行为。
- **Launch**：启动文件，用于一次启动多个节点和配置。
- **Bag**：数据记录文件，用于保存和回放机器人数据。

这些概念的目的都是降低机器人系统集成复杂度。

## ROS/ROS 2 适合做什么

ROS/ROS 2 常用于：

- 移动机器人
- 机械臂
- 无人车
- 无人机研究平台
- 传感器驱动集成
- SLAM、导航、路径规划
- 仿真和可视化
- 多传感器数据记录与回放

对于学习者来说，ROS/ROS 2 的优势是资料多、社区大、示例丰富。你可以从简单的发布/订阅程序开始，再逐步进入导航、机械臂和仿真。

## 常用工具

ROS/ROS 2 生态中常见工具包括：

- **RViz**：机器人数据可视化工具。
- **Gazebo**：机器人仿真环境（原 Ignition，现统一称为 Gazebo）。
- **rosbag / rosbag2**：记录和回放数据。
- **rqt**：图形化调试工具集合。
- **colcon**：ROS 2 常用构建工具。
- **Foxglove Studio**：现代机器人数据可视化工具，可参考 [Foxglove Studio](/foss/foxglove-studio/)。

## 学习建议

如果你刚开始学习，建议按这个顺序：

1. 安装一个当前仍受支持的 ROS 2 distribution（常见 LTS 如 Humble、Jazzy，具体以官方推荐为准）。
2. 跑通官方 turtlesim 或 talker/listener 示例。
3. 理解 Node、Topic、Message。
4. 学习 Service、Action 和 Parameter。
5. 学习 Launch 文件。
6. 使用 RViz 或 Foxglove Studio 观察数据。
7. 再进入 SLAM、Navigation、MoveIt 等具体方向。

:::note
ROS 2 的 distribution 有支持周期。选择版本时应以官方文档当前推荐为准，不要只照旧教程安装已经停止维护的版本。
:::

## 常见误区

### ROS 不是机器人算法本身

ROS 提供框架、工具和生态，但不会自动帮你完成定位、规划或控制。你仍然需要理解算法和机器人硬件。

### 学 ROS 不等于学会机器人

ROS 是重要工具，但机器人系统还涉及传感器、运动学、控制、实时系统、机械结构、电气安全等内容。

### 不要一开始就堆复杂系统

初学时先跑通两个节点之间的通信，再逐步增加传感器、可视化、仿真和导航模块。

## 资源链接

- ROS 官网：[https://www.ros.org](https://www.ros.org)
- ROS 文档入口：[https://docs.ros.org](https://docs.ros.org)
- ROS 2 文档：[https://docs.ros.org/en/rolling/](https://docs.ros.org/en/rolling/)
- ROS 2 GitHub 组织：[https://github.com/ros2](https://github.com/ros2)
- Robotics Stack Exchange：[https://robotics.stackexchange.com](https://robotics.stackexchange.com)

## 小结

ROS/ROS 2 是机器人软件开发中最重要的开源生态之一。它的价值在于标准化模块通信、工具链和系统集成方式。新项目通常建议优先学习 ROS 2，但维护旧系统时仍需要理解 ROS 1。
