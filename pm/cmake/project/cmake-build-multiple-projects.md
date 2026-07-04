---
sidebar_position: 3
slug: /cmake-build-multiple-projects
authors: [luhuadong]
---

# CMake 编译多个子项目

“多个子项目”这里指：在一个总工程里，通过 **add_subdirectory()** 引入多个子目录，每个子目录可能生成自己的可执行文件或库，形成一个多目标、多目录的构建树。

## 与“多个可执行文件”的区别

- **[第三部分：构建多个可执行文件](/cmake/cmake-build-multiple-executables)**：同一 CMakeLists.txt 里多个 **add_executable()**，单目录多目标。
- **本节**：多个**子目录**，每目录一个（或更多）CMakeLists.txt，由顶层 **add_subdirectory()** 串起来，多目录、多子项目。

## 典型做法

顶层 CMakeLists.txt：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.10)
project(SuperProject VERSION 1.0)

add_subdirectory(libcore)    # 核心库
add_subdirectory(app1)       # 应用 1，依赖 libcore
add_subdirectory(app2)       # 应用 2，依赖 libcore
add_subdirectory(tools)      # 工具集，可选
```

在 `app1/CMakeLists.txt` 中：

```cmake showLineNumbers
add_executable(app1 main.cpp)
target_link_libraries(app1 PRIVATE libcore)
```

一次 `cmake --build .` 可构建所有子项目；若只想构建其中一个：

```bash
cmake --build . --target app1
```

## 可选子项目

若某子项目仅在开启某选项时才构建，可用 option + if：

```cmake showLineNumbers
option(BUILD_TOOLS "Build optional tools" OFF)
if(BUILD_TOOLS)
  add_subdirectory(tools)
endif()
```

## 小结

- 多子项目 = 多个 add_subdirectory()，每个子目录有独立 CMakeLists.txt 和目标。
- 被依赖的库子目录要先 add_subdirectory，再在应用子目录里 target_link_libraries。
- 用 **cmake --build . --target 目标名** 可只构建指定目标。
