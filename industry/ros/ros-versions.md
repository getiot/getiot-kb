---
sidebar_position: 2
slug: /ros-versions
authors: [luhuadong]
---

# ROS 版本



本文介绍 ROS 的版本划分，根据 ROS 项目演进，可分为 ROS1 和 ROS2 两个大版本，ROS2 相较于前者有更好的实时性和可靠性。而在 ROS1 和 ROS2 中，又包含许多不同的版本（称为“发行版”，Distributions），下面将简单介绍 ROS 的不同版本，让读者有个大致的认识。



## ROS 和 ROS2

由于历史原因，ROS 有两个大版本 —— ROS1（通常用 ROS 替代）和 ROS2，两者的差别如下图所示。

![](https://static.getiot.tech/ROS1-vs-ROS2-Architecture.png#center)

我们知道 ROS 始于2007年11月，最早是“柳树车库”（Willow Garage）用于 PR2 机器人的开发，同时希望 ROS 能用于其他机器人。因此，柳树车库花费了大量精力定义了抽象级别（通常是通过消息的接口），允许软件重用。按照最初的设想，ROS 是用于单个机器人、板载工作站级别的计算资源、没有实时性需求，以及理想的网络连接场景的学术研究项目。ROS 强调最大的灵活性，没有过多的约定或者禁止。

然而，出乎意料的是，ROS 发布以来就被应用于各种各样的机器人，包括轮式机器人、腿式机器人、工业手臂、室外无人车辆、自动驾驶汽车、无人机、无人艇等等。随着大量基于 ROS 的产品进入市场，比如制造业机器人、农业机器人、商业清洁机器人等，甚至连 NASA 也将运行 ROS 的 Robonaut 2 部署到国际空间站。ROS 已经从最初的学术研究项目，演变成一个工业界应用广泛的商业项目，已经成为机器人领域的事实标准。

随着应用场景的扩大，ROS 最初设计时的局限性已经难以满足更多新需求。比如说实时性和网络延迟，以及 ROS 严重依赖 Ubuntu 系统，导致无法在小型嵌入式平台运行等等。因此，社区开发者对新一代 ROS 的呼声越来越大，ROS2.0 的消息也不绝于耳。

在 ROSCon 2014 上，新一代 ROS 的设计架构（Next-generation ROS：Building on DDS）正式公布。2015年8月第一个 ROS2.0 的 Alpha 版本落地，2016年12月 ROS2.0 的 Beta 版本正式发布，2017年12月8日，万众瞩目的 ROS2.0 终于发布了第一个正式版 —— Ardent Apalone。

ROS2 的核心是 DDS（Data Distribution Service，数据分发服务），它是由对象管理组织 OMG（Object Management Group）在 2014 年发布的一种专门为实时系统设计的数据分发/订阅标准。关于 DDS 的更多介绍我们将在后面进行讲解。



## ROS 版本代号

Ubuntu 和 ROS1 部分版本对应关系及官方支持结束时间如下表所示。

| Ubuntu    | ROS1                                           | 发布时间  | 支持期限  |
| --------- | ---------------------------------------------- | --------- | --------- |
| 20.04 LTS | [Noetic Ninjemys](http://wiki.ros.org/noetic)  | 2020年5月 | 2025年5月 |
| 18.04 LTS | [Melodic Morenia](http://wiki.ros.org/melodic) | 2018年5月 | 2023年5月 |
| 16.04 LTS | [Kinetic Kame](http://wiki.ros.org/kinetic)    | 2016年5月 | 2021年4月 |
| 14.04 LTS | [Indigo Igloo](http://wiki.ros.org/cn/indigo)  | 2014年5月 | 2019年4月 |


Ubuntu 和 ROS2 部分版本对应关系及官方支持结束时间如下表所示。

| Ubuntu    | ROS2                                                         | 发布时间   | 支持期限   |
| --------- | ------------------------------------------------------------ | ---------- | ---------- |
| 22.04 LTS | [Humble Hawksbill](http://docs.ros.org/en/rolling/Releases/Release-Humble-Hawksbill.html) | 2022年5月  | 2027年5月  |
| 20.04 LTS | [Foxy Fitzroy](http://docs.ros.org/en/rolling/Releases/Release-Foxy-Fitzroy.html) | 2020年6月  | 2023年5月  |
| 18.04 LTS | [Dashing Diademata](https://docs.ros.org/en/crystal/Releases/Release-Dashing-Diademata.html) | 2019年5月  | 2021年5月  |
| 18.04 LTS | [Crystal Clemmys](https://docs.ros.org/en/crystal/Releases/Release-Crystal-Clemmys.html) | 2018年12月 | 2019年12月 |


注意：**Noetic Ninjemys 是 ROS1 的最后一个版本，也就是说，Ubuntu 22.04 及后续版本只支持 ROS2。**



## 更多

- [ROS Distributions](http://wiki.ros.org/Distributions)
- [ROS2 Distributions](http://docs.ros.org/en/rolling/Releases.html)



