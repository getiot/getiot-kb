---
sidebar_position: 1
slug: /cmake-dependencies
authors: [luhuadong]
---

# CMake 依赖管理概述

项目常常需要依赖第三方库（系统库、预编译库或源码）。CMake 提供多种方式发现、引用这些依赖，并正确设置包含路径、链接库和编译定义。

## 常见方式

| 方式 | 适用场景 | 说明 |
|------|----------|------|
| **`find_package()`** | 提供 CMake 配置脚本的库（如 Qt、OpenCV、Boost） | 最常用，可得到导入目标（如 `Qt5::Core`），直接 target_link_libraries。 |
| **`pkg-config`** | 提供 .pc 文件的库（常见于 Linux） | 用 `pkg_check_modules()` 获取编译/链接选项，再交给 target。 |
| **`FetchContent`** | 从 URL/Git 拉取源码并在配置时构建 | CMake 3.14+，适合无系统包时的依赖。 |
| **`ExternalProject`** | 在构建时下载、配置、编译外部项目 | 更灵活，可控制编译时机和选项，适合大型或需定制的依赖。 |



## 推荐用法

1. **优先 `find_package`**：若库提供 `XXXConfig.cmake` 或 `FindXXX.cmake`，用 `find_package(XXX REQUIRED)`，再用 `target_link_libraries(你的目标 PRIVATE XXX::XXX)` 链接。
2. **系统有 .pc 文件时**：用 **pkg-config** 集成（见 [pkg-config 集成](/cmake/cmake-pkg-config/)）。
3. **无系统包且需从源码构建**：用 **`FetchContent`**（见 [FetchContent 使用](/cmake/cmake-fetchcontent/)）或 **`ExternalProject`**（见 [ExternalProject 使用](/cmake/cmake-external-project/)）。

后续章节会分别介绍 find_package、pkg-config、FetchContent 和 ExternalProject 的用法。
