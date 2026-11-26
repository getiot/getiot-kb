---
sidebar_position: 9
authors: [luhuadong]
---

# ROS2 命令行工具



本文主要介绍 ROS2 机器人操作系统的一些常用命令行工具及其使用方法，使用这些命令可以使机器人编程和调试变得更加简便。



## ROS2 命令简介

ROS2 的主要命令入口是 `ros2`，其中又包含大量的子命令，可用于 ROS2 程序的开发和测试。下面是其中一些常用的命令及其作用：

- `ros2 run`：运行 ROS2 节点或任意可执行文件。
- `ros2 launch`：启动 ROS2 应用程序，可以同时启动多个节点。
- `ros2 pkg`：用于操作 ROS2 软件包，包括创建 package、指定包名、编译方式、依赖项、节点名等。
- `ros2 node`：用于管理 ROS2 节点，可以列出、杀死、查看节点等。
- `ros2 topic`：用于管理 ROS2 话题（Topic），包括列出、发布、订阅、查看话题等。
- `ros2 service`：用于管理 ROS2 服务（Service），包括列出、调用、创建、删除服务等。
- `ros2 action`：用于管理 ROS2 行为（Action），包括列出、调用、取消行为等。
- `ros2 bag`：用于记录和回放 ROS2 话题数据，可以将数据记录到文件中，以供后续回放和分析。
- `ros2 param`：用于管理 ROS2 参数服务器，包括设置、获取、删除参数等。
- `ros2 msg` 和 `ros2 srv`：用于查看 ROS2 消息和服务类型的定义。
- `ros2 doctor`：用于检查 ROS2 环境是否正常，包括检查网络、环境变量、节点和话题等。

熟练掌握上述 ROS2 命令，可以帮助开发者对 ROS2 应用程序进行管理和监控，加快开发和调试速度。



## ros2 run

`ros2 run` 命令用于运行 ROS2 节点或任意可执行文件。

命令语法：

```bash
ros2 run <package_name> <executable_name>
```

示例：

```bash
ros2 run turtlesim turtle_teleop_key
```

还可以在启动 ROS2 节点时指定要加载的参数文件：

```bash
ros2 run <package_name> <executable_name> --ros-args --params-file <file_name>
```



## ros2 launch

`ros2 launch` 命令用于启动 ROS2 应用程序，可以同时启动多个节点。

命令语法：

```bash
ros2 launch <package_name> <launch_file_name>
```

示例：

```bash
ros2 launch launch_tutorial launch_turtlesim.launch.py
```



## ros2 pkg

`ros2 pkg` 命令用于操作 ROS2 软件包，包括创建 package、指定包名、编译方式、依赖项、节点名等。有 create、executables、list、prefix、xml 共 5 个子命令。

创建软件包：

```bash
ros2 pkg create <package_name> --build-type <build_type> 
                               --node-name  <node_name> 
                               --dependencies <your_dependencies>
```

例如：

```bash
ros2 pkg create my_package --build-type ament_cmake --node-name my_node --dependencies rclcpp std_msgs sensor_msgs
```

选项参数说明：

- `--build-type` 用于指定编程语言，`ament_cmake` 表示使用 C++，`ament_python` 表示使用 Python。
- `--node-name` 用于指定节点名，也是要生成的源码文件，可以后期创建，但是手动创建需要手动配置。
- `--dependencies` 用于指定依赖模块，其中 `rclcpp` 是 C++ 必选的，`rclpy` 是 Python 必选的，`std_msgs` 和 `sensor_msgs` 是我们要用的消息模块，可暂不指定，后续手动配置。

查看 ROS2 系统中所有软件包（注意：需要用 source 设置环境变量才能看到自己写的软件包）

```bash
ros2 pkg list
```

查看软件包中的可执行文件列表

```bash
ros2 pkg executables <package_name>
```



## ros2 node

`ros2 node` 命令用于管理 ROS2 节点，包括 `list` 和 `info` 两个子命令。

列出所有正在运行的节点名称：

```bash
ros2 node list
```

查看指定节点的信息：

```bash
ros2 node info <node_name>
```



## ros2 topic

`ros2 topic` 命令用于管理 ROS2 话题（Topic），包括列出、发布、订阅、查看话题等。

该命令又包含多个子命令：

- `bw`：显示话题使用的带宽；
- `delay`：显示话题的延迟（基于消息头中的时间戳）；
- `echo`：输出指定话题的消息；
- `find`：输出给定类型的可用主题列表；
- `hz`：打印话题的平均发布率；
- `info`：打印有关话题的信息；
- `list`：输出可用的话题列表；
- `pub`：向指定话题发布消息；
- `type`：打印话题的类型。

例如，查看系统内所有当前活跃的话题：（-t 表示显示其类型）

```bash
ros2 topic list -t
```

查看话题的详细信息：

```bash
ros2 topic info <topic_name>
```

查看话题发布数据的速率：

```bash
ros2 topic hz <topic_name>
```

查看数据在话题上发布的情况：

```bash
ros2 topic echo <topic_name>
```

直接从命令行向一个话题发布数据：

```bash
ros2 topic pub <topic_name> <msg_type> '<args>'
```



## ros2 service

`ros2 service` 命令用于管理 ROS2 服务（Service），包括列出、调用、创建、删除服务等。使用方法与 topic 命令类似，包括以下子命令：

- `call`：调用一个服务；
- `find`：查找指定类型的可用服务；
- `list`：列出所有可用服务；
- `type`：显示服务的类型。

例如，查看系统内所有可用服务：（-t 表示显示其类型）

```bash
ros2 service list -t
```

查找使用某类消息类型的服务：

```bash
ros2 service find <type_name>
```

查看服务接收的消息类型：

```bash
ros2 service type <service_name>
```



## ros2 action

`ros2 action` 命令用于管理 ROS2 行为（Action），包括列出、调用、取消行为等。

例如，列出系统内所有 action：

```bash
ros2 action list
```



## ros2 bag

`ros2 bag` 命令用于记录和回放 ROS2 话题数据，可以将数据记录到文件中，以供后续回放和分析。

录制发布到某个 topic 的消息：

```bash
ros2 bag record <topic_name>
```

查看录制好的 rosbag 信息：

```bash
ros2 bag info <bag_file_name>
```

回放 rosbag：

```bash
ros2 bag play <bag_file_name>
```



## ros2 param

`ros2 param` 命令用于管理 ROS2 参数服务器，包括设置、获取、删除参数等。

该命令又包含多个子命令：

- `delete`：删除参数；
- `describe`：显示参数的描述信息；
- `dump`：导出一个节点的所有参数到一个 yaml 文件；
- `get`：获取参数；
- `list`：输出系统内所有可用参数列表；
- `load`：加载参数文件到一个节点；
- `set`：设置参数。

例如，查看参数及其节点归属：

```bash
ros2 param list
```

获取当前参数的值：

```bash
ros2 param get <node_name> <parameter_name>
```

在运行时间内改变参数值：

```bash
ros2 param set <node_name> <parameter_name> <value>
```

将参数导出到一个文件：

```bash
ros2 param dump <node_name>
```



