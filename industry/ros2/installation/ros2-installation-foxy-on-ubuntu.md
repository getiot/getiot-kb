---
sidebar_position: 1
slug: /ros2-installation-foxy-on-ubuntu
authors: [luhuadong]
---

# Ubuntu 20.04 安装 ROS2 Foxy



## 1. 设置编码

```bash
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
```

## 2.设置软件源

```bash
sudo apt update && sudo apt install curl gnupg2 lsb-release
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```

 

```bash
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
```

## 3.安装 ROS2

```bash
sudo apt update
sudo apt install ros-foxy-desktop
```



## 4.设置环境变量

```bash
source /opt/ros/foxy/setup.bash
```



## 5.安装自动补全工具

```bash
sudo apt install python3-argcomplete
```

跑几个例程测试一下：  先运行一个 talker：

```bash
source /opt/ros/foxy/setup.bash
ros2 run demo_nodes_cpp talker
```

再运行一个 Listener

```bash
source /opt/ros/foxy/setup.bash
ros2 run demo_nodes_py listener
```



ROS2 的 RWM 默认使用的 DDS 是 Fast RTPS，Cyclone DDS 默认也安装好了，还可以这样安装 RTI Connext：

```bash
sudo apt update
sudo apt install ros-foxy-rmw-connext-cpp # for RTI Connext (requires license agreement)
```

 安装之后通过环境变量即可切换 DDS：

```bash
RMW_IMPLEMENTATION=rmw_connext_cpp
```

如果哪一天不喜欢了，还可以这样删除：

```bash
sudo apt remove ros-foxy-* && sudo apt autoremove
```



