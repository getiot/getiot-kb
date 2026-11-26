---
sidebar_position: 14
authors: [luhuadong]
---

# ROS2 调试方法



在开发程序时，如果没有调试手段，就好像驾驶一辆没有仪表盘的汽车一样难受，尤其是当遇上了 Bug 的时候。对于 ROS 程序开发来说，Debug 手段也是相当重要，本节就来给大家在 ROS2 中如何调试节点程序。



## 使用 ros2 命令行工具

ROS 本身提供了非常多的[命令行工具](/ros2/ros2-command-line-tools/)，可用于查看 ROS 节点信息、运行状态，查看话题数据等等。你可以通过这些命令对你的设备上正在运行的 ROS 系统进行分析，检查它们是否工作正常。

例如：查看激光雷达点云 Topic 话题数据

```bash
ros2 topic echo /lidar_points
```



## 使用 VS Code 调试

VS Code 是一个强大的工具，通过简单的配置，即可使用它来调试你的 ROS 节点程序。配置方法很简单，主要涉及 tasks.json、launch.json 和 c_cpp_properties.json 三个文件，具体可参考《[VS Code 编译和调试 ROS 2 工程](/vscode/debug-ros2-in-vscode/)》。

![](https://static.getiot.tech/vscode-debugging-ros-project.png#center)



## 直接使用 GDB 调试

有些环境可能无法使用 VS Code，那么可以尝试直接使用 GDB 调试。

首先需要安装依赖，这里使用 **[backward_ros](https://github.com/pal-robotics/backward_ros)** 软件包，它是对 [backward-cpp](https://github.com/bombela/backward-cpp) 包的 ROS2 封装，可以简单快速地使用 GDB 工具调试 ROS2 程序。

根据你的 ROS 版本进行选择，例如 Ubuntu 20.04 对应的 foxy 版本，对应的包是 *ros-foxy-backward-ros*。因此，安装命令如下：

```bash
sudo apt install ros-foxy-backward-ros
```

然后在编译 ROS2 程序时，添加 `CMAKE_BUILD_TYPE` 编译类型选项参数，可以选择 `RelWithDebInfo`、`Debug` 或 `Release`。对应 CMake 的三种编译选项，其中 `Release` 模式主要用于发布代码，会忽略调试信息；`Debug` 模式主要用于调试代码，因为需要生成调试信息，所以时间较长；`RelWithDebInfo` 则在 `Release` 模式下生成调试信息，也可以用于调试代码。通常建议使用 `RelWithDebInfo` 即可。

colcon 编译命令如下：

```bash
colcon build --cmake-args '-DCMAKE_BUILD_TYPE=RelWithDebInfo'
```

这里的引号不是必须的，因此也可以写成这样：

```bash
colcon build --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
```

colcon 支持 `--symlink-install` 选项，作用是工作空间（source）中的文件发生变化时，安装目录（build）的文件也会随着改变。这样在调试的时候会高效一些，命令如下：

```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo
```

如果你想要加快编译速度，可以使用 `--parallel-workers` 选项开启多个线程并行编译，例如同时启动 5 个线程：

```bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=RelWithDebInfo --parallel-workers 5
```

编译完成后，就可以通过 `ros2 run` 命令带上 `--prefix` 参数传入 `gdb` 指令，在 GDB 调试环境中启动 ROS 节点程序。命令语法如下：

```bash
ros2 run --prefix 'gdb -ex run --args' package_name executable_name
```

这里的 *package_name* 是 ROS 包名，*executable_name* 是节点程序名。



### 配置 GDB Server

ROS 中的 GDB 调试方法同样支持 GDB Server 远程调试，只需要修改 `--prefix` 参数即可，例如：

```bash
ros2 run --prefix 'gdbserver localhost:3000' package_name executable_name
```


