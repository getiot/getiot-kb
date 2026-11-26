---
sidebar_position: 11
authors: [luhuadong]
---

# ROS2 话题（Topic）



```bash
ros2 topic list   # 查看 ROS 话题
ros2 topic echo /your_topic  # 查看话题数据
```



在 ROS2 中，`ros2 topic echo`是一个用于查看指定话题（Topic）数据的命令行工具。它可以让用户在终端上实时地查看ROS2节点之间传输的数据。

具体来说，`ros2 topic echo` 命令的作用是：

1. 订阅指定话题：用户需要指定想要查看的话题名称，如`ros2 topic echo /camera/depth/image_raw`。
2. 显示数据：一旦订阅成功，`ros2 topic echo` 就会开始显示从该话题发布的数据。对于不同类型的话题，显示的数据也有所不同。例如，对于传感器数据，显示的内容通常是该传感器测量到的物理量，如距离、速度等；对于图像数据，显示的是图像的像素值等信息。
3. 实时更新：`ros2 topic echo` 会持续不断地显示从话题发布的数据，直到用户手动终止该命令。在显示过程中，用户可以随时使用 CTRL-C 中断命令并退出。

通过使用 `ros2 topic echo`，用户可以快速地了解话题发布的数据内容，以及实时监控系统的运行状态，方便开发和调试。

