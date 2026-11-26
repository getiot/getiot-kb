---
sidebar_position: 6
draft: true
---

# Qt 构建系统



大多数 Qt Creator 项目创建向导都允许用户为自己的项目选择想要的构建系统，通常有 qmake、CMake、Meson 或 Qbs 等构建系统。其中，qmake 是 Qt Creator 自带的，在你安装好 Qt Creator 之后，qmake 就已经安装并配置好了。如果想要使用其他构建系统，则需要额外的配置工作，具体如下：

## 配置 CMake

CMake is an alternative to qmake for automating the generation of build configurations.

参考 [Setting Up CMake](https://doc.qt.io/qtcreator/creator-project-cmake.html)

## 配置 Qbs

[Qbs](http://doc.qt.io/qbs/index.html) is an all-in-one build tool that generates a build graph from a high-level project description (like qmake or CMake do) and executes the commands in the low-level build graph (like make does).

参考 [Setting Up Qbs](https://doc.qt.io/qtcreator/creator-project-qbs.html)

## 配置 Autotools 项目

Qt Creator can open projects that use the Autotools build system. You can build and run the projects directly from Qt Creator.

参考 [Setting Up an Autotools Project](https://doc.qt.io/qtcreator/creator-projects-autotools.html)

## 配置 Generic 项目

Qt Creator supports generic projects, so you can import existing projects that do not use qmake or CMake. This enables you to use Qt Creator as a code editor and to fully control the steps and commands used to build the project.

参考 [Setting Up a Generic Project](https://doc.qt.io/qtcreator/creator-project-generic.html)

## 配置 Nimble

The experimental [Nim](https://nim-lang.org/) plugin integrates the Nimble package manager for generating Nim application executables that are supported on Windows, Linux, and macOS.

参考 [Setting Up Nimble](https://doc.qt.io/qtcreator/creator-project-nimble.html)

## 配置 Meson

Meson is an open source build system meant to be both extremely fast, and, even more importantly, as user friendly as possible.

参考 [Setting Up Meson](https://doc.qt.io/qtcreator/creator-project-meson.html)

## 配置 IncrediBuild

IncrediBuild decreases the time it takes to build C++ code.

参考 [Setting Up IncrediBuild](https://doc.qt.io/qtcreator/creator-project-incredibuild.html)

## 配置 Conan

The experimental Conan plugin integrates the Conan package manager that speeds up the integration of C or C++ libraries into your project. You can use Conan with most build systems integrated into Qt Creator.

参考 [Setting Up Conan](https://doc.qt.io/qtcreator/creator-project-conan.html)



