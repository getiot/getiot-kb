---
sidebar_position: 3
slug: /cmake-case-complex
---

# CMake 实战案例三：复杂项目

这一篇给出一个“更接近生产”的项目骨架：多目录、库与可执行文件分离、可选特性开关、单元测试、依赖管理（示例用 `FetchContent`），以及安装。

## 目标

- 多目录组织：`src/`、`include/`、`apps/`、`tests/`
- 以库为中心：应用与测试都链接同一个库
- 提供一个可选功能开关 `ENABLE_FEATURE_X`
- 集成 CTest + GoogleTest（示例）

## 目录结构（建议模板）

```bash
complex-demo/
├── CMakeLists.txt
├── cmake/
│   └── options.cmake
├── include/
│   └── demo/
│       └── calc.h
├── src/
│   ├── CMakeLists.txt
│   └── calc.c
├── apps/
│   ├── CMakeLists.txt
│   └── demo-cli.c
└── tests/
    ├── CMakeLists.txt
    └── test_calc.cpp
```

## 顶层 CMakeLists.txt

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(complex_demo VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(options)

add_subdirectory(src)
add_subdirectory(apps)

if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
```

`cmake/options.cmake`：

```cmake showLineNumbers
option(ENABLE_FEATURE_X "Enable feature X" OFF)
```

## src/：库目标（核心）

`src/CMakeLists.txt`：

```cmake showLineNumbers
add_library(demo
  calc.c
)

target_include_directories(demo
  PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/../include
)

target_compile_definitions(demo
  PUBLIC
    $<$<BOOL:${ENABLE_FEATURE_X}>:DEMO_ENABLE_FEATURE_X>
)
```

`include/demo/calc.h`：

```c showLineNumbers
#pragma once

int demo_add(int a, int b);
```

`src/calc.c`：

```c showLineNumbers
#include "demo/calc.h"

int demo_add(int a, int b) {
  return a + b;
}
```

## apps/：应用目标

`apps/CMakeLists.txt`：

```cmake showLineNumbers
add_executable(demo-cli demo-cli.c)
target_link_libraries(demo-cli PRIVATE demo)
```

`apps/demo-cli.c`：

```c showLineNumbers
#include <stdio.h>
#include "demo/calc.h"

int main(void) {
  printf("1+2=%d\n", demo_add(1, 2));
  return 0;
}
```

## tests/：GoogleTest（示例）

`tests/CMakeLists.txt`：

```cmake showLineNumbers
include(FetchContent)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG release-1.14.0
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

add_executable(test_calc test_calc.cpp)
target_link_libraries(test_calc PRIVATE demo GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(test_calc)
```

`tests/test_calc.cpp`：

```cpp showLineNumbers
#include <gtest/gtest.h>
#include "demo/calc.h"

TEST(calc, add) {
  EXPECT_EQ(demo_add(1, 2), 3);
}
```

## 构建、运行与测试

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build -j

./build/apps/demo-cli

ctest --test-dir build --output-on-failure
```

启用可选特性：

```bash
cmake -S . -B build -DENABLE_FEATURE_X=ON
cmake --build build -j
```

## 安装（可选）

当你希望把 `demo-cli` 安装到系统（或某个前缀），可以在顶层或 `apps/` 添加：

```cmake showLineNumbers
include(GNUInstallDirs)
install(TARGETS demo-cli RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
```

## 这个骨架的关键点

- **库是中心**：应用与测试都链接库，避免重复编译/复制源码。
- **目录内聚**：每个子目录有自己的 `CMakeLists.txt`，顶层只做“组装”。
- **可选特性用 compile definitions 表达**：让特性对依赖方可见/不可见由 `PUBLIC/PRIVATE` 控制。
- **测试在 BUILD_TESTING 开关下启用**：与 CMake/CTest 生态一致。

## 小结

这套结构足以支撑中型项目，并能自然扩展到依赖管理、安装打包、交叉编译与 CI。你可以把它作为后续章节（依赖/测试/安装/工具链）的“贯穿示例工程”。  
