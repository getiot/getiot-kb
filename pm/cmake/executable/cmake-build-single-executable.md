---
sidebar_position: 1
slug: /cmake-build-single-executable
authors: [luhuadong]
---

# CMake 构建单个可执行文件

构建单个可执行文件是 CMake 中最基础的一类目标，在 [CMake 快速上手](/cmake/cmake-quick-start/) 中已经用 Hello World 做过一次。本节在此基础上稍作归纳和扩展。



## 基本步骤

1. **指定最低版本与工程**

   在 CMakeLists.txt 中写清 `cmake_minimum_required` 和 `project()`。

2. **用源文件生成可执行文件**

   使用 `add_executable(目标名 源文件...)`，目标名即生成的可执行文件名。

示例（单源文件）：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.0)
project(myapp VERSION 0.0.1)add_executable(myapp main.cpp)
```

多源文件时，可先收集到变量再传给 `add_executable`：

```cmake showLineNumbers
set(MYAPP_SRCS main.cpp foo.cpp bar.cpp)
add_executable(myapp ${MYAPP_SRCS})
```



## 构建方式

建议使用**单独构建目录**（out-of-source build），避免源码与生成文件混在一起：

```bash
mkdir build
cd build
cmake ..
cmake --build .
```

生成的可执行文件默认在 `build` 目录下（或各子目录对应的构建目录）。若需统一输出目录，可设置 `RUNTIME_OUTPUT_DIRECTORY`（见 [CMake 编译选项](/cmake/cmake-compile-options/) 等章节）。



## 小结

- 单可执行文件 = 一个 `add_executable(目标名 源文件...)`。
- 工程名（`project()`）与可执行文件名（`add_executable` 第一个参数）可以不同。
- 推荐始终在单独目录中执行 `cmake` 和 `cmake --build`。
