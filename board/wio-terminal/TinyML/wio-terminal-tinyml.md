---
sidebar_position: 1
slug: /wio-terminal-tinyml
---

# Wio Terminal TinyML 教程



## TinyML 概述

你可能已经猜到 ML 是 Machine Learning 的缩写，即机器学习，大多数情况下（尽管并非总是如此）指的是深度学习。TinyML 中的 Tiny 意味着 ML 模型经过优化，可以在极低功耗和小尺寸设备上运行，例如各种 MCU。它是边缘机器学习或嵌入式机器学习的子集。

嵌入式设备有各种形状和大小，从“嵌入式超级计算机” Nvidia Jetson Xavier AGX 到最小的微控制器，例如 ESP32 或 Cortex M0。但是，为什么运行在微控制器上的机器学习被归入一个特殊的类别，甚至被赋予了一个很酷的名字呢？

这是因为它有自己的一系列优点和局限性。TinyML 的吸引力实际上在于 MCU 无处不在、体积小、功耗低而且相对便宜。

以 ARM Cortex M0+ 和围绕它构建的小 [Seeeduino XIAO](https://www.seeedstudio.com/Seeeduino-XIAO-Arduino-Microcontroller-SAMD21-Cortex-M0+-p-4426.html) 板—— 开发板只有拇指大小（20×17.5 毫米），仅消耗 1.33 毫安时的电量（这意味着它可以使用 150 毫安电池工作约 112 小时，如果进入深度睡眠状态会更多）并且成本低至 4.3 美元。

由于最近模型优化方面的改进，以及专门为在微控制器上运行机器学习模型推理而创建的框架的出现，为这些微型设备提供了更多智能成为可能。我们现在可以在微控制器上部署神经网络，用于音频场景识别（例如大象活动或玻璃破碎声）、热词检测（使用特定短语激活设备），甚至用于简单的图像识别任务。

带有嵌入式微控制器的设备可以为传统传感器赋予新的生命和意义，例如使用安装在异常检测和预测性维护机制上的加速度计，或者用于区分各种甜酒的气体传感，例如这个 [Demo](https://wiki.seeedstudio.com/Wio-Terminal-Edge-Impulse-Distinguish-Alochol/)。

TinyML 未来的可能性确实非常巨大，它的主要限制因素是 MCU 的 RAM 和 Flash 的容量大小。比如自动语音识别，虽然简单的热词（或语音命令检测）是可能的，但目前来看，开放域语音识别仍是 MCU 无法实现的。



## TinyML 课程

Seeed EDU 团队制作了手把手教你如何在 Wio Terminal 上使用 TinyML 的课程。你可以通过单击下面的链接下载 PDF 格式的课程和课程材料。

此外，你可以在 Seeed Studio 博客和 Hackster.io 网站上找到之前发布的独立项目——课程中的项目和独立项目都使用 Arduino IDE 对设备进行编程，并混合使用 Edge Impulse 和 Tensorflow Lite for Microcontrollers 作为模型训练和推理。

课程与独立项目的主要区别在于，课程主要是供 STEM 教师作为开发自己的教材或即用型教材的基础，而独立项目则是供 Maker 和 Hacker 探索和改进他们的项目。

这里先简单介绍一下两个模型训练工具：

- [Edge Impulse](https://www.edgeimpulse.com/) 是一个用户友好的边缘设备机器学习开发平台，为整个 TinyML 管道提供初学者友好（但功能强大）的 Web 界面和工具包，从数据收集到模型部署的方式。
- [Tensorflow Lite for Microcontrollers](https://www.tensorflow.org/lite/microcontrollers/get_started) 则不同，它的学习曲线更陡峭，但允许你实现自己的模型训练和推理管道。



### TinyML 和 Wio Terminal 课程

这个课程介绍如何在 Wio Terminal 上使用 TinyML。

![TinyML with Wio Terminal](https://static.getiot.tech/seeed-TinyML_with_Wio_Terminal.png#center-400)

**相关链接**

- PDF 文档：[TinyML with Wio Terminal course](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML/TinyML_with_Wio_Terminal_Course_v1-3.pdf)
- 课程材料：[Seeed_Arduino_WioTerminal_TinyML_Course-1.0.zip](https://github.com/Seeed-Studio/Seeed_Arduino_WioTerminal_TinyML_Course/archive/refs/tags/1.0.zip)
- GitHub 仓库：[Github of the TinyML with Wio Terminal course](https://github.com/Seeed-Studio/Seeed_Arduino_WioTerminal_TinyML_Course)



### TinyML 零代码编程

这个课程的目的旨在通过 Wio Terminal 和 Codecraft 图形编程向初学者介绍嵌入式机器学习的基础知识。

![No-code Programming to Get Started with TinyML](https://static.getiot.tech/seeed-No-code_Programming_to_Get_Started_with_TinyML.png#center-400)

**相关链接**

- PDF 文档：[No-code Programming to Get Started with TinyML course](https://files.seeedstudio.com/wiki/Wio-Terminal-TinyML/No-code_Programming_to_Get_Started_with_TinyML.pdf)



## 推荐应用

[Codecraft](/dictionary/codecraft/) 中有一些预置的推荐应用（Recommended Apps），这些模型已经预先训练好了，直接上传到 Wio Terminal 上即可使用。

![](https://static.getiot.tech/wio-terminal-codecraft-recommended-apps.png#center)

当然，你肯定想自己动手训练模型，那么下面几个示例一定能帮到你！


- [Wio Terminal 内置加速度器动作识别](/wiot/wio-terminal-codecraft-motion-recognition/)
- [Wio Terminal 内置光传感器手势识别](/wiot/wio-terminal-codecraft-gestures-recognition/)
- [Wio Terminal 内置麦克风识别唤醒词](/wiot/wio-terminal-codecraft-wakeup-words-recognition/)
- [Wio Terminal 外接多通道气体传感器识别味道](/wiot/wio-terminal-codecraft-smell-recognition/)

