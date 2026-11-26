---
sidebar_position: 7
slug: /ros-command-line-tools
authors: [luhuadong]
---

# ROS 命令行工具



本文主要介绍 ROS 机器人操作系统的一些常用命令行工具，使用这些命令可以使机器人编程和调试变得更加简便。

为了顺利运行 ROS 命令，你需要其他安装好 ROS 软件（参考 [ROS 安装](/ros/ros-installation-noetic/)），并设置环境变量：

```bash
source /opt/ros/noetic/setup.bash
```



## roscore

roscore 命令是 ROS 中一个很重要的工具，当我们在终端中运行这个命令时，系统就会启动 ROS Master、参数服务器和日志节点。在这之后，我们就可以运行其他的 ROS 程序/节点了。

我们可以打开一个 Shell 终端运行 roscore 指令，然后在另一个 Shell 终端输入如下命令来运行 ROS 节点。运行 roscore 命令后，可以看到类似的信息：

```bash
$ roscore 
... logging to /home/rudy/.ros/log/2928a9d8-de4b-11ec-9b2d-fb09e61e79d4/roslaunch-Latitude-3420-676704.log
Checking log directory for disk usage. This may take a while.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

started roslaunch server http://Latitude-3420:41275/
ros_comm version 1.15.14

SUMMARY
========

PARAMETERS
 * /rosdistro: noetic
 * /rosversion: 1.15.14

NODES

auto-starting new master
process[master]: started with pid [676714]
ROS_MASTER_URI=http://Latitude-3420:11311/

setting /run_id to 2928a9d8-de4b-11ec-9b2d-fb09e61e79d4
process[rosout-1]: started with pid [676724]
started core service [/rosout]
```

可以看到关于启动的 ROS Master 信息和 ROS Master 地址。



## rosnode

rosnode 命令可以帮助我们探索 ROS 节点各个方面的功能。比如，我们可以列出在系统中正在运行的 ROS 节点的数量。在终端中直接输入 rosnode 命令，便可以获得该命令的所有帮助信息。

例如，启动 turtlesim 模拟器后，使用 `rosnode list` 命令可列出正在运行的节点列表：

```bash
$ rosnode list
/rosout
/teleop_turtle
/turtlesim
```



## rostopic

rostopic 命令可以提供系统中与当前话题发送和订阅的相关情况。它可以列出话题名称、打印话题数据和向话题发布数据。

例如，启动 turtlesim 模拟器后，使用 `rostopic list` 命令可列出当前话题：

```bash
$ rostopic list
/rosout
/rosout_agg
/turtle1/cmd_vel
/turtle1/color_sensor
/turtle1/pose
```

假设当前存在一个名为 hello 的话题，那么可以使用如下命令打印/调取话题数据：

```bash
$ rostopic echo /hello
```

使用如下命令向 hello 话题发布数据：

```bash
$ rostopic pub /hello std_msgs/String "Hello"
```

此时，订阅节点会收到 Hello 消息：

```bash
$ rostopic echo /hello
WARNING: topic [/hello] does not appear to be published yet
data: "Hello"
---

```



## rosversion

rosversion 命令可用于检查 ROS 版本。例如，获取当前的 ROS 版本代号：

```bash
$ rosversion -d
noetic
```



## rosparam

rosparam 命令可以列出加载在参数服务器上的参数。例如，列出当前 ROS 系统中的参数名称：

```bash
$ rosparam list
/rosdistro
/roslaunch/uris/host_latitude_3420__41275
/rosversion
/run_id
/turtlesim/background_b
/turtlesim/background_g
/turtlesim/background_r
```

我们也可以通过 rosparam 命令添加参数、设置参数，或者获取参数的值。设置参数的命令格式如下：

```bash
rosparam set parameter_name value
```

例如，添加一个 hello 参数，并将其值设置为 "Hello"：

```bash
$ rosparam set hello "Hello"
```

使用 `rosparam get` 命令获取 hello 参数的值：

```bash
$ rosparam get hello
Hello
```



## roslaunch

我们可以使用 roslaunch 命令启动一个 launch 文件。如果要一次运行多于 10 个的 ROS 节点，那么一个个地运行是很麻烦的。在这种情况下，我们可以用 launch 文件来避免这种麻烦。

ROS launch 文件是 XML 格式的文件，可以在文件中写入想要运行的每个节点。roslaunch 命令的另一优势是可以自动执行 roscore 命令，所以我们不必在运行这些节点前先去运行 roscore 命令。

运行 launch 文件的命令语法如下：

```bash
roslaunch ros_pkg_name launch_file_name
```

示例：

```bash
$ roslaunch roscpp_tutorials talker_listener.launch
```



## rosrun

rosrun 命令用于运行 ROS 节点，语法格式如下：

```bash
rosrun ros_pkg_name node_name
```

示例：

```bash
$ rosrun roscpp_tutorials talker
```



## rosservice

使用 `rosservice list` 命令列出 ROS 系统当前的服务列表：

```bash
$ rosservice list
/rosout/get_loggers
/rosout/set_logger_level
```



## Package 命令

### rospack

rospack 是对软件包（package）管理的工具，命令的用法如下：

| 命令                        | 功能                        |
| :-------------------------- | :-------------------------- |
| `rospack help`              | 显示 rospack 的用法         |
| `rospack list`              | 列出本机所有 package        |
| `rospack depends [package]` | 显示 package 的依赖包       |
| `rospack find [package]`    | 定位某个 package            |
| `rospack profile`           | 刷新所有 package 的位置记录 |

以上命令如果 package 缺省，则默认为当前目录（如果当前目录包含 package.xml）。

### roscd

roscd 命令类似与 Linux 系统的 cd，改进之处在于 roscd 可以直接切换到 ROS 软件包的目录。

| 命令              | 功能                       |
| :---------------- | :------------------------- |
| `roscd [pacakge]` | cd 到 ROS package 所在路径 |

### rosls

rosls 也可以视为 Linux 指令 ls 的改进版，可以直接列出 ROS 软件包的内容。

| 命令              | 功能                  |
| :---------------- | :-------------------- |
| `rosls [pacakge]` | 列出 pacakge 下的文件 |

### rosdep

rosdep 是用于管理 ROS package 依赖项的命令行工具，用法如下：

| 命令                       | 功能                          |
| :------------------------- | :---------------------------- |
| `rosdep check [pacakge]`   | 检查 package 的依赖是否满足   |
| `rosdep install [pacakge]` | 安装 pacakge 的依赖           |
| `rosdep db`                | 生成和显示依赖数据库          |
| `rosdep init`              | 初始化 /etc/ros/rosdep 中的源 |
| `rosdep keys`              | 检查 package 的依赖是否满足   |
| `rosdep update`            | 更新本地的 rosdep 数据库      |

一个较常使用的命令是：

```bash
$ rosdep install --from-paths src --ignore-src --rosdistro=noetic -y
```

该命令用于安装工作空间中 `src` 路径下所有 package 的依赖项（由 pacakge.xml 文件指定）。



