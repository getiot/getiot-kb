---
sidebar_position: 2
authors: [luhuadong]
---

# ROS2 版本



ROS 2 目前平均每半年发布一个版本，不同的版本会有对应的代号（例如 Foxy 或 Humble）和官方适配的 Linux 发行版（推荐使用 Ubuntu）。下面我们将介绍关于 ROS2 发行版的概念，以及 ROS2 的最新版本、历史版本和滚动版本。



## 什么是发行版

ROS 发行版（Distributions）是一组版本化的 ROS 软件包集合，这个概念类似于 Linux 发行版，例如 Ubuntu 或者 Android。ROS 发行版的目的是让开发人员可以在相对稳定的代码库上工作，直到他们准备好向前推进一切。

因此，一旦发行版发布，官方就会尝试限制对核心软件包（ros-desktop-full 下的所有内容）的错误修复和非破坏性改进的更改。这种做法通常适用于整个社区，但对于一些“更高”级别的软件包，规则不太严格。



## 发行版列表

下面列出了当前正在开发维护的和历史的 ROS 2 发行版，支持期限（EOL，即 end-of-life）表示官方提供支持的最后期限。同时，我们还列出了 ROS 2 版本和 Ubuntu 发行版的对应关系，这意味着你在某个 Ubuntu 发行版上可以直接安装对应的 ROS 版本。

| ROS2 发行版                                                  | Ubuntu                  | 发布时间   | 支持期限   | Logo                                                         |
| ------------------------------------------------------------ | ----------------------- | ---------- | ---------- | ------------------------------------------------------------ |
| [**Iron** Irwini](https://docs.ros.org/en/foxy/Releases/Release-Iron-Irwini.html) | 22.04 LTS               | 2023年05月 | 2024年11月 | <img src="https://static.getiot.tech/ros2-logo-iron-small.png" alt="ROS2 Iron Irwini" width="128" /> |
| [**Humble** Hawksbill](https://docs.ros.org/en/foxy/Releases/Release-Humble-Hawksbill.html) | 22.04 LTS               | 2022年05月 | 2027年05月 | <img src="https://static.getiot.tech/ros2-logo-humble-small.png" alt="ROS2 Humble Hawksbill" width="128" /> |
| [**Galactic** Geochelone](https://docs.ros.org/en/foxy/Releases/Release-Galactic-Geochelone.html) | 20.04 LTS               | 2021年05月 | 2022年12月 | <img src="https://static.getiot.tech/ros2-logo-galactic-small.png" alt="ROS2 Galactic Geochelone" width="128" /> |
| [**Foxy** Fitzroy](https://docs.ros.org/en/foxy/Releases/Release-Foxy-Fitzroy.html) | 20.04 LTS               | 2020年06月 | 2023年06月 | <img src="https://static.getiot.tech/ros2-logo-foxy-small.png" alt="ROS2 Foxy Fitzroy" width="128" /> |
| [**Eloquent** Elusor](https://docs.ros.org/en/foxy/Releases/Release-Eloquent-Elusor.html) | 18.04 LTS               | 2019年11月 | 2020年11月 | <img src="https://static.getiot.tech/ros2-logo-eloquent-small.png" alt="ROS2 Eloquent Elusor" width="128" /> |
| [**Dashing** Diademata](https://docs.ros.org/en/foxy/Releases/Release-Dashing-Diademata.html) | 18.04 LTS               | 2019年05月 | 2021年05月 | <img src="https://static.getiot.tech/ros2-logo-dashing-small.png" alt="ROS2 Dashing Diademata" width="128" /> |
| [**Crystal** Clemmys](https://docs.ros.org/en/foxy/Releases/Release-Crystal-Clemmys.html) | 16.04 LTS<br/>18.04 LTS | 2018年12月 | 2019年12月 | <img src="https://static.getiot.tech/ros2-logo-crystal-small.png" alt="ROS2 Crystal Clemmys" width="128" /> |
| [**Bouncy** Bolson](https://docs.ros.org/en/foxy/Releases/Release-Bouncy-Bolson.html) | 16.04 LTS               | 2018年07月 | 2019年07月 | <img src="https://static.getiot.tech/ros2-logo-bouncy-small.png" alt="ROS2 Bouncy Bolson" width="128" /> |
| [**Ardent** Apalone](https://docs.ros.org/en/foxy/Releases/Release-Ardent-Apalone.html) | 16.04 LTS               | 2017年12月 | 2018年12月 | <img src="https://static.getiot.tech/ros2-logo-ardent-small.png" alt="ROS2 Ardent Apalone" width="128" /> |



## 滚动发行版

[ROS 2 Rolling Ridley](https://docs.ros.org/en/foxy/Releases/Release-Rolling-Ridley.html) 是 ROS 2 的滚动开发发行版。它在 [REP 2002](https://www.ros.org/reps/rep-2002.html) 中进行了描述，并于 2020 年 6 月首次推出。

ROS 2 的滚动分发有两个目的：

1. 作为 ROS 2 未来稳定分发的暂存区
2. 它是最新开发版本的集合

顾名思义，滚动（Rolling）意味着不断更新，可以进行包括重大更改在内的就地更新。通常，我们建议大多数人使用最新的稳定发行版（请参阅前面的发行版列表）。如果你是 ROS 2 的开发人员，或者想了解 ROS 2 的最新进展和功能，那么可以使用滚动发行版。发布到滚动发行版的[软件包](https://docs.ros.org/en/foxy/How-To-Guides/Releasing/Releasing-a-Package.html)，最终也会发布到 ROS 2 未来的稳定发行版中。
