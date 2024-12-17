---
sidebar_position: 31
slug: /tinygo
---

# TinyGo：用于微控制器的 Go 编译器



TinyGo 是一个用于微控制器的 Go 编译器，专注于支持嵌入式系统和物联网设备等资源受限的平台，如微控制器、嵌入式设备、WebAssembly（WASM）等。它重用了 Go 语言工具和 LLVM 一起使用的库，编译用 Go 语言编写的程序。

TinyGo 针对嵌入式系统做了优化（不支持所有 Go 标准库），生成的可执行文件更小，运行速度可能会受到一定影响，但更适合在资源受限的环境下运行。

![](./images/tinygo-logo.png#center-200)



## 支持硬件

- Adafruit Circuit Playground Express
- Adafruit ItsyBitsy M0
- Arduino Uno
- BBC:Microbit
- ST Micro STM32F103XX "Bluepill"
- Digispark
- Nordic Semiconductor PCA10031
- Nordic Semiconductor PCA10040
- Nordic Semiconductor PCA10056
- Makerdiary nRF52840-MDK
- Phytec reel board



## 资源链接

- [TinyGo 官方网站](https://tinygo.org)
- [TinyGo 代码仓库](https://github.com/tinygo-org/tinygo)
