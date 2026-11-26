---
sidebar_position: 14
slug: /ros-client-libraries
authors: [luhuadong]
---

# ROS 客户端库



ROS 客户端库（Client Libraries）是一系列实现了 ROS 概念所对应功能的代码，我们只需要在自己软件包中调用这些库函数，就可以实现一个 ROS 节点。简单来说，客户端库提供了丰富的用于创建 ROS 应用的内置函数，可以帮我们节省大量的开发时间。

ROS 提供了多种语言的客户端库，包括 C++、Python、Lisp 等等。ROS 客户端库提供了丰富的用于创建 ROS 应用的内置函数，可以帮助我们节省大量的开发时间。当然，从理论上来说，你可以使用其他任何编程语言编写 ROS 节点，不过这可能需要你付出更多时间。

ROS 客户端库可以分为两大类，一类称为 Main client libraries，即 ROS 官方主要维护的库；另一类称为 Experimental client libraries，即处于实验性阶段或由社区维护的库。



## 主要的 ROS 客户端库

- [roscpp](http://wiki.ros.org/roscpp)：roscpp 是 C++ 编写的 ROS 客户端库，它具有高性能的特点，因此也是目前最常用的 ROS 客户端库。
- [rospy](http://wiki.ros.org/rospy)：rospy 是纯 Python 编写的 ROS 客户端库，它的优势在于节省开发时间。和 roscpp 相比，我们可以用更少的时间创建一个 ROS 节点，是用于快速原型设计的一个理想选择。ROS 中的大多数命令行工具，如 roslaunch、roscore 等，都是用 rospy 客户端库编写的。
- [roslisp](http://wiki.ros.org/roslisp)：roslisp 是 LISP 语言的 ROS 客户端库，它主要用于 ROS 中的运动规划库，并不像 roscpp 和 rospy 那么常用。



## 实验性 ROS 客户端库

- [roscs](http://wiki.ros.org/roscs)：roscs 是 Mono/.NET 的客户端库。它可以被任何 Mono/.NET 语言使用，包括 C#、Iron Python、Iron Ruby 等。ROS 构建系统将为每个用 roscs 编写的包创建 .DLL 和 .so 文件。
- [roseus](http://wiki.ros.org/roseus)：roseus 是 [EusLisp](http://wiki.ros.org/euslisp) 语言的客户端库。
- [rosgo](http://wiki.ros.org/rosgo)：rosgo 是纯 [Go](http://golang.org/) 语言实现的客户端库。
- [roshask](https://github.com/acowley/roshask)：roshask 是 Haskell 的客户端库。
- [rosjava](http://wiki.ros.org/rosjava)：rosjava 是纯 Java 中的 ROS 实现，支持 Android。
- [rosnodejs](http://wiki.ros.org/rosnodejs)：rosnodejs 是 Node.js 的原生 ROS Javascript 客户端库，提供与联网 ROS Master 的直接通信方式。
- [RobotOS.jl](https://github.com/phobon/RobotOS.jl)：RobotOS.jl 是一个原生的 [Julia](http://julialang.org/) 包，它包装了 [rospy](http://wiki.ros.org/rospy)。
- [roslua](http://wiki.ros.org/roslua)：roslua 是 Lua 的客户端库，它是一种轻量级但功能强大的可嵌入脚本语言。客户端库目前处于实验和积极开发阶段。
- [PhaROS](http://car.mines-douai.fr/category/pharos/)：PhaROS 是一个基于 MIT 许可的客户端库，使用 [Pharo](http://pharo-project.org/) 免费的 Smalltalk 语言。
- [rosR](http://wiki.ros.org/rosR)：rosR 是统计编程语言 [R](http://www.r-project.org/) 的 ROS 语言扩展。
- [rosrust](http://wiki.ros.org/rosrust)：crate 中的 Rust 语言绑定 [rosrust Github](https://github.com/adnanademovic/rosrust) [rosrust Crate](https://crates.io/crates/rosrust)。
- [rosruby](http://wiki.ros.org/rosruby)：rosruby 支持 [ruby](https://www.ruby-lang.org/fr/)。
- [Unreal-Ros-Plugin](http://wiki.ros.org/Unreal-Ros-Plugin)：一个使用 rosbridge 接收/发送 ros 主题的虚幻插件。
- [ROS-MATLAB Interface](https://www.mathworks.com/help/robotics/robot-operating-system-ros.html)：通过 [Robotics System Toolbox](https://www.mathworks.com/products/robotics)™ 从 [MATLAB](https://www.mathworks.com/products/matlab.html)® 连接到 ROS 的函数库。
- [ROS-Simulink Interface](https://www.mathworks.com/help/robotics/ros-access-with-simulink.html)：一组 [Simulink](https://www.mathworks.com/products/simulink.html)® 块连接到 ROS 并通过 [Robotics System Toolbox](https://www.mathworks.com/products/robotics.html)™ 从 [Simulink](https://www.mathworks.com/products/simulink) 部署 ROS 节点。
- [ROS.jl](https://github.com/gstavrinos/ROS.jl)：[Julia](https://julialang.org/) 的 C++ 包装器（wrapper）。



