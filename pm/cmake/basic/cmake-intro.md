---
sidebar_position: 1
slug: /cmake-intro
authors: [luhuadong]
---

# CMake 简介

**CMake** 是一个强大的开源、跨平台的自动化构建工具，可用于跨平台软件工程的编译、构建、测试和打包操作。开发人员可以通过 CMake 使用简单的平台和编译器独立配置文件来控制软件的编译过程。目前，对于有跨平台需求的 C/C++ 项目，使用 CMake 管理是最方便的。

CMake 是 Makefile 的上层工具，它通过读取脚本文件 CMakeLists.txt 中的规则来构建编译系统。其目的正是为了产生可移植的 Makefile，并简化自己动手写 Makefile 时的巨大工作量。

## 项目起源

CMake 是众多 Make 工具中的一种。Make 工具里面，比较出名的有 GNU Make、QT 的 qmake、微软的 MS nmake、BSD Make（pmake）、Makepp 等等。这些 Make 工具遵循着不同的规范和标准，所执行的 Makefile 格式也千差万别。这样就带来了一个严峻的问题：如果软件想跨平台，必须要保证能够在不同平台编译。而如果使用上面的 Make 工具，就得为每一种标准写一次 Makefile ，这将是一件让人抓狂的工作。因此 CMake 应运而生，它可以让程序员通过一个与开发平台无关的 CMakeLists.txt 文件来定制整个编译流程，然后再根据目标用户的平台进一步生成所需的 Makefile 和工程文件，如 Linux 平台的 Makefile 或者 Windows 平台下面的 VS 工程。也是一种“Write once, run everywhere”。

![](https://static.getiot.tech/cmake-body.png#center)

## 发展历程

1999 年，国家医学图书馆雇用了一个叫 Kitware 的小公司来开发一个能更好配置、构建和发布复杂跨平台软件的方法。这项工作是 ITK（the Insight Segmentation and Registration Toolkit，一种软件）项目的一部分。作为这个项目的工程领导，Kitware 负责开发一个可供 ITK 项目的研究人员和开发人员使用的软件构建体系。这个系统必须使用简单，并且尽量不占用开发员推进主项目的时间。基于上述指导思想，CMake 作为过去的软件构建工具 autoconf/libtool 的替代品，它应该扬其长避其短。经过多年的发展，CMake 从最初的软件构建体系发展成为了一系列的开发工具：CMake、CTest、CPack 和 CDash。

- **CMake** 是软件构建工具；
- **CTest** 是一个测试驱动工具，用来做回归测试；
- **CPack** 是打包工具，它能为用 CMake 构建的软件创造各个平台的安装包；
- **CDash** 是一个网页应用，能够持续执行集成测试并且展示测试结果。

## 为什么使用 CMake

有许多理由让您选择使用 CMake 作为工程的构建工具，例如：- **CMake 是高效的**
  - CMake 可以让开发人员花更多的时间编写代码，而花更少的时间搞清楚构建系统。
  - CMake 是开源的，可免费用于任何项目。
- **CMake 很强大**
  - CMake 支持同一项目中的多个开发环境和编译器（例如：Visual Studio IDE、Qt Creator、JetBrains CLion、vim、emacs、gcc、MSVC、clang、Intel）。
  - CMake 支持多种语言，包括 C/C++/CUDA/Fortran/Python，还支持在构建过程中运行任意自定义命令。
  - CMake 通过 CTest 支持与 Jenkins、Travis、CircleCI、GitLab CI 以及几乎任何 CI 系统协同工作的持续集成（CI）测试。测试结果使用 [CDash](https://www.cdash.org) 显示。
  - CMake 支持将第三方库集成到您的项目中。
- **CMake 是开发团队的首选**
  - CMake 是构建 C++ 项目的事实标准。
  - 许多 C++ 项目正在转向 CMake。（根据 [2018 Octoverse 报告](https://octoverse.github.com/projects.html)，它是 GitHub 上增长速度第六快的语言）
  - CMake 拥有成熟且经过良好测试的广泛开发者社区，自 2000 年以来经历了持续改进。

## 应用项目

许多大型 C/C++ 项目都采用 CMake 来管理构建系统，例如：

- [KDE](https://github.com/KDE)
- [OpenCV](https://github.com/opencv/opencv)
- [TDengine](https://github.com/taosdata/TDengine)
- [Mbed TLS](https://github.com/ARMmbed/mbedtls)
- [Eclipse Paho MQTT](https://github.com/eclipse/paho.mqtt.c)
- 还有 [CMake](https://github.com/Kitware/CMake) 本身

## 相关链接

- 官方网站：[https://cmake.org](https://cmake.org)
- 文档中心：[https://cmake.org/documentation/](https://cmake.org/documentation/)
- GitHub 仓库：[https://github.com/Kitware/CMake](https://github.com/Kitware/CMake)
- CMake Tutorial：[https://cmake.org/cmake/help/latest/guide/tutorial/index.html](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
