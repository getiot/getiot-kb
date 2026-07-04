---
sidebar_position: 1
slug: /cmake-cross-compile
authors: [luhuadong]
---

# CMake 交叉编译

本文通过一个简单示例，说明如何在 CMake 工程中配置交叉编译，生成面向不同硬件平台的可执行文件。示例代码可在 [getiot/linux-c/hello](https://github.com/getiot/linux-c/tree/main/hello) 仓库查看。

## 搭建工程

先写一个最简单的 hello.c：

```c showLineNumbers
#include <stdio.h>

int main(void)
{
    printf("Hello, GetIoT\n");
    return 0;
}
```

对应的 CMakeLists.txt：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.1.3)
project(hello)
set(HELLO_SRCS hello.c)
add_executable(${PROJECT_NAME} ${HELLO_SRCS})
```

在 build 目录下执行 `cmake .. && make`，得到本机（如 x86-64）可执行文件：

```bash
$ mkdir build && cd build
$ cmake .. && make
$ file hello
# hello: ELF 64-bit LSB shared object, x86-64, ...
```

## 方法一：使用 option 切换

在 CMakeLists.txt 中增加一个选项（option），开启时设置交叉编译相关变量（以 aarch64 为例）：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.1.3)
project(hello)
set(HELLO_SRCS hello.c)

option(CROSSCOMPILE_ENABLED "Whether to build for arm" OFF)
if(CROSSCOMPILE_ENABLED)
  set(CMAKE_SYSTEM_NAME Linux)
  set(CMAKE_SYSTEM_PROCESSOR aarch64)
  set(target_arch aarch64-linux-gnu)
  set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
  set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)
  set(CMAKE_LIBRARY_ARCHITECTURE ${target_arch} CACHE STRING "" FORCE)
  set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
  set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
endif()

add_executable(${PROJECT_NAME} ${HELLO_SRCS})
```

编译时打开选项：

```bash
$ cmake -DCROSSCOMPILE_ENABLED=ON ..
$ make
$ file hello
# hello: ELF 64-bit LSB shared object, ARM aarch64, ...
```

## 方法二：使用工具链文件

我们更推荐使用工具链文件，不修改 CMakeLists.txt，把交叉编译配置单独写进一个 .cmake 文件（如 `arm_linux_setup.cmake`）：

```cmake showLineNumbers
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(target_arch aarch64-linux-gnu)
set(CMAKE_C_COMPILER /usr/bin/aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/aarch64-linux-gnu-g++)
set(CMAKE_LIBRARY_ARCHITECTURE ${target_arch} CACHE STRING "" FORCE)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
```

配置时通过 **CMAKE_TOOLCHAIN_FILE** 指定该文件：

```bash
$ cmake -DCMAKE_TOOLCHAIN_FILE=../arm_linux_setup.cmake ..
$ make
```

这样同一份 CMakeLists.txt 既可本机编译，也可交叉编译，只需切换工具链文件。工具链文件的更多约定见 [CMake 工具链文件](/cmake/cmake-toolchain/)。

## 配置说明

交叉编译时 CMake 需要知道“目标系统”和“用哪套编译器”：

- **CMAKE_SYSTEM_NAME**：目标系统名，如 Linux。
- **CMAKE_SYSTEM_PROCESSOR**：目标处理器，如 aarch64。
- **CMAKE_C_COMPILER** / **CMAKE_CXX_COMPILER**：C/C++ 编译器可执行文件路径。

这些变量可通过命令行 `-D` 传入，但写在工具链文件里更清晰、不易出错，也便于复用。
