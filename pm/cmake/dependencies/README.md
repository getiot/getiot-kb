---
sidebar_position: 0
---

# 第六部分：依赖管理

这一部分讲“如何把外部库正确地接入你的工程”。优先推荐现代 CMake 的做法：**用 target 表达依赖**，让 include、编译选项、传递依赖都自动传播。

## 学习目标

- 了解依赖管理的几种路径：系统包、源码拉取、外部构建、手动集成
- 能熟练使用 `find_package()`（Config / Module）并排查“找不到包”
- 能在需要时用 `pkg-config` 或 `FetchContent` 作为补充方案

## 推荐阅读顺序

1. `CMake 依赖管理概述`
2. `find_package 详解`
3. `pkg-config 集成`
4. `FetchContent 使用`
5. `ExternalProject 使用`

## 选型建议（快速结论）

- **优先 `find_package(CONFIG)`**：依赖提供 CMake Config 包时最稳定、最现代
- **源码依赖用 `FetchContent`**：依赖不大、希望“一键构建”时
- **大型依赖/隔离构建用 `ExternalProject`**：适合 superbuild、交叉编译、多工具链

