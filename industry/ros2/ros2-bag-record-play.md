---
sidebar_position: 16
authors: [luhuadong]
---

# ROS2 录制和回放



`ros2 bag` 是一个命令行工具，用于录制系统话题发布的数据。它可以记录经过任意个话题的数据，并保存到一个数据库中，你可以回放这些数据进行复现测试或实验的结果。记录话题也是一个很好分享你工作内容的方式，让别人进行再创造（你的工作）。



为了记录话题发布的数据，使用以下指令语法：

```bash
ros2 bag record <topic_name>

ros2 bag record -o subset /turtle1/cmd_vel /turtle1/pose
```

在运行该指令之前，新开一个终端，进入之前创建的目录bag_files下（再运行该指令），因为rosbag文件回报存在你运行指令的目录下。运行指令：

```bash
```

输入 `ctrl+c` 停止录制。

收集到的数据保存在 `bag` 文件中，其名字样式如同`rosbag2_year_month_day-hour_minute_second`。



你可以查看录制内容，通过运行：

```bash
ros2 bag info <bag_file_name>
```

回放

```bash
ros2 bag play <bag_file_name>
```





