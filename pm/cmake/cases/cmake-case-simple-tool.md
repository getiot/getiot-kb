---
sidebar_position: 1
slug: /cmake-case-simple-tool
---

# CMake 实战案例一：简单命令行工具

这一篇用一个“命令行工具”贯穿最常见的 CMake 用法：从单文件到多文件，从最小可用到可安装、可发布。

## 目标

- 构建一个可执行程序 `hello`
- 支持 Debug/Release
- 给出最小可复制的目录结构、CMakeLists、构建命令

## 场景 A：单文件项目（最小可用）

目录结构：

```bash
hello/
├── CMakeLists.txt
└── main.c
```

`main.c`：

```c showLineNumbers
#include <stdio.h>

int main(void) {
  puts("Hello, CMake!");
  return 0;
}
```

`CMakeLists.txt`：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(hello C)

add_executable(hello main.c)
```

构建：

```bash
cmake -S . -B build
cmake --build build -j
./build/hello
```

## 场景 B：多文件 + include 目录（更贴近真实项目）

目录结构：

```bash
hello/
├── CMakeLists.txt
├── include/
│   └── greet.h
└── src/
    ├── greet.c
    └── main.c
```

`include/greet.h`：

```c showLineNumbers
#pragma once

const char* greet(void);
```

`src/greet.c`：

```c showLineNumbers
#include "greet.h"

const char* greet(void) {
  return "Hello, CMake (multi-file)!";
}
```

`src/main.c`：

```c showLineNumbers
#include <stdio.h>
#include "greet.h"

int main(void) {
  puts(greet());
  return 0;
}
```

`CMakeLists.txt`（用 target-based 写法，不污染全局）：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(hello C)

add_executable(hello
  src/main.c
  src/greet.c
)

target_include_directories(hello PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
```

构建命令同上。

## 场景 C：加上版本号、编译选项与构建类型

你可以在顶层声明版本与标准，并按配置添加编译选项：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(hello VERSION 1.0.0 LANGUAGES C)

add_executable(hello src/main.c src/greet.c)
target_include_directories(hello PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_compile_options(hello PRIVATE
  $<$<CONFIG:Debug>:-O0 -g>
  $<$<CONFIG:Release>:-O3>
)
```

配置 Debug/Release：

```bash
cmake -S . -B build-debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build-debug -j

cmake -S . -B build-release -DCMAKE_BUILD_TYPE=Release
cmake --build build-release -j
```

## 场景 D：安装（可选，但很实用）

给可执行文件加安装规则：

```cmake showLineNumbers
include(GNUInstallDirs)
install(TARGETS hello RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
```

安装到系统或自定义前缀：

```bash
cmake -S . -B build -DCMAKE_INSTALL_PREFIX=$HOME/.local
cmake --build build -j
cmake --install build
~/.local/bin/hello
```

## 常见坑

- **忘了用 `-S`/`-B` 分离源代码与构建目录**：推荐统一用 `cmake -S . -B build`。
- **头文件找不到**：优先用 `target_include_directories()` 绑定到目标，不要用全局 `include_directories()`。
- **Debug/Release 没生效**：单配置生成器（Makefiles/Ninja）要设置 `CMAKE_BUILD_TYPE`；多配置生成器（VS/Xcode）要用 `--config`。

## 小结

这个案例覆盖了“可执行程序”的核心骨架。下一篇可以把可复用逻辑提取成库，并演示 `PUBLIC/PRIVATE/INTERFACE` 的传播规则。  
