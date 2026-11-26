---
sidebar_position: 12
slug: /ros-catkin-workspace
authors: [luhuadong]
---

# ROS Catkin 工作空间



[前面](/ros/ros-build-system/)介绍了 ROS 编译系统 Catkin 的工作原理，本文将继续介绍 Catkin 的使用，包括工作空间的创建以及目录结构的说明。



## 创建工作空间

通常，在创建 ROS 软件包之前需要先创建 ROS 工作空间（也称为 Catkin 工作空间）。所谓的工作空间，也就是存储 ROS 软件包的地方。在工作空间中，我们可以创建新的软件包、安装现有的软件包，以及编译生成新的可执行文件。

Catkin 工作空间的目录（文件夹）对路径和名称没有任何要求，也就是说你可以任意命名。不过，工作空间中必须有一个 src 目录（该名称不能修改）。

例如，在用户家目录下创建一个 catkin_ws 目录作为工作空间：

```bash
$ mkdir -p ~/catkin_ws/src
```

切换到工作空间的 src 目录：

```bash
$ cd ~/catkin_ws/src
```

执行初始化命令使其成为一个新的 ROS 工作空间：

```bash
$ catkin_init_workspace
```

可以看到在 `~/catkin_ws/src` 目录出现了一个 CMakeLists.txt 文件：

```bash
rudy@Latitude-3420:~/catkin_ws/src$ catkin_init_workspace 
Creating symlink "/home/rudy/catkin_ws/src/CMakeLists.txt" pointing to "/opt/ros/noetic/share/catkin/cmake/toplevel.cmake"
rudy@Latitude-3420:~/catkin_ws/src$ ls
CMakeLists.txt
```

注意：如果不初始化工作空间，就不能正确地创建、编译和链接软件包。

至此，Catkin 工作空间已经创建完毕。我们可以尝试编译一下它！首先，切换到 src 的上一级目录，然后执行 `catkin_make` 命令即可。如下所示：

```bash
$ cd ..
$ catkin_make
```

编译完成后，可以看到 catkin_ws 目录下除了 src，还增加了 build 和 devel 目录。

```bash
rudy@Latitude-3420:~/catkin_ws$ ls
build  devel  src
```

下面将详细介绍它们的作用。



## 目录结构

![](https://static.getiot.tech/ROS-catkin-workspace-dirs.jpg#center)



### src 目录

Catkin 工作空间中的 src 目录是存储新创建的软件包或者从远程代码库复制软件包的地方。src 目录可以包含多个 Package，如下图所示。

![](https://static.getiot.tech/ROS-catkin-workspace-src.jpg#center)

ROS 软件包只有在 src 目录中才可以被创建或者编译执行。当我们在工作空间中执行 `catkin_make` 命令时，该命令会递归检查 src 目录中的每个软件包并一一编译它们。软件包（Package）是 catkin 工作空间的基本单元，也是我们后续编写代码的地方。

### build 目录

执行 `catkin_make` 命令后，Catkin 工具会在 build 目录中创建一些中间编译文件和中间缓存文件。这些缓存文件可以避免再次执行 `catkin_make` 命令时重新编译所有的软件包。因此，如果你想重新编译所有 ROS 软件包，删除 build 目录即可。

### devel 目录

当执行 `catkin_make` 命令时，所有的软件包都会被编译。如果编译成功，那么目标可执行文件将会被创建，这些可执行文件就存储在 devel 目录中。

devel 目录还包含一些脚本文件，可将当前工作空间添加到 ROS 的系统工作空间目录中。只有运行这些脚本后，才可以访问当前工作空间的软件包。命令如下：

```bash
$ source ~/<workspace_name>/devel/setup.bash
```

你也可以将上述命令添加到 ~/.bashrc 文件，这样在每次打开 Bash 终端时就会自动将工作空间添加到 ROS 系统。

### install 目录

当本地生成了目标可执行文件后，可以在 Catkin 工作空间执行以下命令来安装这些可执行文件。

```bash
$ catkin_make install
```

执行完成后，可以在工作空间看到新增了一个名为 install 的目录，该目录存储了刚刚安装的目标文件。当运行程序时，install 目录中相应的可执行文件就会被执行。



