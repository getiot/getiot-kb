---
sidebar_position: 21
authors: [luhuadong]
---

# Rviz2 显示 USB 摄像头



## 安装依赖

```bash
sudo apt install ros-foxy-camera*
sudo apt install ros-foxy-usb-cam*
```



## 启动摄像头节点

```bash
ros2 launch usb_cam demo_launch.py
```



## 启动 Rviz2

![](https://static.getiot.tech/rviz2-add-camera-image.png)

## v4l2_camera 软件包

https://gitlab.com/boldhearts/ros2_v4l2_camera

```bash
ros2 run v4l2_camera v4l2_camera_node
```

指定设备节点

```bash
ros2 run v4l2_camera v4l2_camera_node --ros-args -p video_device:=/dev/video3
```



