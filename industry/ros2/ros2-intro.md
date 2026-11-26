---
sidebar_position: 1
authors: [luhuadong]
---

# ROS2 简介

![ROS2 简介](https://static.getiot.tech/ros2-logo.png#center-100)

**ROS2**（Robot Operating System 2）是一个用于机器人和自动化系统开发的开源软件平台。从名字可以看出，它是 [ROS](/ros/ros-intro/) 的下一代版本，目标是利用 ROS1 的优点，改进不足之处，提供一个更加稳定、可靠和可扩展的平台，满足越来越复杂和多样化的机器人应用场景。



## 功能特点

相较于 ROS，ROS2 具有以下特点：

- **更好的可移植性**。ROS2 可以在不同的操作系统和处理器架构上运行，例如 Linux、Windows、macOS 等操作系统，amd64、arm64 等处理器，以满足不同用户的需求。
- **更加稳定和可靠**。ROS2 在设计时考虑了一些 ROS 中存在的问题，例如通信的可靠性、多线程支持等，以提供更加稳定和可靠的运行环境。
- **更加灵活的通信机制**。ROS2 引入了 DDS（Data Distribution Service）作为通信机制，它支持更多的消息传输模式，例如点对点、多播、组播等，以满足不同的应用场景。
- **更好的安全性**。ROS2 提供了更加完善的安全机制，例如支持加密通信、用户身份验证等，以保护机器人系统的安全。
- **更加开放和可扩展**。ROS2 的设计更加开放，可以方便地添加新的功能和扩展，例如支持其他语言、提供更多的驱动程序等。

此外，为了支持机器人系统的开发和测试，ROS2 还提供了丰富的功能和工具，例如消息传输、参数服务器、时间同步、调试工具等。



## 应用场景

目前，ROS2 广泛应用于机器人和自动化系统的开发，例如：

- **工业自动化**。用于机器人和自动化设备的控制和监控，例如生产线上的物料搬运、装配、质检等。
- **服务机器人**。用于服务机器人的开发，例如提供导航、人脸识别、语音识别、图像识别、自主探索等功能。
- **智能交通**。用于智能交通系统的开发，例如自动驾驶汽车、无人机等。
- **医疗保健**。用于医疗保健设备的开发，例如外科手术机器人、病房机器人等。
- **农业机器人**。用于农业机器人的开发，例如自动化种植、灌溉、收获等。

![ROS2机器人操作系统应用场景](https://static.getiot.tech/ROS2-usercases.webp#center)

下面是一些运行 ROS2 的实际项目：

- [TurtleBot 3](https://www.turtlebot.com/turtlebot3/)：一个基于 ROS 和 ROS2 的低成本、可扩展的移动机器人平台，用于教育、研究和开发机器人应用。
- [Open Robotics](https://www.openrobotics.org)：Open Robotics 是 ROS2 的主要开发者之一，他们正在开发许多基于 ROS2 的机器人应用，例如 [MARA](https://acutronicrobotics.com/products/mara/) 机器人和 [Loco Positioning System](https://www.bitcraze.io/documentation/system/positioning/loco-positioning-system/)。
- [Apex.AI](https://www.apex.ai)：Apex.AI 是一家专门从事自动驾驶软件的公司，他们使用 ROS2 作为其开发平台，开发了基于 ROS2 的自动驾驶软件 Apex.OS，并根据 ISO 26262 车辆功能安全标准获得了ASIL D 认证。
- [LG Electronics](https://www.lg.com)：使用 ROS2 开发智能家居和服务机器人，以提供更智能、更方便的生活体验。
- [Bosch](https://www.bosch.com)：使用 ROS2 开发智能制造和智能交通系统。



## 相关链接

- [ROS2 官方文档（Humble）](https://docs.ros.org/en/humble/index.html)
- [ROS2 C++ 库 API](https://docs.ros2.org/latest/api/rclcpp/)
- [ROS2 Python 库 API](https://docs.ros2.org/latest/api/rclpy/)
- [ROS2 GitHub 主页](https://github.com/ros2)
- [ROS 2 Design](https://design.ros2.org)

