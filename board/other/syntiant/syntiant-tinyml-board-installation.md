---
sidebar_position: 2
---

# Syntiant TinyML Board 开发环境



本文主要介绍如何搭建 Syntiant TinyML 板的开发环境，为了方便用户训练机器学习模型，[Edge Impulse](/dictionary/edge-impulse/) 已经完全支持 Syntiant TinyML Board 了。因此我们需要安装相关的依赖工具。



## 安装依赖

要在 Edge Impulse 中使用 Syntiant TinyML Board，首先需要安装以下软件依赖：

- Arduino CLI（参考 [Arduino 命令行工具](/arduino/arduino-cli/)）
- Edge Impulse CLI

由于 Edge Impulse CLI 依赖 Node.js，因此你还需要先安装 Node.js。安装步骤如下：

1. Node.js v12 或更高版本，参考 [Node.js 安装](/nodejs/nodejs-installation/)

2. [Arduino CLI](https://arduino.github.io/arduino-cli/latest/)，Linux 和 macOS 可执行下面命令安装：

   ```bash
   curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
   ```

   安装完成后，可以使用下面命令进行测试：

   ```bash
   arduino-cli version
   ```

3. Edge Impulse CLI 和 serial monitor

   ```bash
   npm install -g edge-impulse-cli 
   ```

提示：如果安装 Edge Impulse CLI 时出现问题，请参考 [Installation and troubleshooting](https://docs.edgeimpulse.com/docs/cli-installation) 排除故障。



## Arduino IDE

打开 Arduino IDE 的开发板管理器，在搜索框输入 `Arduino&MKRZERO`，安装最新版本的库。

![Syntiant TinyML Board Arduino IDE 开发环境](https://static.getiot.tech/Syntiant-TinyML-Board-Arduino-IDE-Library.png#center)

安装好 Arduino SAMD Boards（32-bits ARM Cortex-M0+）库以后，就可以使用 Arduino IDE 直接对其进行编程啦！



## 资源链接

- 固件：[https://github.com/edgeimpulse/firmware-syntiant-tinyml](https://github.com/edgeimpulse/firmware-syntiant-tinyml)

