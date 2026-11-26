---
sidebar_position: 0
---

# ROS 安装

本文主要介绍如何在 Ubuntu 20.04 中安装 ROS（Noetic）。

## 第1步：配置 Ubuntu 软件仓库

参考 [Ubuntu 官方手册](https://help.ubuntu.com/community/Repositories/Ubuntu) 配置 Ubuntu 系统的软件仓库信息，以支持 "restricted"、"universe" 和 "multiverse"。

提示：Ubuntu 的软件包是按照自由程度来分类的，一种分为四大类：

- **Main**（主要的）：由 Ubuntu 团队支持的可以自由发布的开源软件；
- **Universe**（全人类）：由社区主导的可以自由发布的开源软件；
- **Restricted**（限制的）：设备专有的驱动，虽然没有自由软件版权，但依然被 Ubuntu 团队支持的软件；
- **Multiverse**（多元的）：受版权或法律问题限制的软件。



## 第2步：配置 sources.list

设置你的计算机接受来自 packages.ros.org 的软件。

```bash
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```



## 第3步：配置 keys

```bash
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```



## 第4步：安装

First, make sure your Debian package index is up-to-date:

```
sudo apt update
```

Now pick how much of ROS you would like to install.

- **Desktop-Full Install: (Recommended)** : Everything in **Desktop** plus 2D/3D simulators and 2D/3D perception packages

  - 

    ```bash
    sudo apt install ros-noetic-desktop-full
    ```

    or [click here](apt:ros-noetic-desktop-full?refresh=yes)

  **Desktop Install:** Everything in **ROS-Base** plus tools like [rqt](http://wiki.ros.org/rqt) and [rviz](http://wiki.ros.org/rviz)

  - 

    ```
    sudo apt install ros-noetic-desktop
    ```

    or [click here](apt:ros-noetic-desktop?refresh=yes)

  **ROS-Base: (Bare Bones)** ROS packaging, build, and communication libraries. No GUI tools.

  - 

    ```
    sudo apt install ros-noetic-ros-base
    ```

    or [click here](apt:ros-noetic-ros-base?refresh=yes)

There are even more packages available in ROS. You can always install a specific package directly.

- 

  ```
  sudo apt install ros-noetic-PACKAGE
  ```

  e.g.

  ```
  sudo apt install ros-noetic-slam-gmapping
  ```

To find available packages, see [ROS Index](https://index.ros.org/packages/page/1/time/#noetic) or use:

```bash
apt search ros-noetic
```



## 第5步：环境配置

You must source this script in every **bash** terminal you use ROS in.

```bash
source /opt/ros/noetic/setup.bash
```

It can be convenient to automatically source this script every time a new shell is launched. These commands will do that for you.

```bash
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

注意：If you have more than one ROS distribution installed, `~/.bashrc` must only source the `setup.bash` for the version you are currently using.



## 第6步：构建软件包依赖

Up to now you have installed what you need to run the core ROS packages. To create and manage your own ROS workspaces, there are various tools and requirements that are distributed separately. For example, [rosinstall](http://wiki.ros.org/rosinstall) is a frequently used command-line tool that enables you to easily download many source trees for ROS packages with one command.

To install this tool and other dependencies for building ROS packages, run:

```bash
sudo apt install python3-rosdep python3-rosinstall \
     python3-rosinstall-generator python3-wstool build-essential
```



#### Initialize rosdep

Before you can use many ROS tools, you will need to initialize `rosdep`. `rosdep` enables you to easily install system dependencies for source you want to compile and is required to run some core components in ROS. If you have not yet installed `rosdep`, do so as follows.

```bash
sudo apt install python3-rosdep
```

With the following, you can initialize `rosdep`.

```bash
sudo rosdep init
rosdep update
```



