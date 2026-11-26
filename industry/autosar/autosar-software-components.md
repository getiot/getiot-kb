---
sidebar_position: 4
---

# AUTOSAR 软件组件



[前面](/autosar/autosar-architecture/)说到，AUTOSAR 应用软件层（Application Software Layer，ASW）包含若干个软件组件（Software Component，SWC）。软件组件不仅仅是应用层的核心，也是一些抽象层、复杂驱动层等实现的载体。

由于软件组件包含的概念较多，因此本文将单独介绍 AUTOSAR 软件组件的相关概念，这些知识也是后续进行应用层、抽象层等开发的基础。



## 概述

AUTOSAR 软件组件大体上可分为原子软件组件（Atomic SWC）和部件（Composition SWC）。其中，部件可以包含多干原子软件组件或部件。

原子软件组件则可根据不同用途分为以下几种类型：

- **应用软件组件（Application SWC）**

  主要用于实现应用层控制算法。

- **传感器/执行器软件组件（Sensor/Actuator SWC）**

  用于处理具体传感器/执行器的信号，可以直接与 ECU 抽象层交互。

- **标定参数软件组件（Parameter SWC）**

  主要提供标定参数值。

- **ECU 抽象软件组件（ECU Abstraction SWC）**

  提供访问 ECU 具体 I/O 的能力。该软件组件一般提供引用 C/S 接口的供型端口（Server 端），由其他软件组件（如传感器/执行器软件组件）的需型端口（Client 端）调用。此外，ECU 抽象软件组件也可以直接和一些基础软件进行交互。

- **复杂设备驱动软件组件（Complex Device Driver SWC）**

  推广了 ECU 抽象软件组件，它可以定义端口与其他软件组件通信，还可以与 ECU 硬件直接交互。因此这类软件组件的灵活性最强，但由于其和应用对象强相关，从而导致其可移植性较差。

- **服务软件组件（Service SWC）**

  主要用于基础软件层，可通过标准接口或标准 AUTOSAR 接口和其他类型的软件组件进行交互。

值得一提的是，上述这些软件组件有的仅仅是概念上的区分，从具体实现及代码生成角度而言都是相通的。

