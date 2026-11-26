---
sidebar_position: 29
sidebar_label: LiDAR SDK 软件包
authors: [luhuadong]
---

# 激光雷达 SDK 软件包



本文收集目前主要激光雷达厂商的 SDK 软件包，其中大多还会提供 ROS（ROS1 和/或 ROS2）驱动软件包。使用这些 SDK 软件包，可以快速地将激光雷达集成到你的智能系统中，包括工业自动化、智能基础设施、机器人、自动驾驶汽车等应用领域。



## Ouster

Ouster 为其激光雷达产品提供了两个 SDK 软件包：

- [ouster-sdk](https://github.com/ouster-lidar/ouster_example)：提供了与激光雷达硬件交互接口的 SDK，并提供 C++ 和 Python 接口，以及测试数据、测试工具和示例参考代码。
- [ouster-ros](https://github.com/ouster-lidar/ouster-ros)：基于 ouster-sdk 的 ROS 驱动软件包，支持 ROS1 和 ROS2。

Ouster SDK 提供的功能包括：

- 查询和设置传感器配置；
- 以 pcap 格式录制和读取数据；
- 可靠地读取和缓冲传感器 UDP 数据流；
- 将原始数据转换为深度/信号/近红外/反射率图像（去交错）；
- 距离测量到笛卡尔 (x, y, z) 坐标的有效投影；
- 多波束闪光激光雷达数据的可视化。

另外，在 Python 的实现中，SDK 还提供以下功能：

- 基于帧访问激光雷达数据作为 numpy 数据类型；
- 用于 pcap 和传感器的响应式可视化工具。

Python 版本的 ouster-sdk 库通过 [PyPI](https://pypi.org/project/ouster-sdk/) 发布，可通过下面命令安装：

```bash
pip install ouster-sdk
```

在线文档：[https://static.ouster.dev/sdk-docs/](https://static.ouster.dev/sdk-docs/)



## 速腾

速腾聚创（RoboSense）为其激光雷达提供的 SDK，主要包括 rs_driver 和 rslidar_sdk 两部分。

- [rs_driver](https://github.com/RoboSense-LiDAR/rs_driver)：速腾雷达驱动核心软件包，支持包括 RS-LiDAR-16、RS-LiDAR-32、RS-Bpearl、RS-Helios、RS-Helios-16P、RS-Ruby-128、RS-Ruby-80、RS-Ruby-48、RS-Ruby-Plus-128、RS-Ruby-Plus-80、RS-Ruby-Plus-48、RS-LiDAR-M1、RS-LiDAR-M2、RS-LiDAR-E1 等所有型号的激光雷达。
- [rslidar_sdk](https://github.com/RoboSense-LiDAR/rslidar_sdk)：在 ROS 环境下的雷达驱动软件包，支持 ROS1 和 ROS2。

rslidar_sdk 软件包的核心是 rs_driver，如果你希望基于 ROS/ROS2 进行二次开发，可以直接使用 rslidar_sdk 软件包。配合 ROS/ROS2 自带的 rviz 可视化工具，可以查看点云。如果你希望将雷达驱动集成到自己的工程，作更深一步的二次开发，那么可以基于 rs_driver 进行开发。



## 禾赛

禾赛（Hesai）为其激光雷达提供的 SDK 相对来说比较散乱，下面列出比较通用的两个 SDK。

- [HesaiLidar_General_SDK](https://github.com/HesaiTechnology/HesaiLidar_General_SDK)：禾赛雷达核心驱动软件包，支持 Pandar40P、Pandar64、Pandar20A、Pandar20B、PandarQT、Pandar40M、PandarXT 等型号激光雷达。
- [HesaiLidar_General_ROS](https://github.com/HesaiTechnology/HesaiLidar_General_ROS)：基于 HesaiLidar_General_SDK 的 ROS 驱动软件包，只支持 ROS1。

**2023年11月更新** 👇

可能是原来的 SDK 设计太混乱了，最近官方开源了 2.0 版本的 SDK，包括两个仓库：

- [HesaiLidar_SDK_2.0](https://github.com/HesaiTechnology/HesaiLidar_SDK_2.0)：核心驱动软件包，支持 Pandar、AT128、QT、FT120 和 XT16/XT32 激光雷达，依赖 PCL、Boost 等库。
- [HesaiLidar_ROS_2.0](https://github.com/HesaiTechnology/HesaiLidar_ROS_2.0)：基于 HesaiLidar_SDK_2.0 的 ROS 驱动软件包，同时支持 ROS1 和 ROS2。



## 览沃

览沃（Livox）为其激光雷达提供的 SDK 相对比较规范，并且提供了较为完善的说明文档。

- [Livox-SDK](https://github.com/Livox-SDK/Livox-SDK)：览沃雷达核心驱动软件包，支持 Mid-40、Mid-70、Tele-15、Horizon、Avia 系列型号激光雷达。
- [Livox-SDK2](https://github.com/Livox-SDK/Livox-SDK2)：览沃雷达核心驱动软件包，支持 HAP、Mid-360 系列型号激光雷达。
- [livox_ros_driver](https://github.com/Livox-SDK/livox_ros_driver)：览沃雷达 ROS1 驱动软件包。
- [livox_ros_driver2](https://github.com/Livox-SDK/livox_ros_driver2)：览沃雷达 ROS2 驱动软件包。

在线文档：

- [Livox Wiki 英文页面](https://livox-wiki-en.readthedocs.io/en/latest)
- [Livox Wiki 中文页面](https://livox-wiki-cn.readthedocs.io/zh_CN/latest)

