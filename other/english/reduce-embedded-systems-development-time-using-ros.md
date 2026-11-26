---
sidebar_position: 23
---

# 使用 ROS 加快嵌入式系统开发



Large systems nowadays are generally divided into many small components, “microservices”, that are easy to isolate, replace or integrate into other solutions. Those components often need to run on different hardware architectures and may be written in different programming languages: C++, C and Python are among the most popular options in the embedded world.

现在的大型系统通常被分成许多小组件，即“微服务”，它们很容易隔离、替换或集成到其他解决方案中。 这些组件通常需要在不同的硬件架构上运行，并且可能用不同的编程语言编写：C++、C 和 Python 是嵌入式世界中最流行的选项。

The question is then, how do you connect those components together? More importantly, how can you avoid losing sleep over the often tedious debugging & optimization of custom messaging infrastructures?

那么问题是，如何将这些组件连接在一起？ 更重要的是，你如何才能避免因自定义消息传递基础架构的通常乏味的调试和优化而失眠？

In this article we’ll look at one possible solution called ROS (short for Robot Operating System). We believe that ROS provides not only a fast and reliable messaging system but also access to a huge ecosystem of building blocks that will easily interface with your own components.

在本文中，我们将研究一种称为 ROS（Robot Operating System，机器人操作系统的缩写）的可能解决方案。我们相信 ROS 不仅提供了一个快速可靠的消息传递系统，而且还提供了一个巨大的构建块生态系统的访问权限，这些构建块可以轻松地与你自己的组件进行交互。

