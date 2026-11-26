---
sidebar_position: 8
---

# AUTOSAR 方法论



AUTOSAR 方法论（AUTOSAR Methodology）中车用控制器软件的开发涉及系统级、ECU 级和软件组件级。

- 系统级主要考虑系统功能需求、硬件资源、系统约束，然后建立系统架构；
- ECU 级根据抽象后的信息对 ECU 进行配置；
- 系统级和 ECU 级设计的同时，伴随着软件组件级的开发。

上述每个环节都有良好的通信接口，并使用统一的 arxml（AUTOSAR Extensible Markup Language）描述文件，以此构建了 AUTOSAR 方法论。

下图展示了 AUTOSAR 方法论中“自顶向下”的软件组件设计和 VFB 实现方法。

![](https://static.getiot.tech/autosar-methodology-01.png#center)

在开发 AUTOSAR 之前，需要先编写系统配置描述文件，包括以下三部分内容：

1. **软件组件描述**（SW-Component Description）：包含系统中所涉及的软件组件的接口信息，例如数据类型、端口接口、端口等；
2. **ECU 资源描述**（ECU Resource Description - HW only）：包含系统中每个 ECU 所需要的处理器及其外设、传感器、执行器等信息；
3. **系统约束描述**（System Constraint Description）：包含总线信号、软件组件间的拓扑结构和一些映射关系等信息。

基于上述系统配置输入描述文件，系统配置根据 ECU 资源和时序要求，将软件组件映射到对应的 ECU 上，生成系统配置描述文件（System Configuration Description）。该文件包含了设计过程中非常重要的一个描述 —— 系统通信矩阵，其描述了网络中所有运行的数据帧及其对应的时序和内容。

从系统级到 ECU 级的过渡操作是指 ECU 信息抽取（ECU Extract）。在系统配置阶段已经将每个 ECU 所包含的所有软件组件、网络通信等信息封装好，ECU 信息抽取阶段只需将待配置 ECU 信息抽取出来即可，服务于之后的 ECU 配置。

ECU 配置过程主要是对 RTE 和 BSW 的配置。

- 在 RTE 配置阶段，需要将软件组件的运行实体映射到相应的操作系统任务；
- 在 BSW 配置阶段，需要详细配置 BSW 层中所需要用到的模块，一般有操作系统、通信服务、ECU 抽象层和微控制器抽象层等。

然后根据 ECU 配置信息生成 BSW 和 RTE 代码，再结合软件组件级实现的应用代码，最终进行代码集成，编译链接，生成单片机可执行文件。

