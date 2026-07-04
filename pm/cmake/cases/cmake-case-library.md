---
sidebar_position: 2
slug: /cmake-case-library
---

# CMake 实战案例二：库项目

这一篇把上一章的“功能代码”抽成一个库，并演示一个更接近真实工程的组织方式：**一个库 + 一个应用**，并用现代 CMake 的 target 传播 include 与依赖。

## 目标

- 构建一个库 `mylib`（静态或共享都可）
- 构建一个应用 `app`，链接 `mylib`
- 用 `PUBLIC/PRIVATE` 正确传播头文件路径

## 目录结构

```bash
lib-demo/
├── CMakeLists.txt
├── include/
│   └── mylib/
│       └── greet.h
├── src/
│   └── greet.c
└── app/
    └── main.c
```

`include/mylib/greet.h`：

```c showLineNumbers
#pragma once

const char* mylib_greet(void);
```

`src/greet.c`：

```c showLineNumbers
#include "mylib/greet.h"

const char* mylib_greet(void) {
  return "Hello from mylib!";
}
```

`app/main.c`：

```c showLineNumbers
#include <stdio.h>
#include "mylib/greet.h"

int main(void) {
  puts(mylib_greet());
  return 0;
}
```

## 顶层 CMakeLists.txt（推荐写法）

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(lib_demo C)

option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

add_library(mylib
  src/greet.c
)

target_include_directories(mylib
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable(app app/main.c)
target_link_libraries(app PRIVATE mylib)
```

这里的关键点是：把 `include/` 作为 `mylib` 的 **PUBLIC include**。这样 `app` 链接 `mylib` 后，会自动继承头文件搜索路径，不需要再给 `app` 单独设置 include。

## 构建与运行

```bash
cmake -S . -B build
cmake --build build -j
./build/app
```

如果你想构建共享库：

```bash
cmake -S . -B build-shared -DBUILD_SHARED_LIBS=ON
cmake --build build-shared -j
```

## 加一点“像项目”的内容：安装与导出（可选）

如果希望 `mylib` 能被别的工程 `find_package`，通常需要安装并导出 target（这一块属于“打包/安装”章节重点，这里只给最小骨架）：

```cmake showLineNumbers
include(GNUInstallDirs)

install(TARGETS mylib
  EXPORT mylibTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
```

## 常见坑

- **把头文件路径写成 PRIVATE**：库自身能编译，但下游链接后找不到头文件；对外提供的头文件目录应是 `PUBLIC`（或 `INTERFACE`）。
- **库与应用混用全局 include_directories**：短期能跑，长期会变成依赖地狱；优先把依赖绑定到 target。

## 小结

这个案例的核心是“库 target 如何把 include/依赖传播给下游”。下一篇会给出一个多目录、带测试与依赖管理的更完整工程骨架。  
