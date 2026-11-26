---
sidebar_position: 3
---

# STM32 软件工具



意法半导体（ST）与合作伙伴共同构建了一个强大且成熟的 STM32 生态系统，提供完善的开发工具，帮助用户简化产品的开发。这些工具包括辅助开发的一整套免费的 STM32Cube 软件工具，以及各种功能的软件扩展包；针对 AI 人工智能开发的 STM32Cube.AI 和 NanoEdge AI Studio 工具；以及一些在产品全生命周期提供帮助的工具，例如 STM32 Finder。



## STM32Cube

STM32Cube 是软件工具和嵌入式软件库的结合：

- 一套完整的 PC 软件工具，可满足一个完整项目开发周期的所有需求；
- 在 STM32 微控制器和微处理器上运行的嵌入式软件模块，可带来各种功能（从 MCU 组件驱动程序到更高级的面向应用的特性）。



### STM32CubeMX

STM32CubeMX 作为一种图形化工具，可以用于配置任何 STM32 微控制器。这款简单易用的图形用户界面为 Cortex-M 内核生成初始化 C 代码，并为 Cortex-A 内核生成 Linux 设备树源码。

### STM32CubeIDE

STM32CubeIDE 是一种集成开发环境。该 IDE 基于 Eclipse 或 GNU C/C++ 工具链等开源解决方案，包括编译报告功能和高级调试功能。它还额外集成了生态系统中其他工具才有的功能，比如来自 STM32CubeMX 的硬件和软件初始化和代码生成功能。

实际上，STM32CubeMX 本身包含在 STM32CubeIDE 中。

### STM32CubeMonitor

STM32CubeMonitor 是一款功能强大的监控工具，可帮助开发人员实时微调其应用程序的行为和性能。该数据可视化工具支持在运行时监测和诊断 STM32 应用，新版本还支持远程数据获取和多格式显示，帮助以各种形式对主机设备上的应用程序行为进行可视化，如 PC、平板电脑或智能手机。

### STM32CubeProgrammer

STM32CubeProgrammer 是一个编程工具。它通过多种多样可用的通信媒介（JTAG、SWD、UART、USB DFU、I2C、SPI、CAN 等）为读取、写入和验证设备和外部存储器等操作提供简单易用且高效的环境。

STM32 常用的编程接口：

- 调试接口：JTAG、SWD
- Bootloader 接口：UART、USB



### 软件模块

此外，STM32Cube 工具支持扩展功能，ST 为每个系列的产品提供了对应的软件模块，可根据需要灵活添加到 STM32Cube 软件工具中。这些扩展的软件模块主要包括两方面：

- **STM32Cube MCU 和 MPU 软件包**：专用于每个 STM32 系列产品，提供操作可用的 STM32 外设集所需的全部嵌入式软件模块。它们包括驱动程序（HAL、底层等）、中间件，以及各种实际用例中使用的大量示例代码。
- **STM32Cube 扩展包**：适用于面向应用的解决方案。STM32 扩展包来自 ST 或核准的合作伙伴，通过附加的嵌入式软件模块对 STM32Cube MCU 软件包进行补充和扩展，旨在围绕 STM32 创建广泛的可扩展嵌入式软件产品。



## AI 人工智能

### STM32Cube.AI

STM32Cube.AI 是一个集成在 STM32Cube 软件开发环境的 AI 扩展包，可以对模型进行优化和调优，并直接应用在 STM32 上。

实际上，STM32Cube.AI 是一个 AI 模型转换工具，使用它之前需要用户自行开发和训练模型，支持主流的 AI 框架，包括：TensorFlowLite、Keras、SciKit-Learn、ONNX、MATLAB、PyTorch 等等。

### NanoEdge AI Studio

NanoEdge AI Studio 是嵌入式人工智能软件开发商 Cartesiam 推出的针对 STM32 开发板优化的软件工具。该工具可以消除传统 AI 开发障碍，让缺乏机器学习的企业和开发者也能快速将 AI 功能应用到产品中。



## STM32 Finder

由于 STM32 提供超过 1000 中型号的 MCU 产品，为了方面客户选型，意法半导体提供了 STM32 Finder 选型工具。Finder 工具拥有强大的搜索筛选器，让用户更细致地描述所需的外围设备。自适应图形界面能够根据智能手机或平板电脑的触屏以及屏幕方向自动优化显示效果，内容缓存支持离线搜索。此外，新的增量数据库管理功能在数据更新时可大限度地减少数据使用量和等待时间。

![](https://static.getiot.tech/STM32-Finder.jpg#center)



