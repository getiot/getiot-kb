---
sidebar_position: 2
slug: /ros-installation-melodic
authors: [luhuadong]
---

# Ubuntu 18.04 安装 ROS Melodic

本文介绍如何在 Ubuntu 18.04 安装 ROS Melodic 软件包，并进行简单的测试。


## 安装步骤

**1、配置 Ubuntu 软件仓库**

配置 Ubuntu 软件仓库支持 "restricted" "universe" 和 "multiverse" 来源，最简单的方法是在「软件和更新」配置窗口进行勾选，如下图所示。

![](https://static.getiot.tech/ROS-Configure-your-Ubuntu-repositories.png#center)

扩展阅读：[Ubuntu 软件源](/ubuntu/ubuntu-software-repositories/)、[Ubuntu Repositories](https://help.ubuntu.com/community/Repositories/Ubuntu)

**2、设置 sources.list**

执行下面命令，设置从官方源（packages.ros.org）下载 ROS 软件包

```bash
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

国内的开发者可自行替换合适的软件源，例如修改为清华源

```bash
sudo sh -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

**3、设置密钥**

密钥的设置需要用到 curl 命令，如果你的系统还没有该命令，请先执行下面命令安装。

```bash
sudo apt install curl
```

然后设置密钥

```bash
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```

国内开发者可以使用下面命令替代

```bash
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
```

**4、开始安装**

安装桌面完整版的 ROS Melodic

```bash
sudo apt update
sudo apt install ros-melodic-desktop-full
```

这一步需要一些时间，你可以先去喝一杯茶哦！

**5、设置环境变量**

安装完成后，需要在你想使用 ROS 的 Bash 终端执行下面命令，以初始化 ROS Melodic 的环境变量。

```bash
source /opt/ros/melodic/setup.bash
```

为了方便使用，可以将其添加到用户的 .bashrc 脚本，这样就可以在每次打开 Bash 终端的时候自动完成设置。

```bash
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

如果是用 zsh 的小伙伴，则用下面命令替代

```bash
echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
source ~/.zshrc
```

**6、安装依赖**

到目前为止，你已经安装了运行核心 ROS 包所需的程序。不过为了便于创建和管理你自己的 ROS 工作区，满足日后安装各种工具和软件的需求，建议执行下面命令以安装依赖。例如，rosinstall 是一个经常使用的命令行工具，它使你能够通过一个命令轻松地为 ROS 包下载许多源码树。

想象一下，假设有一个机器人应用程序，它包含了 100 多个程序包，而用户需要在计算机中配置这些包，那么仅仅为这些包安装依赖包就是一件非常困难的事情。在这种情况下，rosinstall 这样的工具就会非常有用！只需要一条指令，便可以完成所有包的安装。

要安装这个工具和其他依赖项来构建 ROS 包，请执行命令：

```bash
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
```

**7、初始化 rosdep**

在使用其他 ROS 工具之前，还需要初始化 rosdep。Rosdep 工具对于安装 ROS 包的依赖包非常有用，一个 ROS 包可能需要若干个依赖包才能正常工作，Rosdep 会检查依赖包是否可用，如果不可用，它将自动安装这些依赖包。

如果你还没有安装 rosdep，请执行下面命令进行安装（其实上一步已经安装了）。

```bash
sudo apt install python3-rosdep
```

现在，你可以初始化 rosdep 了

```bash
sudo rosdep init
rosdep update
```

**8、检查是否安装成功**

最后，我们可以使用 `rosversion -d` 命令验证 ROS 的安装是否正确，如下：

```bash
$ rosversion -d
melodic
```



## 测试

打开一个新的 Bash 终端，测试 roscore 是否能正常启动

```bash
roscore
```

注意：如果没有配置自动初始化 ROS 环境，则每次开启 Bash 终端都需要执行以下命令。

```bash
source /opt/ros/melodic/setup.bash
```

新开启一个 Bash 终端，执行以下命令启动一个小乌龟模拟器：

```bash
rosrun turtlesim turtlesim_node
```

再开启一个 Bash 终端，在该终端控制小乌龟移动，执行以下命令：

```bash
rosrun turtlesim turtle_teleop_key
```

提示：鼠标必须聚焦在这个终端，按下方向键时乌龟才会移动。

![](https://static.getiot.tech/ROS-Noetic-turtlesim-test.png#center)

更多测试示例请参考 [ROS Tutorials](http://wiki.ros.org/ROS/Tutorials)



