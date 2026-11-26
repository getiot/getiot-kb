---
sidebar_position: 8
authors: [luhuadong]
---

# 创建 ROS2 软件包



本文介绍如何创建一个支持 CMake 或 Python 的 ROS2 软件包（package），并尝试运行它。



## 什么是 ROS2 软件包

A package can be considered a container for your ROS 2 code. If you want to be able to install your code or share it with others, then you’ll need it organized in a package. With packages, you can release your ROS 2 work and allow others to build and use it easily.

Package creation in ROS 2 uses ament as its build system and colcon as its build tool. You can create a package using either CMake or Python, which are officially supported, though other build types do exist.



## ROS2 软件包目录结构

### 必须的配置文件

ROS 2 Python and CMake packages each have their own minimum required contents:

#### CMake

- `package.xml` file containing meta information about the package
- `CMakeLists.txt` file that describes how to build the code within the package

The simplest possible package may have a file structure that looks like:

```bash
my_package/
     CMakeLists.txt
     package.xml
```



#### Python

- `package.xml` file containing meta information about the package
- `setup.py` containing instructions for how to install the package
- `setup.cfg` is required when a package has executables, so `ros2 run` can find them
- `/<package_name>` - a directory with the same name as your package, used by ROS 2 tools to find your package, contains `__init__.py`

The simplest possible package may have a file structure that looks like:

```bash
my_package/
      setup.py
      package.xml
      resource/my_package
```



### 工作目录参考

A single workspace can contain as many packages as you want, each in their own folder. You can also have packages of different build types in one workspace (CMake, Python, etc.). You cannot have nested packages.

Best practice is to have a `src` folder within your workspace, and to create your packages in there. This keeps the top level of the workspace “clean”.

A trivial workspace might look like:

```bash
workspace_folder/
    src/
      package_1/
          CMakeLists.txt
          package.xml

      package_2/
          setup.py
          package.xml
          resource/package_2
      ...
      package_n/
          CMakeLists.txt
          package.xml
```



## 第一个 ROS2 软件包

### 创建软件包

First, [source your ROS 2 installation](https://docs.ros.org/en/foxy/Tutorials/Beginner-CLI-Tools/Configuring-ROS2-Environment.html).

Let’s use the workspace you created in the [previous tutorial](https://docs.ros.org/en/foxy/Tutorials/Beginner-Client-Libraries/Creating-A-Workspace/Creating-A-Workspace.html#new-directory), `ros2_ws`, for your new package.

Make sure you are in the `src` folder before running the package creation command.

```bash
cd ~/ros2_ws/src
```

The command syntax for creating a new package in ROS 2 is:

```bash
ros2 pkg create --build-type ament_cmake <package_name>
```

如果使用 Python，则使用以下命令：

```bash
ros2 pkg create --build-type ament_python <package_name>
```

For this tutorial, you will use the optional argument `--node-name` which creates a simple Hello World type executable in the package.

Enter the following command in your terminal:

```bash
# CMake
ros2 pkg create --build-type ament_cmake --node-name my_node my_package
# Python
ros2 pkg create --build-type ament_python --node-name my_node my_package
```

You will now have a new folder within your workspace’s `src` directory called `my_package`.

After running the command, your terminal will return the message:

```bash
going to create a new package
package name: my_package
destination directory: /home/user/ros2_ws/src
package format: 3
version: 0.0.0
description: TODO: Package description
maintainer: ['<name> <email>']
licenses: ['TODO: License declaration']
build type: ament_cmake
dependencies: []
node_name: my_node
creating folder ./my_package
creating ./my_package/package.xml
creating source and include folder
creating folder ./my_package/src
creating folder ./my_package/include/my_package
creating ./my_package/CMakeLists.txt
creating ./my_package/src/my_node.cpp
```

You can see the automatically generated files for the new package.

### 构建

Putting packages in a workspace is especially valuable because you can build many packages at once by running `colcon build` in the workspace root. Otherwise, you would have to build each package individually.

Return to the root of your workspace, build your packages:

```bash
cd ~/ros2_ws
colcon build
```

Recall from the last tutorial that you also have the `ros_tutorials` packages in your `ros2_ws`. You might have noticed that running `colcon build` also built the `turtlesim` package. That’s fine when you only have a few packages in your workspace, but when there are many packages, `colcon build` can take a long time.

To build only the `my_package` package next time, you can run:

```bash
colcon build --packages-select my_package
```

### 运行

加载配置

To use your new package and executable, first open a new terminal and source your main ROS 2 installation.

Then, from inside the `ros2_ws` directory, run the following command to source your workspace:

```bash
source install/local_setup.bash
```

Now that your workspace has been added to your path, you will be able to use your new package’s executables.

To run the executable you created using the `--node-name` argument during package creation, enter the command:

```bash
ros2 run my_package my_node
```



## 软件包详解

Inside `ros2_ws/src/my_package`, you will see the files and folders that `ros2 pkg create` automatically generated:

```bash
my_package/
├── CMakeLists.txt
├── include
│   └── my_package
├── package.xml
└── src
    └── my_node.cpp
```

`my_node.cpp` is inside the `src` directory. This is where all your custom C++ nodes will go in the future.

### 修改 package.xml

You may have noticed in the return message after creating your package that the fields `description` and `license` contain `TODO` notes. That’s because the package description and license declaration are not automatically set, but are required if you ever want to release your package. The `maintainer` field may also need to be filled in.

From `ros2_ws/src/my_package`, open `package.xml` using your preferred text editor:

```xml
<?xml version="1.0"?>
<?xml-model
   href="http://download.ros.org/schema/package_format3.xsd"
   schematypens="http://www.w3.org/2001/XMLSchema"?>
<package format="3">
 <name>my_package</name>
 <version>0.0.0</version>
 <description>TODO: Package description</description>
 <maintainer email="user@todo.todo">user</maintainer>
 <license>TODO: License declaration</license>

 <buildtool_depend>ament_cmake</buildtool_depend>

 <test_depend>ament_lint_auto</test_depend>
 <test_depend>ament_lint_common</test_depend>

 <export>
   <build_type>ament_cmake</build_type>
 </export>
</package>
```

Input your name and email on the `maintainer` line if it hasn’t been automatically populated for you. Then, edit the `description` line to summarize the package:

```xml
<description>Beginner client libraries tutorials practice package</description>
```

Then, update the `license` line. You can read more about open source licenses [here](https://opensource.org/licenses/alphabetical). Since this package is only for practice, it’s safe to use any license. We’ll use `Apache License 2.0`:

```xml
<license>Apache License 2.0</license>
```

Don’t forget to save once you’re done editing.

Below the license tag, you will see some tag names ending with `_depend`. This is where your `package.xml` would list its dependencies on other packages, for colcon to search for. `my_package` is simple and doesn’t have any dependencies, but you will see this space being utilized in upcoming tutorials.



## 总结

You’ve created a package to organize your code and make it easy to use for others.

Your package was automatically populated with the necessary files, and then you used colcon to build it so you can use its executables in your local environment.







