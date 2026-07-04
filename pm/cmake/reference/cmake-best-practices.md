---
sidebar_position: 3
slug: /cmake-best-practices
authors: [luhuadong]
---

# CMake 最佳实践

本节归纳一些常用写法与习惯，便于写出易维护的 CMake 工程。

## 多源文件与 aux_source_directory若有多个源文件，可逐个列在 add_executable 中，或先收集到变量再传入：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.0)
project(Demo)

# 方式一：显式列出
add_executable(Demo main.cc foo.cc bar.cc)

# 方式二：用 aux_source_directory 收集当前目录源文件
aux_source_directory(. DIR_SRCS)
add_executable(Demo ${DIR_SRCS})
```

:::tip
`aux_source_directory` 只收集当前目录、不递归，且无法按扩展名过滤。新项目更推荐显式列出或使用 `target_sources()`，便于控制哪些文件参与构建。
:::

## 依赖库：从源码构建

若依赖在工程内用 add_library 从源码构建，直接 target_link_libraries 即可：

```cmake showLineNumbers
add_library(archive archive.cpp zip.cpp lzma.cpp)
add_executable(zipapp zipapp.cpp)
target_link_libraries(zipapp PRIVATE archive)
```

参考：[CMake 官方手册 Binary Targets](https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#binary-targets)。

## 依赖库：使用预编译库

若已有预编译库（如 mylib.so），不要用已弃用的 `link_directories()` + 裸库名；推荐用 **find_library** 或 **IMPORTED** 目标。简单情形下可先找到库再链接：

```cmake showLineNumbers
find_library(MYLIB_LIB mylib PATHS ../lib NO_DEFAULT_PATH)
add_executable(myapp myapp.cpp)
target_link_libraries(myapp PRIVATE ${MYLIB_LIB})
# 若头文件不在默认路径，还需 target_include_directories(myapp PRIVATE ../include)
```

这样比全局 `link_directories(../lib)` 更清晰，且只影响该目标。参考：[Stack Overflow: CMake link to external library](https://stackoverflow.com/questions/8774593/cmake-link-to-external-library)。

## 小结

- 多源文件：显式列出或 aux_source_directory，新项目更推荐显式或 target_sources。
- 工程内库：add_library + target_link_libraries(目标 PRIVATE 库名)。
- 预编译库：用 find_library 或 IMPORTED 目标，避免 link_directories 污染全局。
- 更多结构与实践见 [CMake 项目结构最佳实践](/cmake/cmake-project-best-practices/)。
