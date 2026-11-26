---
sidebar_position: 10
sidebar_label: LiDAR 点云可视化软件
authors: [luhuadong]
---

# 激光雷达（LiDAR）点云可视化软件

本文介绍在激光雷达领域常用的一些 3D 点云可视化软件，除了显示点云数据以外，通常还包含一些非常实用的功能，例如过滤、测量、统计等等，其中一些工具还提供了强大的点云算法，例如点云滤波、分类、拟合等等，对于激光雷达和 3D 点云的开发非常重要。



## CloudCompare

CloudCompare 是一款开源的三维点云（Point Cloud）处理软件，可以方便地使用计算法向量、优化法向量、泊松构网、滤波等功能。CloudCompare 具有不错的软件框架，可满足许多公司的二次开发需求。

![CloudCompare](https://static.getiot.tech/CloudCompare-screenshot-linux.png#center)

Linux 可以通过 Flathub 或 Snap 软件包方式安装，方法如下：

【Flathub】

```bash
flatpak install flathub org.cloudcompare.CloudCompare
```

【Snap】

```bash
snap install cloudcompare
```

提示：Snap 方式提供 stable、beta 和 edge 三种，你可以通过在终端中执行 `sudo snap refresh --<channel name>` 随时在这 3 个版本之间切换。

CloudCompare 的相关链接：

- 软件下载地址：[https://www.danielgm.net/cc/](https://www.danielgm.net/cc/)
- GitHub 仓库：[https://github.com/CloudCompare/CloudCompare](https://github.com/CloudCompare/CloudCompare)



## LidarView

LidarView 是一个用于对实时捕获的 3D LiDAR 数据进行实时可视化和处理的软件。它基于 ParaView 的应用程序，这意味着它基于开源的 Paraview 代码库，用于加载数据、显示数据并与之交互。在 ParaView 基础设施之上，LidarView 为多个激光雷达品牌提供特定的实时网络数据处理，以及与激光雷达相关的后处理工具。它还具有特定的用户界面，旨在实时查看和分析来自主要激光雷达制造商的激光雷达数据。

![](https://static.getiot.tech/lidarview_ui_view-1024x624.png#center)

LidarView 是 [VeloView](https://www.paraview.org/veloview)（Kitware 使用 Velodyne 开发）的品牌独立版本，独立于 Velodyne 并在 Apache 2.0 许可下提供实验性算法和功能。与品牌支持的版本相比，LidarView 可能会在某些情况下（例如不兼容的点云数据）导致崩溃。

LidarView 具有如下功能特性：

- 来自实时传感器流或记录的 .pcap 文件的输入；
- LiDAR 的可视化以 3D + 时间戳返回，包括 3D 位置坐标和属性数据，例如时间戳（timestamp）、方位角（azimuth）、激光 ID（laser id）等；
- 支持通过电子表格检查器（Spreadsheet inspector）查看的 LiDAR 属性，例如时间戳、方位角、激光 ID 等；
- 支持从传感器记录到 .pcap 文件；
- 支持导出为 CSV、PLY、PCD、LAS 或 VTK 格式；
- 记录和导出 GPS 和 IMU 数据（暂时移除）；
- 可视化 GPS 数据的路径（暂时移除）；
- 网格和标尺工具；
- 显示或隐藏激光的子集；
- 同时显示多帧数据并聚合它们；
- 支持点云的 3D 变换；
- 运行 SLAM 估计 LiDAR 在场景中的轨迹并构建环境的 3D 地图。

LidarView 的相关链接：

- GitLab 仓库：[https://gitlab.kitware.com/LidarView/lidarview](https://gitlab.kitware.com/LidarView/lidarview)
- GitHub 镜像仓库：[https://github.com/Kitware/LidarView](https://github.com/Kitware/LidarView)
- LidarView 主页：[https://www.paraview.org/lidarview](https://www.paraview.org/lidarview/)



## VeloView

VeloView 是 Velodyne 的 LidarView 的意思。它使用特定的 VelodynePlugin 和 Velodyne Lidar 数据包解释器来处理传统数据包格式（HDL64/32、VLP16/32、VLS128）和高级数据包格式（Velarray、VLS128、Velabit）。

VeloView 的相关链接：

- GitLab 仓库：[https://gitlab.kitware.com/LidarView/VeloView-Velodyne](https://gitlab.kitware.com/LidarView/VeloView-Velodyne)
- GitHub 镜像仓库：[https://github.com/Kitware/VeloView](https://github.com/Kitware/VeloView)
- VeloView 主页：[https://www.paraview.org/VeloView](https://www.paraview.org/VeloView)



## Rviz

ROS 机器人操作系统提供的 Rviz 也是一个点云可视化的实用工具，通过订阅点云消息主题，接收并显示点云数据。

![Rviz 显示激光雷达点云数据](https://static.getiot.tech/Rviz2-screenshot.png#center)



## CloudViewer

CloudViewer （点云可视化软件）是一款面向三维点云数据处理、点云开发专业人员及爱好者的三维点云可视化软件，该软件具备以下功能：

1. **点云 IO**。常见点云格式文件（如 ply、pcd 和 obj）的读取、保存、删除清空及可视化。
2. **点云的基本操作**。设置点云颜色，合并多个点云，点云格式转换等。
3. **可视化的基本操作**。设置视图窗口背景颜色，设置点云的可视化尺寸，设置坐标系的显示，设置视图方位（Main view、Left view、Top view），网格面片显示，网格线框显示等。
4. **模型生成**。生成简单立方排布的点云以及基本三维模型，该功能主要用于测试。
5. **软件界面基本功能**。软件由：菜单栏、工具栏、资源管理树、属性管理器、输出窗口、状态栏、视图窗口以及 RGB 窗口组成。其中部分都是停靠窗口，可以在菜单栏的视图选项设置是否显示，方便用户自定义软件界面。软件还提供 Windows 和 Darcula 两大主题，其中 Darcula 主题为默认主题，仿照 Visual Studio 和 Android Studio 相应暗系主题设计，极具极客风范。

CloudViewer 的相关链接：

- GitHub 仓库：[https://github.com/nightn/CloudViewer](https://github.com/nightn/CloudViewer)



