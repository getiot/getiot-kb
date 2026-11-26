---
sidebar_position: 13
slug: /ros-creating-package
authors: [luhuadong]
---

# ROS 创建软件包



在开始 ROS 编程之前，首先需要创建工作空间和软件包（Package）。我们可以在软件包中编写代码（通常采用 C++ 或 Python），调用 ROS 内置的 API 函数，实现相关的功能。这样的程序也称为 ROS 节点。



## 创建工作空间

在创建 ROS 程序包之前，首先需要创建 ROS 工作空间。所谓的工作空间，也就是 ROS 软件包存储的地方。在工作空间中，我们可以创建新的软件包、安装现有的软件包，以及编译生成新的可执行文件。关于 Catkin 和工作空间的详细介绍，请阅读 [ROS Catkin 编译系统](/ros/ros-build-system/) 和 [ROS Catkin 工作空间](/ros/ros-catkin-workspace/)。

在用户家目录下创建一个 catkin_ws 目录作为工作空间：

```bash
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/src
$ catkin_init_workspace
```

现在，你已经得到一个初始化后的 ROS 工作空间，可以在这里创建、编译和链接软件包。



## 创建 ROS 软件包

ROS 软件包是我们组织 ROS 节点和函数库的一个代码集，创建软件包的命令是 `catkin_create_pkg`，命令语法如下：

```bash
catkin_create_pkg <ros_package_name> <package_dependencies>
```

第一个参数 `ros_package_name` 是软件包的名称；第二个参数 `package_dependencies` 是可变长度的参数，表示软件包的依赖包。

例如，我们要创建一个含有依赖包的 "hello_world" 软件包，那么可以在 Catkin 工作空间的 src 目录下执行如下命令：

```bash
~/catkin_ws/src$ catkin_create_pkg hello_world roscpp rospy std_msgs
```

此时，`~/catkin_ws/src` 目录的内容如下：

```bash
├── CMakeLists.txt -> /opt/ros/noetic/share/catkin/cmake/toplevel.cmake
└── hello_world
    ├── CMakeLists.txt
    ├── include
    │   └── hello_world
    ├── package.xml
    └── src
```

在 hello_world 软件包中，包括 src 和 include 目录，以及 package.xml 和 CMakeLists.txt 文件。

各目录或文件的作用如下：

- CMakeLists.txt：该文件包含了编译软件包中的 ROS 源代码和创建可执行文件的所有命令。
- package.xml：该 XML 文件主要记录了软件包的依赖包和一些与自身相关信息等。
- src 目录：ROS 软件包的源代码就保存在这个目录中。通常来说，C++ 文件直接保存在这个目录中，而 Python 脚本需要存放在 script 目录中（在 src 目录中新建）。
- include 目录：该目录包含了源程序的头文件，第三方的函数库文件也可以放到这个目录。

现在，你已经创建好一个 ROS 软件包的骨架了！



## ROS 软件包示例

具体的 ROS 软件包示例请参考下面内容：

* [ROS 发布/订阅节点示例（C++）](/ros/ros-writing-publisher-subscriber-cpp/)
* [ROS 发布/订阅节点示例（Python）](/ros/ros-writing-publisher-subscriber-python/)
* [ROS 服务/客户节点示例（C++）](/ros/ros-writing-service-client-cpp/)
* [ROS 服务/客户节点示例（Python）](/ros/ros-writing-service-client-python/)