ROS has been adopted in the products of different companies in the industry. For instance, [Sony embraced the use of ROS in the Aibo project](https://roscon.ros.org/2018/presentations/ROSCon2018_Aibo.pdf). Another example is the Spanish company [Robotnik](http://wiki.ros.org/RobotnikAutomation), which designs and creates mobile industrial ROS-based robots. [Fetch Robotics](https://fetchrobotics.com/), which offers a range of warehouse robots for automation in manufacturing and warehousing operations, also employs ROS in its products. 

ROS已被业界不同公司的产品所采用。 例如，[索尼支持在 Aibo 项目中使用 ROS](https://roscon.ros.org/2018/presentations/ROSCon2018_Aibo.pdf)（一款电子宠物狗）。 另一个例子是西班牙公司 [Robotnik](http://wiki.ros.org/RobotnikAutomation)，该公司设计和制造基于 ROS 的移动工业机器人。 [Fetch Robotics](https://fetchrobotics.com/) 提供一系列用于制造和仓储操作自动化的仓库机器人，还在其产品中使用 ROS。



## 原则（Principles）

Despite its name, ROS is not an operating system. At its core, it’s rather a communication backbone along with a lot of higher level tools that are suited for robotics.

尽管它的名字叫 ROS，但它并不是一个操作系统。从本质上讲，它是一个通信骨干网以及许多适用于机器人技术的更高级别的工具。

### 通信基础设施（Communication infrastructure）

Communication endpoints in ROS are called nodes. Nodes exchange structured data over two types of channels:

ROS 中的通信端点称为节点。节点通过两种类型的通道交换结构化数据：

#### 主题（Topics）

**Topics** provide a publish/subscribe pattern where some nodes emit data over a named bus and other nodes listen over the same bus to receive the data. It’s conceptually similar to a radio broadcast where subscribers “tune in” to the right frequency according to their interest, with the difference that multiple nodes can publish over the same topic without signal degradation. Thanks to the use of multicast, adding subscribers to a topic doesn’t generate any additional traffic over the network.

**主题** 提供了一种发布/订阅模式，其中一些节点通过命名总线发送数据，而其他节点通过同一总线侦听以接收数据。 它在概念上类似于无线电广播，订阅者可以根据自己的兴趣“调入”正确的频率，不同之处在于多个节点可以在同一主题上发布而不会出现信号衰减。由于使用了多播，向主题添加订阅者不会在网络上产生任何额外的流量。

![](https://static.getiot.tech/ros-publish-subscribe-mode.png#center)

Topics are great for data flow, where for example some component may regularly publish updates on a ship’s position or the progression of some background task to be consumed by other components, like a user interface or a path finding algorithm.

主题非常适合数据流，例如某些组件可能会定期发布船舶位置的更新或某些后台任务的进度以供其他组件使用，例如用户界面或路径查找算法。

#### 服务（Services）

**Services**, on the other hand, are a request/response mechanism where a single node handles requests from one or more clients.

另一方面，**服务**是一种请求/响应机制，其中单个节点处理来自一个或多个客户端的请求。

![](https://static.getiot.tech/ros-request-response-mode.png#center)

This is better suited for control flow: operations that change the state of the system. For example, a user interface may request a system reboot or load a different configuration using the appropriate service.

这更适合于控制流：改变系统状态的操作。 例如，用户界面可能会请求系统重启或使用适当的服务加载不同的配置。

In both cases, messages exchanged between nodes are structured according to message definition files which are user defined and domain specific. Both topics & services are created and removed at runtime and can be dynamically discovered using standard ROS requests.

在这两种情况下，节点之间交换的消息都是根据用户定义的和域特定的消息定义文件构建的。 主题和服务都是在运行时创建和删除的，并且可以使用标准 ROS 请求动态发现。

### 生态系统和工具（Ecosystem & tools）

On top of this communication infrastructure, ROS provides tools to help build robot applications efficiently. These tools accelerate the progress of software development and include debugging, visualization, and logging functionalities.

在这种通信基础设施之上，ROS 提供了帮助高效构建机器人应用程序的工具。这些工具加速了软件开发的进程，包括调试、可视化和日志记录功能。

For instance, the software tool [Rviz](https://github.com/ros2/rviz) provides support for 3D visualization of data from your robot application. It allows the combination of data from different sensors and the robot’s current state into a combined view. [Rosbag2](https://github.com/ros2/rosbag2) also provides an interesting functionality allowing the recording of data from the system. This recorded information includes data from sensors and the robot’s trajectory and can be further used in debugging and data analysis. For an overview of the system, illustrating the ROS nodes and topics, the [Rqt_graph](https://github.com/ros-visualization/rqt_graph/) can be used. This tool provides a GUI plugin for visualizing the ROS graph and can be especially useful for large systems with several nodes interacting with each other.

例如，软件工具 [Rviz](https://github.com/ros2/rviz) 支持机器人应用程序数据的 3D 可视化。 它允许将来自不同传感器的数据和机器人的当前状态组合成一个组合视图。 [Rosbag2](https://github.com/ros2/rosbag2) 还提供了一个有趣的功能，允许从系统记录数据。 这些记录的信息包括来自传感器的数据和机器人的轨迹，可进一步用于调试和数据分析。 对于系统的概述，说明 ROS 节点和主题，可以使用 [Rqt_graph](https://github.com/ros-visualization/rqt_graph/)。 该工具提供了一个用于可视化 ROS 图的 GUI 插件，对于具有多个节点相互交互的大型系统特别有用。

## 优势（Benefits）

### 鲁棒性（Robustness）

Since 2007, ROS has been used everywhere, from robotic arms to underwater vehicles. By default, ROS uses eProsima Fast DDS as a communication backend. That open source implementation has been used in safety critical & high performance scenarios such as self driving cars, planes and battleships. At Kapernikov, we’ve used ROS [aboard a robotic ship](https://kapernikov.com/cases/where-exactly-is-my-ship-accurate-dynamic-positioning-of-vessels/) and [inside food sorting machines](https://kapernikov.com/cases/machine-learning-for-optical-sorting-machines/).

自 2007 年以来，ROS 无处不在，从机械臂到水下航行器。 默认情况下，ROS 使用 eProsima Fast DDS 作为通信后端。 该开源实现已用于安全关键和高性能场景，例如自动驾驶汽车、飞机和战舰。 在 Kapernikov，我们使用了 ROS [在一艘机器人船上](https://kapernikov.com/cases/where-exactly-is-my-ship-accurate-dynamic-positioning-of-vessels/) 和 [inside food 分选机](https://kapernikov.com/cases/machine-learning-for-optical-sorting-machines/)。

Why reinvent the wheel? Even using ROS as a simple communication backbone considerably reduces development time, allowing you to focus on your core business and making your product stand out from the competition.

为什么要重新发明轮子？即便只是将 ROS 用作简单的通信骨干网，也能大大缩短开发时间，让你专注于核心业务，让你的产品在竞争中脱颖而出。

### 良好的生态（Large ecosystem）

One of the benefits of using a standard communication interface is to be able to communicate with 3rd party components. Some hardware manufacturers even support ROS out of the box, making it easy for both experimental or production code to interface with their products.

使用标准通信接口的好处之一是能够与第三方组件通信。一些硬件制造商甚至开箱即用地支持 ROS，使实验或生产代码可以轻松地与他们的产品交互。

For example, Basler provides cameras alongside a ROS driver that directly exposes the raw image captured by the sensor on a ROS topic, allowing any software with a ROS interface to access the image pixels.

例如，Basler 提供相机以及 ROS 驱动程序，该驱动程序直接在 ROS 主题上公开传感器捕获的原始图像，允许任何具有 ROS 接口的软件访问图像像素。

The ROS community has also developed hundreds of algorithms that are presented as ROS components and solve usual problems seen in robotics, such as path finding and geometry transformation.

ROS 社区还开发了数百种算法，这些算法以 ROS 组件的形式出现，解决了机器人技术中的常见问题，例如路径查找和几何变换。

### 编程语言无关性（Programming language independence）

ROS nodes communicate with each other using clearly defined interfaces that are language independent. As a result, it is very common to see systems based on ROS use a combination of Python and C++, and this brings additional benefits at every step of the development process:

ROS 节点使用独立于语言的明确定义的接口相互通信。 因此，基于 ROS 的系统结合使用 Python 和 C++ 是很常见的，这在开发过程的每一步都带来了额外的好处：

- During the research phase, prototypes can be quickly developed in Python if users are more familiar with that language or if they want to benefit from the huge number of helper packages that are available. If needed, those parts can then be rewritten in C++ without altering the other components.
- 在研究阶段，如果用户更熟悉 Python 语言或者他们想从可用的大量帮助程序包中受益，则可以使用 Python 快速开发原型。如果需要，这些部分可以在不改变其他组件的情况下用 C++ 重写。

- Python can be used to develop integration tests (with a framework such as pytest-bdd) that test your components (no matter in which language they are written) using the exact same interfaces that runtime clients will use.
- Python 可用于开发集成测试（使用诸如 pytest-bdd 之类的框架），使用运行时客户端将使用的完全相同的接口来测试你的组件（无论它们是用哪种语言编写的）。
- Your deployed solution may consist of a heterogeneous set of nodes written in C++ or Python, depending on the type of problem they solve or on which framework they are built.
- 你部署的解决方案可能包含一组用 C++ 或 Python 编写的异构节点，具体取决于它们解决的问题类型或构建的框架。
- It’s future proof! No matter what programming languages will be used in a few years, chances are there will be a binding for ROS that enables interfacing with today’s components. While C++, Python and even Lisp are officially supported, a quick Google search brings client libraries for the usual suspects such as Java, Rust & C#.
- 这是未来的证明！无论几年后会使用什么编程语言，ROS 都有可能绑定到今天的组件。虽然官方支持 C++、Python 甚至 Lisp，但通过 Google 快速搜索可以找到常用编程语言的客户端库，例如 Java、Rust 和 C#。

### 架构灵活性（Architecture flexibility）

Using ROS means that your components don’t need to know on which computers their communication peers are running. While some early deployment of your product may run two nodes together on the same machine, a need for more processing power or a different hardware architecture later in development can most of the time be addressed by simply moving one node to another system. The code of both components should stay exactly the same. And it will always be easy to replace a node (or multiple nodes) by a new implementation, e.g. to quickly test a new reasoning engine.

使用 ROS 意味着你的组件不需要知道它们的通信对等方正在哪些计算机上运行。虽然你的产品的一些早期部署可能会在同一台机器上同时运行两个节点，但在大多数情况下，只需将一个节点移动到另一个系统就可以解决后期开发中对更多处理能力或不同硬件架构的需求。两个组件的代码应该保持完全相同。并且总是很容易用新的实现替换一个节点（或多个节点），例如快速测试新的推理引擎。

## 总结（Conclusion）

ROS provides a robust, flexible framework for applications, robotics and other. It supports a wide range of programming languages, comes with a ton of modules to connect to existing hardware or provide common functions and allows a flexible application architecture.

ROS 为应用程序、机器人技术和其他提供了一个强大、灵活的框架。 它支持广泛的编程语言，带有大量模块以连接到现有硬件或提供通用功能，并允许灵活的应用程序架构。



---

原文链接：[Reduce embedded systems development time using ROS](https://kapernikov.com/reduce-embedded-systems-development-time-using-ros/)

