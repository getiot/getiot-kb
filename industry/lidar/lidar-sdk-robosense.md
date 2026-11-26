---
sidebar_position: 31
sidebar_label: 速腾激光雷达 SDK 介绍
draft: true
authors: [luhuadong]
---

# 速腾激光雷达 SDK 介绍



https://github.com/RoboSense-LiDAR

速腾聚创 RoboSense

仓库说明

| 仓库        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| rslidar_sdk | Ubuntu 环境下的雷达驱动软件包，包括如下内容：<br/>- 雷达驱动内核 rs_driver<br/>- ROS 拓展功能<br/>- ROS2拓展功能 |
| rs_driver   | RoboSense 雷达驱动内核                                       |



rs_driver 支持 RoboSense 的两种雷达：

- 机械式雷达。如 RS16/RS32/RSBP/RSHELIOS/RS80/RS128。机械式雷达有控制激光发射角度的旋转部件，有 360° 扫描视场。
- MEMS 雷达。如 RSM1。MEMS 雷达是单轴、谐振式的 MEMS 扫描镜，其水平扫描角度可达 120°。



RoboSense雷达与电脑主机的通信协议有三种。

- MSOP (Main data Stream Ouput Protocol)。 激光雷达将扫描出来的距离、角度、反射率等信息封装成MSOP Packet，输出给电脑主机。
- DIFOP (Device Information Output Protocol)。激光雷达将自身的配置信息，以及当前的状态封装成DIFOP Packet，输出给电脑主机。
- UCWP (User Configuration Write Protocol)。用户可以修改激光雷达的某些配置参数。

rs_driver处理前两类协议的包，也就是MSOP Packet和DIFOP Packet。
