---
sidebar_position: 2
slug: /tinymaix
---

# TinyMaix 超轻量级推理框架



TinyMaix 是矽速科技（Sipeed）推出的一款面向单片机（MCU）的超轻量级的神经网络推理库，即 TinyML 推理库，可以让你在任意单片机上运行轻量级深度学习模型。



## 关键特性

- 核心代码少于 **400 行**（tm_layers.c + tm_model.c + arch_cpu.h），代码段（.text）少于 **3KB**。
- 低内存消耗，甚至 **Arduino ATmega328**（32KB Flash，2KB Ram）都能基于 TinyMaix 跑 mnist（手写数字识别）。
- 支持 **INT8/FP32/FP16** 模型，实验性地支持 **FP8** 模型，支持 keras h5 或 tflite 模型转换。
- 支持多种芯片架构的专用指令优化：**ARM SIMD/NEON/MVEI、RV32P、RV64V**。
- 友好的用户接口，只需要 load/run 模型。
- 支持全静态的内存配置（无需 malloc）。



## 相关链接

- GitHub 仓库：[https://github.com/sipeed/TinyMaix](https://github.com/sipeed/TinyMaix)
- 使用文档：[https://wiki.sipeed.com/news/others/tinymaix_cnx/tinymaix_cnx.html](https://wiki.sipeed.com/news/others/tinymaix_cnx/tinymaix_cnx.html)

