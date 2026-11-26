---
sidebar_position: 17
authors: [luhuadong]
---

# ROS2 和 ROS1 的 rosbag 转换

![ROS2 和 ROS1 的 rosbag 转换](https://static.getiot.tech/rosbag-convert.png#center)

rosbag 是 ROS 中的一种常用的数据记录和回放工具，用于捕获和存储 ROS 消息。但是 ROS1 和 ROS2 的 rosbag 存储格式是不一样的，因此在使用过程中，常常会有 rosbag 格式转换的需求。因此，本文将介绍 ROS1 和 ROS2 中的 rosbag 格式，并演示如何使用 rosbags 工具进行转换。



## rosbag 格式

在 ROS1 中，rosbag 的文件后缀是 .bag，它是一种基于二进制的 ROS 消息存储格式。它将消息以二进制形式写入文件，每个消息都包含一个时间戳和一个消息体。这种格式的好处是可以高效地存储大量的消息数据，但也存在一些限制，例如不支持跨平台的消息兼容性和扩展性。

因此，ROS2 对 rosbag 格式进行了一些改进和扩展，采用了一种基于 SQLite 的数据库格式，包括一个 .db3 数据库和一个 .yaml 文件，可以更好地支持跨平台的消息兼容性和扩展性。它将 ROS 消息存储为表格形式，每个表格都包含时间戳、消息类型和消息数据。这种格式的好处是可以更灵活地查询和过滤消息数据，并且支持更多的数据类型和结构。

总的来说，ROS1 的 rosbag 使用基于二进制的格式，而 ROS2 使用基于 SQLite 的数据库格式。前者格式相对较为固定，不支持动态扩展；而后者格式更灵活，具有更好的跨平台兼容性和扩展性，同时支持更灵活的查询和过滤。对于需要在不同平台之间共享和分析 ROS 消息数据的用户来说，ROS2 的 rosbag 格式可能是更好的选择。



## 常见的 rosbag 转换方法

目前来看，比较常见的转换方法是利用 ros2_bridge 转录，简单来说就是同时启动 ROS1 和 ROS2，通过 ROS2 的 `ros2 bag play` 命令播放 rosbag 数据，同时通过 ROS1 的 `rosbag record` 命令录制，从而实现 rosbag 数据格式的转换。

下面是命令操作示例：

```bash
# 1. 新建两个终端窗口，分别设置 ROS1 和 ROS2 的环境变量
# 2. 在 ROS2 的终端启动 ros1_bridge
$ ros2 run ros1_bridge dynamic_bridge
# 3. 播放 ROS2 的 rosbag
$ ros2 bag play <your-ros2-bag>
# 4. 录制 ROS1 的 rosbag（在另一个终端）
$ rosbag record <target-topic>
```

这个方法虽然很直接，但是也有明显的缺点。首先是需要同时安装 ROS1 和 ROS2 环境；然后是需要一边播放，一边录制，转换的时间依赖于 rosbag 文件的长度；如果数据量较大，比如 LiDAR 的点云数据，在转录的时候很容易丢失数据。



## 使用 rosbags 转换工具

鉴于 ros2_bridge 转录的限制，我们更推荐使用一个叫 **[rosbags](https://pypi.org/project/rosbags/)** 的工具进行转换，它不依赖于 ROS1 和 ROS2 环境，可以非常快速地实现 .bag 和 .db3 格式的相互转换。

rosbags 是一个 Python 编写的工具，可通过 pip 进行安装：

```bash
pip install rosbags
```

以后如果需要更新 rosbags，可以执行下面命令：

```bash
pip install --upgrade rosbags
```

安装好之后，系统会增加一个 `rosbags-convert` 命令，转换方法非常简单。例如：

**将 ROS2 的 rosbag 转换为 ROS1 格式：**

```bash
rosbags-convert <your-ros2-bag>
```

**将 ROS1 的 rosbag 转换为 ROS2 格式：**

```bash
rosbags-convert <your-ros1-bag>
```

稍等片刻，你的 rosbag 就转换好了！
