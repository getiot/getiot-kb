---
sidebar_position: 11
slug: /ros-build-system
authors: [luhuadong]
---

# ROS Catkin 编译系统



ROS 有一套自己的用于编译 ROS 程序包的编译系统，称为 **Catkin**。它是由 [CMake](/cmake/cmake-intro/) 编译系统和一些 Python 脚本定制而成的一套特殊的编译系统。有了 Catkin，我们就不需要过多关注 CMake 和 make 的功能，只需一条命令就可以将源代码生成可执行程序。



## 为什么需要 Catkin

为什么 ROS 不直接使用 CMake 呢？

原因很简单，因为创建 ROS 软件包是一个很复杂的工作，而且其复杂程度会随着软件包及其依赖包数量的增加而增加，编译起来非常不方便。Catkin 编译系统正是为了解决这一痛点而出现的！

实际上，早期的 ROS 编译系统是 rosbuild。但随着 ROS 的不断发展，rosbuild 逐渐暴露出许多缺点，不能很好满足系统需要。在 Groovy 版本面世后，Catkin 作为 rosbuild 的替代品被正式投入使用。Catkin 操作更加简化且工作效率更高，可移植性更好，而且支持交叉编译和更加合理的功能包分配。目前的 ROS 同时支持着 rosbuild 和 Catkin 两种编译系统，但 ROS 的核心软件包也已经全部转换为 Catkin。rosbuild 已经被逐步淘汰，所以建议初学者直接上手 Catkin。



## Catkin 的工作原理 

Catkin 是 CMake 的进一步封装和扩展，而 CMake 则是一种元构建系统（make 生成器），它会生成 Makefile，再由 make 工具完成编译。

下图是 ROS 编译系统 Catkin 的大致工作流程：

<img src="https://static.getiot.tech/ROS-catkin-workflow.jpg" alt="ROS 编译系统 Catkin 的工作原理" title="ROS 编译系统 Catkin 的工作原理" width="600" />

Catkin 编译的工作流程如下：

1. 首先在工作空间 `catkin_ws/src/` 下递归的查找其中每一个 ROS 的 package。
2. package 中会有 package.xml 和 CMakeLists.txt 文件，Catkin（CMake）编译系统依据 CMakeLists.txt 文件，从而生成 `Makefile`（存放于 `catkin_ws/build/`）。
3. 然后 `make` 工具根据刚刚生成的 `Makefile` 等文件，编译链接生成可执行文件（存放于 `catkin_ws/devel`）。

也就是说，Catkin 就是将 `cmake` 与 `make` 指令做了一个封装，从而完成整个编译过程的工具。因此，Catkin 具有操作简单、一次配置多次使用、跨依赖项目编译等优点。



## Catkin 的功能特点

Catkin 是基于 CMake 的编译构建系统，具有以下特点：

- Catkin 沿用了包管理的传统如 `find_package()` 基础结构，`pkg-config`
- 扩展了 CMake，例如
  - 软件包编译后无需安装就可使用
  - 自动生成 `find_package()` 代码，`pkg-config`文件
  - 解决了多个软件包构建顺序问题

一个 Catkin 的软件包（package）必须要包括两个文件：

- package.xml：包括了 package 的描述信息
  - name, description, version, maintainer(s), license
  - opt. authors, url's, dependencies, plugins, etc...
- CMakeLists.txt：构建 package 所需的 CMake 文件
  - 调用 Catkin 的函数/宏
  - 解析 package.xml
  - 找到其他依赖的 catkin 软件包
  - 将本软件包添加到环境变量



## catkin_make 命令

要用 catkin 编译一个工程或软件包，只需要使用 `catkin_make` 指令。一般当我们写完代码，执行一次 `catkin_make` 进行编译，调用系统自动完成编译和链接过程，构建生成目标文件。

`catkin_make` 命令可指定一些选项参数，具体说明如下：

```bash
catkin_make [args]
  -h, --help            # 帮助信息
  -C DIRECTORY, --directory DIRECTORY
                        # 工作空间的路径 (默认为 '.')
  --source SOURCE       # src 的路径 (默认为'workspace_base/src')
  --build BUILD         # build 的路径 (默认为'workspace_base/build')
  --use-ninja           # 用 ninja 取代 make
  --use-nmake           # 用 nmake 取'make
  --force-cmake         # 强制 cmake，即使已经 cmake 过
  --no-color            # 禁止彩色输出 (只对 catkin_make 和 CMake 生效)
  --pkg PKG [PKG ...]   # 只对某个 PKG 进行 make
  --only-pkg-with-deps  ONLY_PKG_WITH_DEPS [ONLY_PKG_WITH_DEPS ...]
                        # 将指定的 package 列入白名单 CATKIN_WHITELIST_PACKAGES，
                        # 之编译白名单里的 package。该环境变量存在于 CMakeCache.txt。
  --cmake-args [CMAKE_ARGS [CMAKE_ARGS ...]]
                        # 传给 CMake 的参数
  --make-args [MAKE_ARGS [MAKE_ARGS ...]]
                        # 传给 Make 的参数
  --override-build-tool-check
                        # 用来覆盖由于不同编译工具产生的错误
```

注意：Catkin 编译之前需要回到工作空间目录（src 目录的上一级），在其他路径下执行 `catkin_make` 命令编译是不会成功的。

更多的 Catkin 编译示例请参考下面内容：

* [ROS 发布/订阅节点示例（C++）](/ros/ros-writing-publisher-subscriber-cpp/)
* [ROS 发布/订阅节点示例（Python）](/ros/ros-writing-publisher-subscriber-python/)
* [ROS 服务/客户节点示例（C++）](/ros/ros-writing-service-client-cpp/)
* [ROS 服务/客户节点示例（Python）](/ros/ros-writing-service-client-python/)



