---
sidebar_position: 3
---

# AUTOSAR 系统架构



2003 年，由全球汽车制造商、零部件供应商及其他电子、半导体和软件系统公司联合建立了汽车开放系统架构联盟（Automotive Open System Architecture），即 AUTOSAR。并联合推出了一个开放化的、标准化的汽车嵌入式系统软件架构 —— AUTOSAR 规范。

与传统 ECU 软件架构相比，AUTOSAR 分层架构的高度抽象使得汽车嵌入式系统软硬件耦合度大大降低，两者对比如下图所示。

![](https://static.getiot.tech/AUTOSAR-vs-conventional-arch.png#center)

AUTOSAR 分层架构是实现软硬件分离的关键，它使汽车嵌入式系统控制软件开发者摆脱了以往 ECU 软件开发与验证时对硬件系统的依赖。

在 AUTOSAR 分层架构中，汽车嵌入式系统软件自上而下分别为应用软件层（Application Software Layer，ASW）、运行时环境（Runtime Environment，RTE）、基础软件层（Basic Software Layer，BSW）和微控制器（Microcontroller）。为保证上层与下层的无关性，在通常情况下，每一层只能使用下一层所提供的接口，并向上一层提供相应的接口。

![AUTOSAR 分层架构](https://static.getiot.tech/autosar-software-arch-simple.png#center)



## AUTOSAR 应用软件层

AUTOSAR 应用软件层（Application Software Layer，ASW）包含若干个软件组件（Software Component，SWC），软件组件间通过端口（Port）进行交互。每个软件组件可以包含一个或者多个运行实体（Runnable Entity，RE），运行实体中封装了相关控制算法，其可由 RTE 事件（RTE Event）触发。



## AUTOSAR 运行时环境

AUTOSAR 运行时环境（Runtime Environment，RTE）作为应用软件层和基础软件层交互的桥梁，为软硬件分离提供了可能。RTE 可以实现软件组件间、基础软件间以及软件组件和基础软件之间的通信。

RTE 封装了基础软件层的通信和服务，为应用层软件组件提供了标准化的基础软件和通信接口，使得应用层可以通过 RTE 接口函数调用基础软件的服务。此外，RTE 抽象了 ECU 之间的通信，即 RTE 通过使用标准化的接口将其统一为软件组件之间的通信。由于 RTE 的实现与具体 ECU 有关，所以必须为每个 ECU 分别实现。



## AUTOSAR 基础软件层

AUTOSAR 基础软件层（Basic Software Layer，BSW）又可分为四层，即服务层（Services Layer）、ECU 抽象层（ECU Abstraction Layer）、微控制器抽象层（Microcontroller Abstraction Layer，MCAL）和复杂驱动（Complex Drivers）。

![AUTOSAR 基础软件层](https://static.getiot.tech/AUTOSAR-Basic-Software-Layer.png#center)

各个软件层又由一系列基础软件组件构成，包括系统服务（System Services）、存储器服务（Memory Services）、通信服务（Communication Services）等。它们主要用于提供基础软件服务，包括标准化的系统功能和功能接口。

**服务层**

服务层（Services Layer）提供了汽车嵌入式系统软件常用的一些服务，其可分为系统服务（System Services）、存储器服务（Memory Services）以及通信服务（Communication Services）三大部分。提供包括网络通信管理、存储管理、ECU 模式管理和实时操作系统（RTOS）等服务。除了操作系统外，服务层的软件模块都是与 ECU 平台无关的。

**ECU 抽象层**

ECU 抽象层（ECU Abstraction Layer）包括板载设备抽象、存储器硬件抽象、通信硬件抽象和 I/O 硬件抽象。该层将 ECU 结构进行了抽象，负责提供统一的访问接口，实现对通信、存储器以及 I/O 的访问，从而不需要考虑这些资源是由微控制器片内提供的，还是由微控制器片外设备提供的。该层与 ECU 平台相关，但与微控制器无关，这种无关性正是由微控制器抽象层来实现的。

**微控制器抽象层**

微控制器抽象层（Microcontroller Abstraction Layer，MCAL）是实现不同硬件接口统一化的特殊层。通过微控制器抽象层可将硬件封装起来，避免上层软件直接对微控制器的寄存器进行操作。微控制器抽象层包括微控制器驱动、存储器驱动、通信驱动、I/O 驱动等模块。

**复杂驱动层**

由于对复杂传感器和执行器进行操作的模块涉及严格的时序问题，难以抽象，所以在 AUTOSAR 规范中这部分没有被标准化，统称为复杂驱动（Complex Drivers）。
