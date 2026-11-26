---
sidebar_position: 6
---

# AUTOSAR 应用接口



在 AUTOSAR 规范中，将不同模块间通信的接口划分为以下三类：

1. AUTOSAR 接口（AUTOSAR Interface）
2. 标准 AUTOSAR 接口（Standardized AUTOSAR Interface）
3. 标准接口（Standardized Interface）

三种应用接口在 AUTOSAR 架构中的示意图如下图所示。

![AUTOSAR 软件架构的接口示意](https://static.getiot.tech/autosar-application-interface.png#center)

具体说明如下：

- **AUTOSAR 应用接口**（AUTOSAR Interface）是从软件组件的端口衍生而来的通用接口，用于描述数据或服务。它由 RTE 提供给软件组件，可以作为软件组件间通信的接口，也可以作为软件组件与 I/O 硬件抽象层或复杂设备驱动层间的接口。AUTOSAR 接口非标准，可自定义，但在 AUTOSAR 规范中目前已对车身、底盘及动力传动系统控制领域的应用接口做了一些标准化工作。
- **标准 AUTOSAR 接口**（Standardized AUTOSAR Interface）是一中特殊的 AUTOSAR 接口，在 AUTOSAR 规范中有明确的定义。由 RTE 向软件组件提供 BSW 中的服务，如存储器管理、ECU 状态管理、“看门狗”管理等。
- **标准接口**（Standardized Interface）在 AUTOSAR 规范中以 C 语言中 API 的形式明确定义。主要用于 ECU 上的 BSW 各模块间、RTE 和操作系统间、RTE 和通信模块间，应用软件组件不可访问。

