---
sidebar_position: 5
slug: /ros-basic-concepts
authors: [luhuadong]
---

# ROS 基本概念



本文主要介绍 ROS 机器人操作系统的一些基本概念。从根本上说，ROS 是两个程序或者进程间通信的框架。在机器人项目中，通常会有很多执行器和传感器模块，使用 ROS 就可以将这些模块编程为各个节点，这些节点就可以通过和名为 ROS Master 的 ROS 程序通信，发送信息的节点称为发布节点（Publisher Nodes），接收信息的节点称为订阅节点（Subscriber Nodes），ROS Master 负责向节点广播彼此的节点信息以帮助它们建立连接，这样就实现了多个节点间的相互通信。



## ROS 相关术语

- **ROS 节点**（Node）：使用 ROS API 进行运算的进程。
- **ROS 主机**（Master）：连接 ROS 节点的媒介程序。
- **ROS 参数服务器**（Parameter Server）：指通常与 ROS Master 一起运行的一个程序。使用者可以在此服务器上存储不同的参数，所有的节点都可以访问它，使用者可以设置参数的保密性。如果某个参数是公共的，那么所有节点都可以访问；但如果某个参数具有私有属性，那么只有特定的节点才可以访问这个参数。
- **ROS 话题**（Topic）：即“总线”，ROS 节点可以通过该总线发送或接收信息。一个节点可以发布或者接收任意数量的话题。
- **ROS 消息**（Message）：消息基本上都是通过话题传送的。ROS 含有许多内建的消息类型，当然使用者也可以定义他们自己的消息类型。
- **ROS 服务**（Service）：服务是一种根据客户节点的请求进行服务响应的功能，前面提到的 ROS 话题（Topic）采用消息发布/订阅机制，而 ROS 服务则有着请求/应答的机制。能够处理服务请求的节点被称为服务节点，而请求服务的节点被称为客户节点。
- **ROS 数据包**（bags）：一种可用于保存和查看 ROS 话题历史记录的有效方式，可用于在机器人中记录数据以便离线处理。



## ROS 文件系统

ROS 文件系统的概念及术语包括程序包、元包、包清单、代码库、消息类型和服务类型。

- **ROS 程序包** 是 ROS 软件的独立单元，又称为“原子单元”。所有的源代码、数据文件、生成文件、依赖包和其他文件都放在程序包中。

- **ROS 元包** 记录了服务于同一应用的一组程序包的相关信息，它不包含源代码文件或者数据文件。ROS 元包只提供分组功能，用于组织管理一组 ROS 程序包。

- **包清单** 是 ROS 程序包里的 XML 文件，它涵盖了 ROS 程序包的所有基本信息，包括程序包的名称、描述、作者、依赖包等。下面是一个典型的程序包的 XML 文件示例：

  ```xml
  <? xml version = "1.0"?>
  <package>
      <name>test_pkg</name>
      <version>0.0.1</version>
      <description>The test package</description>
      <maintatiner email="robot@getiot.tech">robot</maintatiner>
      <license>BSD</license>
      <buildtool_depend>catkin</buildtool_depend>
      ...
      <run_depend>catkin</run_depend>
      ...
  </package>
  ```

- **ROS 代码库** 是共享同一个版本控制系统一组 ROS 程序包的集合。

- **消息类型** 用来定义新的 ROS 消息类型。尽管 ROS 中有许多内建的消息类型可供直接使用，但是如果我们想要创建一种新的 ROS 消息类型，也是完全可以实现的。新的消息类型被定义并存储在程序包中的 msgs 文件夹中。

- **服务类型** 与消息类型十分相似，它也可以由我们自己定义，并被存放于程序包的 srv 文件夹中。



