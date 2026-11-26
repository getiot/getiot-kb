---
sidebar_label: PlatformIO
sidebar_position: 19
slug: /platformio
---

# PlatformIO 开发工具

![](https://static.getiot.tech/PlatformIO_logo.svg#center-100)

## 简介

**PlatformIO**（简称 PIO）是一款开源且跨平台的嵌入式系统与产品程序的开发工具，可以说是一个强大的嵌入式一站式工具。

传统的嵌入式开发工具通常与厂商绑定，使得我们在更换硬件平台的同时往往需要更换开发工具，这会很不方便。而 PlatformIO 的目标就是解决这个难题，因此它可用于多种嵌入式架构与平台的开发，支持包括 STM32、STM8、ESP32、Amtel AVR、ESP8266、8051 等多种嵌入式平台。

同时，PlatformIO 提供了一系列的工具和服务，可以帮助开发人员在不同的硬件平台上进行的开发、测试和部署。这些优势使得 PlatformIO 在物联网应用开发中受到广大开发者的欢迎。

## 项目起源

PlatformIO 最早由乌克兰开发者 [Ivan Kravets](https://github.com/ivankravets) 在2014年创立。他希望创建一个简单而实用的 IoT 开发生态系统，并提供与各种硬件平台的兼容性。随着时间的推移，PlatformIO 得到了越来越广泛的应用和认可。现在，PlatformIO 已经成为一个活跃的社区，并且有许多用户和贡献者参与其中。

## 主要特点

PlatformIO 具有以下特点：

- 跨平台：支持 Windows、Linux 和 macOS 等操作系统。
- 兼容性：支持超过 100 种不同的嵌入式板卡和框架，包括 Arduino、ESP32、STM32 等常见硬件平台。
- 实用性：提供了一系列的工具和服务，可以帮助开发人员在不同的硬件平台上进行物联网应用的开发、测试和部署。
- 易用性：提供了易于理解和使用的 API 和 GUI 界面，可以帮助开发人员快速上手。
- 开放性：PlatformIO 是一个开源项目，并且遵循 Apache 2.0 许可证。

## 应用领域

PlatformIO 是一个强大的开发工具，可以应用于许多领域，例如：

- 物联网开发：PlatformIO 可以为物联网提供跨平台的开发、测试和部署解决方案。
- 嵌入式系统开发：PlatformIO 可以为嵌入式系统开发提供跨平台的工具和服务。
- 自动化控制系统开发：PlatformIO 可以用于自动化控制系统的开发和测试。
- 机器人开发：PlatformIO 可以用于机器人控制系统的开发和测试。

## 使用方式

PlatformIO 的核心组件是称为 “[PIO Core](https://github.com/platformio/platformio-core)” 的命令行工具，它使用 Python 语言编写，可以独立于集成开发环境（IDE）与文本编辑器使用。因此，PlatformIO 为许多集成开发环境（IDE）与文本编辑器开发了插件，包括 Atom、Eclipse、Emacs、NetBeans、Vim、Visual Studio 和 VS Code 等。

PlatformIO + VS Code 是目前最受欢迎的嵌入式开发 IDE 解决方案之一。PlatformIO 为不同的嵌入式平台提供不同的框架，开发者可以选用厂商提供的或者跨平台的 SDK，比如 Arduino 框架；同时 PlatformIO 也提供第三方代码库的引用与管理功能，能够直接在 IDE 内安装这些第三方库。此外，PlatformIO 还支持单元测试与远程开发功能，并附带了简易的串口调试工具。

![](https://static.getiot.tech/PlatformIO-VSCode-Extension.png#center)



## 相关链接

- [PlatformIO 项目官网](https://platformio.org)
- [PlatformIO Labs](https://piolabs.com)
- [PlatformIO GitHub 主页](https://github.com/platformio)
