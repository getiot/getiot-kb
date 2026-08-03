---
sidebar_position: 1
---

# Yocto Project 简介

Yocto Project 是一个针对嵌入式应用，由全球各地开发人员共同开发、维护的开源软件合作项目。该项目提供模板、工具和方法，帮你创建定制的 Linux 系统和嵌入式产品，而无需关心硬件体系，适合嵌入式Linux开发人员使用，极大地简化了开发过程，因为你不用从头裁剪一个包含很多你并不需要的软件的完整的 Linux 发布版本。

Yocto Project™ 是一个开源的协作软件，提供模板、工具和方法帮你创建定制的 Linux 系统和嵌入式产品，而无需关心硬件体系。适合嵌入式 Linux 开发人员使用。

![](https://static.getiot.tech/Yocto-Badge-Update-Participant-2018.png#center)



## Yocto 项目起源

Yocto Project 起源于一群年轻人想给他们自己的 PDA 编写一个操作系统，当时没有一家公司给 PDA 编写操作系统，于是这些人便想自己写一个。他们采用了 Linux Gentoo 桌面的几个工具，尤其是采用了编译工具 bitbake。刚开始 bitbake 和元数据是打包在一起的，但几年后 bitbake 从元数据中分离出来，形成了现在的 OpenEmbedded。当时有些公司采用了 OpenEmbedded 作为他们的工具，但大多数的嵌入式系统厂商依然采用自己的工具和流程来裁剪 Linux。

到了2010年，由于看到大多数公司花费大量的人力和财力干相同的事情，Wind River Systems 和 Intel 开源技术中心牵头成立了一个开源项目，旨在开发一套标准的构建工具，这套工具采用了 OpenEmbedded 的几个关键组件，任何人都可以使用，任何人都可以贡献。这个项目不以盈利为目的，而是保持开放和中立，为需要他们的社区提供工具和支持，因此这个项目开始与 Linux 基金会合作，由此诞生了 Yocto Project。

如今，Yocto Project 已经成为嵌入式 Linux 系统创建的标准方式，有18个组织和社区成员，这包括了数十家公司、数百名贡献者，以及超过140个国家的开发人员。这是世界上最大的合作开源软件项目之一。

官方网站：[https://www.yoctoproject.org](https://www.yoctoproject.org)



## 为什么要用 Yocto

有许多原因使您考虑采用 Yocto Project 来构建 Linux 系统，其中主要的原因包括：

- Yocto Project 是一个由许多专家和半导体企业组织的开源项目，发展至今已经相当可靠；
  Intel、AMD、ARM、NXP、TI、ST、高通等半导体厂商都是 Yocto Project 项目的成员，如果您的产品正在使用这些公司旗下的处理器，那么通常支持采用 Yocto 方式构建系统，也便于与开源社区同步。
- Yocto Project 可以帮助您创建定制的 Linux 系统和嵌入式产品，不必过于关心硬件体系，简化了客制化 Linux 的开发过程。
- 通过创建和维护自己的 layer，可以实现不同硬件平台、不同产品的兼容与管理，提高代码复用率。



## Yocto 工作流程

![](https://static.getiot.tech/yocto-architecture-drawio.png#center)



## 版本代号

|    代号    |    Yocto 版本     |  发布日期  |   备注   |
| :--------: | :---------------: | :--------: | :------: |
| Kirkstone  | Yocto Project 3.5 | 2022年4月  |  未发布  |
|  Honister  | Yocto Project 3.4 | 2021年10月 | 计划发布 |
| Hardknott  | Yocto Project 3.3 | 2021年4月  | 稳定版本 |
| Gatesgarth | Yocto Project 3.2 | 2020年10月 | 稳定版本 |
|  Dunfell   | Yocto Project 3.1 | 2020年4月  | 长期支持 |
|    Zeus    | Yocto Project 3.0 | 2019年10月 | 项目终止 |
|  Warrior   | Yocto Project 2.7 | 2019年4月  |          |
|    Thud    | Yocto Project 2.6 | 2018年10月 |          |
|    Sumo    | Yocto Project 2.5 | 2018年4月  |          |
|   Rocko    | Yocto Project 2.4 | 2017年10月 |          |
|    Pyro    | Yocto Project 2.3 | 2017年4月  |          |
|   Morty    | Yocto Project 2.2 | 2016年10月 |          |
|  Krogoth   | Yocto Project 2.1 | 2016年4月  |          |
|   Jethro   | Yocto Project 2.0 | 2015年10月 |          |
|    Fido    | Yocto Project 1.8 | 2015年4月  |          |
|   Dizzy    | Yocto Project 1.7 | 2014年10月 |          |
|   Daisy    | Yocto Project 1.6 | 2014年4月  |          |
|    Dora    | Yocto Project 1.5 | 2013年10月 |          |
|   Dylan    | Yocto Project 1.4 | 2013年4月  |          |
|   Danny    | Yocto Project 1.3 | 2012年10月 |          |
|   Denzil   | Yocto Project 1.2 | 2012年4月  |          |
|   Edison   | Yocto Project 1.1 | 2011年10月 |          |
|  Bernard   | Yocto Project 1.0 | 2011年4月  |          |
|  Laverne   | Yocto Project 0.9 | 2010年10月 |          |
|   Green    |        N/A        | 2010年6月  |          |
|   Purple   |        N/A        | 2009年12月 |          |
|   Pinky    |        N/A        | 2009年11月 |          |
|   Blinky   |        N/A        | 2007年8月  |          |
|   Clyde    |        N/A        | 2007年1月  |          |
|    Inky    |        N/A        | 2006年2月  |          |



