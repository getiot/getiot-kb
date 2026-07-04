---
sidebar_position: 0
---

# 第一部分：入门基础

这一部分面向第一次接触 CMake 的读者，目标是让你能把一个小工程**配置、生成、构建、运行**起来，并建立对 CMake 生态（生成器、构建目录、GUI）的整体认识。

## 学习目标

- 理解 CMake 是“生成构建系统”的工具，而不是编译器
- 掌握最常用的工作流：`cmake -S . -B build` → `cmake --build build`
- 能在本机完成安装、并知道如何选择合适的生成器（Ninja/Makefiles 等）

## 推荐阅读顺序

1. `CMake 简介`：了解它解决什么问题、在工程里处于什么位置
2. `CMake 安装`：把工具链装好（CMake 本体、编译器、生成器）
3. `CMake 快速上手`：跑通最小工程
4. `CMake 图形界面`：了解 CMake GUI / ccmake 适合什么场景

## 练习建议

- 把快速上手的示例改成多文件项目，并引入一个 `include/` 目录
- 尝试切换生成器（如 Ninja 与 Unix Makefiles），观察 build 目录变化

