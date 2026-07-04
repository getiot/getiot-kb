---
sidebar_position: 4
slug: /cmake-superbuild
authors: [luhuadong]
---

# CMake Superbuild 超级构建

**Superbuild** 是 CMake 的一种用法：在“主项目”的配置/构建过程中，先配置并构建项目所**依赖的第三方库**，再把这些依赖的构建结果交给主项目使用。也就是说，“生成主项目的构建器（如 Makefile、VS 工程）之前，先完成依赖的构建”。

:::tip 说明

“生成构建器”指的是生成当前项目的构建系统，例如 VSCode 下的 CMake 工程、GCC 的 Makefile、macOS 下的 Xcode 工程等。

:::



## 典型做法

- 使用 **`ExternalProject_Add()`** 在顶层 CMakeLists.txt 中声明依赖的源码位置（URL 或本地路径）、配置与构建命令；CMake 会在构建阶段下载/配置/编译这些依赖。
- 主项目通过 **`add_subdirectory()`** 引入的“实际工程”只负责应用本身，其依赖由 Superbuild 层在上一级先构建好，并通过 **`CMAKE_PREFIX_PATH`** 或 **`find_package`** 的搜索路径指向 Superbuild 构建出的安装目录。这样，一次 `cmake .. && cmake --build .` 会先构建依赖，再构建主项目，适合“依赖不提供系统包、需要从源码构建”的场景。



## 与 FetchContent 的区别

- **FetchContent**：通常在配置阶段拉取并（通过 `add_subdirectory`）在同一构建树中构建依赖，依赖与主项目混在同一 build 目录。
- **Superbuild / ExternalProject**：依赖在构建阶段构建，可放在独立目录，构建顺序和安装路径更灵活，适合大型或需严格隔离的依赖。



## 小结

- Superbuild = 先构建依赖，再构建主项目；常用 **ExternalProject_Add** 管理依赖的下载与构建。
- 主项目通过前缀路径或 `find_package` 使用 Superbuild 构建出的依赖。
- 适合无系统包、需从源码构建且希望构建流程一体化的场景。