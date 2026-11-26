---
sidebar_position: 1
---

# Syntiant TinyML Board 简介



Syntiant TinyML Board 是美国 AI 芯片研发商 Syntiant 推出的一款 TinyML 开发板，它配备了超低功耗 Syntiant NDP101 神经决策处理器，可以使语音和传感器应用程序分别在 140 和 100 微瓦以下运行。与基于 MCU 的传统 MCU 相比，Syntiant TinyML 板的吞吐量提高 20 倍，系统效率提高 200 倍。

Syntiant TinyML 板的尺寸非常小，仅为 24 毫米 x 28 毫米，是一个小型的独立系统。开发者可以直接通过 Micro USB 连接硬件，通过 Edge Impulse 轻松下载经过训练的模型，而无需任何专用调试硬件。

![Syntiant TinyML Board 开发板](https://static.getiot.tech/Syntiant_TinyML_Board_front.png#center)

备注：Syntiant 是美国一家 AI 芯片研发商，其主要产品为一款低功耗、高性能的深度神经网络处理器，该产品没有传统处理器架构的限制，使用模拟神经网络，该网络可以通过极高的内存效率实现极低的功耗，并且具有大规模并行乘法累加计算的能力，致力于让任何设备都能添加语音控制系统。



## 功能特性

- 神经决策处理器使用 NDP101，连接了两个传感器
  - BMI160 6 轴运动传感器
  - SPH0641LM4H 麦克风
- 主机处理器：SAMD21 Cortex-M0+ 32 位低功耗 48MHz ARM MCU
  - 内置 256KB FLASH 和 32KB SRAM
  - 5 个数字 I/O（与 Arduino MKR 系列板兼容）
  - 其中包含 1 路 UART 接口和 1 路 I2C 接口（包括在数字 I/O 引脚中）
  - 2MB 板载串行闪存
  - 一个用户定义的 RGB LED
  - uSD 卡插槽
- 电路板可使用 5V Micro-USB 或 3.7V LiPo 电池供电



## 硬件组成

Syntiant TinyML 板的硬件组成如下方框图所示。核心器件包括 SAMD21 主控制器、NDP101 神经决策处理器，以及与 NDP101 相连接的两个传感器 —— BMI160 六轴运动传感器和 SPH0641LM4H 麦克风。

![Syntiant TinyML Board 硬件组成](https://static.getiot.tech/Syntiant-TinyMLBoard-BD-TWeb.jpg#center)

NDP101 支持多达 560k 个参数和 64 种输出分类，用户可以利用它来实现非常丰富的 TinyML 应用。

Syntiant TinyML 板的硬件资源分布如下图所示。

![](https://static.getiot.tech/Syntiant-TinyML-Board-Annotation.png#center)



## 资源链接

- [Syntiant Tiny Machine Learning Development Board](https://www.syntiant.com/tinyml)
- [NDP101 Neural Decision Processor](https://www.syntiant.com/ndp101)
- [Edge Impulse 支持此硬件](https://docs.edgeimpulse.com/docs/syntiant-tinyml-board)
- [TinyML 框图](https://www.eetree.cn/wiki/_media/syntiant_tinyml_block_diagram.pdf)
- [TinyML 原理图](https://www.eetree.cn/wiki/_media/syntiant_tinyml_p1_sch.pdf)
- [TinyML Board 教程 （适用于 Windows）](https://www.eetree.cn/wiki/_media/syntiant_tinyml_tutorial_windows_.pdf)
- [TinyML Board 教程 （适用于 Mac）](https://www.eetree.cn/wiki/_media/syntiant_tinyml_tutorial_mac_.pdf)

