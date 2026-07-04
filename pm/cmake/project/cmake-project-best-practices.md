---
sidebar_position: 4
slug: /cmake-project-best-practices
authors: [luhuadong]
---

# CMake 项目结构最佳实践

以下是一些常用的 CMake 项目组织与书写习惯，便于维护和与他人协作。

## 目录与 CMakeLists 组织

- **一个目录一个职责**：例如 `src/` 放应用、`lib/` 放内部库、`tests/` 放测试，顶层只做 `project()` 和 `add_subdirectory()`。
- **out-of-source 构建**：始终在单独 build 目录执行 cmake，避免污染源码。
- **子目录顺序**：先 add_subdirectory 被依赖的库，再 add_subdirectory 依赖它们的应用或测试。

## 目标与依赖

- **以 target 为中心**：用 **target_include_directories**、**target_compile_definitions**、**target_link_libraries** 等把属性绑在目标上，少用全局的 include_directories、link_libraries。
- **明确可见性**：链接时写清 **PRIVATE** / **PUBLIC** / **INTERFACE**，避免依赖泄露或缺失。
- **find_package 与导入目标**：优先用 `find_package(XXX)` 得到的 `XXX::XXX` 等导入目标做 target_link_libraries，而不是手写路径和链接选项。## 版本与选项

- **cmake_minimum_required** 和 **project(名称 VERSION x.y.z)** 写在最前，便于脚本和策略生效。
- **option()** 用于可选功能、测试、工具等，默认值明确，并在文档或注释中说明。
- 避免在 CMakeLists 里无条件覆盖 **CMAKE_BUILD_TYPE** 等用户可能通过 -D 传入的变量。

## 安装与打包

- 使用 **CMAKE_INSTALL_PREFIX** 和 **CMAKE_INSTALL_BINDIR**、**CMAKE_INSTALL_LIBDIR** 等变量，使安装布局符合 FHS 或目标平台习惯。
- 需要分发包时在末尾 **include(CPack)** 并设置 **CPACK_*** 变量。更多细节可参考 [CMake 最佳实践](/cmake/cmake-best-practices/)。
