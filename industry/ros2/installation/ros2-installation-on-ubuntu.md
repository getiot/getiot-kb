---
sidebar_position: 2
slug: /ros2-installation-on-ubuntu
authors: [luhuadong]
---

# Ubuntu 22.04 安装 ROS2 Humble



本文介绍如何在 Ubuntu 22.04（Jammy）上安装 ROS 2 软件包，ROS 2 的版本是当前最新的 Humble Hawksbill。本教程适用于不同的 Ubuntu 发行版，以及 amd64 和 arm64 平台。例如，如果你想要在 Ubuntu 20.04 上安装 ROS 2，只需要将本教程中的 Humble 替换为 Foxy 即可。



## 准备工作

### 设置语言环境

首先需要确保你所使用的环境支持 UTF-8。一般来说，我们使用的 Linux 发行版都支持 UTF-8 语言环境。但是如果你使用 Docker 容器之类的最小系统，那么可能配置的是最小语言环境，例如 POSIX。可以使用以下命令设置进行测试。

```bash
locale  # check for UTF-8

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

locale  # verify settings
```



### 设置软件源

使用以下命令将 ROS 2 apt 存储库添加到系统（需要先确保 [Ubuntu Universe 存储库](https://help.ubuntu.com/community/Repositories/Ubuntu) 已启用）。

```bash
sudo apt install software-properties-common
sudo add-apt-repository universe
```

使用 apt 添加 ROS 2 GPG 密钥。

```bash
sudo apt update && sudo apt install curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
```

> 提示：如果上述命令执行失败，通常是由于 DNS 解析失败导致的，你可以使用 [nslookup](/linux-command/nslookup/) 命令查询 raw.githubusercontent.com 的域名信息，并将域名及其 IP 地址填到 `/etc/hosts` 文件进行手动解析。（参考 [GitHub 无法读取远程仓库](/github/github-errata-port-443-connection-refused/)）

然后将存储库添加到系统的软件源列表中。

```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
```



## 安装 ROS 2 软件包

### 更新系统

更新 apt 软件包索引信息：

```bash
sudo apt update
```

更新软件包：

```bash
sudo apt upgrade
```

提示：ROS 2 软件包建立在经常更新的 Ubuntu 系统上，因此我们建议你在安装 ROS 2 软件包之前确保你的系统是最新的。



### 安装 Desktop 版本

执行下面命令安装 Desktop 版本的 ROS 2，这是我们推荐初学者安装的版本，因为 Desktop 版本包含了 ROS、RViz、demos、tutorials 等内容。

```bash
sudo apt install ros-humble-desktop
```



### 安装 Base 版本

执行下面命令安装 Base 版本的 ROS 2，基础版本包含通信库、消息包、命令行工具，但是没有 GUI 工具。

```bash
sudo apt install ros-humble-ros-base
```



### 安装开发工具

执行下面命令安装 ROS 开发工具，包括编译器和其他构建 ROS 包的工具。

```bash
sudo apt install ros-dev-tools
```



## 设置环境变量

如果前面的安装命令顺利执行完毕，那么你已经成功安装 ROS 2 了。不过在使用之前，我们还需要设置环境变量。

设置的方法是执行 ROS 2 提供的 setup.bash 脚本，例如：

```bash
# Replace ".bash" with your shell if you're not using bash
# Possible values are: setup.bash, setup.sh, setup.zsh
source /opt/ros/humble/setup.bash
```



## 测试示例

如果你前面安装的是 `ros-humble-desktop` 版本，那么可以尝试运行 ROS 2 自带的示例程序 Talker-listener。

打开一个终端，依次执行以下命令，运行 `talker` 节点：

```bash
source /opt/ros/humble/setup.bash
ros2 run demo_nodes_cpp talker
```

另开一个终端，依次执行以下命令，运行 `listener` 节点：

```bash
source /opt/ros/humble/setup.bash
ros2 run demo_nodes_py listener
```

这时候，你应该会看到 `talker` 说它正在发布消息，而 `listener` 说我听到了这些消息。

```bash
# talker 节点
$ ros2 run demo_nodes_cpp talker
[INFO] [1677591294.921179014] [talker]: Publishing: 'Hello World: 1'
[INFO] [1677591295.921028802] [talker]: Publishing: 'Hello World: 2'
[INFO] [1677591296.921506241] [talker]: Publishing: 'Hello World: 3'

# listener 节点
$ ros2 run demo_nodes_py listener
[INFO] [1677591294.957119512] [listener]: I heard: [Hello World: 1]
[INFO] [1677591295.925429074] [listener]: I heard: [Hello World: 2]
[INFO] [1677591296.926465954] [listener]: I heard: [Hello World: 3]
```

通过该示例，我们可以验证 ROS 2 的 C++ 和 Python API 是否正常工作。



## 卸载 ROS2

如果你想卸载 ROS 2，或者想从二进制文件安装后切换到基于源的安装，那么可以运行以下命令卸载 ROS 2。

```bash
sudo apt remove ~nros-humble-* && sudo apt autoremove
```

如果你想将 ROS 2 的软件包信息删除干净，可以执行以下命令。

```bash
sudo rm /etc/apt/sources.list.d/ros2.list
sudo apt update
sudo apt autoremove
# Consider upgrading for packages previously shadowed.
sudo apt upgrade
```

