---
sidebar_position: 5
---

# AUTOSAR 数据类型



AUTOSAR 规范中定义了三种数据类型（Data Type）：

1. 应用数据类型（Application Data Type，ADT）
2. 实现数据类型（Implementation Data Type，IDT）
3. 基础数据类型（Base Type）

三种数据类型的具体说明如下。



## 应用数据类型

应用数据类型（Application Data Type，ADT）是在软件组件设计阶段抽象出来的数据类型，用于表征实际物理世界的量，是提供给应用层使用的，仅仅是一种功能的定义，并不生成实际代码。

ADT 从应用逻辑的角度描述数据，体现该数据在现实中的物理语义、物理取值范围、物理单位等。在 ADT 中通常会关联一个计算公式（Computation Method），描述数据从物理（值）范围到内部数字（位）级别的转换关系。一般地，在功能定义的过程中，我们会使用 ADT 的方式对数据进行描述，此时，各应用之间的通信还处于 VFB（Virtual Function Bus）的阶段。



## 实现数据类型

实现数据类型（Implementation Data Type，IDT）是代码级别的数据类型，是对应用数据类型的具体实现；它需要引用基础数据类型（Base Type），并且还可以配置一些计算方法（Compute Method）和限制条件（Data Constraint）。

在 AUTOSAR 中，对于应用数据类型没有强制要求使用，用户可以直接使用实现数据类型。而如果使用了应用数据类型，那么必须进行数据类型映射（Data Type Mapping），即将应用数据类型和实现数据类型进行映射，从而来对每个应用数据类型进行具体实现。



## 基础数据类型

基础数据类型（Base Type）是从 Bit 或 Byte 的角度描述底层平台（Platform）支持的原生类型，这些原生类型最终构建了 IDT 的实现。

完整的 AUTOSAR 数据类型定义包含 ADT、IDT 和 Base Type，且 ADT 和 IDT 之间需要定义映射关系，IDT 和 Base Type 之间需要定义关联关系。ADT 和 IDT 各有关注点和使用场合，实际应用过程中，当我们对物理语义不是很关心的时候，可以只定义 IDT 而不定义 ADT。

