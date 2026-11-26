---
sidebar_position: 20
authors: [luhuadong]
---

# ROS2 使用 imu_tools



imu_tools 是一个 ROS 工具包，包含了与 IMU 相关的过滤器和可视化工具。你可以在 [GitHub](https://github.com/CCNYRoboticsLab/imu_tools) 找到它，该存储库包含：

- `imu_filter_madgwick`：一个过滤器，它将来自通用 IMU 设备的角速度、加速度和（可选）磁读数融合到一个方向中。 基于 [1](https://www.x-io.co.uk/open-source-imu-and-ahrs-algorithms/) 的工作。
- `imu_complementary_filter`：一种滤波器，它使用基于互补融合的新颖方法将来自通用 IMU 设备的角速度、加速度和（可选）磁读数融合到方向四元数中。 基于 [2](https://www.mdpi.com/1424-8220/15/8/19302) 的工作。
- `rviz_imu_plugin` 用于显示 `sensor_msgs::Imu` 消息的 rviz 插件

IMU-related filters and visualizers. The repository contains:

- `imu_filter_madgwick`: a filter which fuses angular velocities, accelerations, and (optionally) magnetic readings from a generic IMU device into an orientation. Based on the work of [1](https://www.x-io.co.uk/open-source-imu-and-ahrs-algorithms/).
- `imu_complementary_filter`: a filter which fuses angular velocities, accelerations, and (optionally) magnetic readings from a generic IMU device into an orientation quaternion using a novel approach based on a complementary fusion. Based on the work of [2](https://www.mdpi.com/1424-8220/15/8/19302).
- `rviz_imu_plugin` a plugin for rviz which displays `sensor_msgs::Imu` messages



## 安装

### From binaries

This repo has been released into all current ROS1 and ROS2 distros. To install, simply:

```bash
sudo apt install ros-<YOUR_ROSDISTO>-imu-tools
```

例如：

```bash
sudo apt install ros-foxy-imu-tools
```





## 使用

`imu_filter_madgwick`：一种[滤波器](https://so.csdn.net/so/search?q=滤波器&spm=1001.2101.3001.7020)，可将来自常规IMU设备的角速度，加速度和磁力计读数（可选）融合到一个方向中。基于工作：

http://www.x-io.co.uk/open-source-imu-and-ahrs-algorithms/



`imu_complementary_filter`：一种滤波器，它使用一种基于互补融合的新颖方法，将来自通用IMU设备的角速度，加速度和磁力计读数（可选）融合到方向四元数中。基于文献：

http://www.mdpi.com/1424-8220/15/8/19302



`rviz_imu_plugin`：rviz插件，可显示`sensor_msgs::Imu`消息。







