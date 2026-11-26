---
sidebar_position: 21
slug: /ros-rplidar-a1
authors: [luhuadong]
---

# ROS 连接 RPLIDAR A1 激光雷达



RPLIDAR A1 是思岚（SLAMTEC）推出的一款低成本 360 度激光扫描测距雷达，可以实现在二维平面的 12 米半径范围内进行 360 度全方位的激光测距扫描，并产生所在空间的平面点云地图信息。这些云地图信息可用于地图测绘、机器人定位导航、物体/环境建模等实际应用中。

![](https://static.getiot.tech/rplidar_A1.png#center)

关于 RPLIDAR A1 的详细介绍请参考《[RPLIDAR 思岚 A1 激光雷](/sensor-module/slamtec-rplidar-a1/)》



## 硬件连接





## 使用步骤

下载 rplidar_ros 软件包源代码

```bash
$ cd ~/catkin_ws/src
$ git clone https://github.com/Slamtec/rplidar_ros.git
```

编译 rplidar_ros 软件包

```bash
$ cd ../
$ catkin_make
```

将当前 Catkin 工作空间添加到 ROS 系统

```bash
$ source devel/setup.bash
```

启动 ROS 节点展示 RPLIDAR A1 扫描的点云数据

```bash
$ roslaunch rplidar_ros view_rplidar.launch
```

一切顺利的话，就会在 Rviz 界面中看到 RPLIDAR A1 激光雷达的点云。

![](https://static.getiot.tech/ROS-Rviz-view-rplidar-A1.png#center)





