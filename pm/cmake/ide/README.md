---
sidebar_position: 0
---

# 第十一部分：IDE 集成

这一部分面向“希望在 IDE 里舒适开发 CMake 工程”的读者，内容以操作步骤、配置要点与常见问题为主。

## 学习目标

- 在 VSCode/QtCreator/CLion 中完成配置、构建、调试
- 理解 IDE 一般如何选择 Kit/Generator/Build Type
- 能定位 IDE 与命令行行为不一致的根因（构建目录、缓存、生成器差异等）

## 推荐阅读顺序

1. `CMake + VSCode 编译调试`
2. `CMake + QtCreator 编译调试`
3. `CMake + CLion 编译调试`

## 练习建议

- 固定一个统一的 build 目录策略（如 `build/`、`build-debug/`、`build-release/`），避免 IDE 自动生成目录导致混乱

