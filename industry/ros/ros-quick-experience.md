---
sidebar_position: 9
slug: /ros-quick-experience
draft: true
authors: [luhuadong]
---

# ROS 快速体验



本文通过几个小实验示例，带你快速体验 ROS 机器人操作系统。阅读并完成这些小实验，你将对 ROS 有一个大致的了解，便于以后更好地理解如何用 ROS 控制机器人。

提示：在开始之前，请先确保你已经完成 [ROS 的安装](/ros/ros-installation-noetic/)。



## ROS 实例：Hello World

当我们安装完 ROS 之后，就已经安装了一些 ROS 应用实例。下面先来看一个简单的 Hello World 实例。

在这个实例中，包含 talker 和 listener 两个节点。其中，talker 节点发布一个字符串消息，listener 节点则订阅这个消息。talker 和 listener 节点间的关系如下图所示。

![ROS 快速体验](https://static.getiot.tech/ROS-demo-talker-listener.png#center)

下面启动一个 Shell 终端，首先运行 roscore 命令：

```bash
$ roscore
```

新开一个 Shell 终端，运行 talker 节点：

```bash
$ rosrun roscpp_tutorials talker
```

此时，可以通过 `rostopic` 命令看到 ROS 系统中增加了 chatter 话题：

```bash
$ rostopic list
/chatter
```

在另一个 Shell 终端，运行 listener 节点：

```bash
$ rosrun roscpp_tutorials listener
```

现在，talker 和 listener 两个节点已经工作起来了，我们可以在终端看到 "hello world" 消息的传递。

```bash
$ rosrun roscpp_tutorials talker
[ INFO] [1653727234.492597108]: hello world 0
[ INFO] [1653727234.592746209]: hello world 1
[ INFO] [1653727234.692691386]: hello world 2
[ INFO] [1653727234.792815087]: hello world 3
[ INFO] [1653727234.892705453]: hello world 4
[ INFO] [1653727234.992795105]: hello world 5
[ INFO] [1653727235.092694703]: hello world 6
...
$ rosrun roscpp_tutorials listener
[ INFO] [1653727234.793428605]: I heard: [hello world 3]
[ INFO] [1653727234.893058760]: I heard: [hello world 4]
[ INFO] [1653727234.993181092]: I heard: [hello world 5]
[ INFO] [1653727235.093082177]: I heard: [hello world 6]
```

如果想要同时运行两个节点，可以使用 `roslaunch` 命令，如下：

```bash
$ roslaunch roscpp_tutorials talker_listener.launch
```

其中，roscpp_tutorials 是 ROS 中的一个教程包，其中包含一个 talker_listener.launch 文件。



## ROS 实例：turtlesim

前面是基于命令行的示例，接下来我们通过模拟器的方式来体验 ROS 系统。

turtlesim 是 ROS 自带的一个含有乌龟机器人的二维模拟器，我们可以用 ROS 话题、ROS 服务和参数服务器来移动乌龟，读取乌龟的当前位置和改变乌龟的颜色等。

我们可以使用如下命令启动 turtlesim 应用：

```bash
$ rosrun turtlesim turtlesim_node
```

此时可以看到一个 TurtleSim 图形窗口，中间有一个可爱的小乌龟：

![](https://static.getiot.tech/ROS-demo-turtlesim.png#center)

这个时候，我们可以先通过 `rostopic` 命令查看当前的话题，如下：

```bash
$ rostopic list
/rosout
/rosout_agg
/turtle1/cmd_vel
/turtle1/color_sensor
/turtle1/pose
```

通过 `rosservice` 命令查看 turtlesim 节点创建的服务列表，如下：

```bash
$ rosservice list
/clear
/kill
/reset
/rosout/get_loggers
/rosout/set_logger_level
/spawn
/turtle1/set_pen
/turtle1/teleport_absolute
/turtle1/teleport_relative
/turtlesim/get_loggers
/turtlesim/set_logger_level
```

通过 `rosparam` 命令查看 ROS 参数，如下：

```bash
$ rosparam list
/rosdistro
/rosversion
/run_id
/turtlesim/background_b
/turtlesim/background_g
/turtlesim/background_r
```



### 移动小乌龟

现在，我们可以在另一个 Shell 终端启动一个 ROS 节点，用于移动小乌龟。命令如下：

```bash
$ rosrun turtlesim turtle_teleop_key
```

我们可以通过电脑键盘上的方向键控制小乌龟，当按下任意一个方向键时，节点就会向 `/turtle1/cmd_vel` 话题发送乌龟移动的方向和速度值。

![](https://static.getiot.tech/ROS-demo-turtlesim-teleop_key.png#center)



### 正方形路线

关闭上一示例启动的两个节点，重新启动 turtlesim 节点：

```bash
$ rosrun turtlesim turtlesim_node
```

在另一个 Shell 终端启动一个画正方形的节点：

```bash
$ rosrun turtlesim draw_square
```

可以看到，小乌龟在不断地画正方形。

![](https://static.getiot.tech/ROS-demo-turtlesim-draw-square.png#center)

如果要重置 turtlesim 仿真环境，可以调用名为 `/reset` 的服务：

```bash
$ rosservice call /reset
```



## ROS 图形工具

ROS 为我们提供了许多图形化工具，其中最常用的包括 Rviz 和 Rqt 工具，可用于将传感器的数据可视化。例如，Rviz 工具可将图像数据、3D 点云、机器人模型和坐标变换数据等可视化。

### Rviz

Rviz 工具随着 ROS 的安装也已经安装好了，只需要在 Shell 终端执行以下命令即可启动：（注意要先启动 roscore 哦）

```bash
$ rosrun rviz rviz
```

一切顺利，你将会看到如下的 Rviz 界面：

![](https://static.getiot.tech/ROS-demo-Rviz.png#center)

Rviz 主界面包括 5 个区域：

- **3D 视窗**（中间）：这片区域负责将传感器的 3D 数据、机器人的坐标变化数据、3D 模型数据和其他类型的 3D 数据可视化。
- **显示面板**（左侧）：显示各个传感器的数据。
- **视图面板**（右侧）：可根据应用选择观察窗口的 3D 视角。
- **工具栏**（上方）：包含一些常用的工具选项，如调整 3D 视角、测量机器人位置、设置机器人的导航目标和改变摄像头的视角等。
- **时间面板**（下方）：显示 ROS 的当前时间和已经运行的时间等信息。这个时间戳可能对处理传感器信息非常有帮助。



### Rqt

Rqt 包含一些常用命令选项，可将 2D 数据可视化、将话题记入日志、发布话题和请求服务等。

在 Shell 终端执行以下命令即可启动 Rqt：（注意要先启动 roscore 哦）

```bash
$ rosrun rqt_gui rqt_gui
```

此时会得到一个仅有若干个菜单选项的空白 GUI，可以从下拉菜单中添加自己的插件，例如下面是加载 Plot 和 Robot Steering 插件后的 Rqt GUI 界面。

![](https://static.getiot.tech/ROS-demo-Rqt.png#center)

