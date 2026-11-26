---
sidebar_position: 1
---

# Zephyr 简介

![](https://static.getiot.tech/Zephyr-logo-small.png#center)

## Zephyr 是什么

Zephyr RTOS 是一种相对较新的实时操作系统，可为多种 MCU 架构提供支持。你可以获得其他 RTOS 提供的所有常见内核功能，例如线程、信号量、互斥体等（FreeRTOS 是另一个流行的选项）。不同 RTOS 之间完整深入的技术比较超出了本教程的范围，但足以说明我认为 Zephyr 在使使用这些“内核对象”变得容易方面做得很好。

Zephyr RTOS 的另一个主要优点是它完全开源并得到 Linux 基金会的支持。 其他 RTOS 通常得到 Amazon (FreeRTOS)、Azure RTOS (Microsoft) 和 MbedOS (ARM) 等行业巨头的支持； 导致可能的供应商锁定。

也许毫不奇怪，这种开放性极大地加速了 Zephyr 的采用，这可以在比较不同 RTOS 项目之间的贡献数量时看出：

[Contributions to the Zephyr RTOS GitHub repository](https://github.com/zephyrproject-rtos/zephyr/graphs/contributors)

Zephyr 的另一个显着特点是其独特的构建和配置系统。对于那些来自嵌入式 Linux 世界的人来说，Kconfig 是一个熟悉的功能，它允许开发人员调整内核的构建过程，并仅包含那些使用的功能（从而减少内存占用）。



## 为什么选择 Zephyr

选择学习 Zephyr 嵌入式操作系统，以及在你的项目中使用 Zephyr 的原因有很多，下面是我认为的四个主要原因：

1. **轻量级设计**：Zephyr的内核设计非常精简，适用于资源受限的嵌入式系统，能够在小型设备上运行。
2. **开源社区支持**：作为Linux基金会项目，Zephyr得到了广泛的开源社区支持，有着活跃的开发者和丰富的文档资源。
3. **多架构支持**：Zephyr支持多种处理器架构，包括ARM、RISC-V、XTENSA等，提供了更广泛的硬件平台支持。
4. **灵活可定制**：Zephyr的模块化设计使得用户能够根据项目需求选择性地配置和定制内核，实现更高度的灵活性。
