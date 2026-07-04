---
sidebar_position: 2
slug: /cmake-variables
authors: [luhuadong]
---

# CMake 常用变量

## 概述

**变量引用方式**：使用 `${变量名}` 引用变量。在 `if()` 等语句中则直接使用变量名，不通过 `${}`。

**变量定义方式**：主要有隐式定义和显式定义两种。

- **隐式定义**：例如 `project(HELLO)` 会隐式定义 `HELLO_BINARY_DIR`、`HELLO_SOURCE_DIR` 等（将工程名大写后作为前缀）。
- **显式定义**：使用 `set()` 命令，例如：

```cmake showLineNumbers
set(HELLO_SRC main.cpp src/other.cpp)
```

之后即可通过 `${HELLO_SRC}` 引用该变量。

## 常用目录变量

`CMAKE_BINARY_DIR`、`PROJECT_BINARY_DIR`、`<PROJECT>_BINARY_DIR` 这三个变量指代的内容是一致的，如果是 in source 编译，指得就是工程顶层目录，如果是 out-of-source 编译，指的是工程编译发生的目录。`PROJECT_BINARY_DIR` 跟其他指令稍有区别，现在，你可以理解为他们是一致的。

`CMAKE_SOURCE_DIR`、`PROJECT_SOURCE_DIR`、`<PROJECT>_SOURCE_DIR` 这三个变量指代的内容是一致的，不论采用何种编译方式，都是工程顶层目录。也就是在 in source 编译时，他跟 `CMAKE_BINARY_DIR` 等变量一致。`PROJECT_SOURCE_DIR` 跟其他指令稍有区别，现在，你可以理解为他们是一致的。

`CMAKE_CURRENT_SOURCE_DIR` 指的是当前处理的 CMakeLists.txt 所在的路径，比如上面我们提到的 src 子目录。

`CMAKE_CURRENT_BINARY_DIR`，如果是 in-source 编译，它跟 `CMAKE_CURRENT_SOURCE_DIR` 一致，如果是 out-of-source 编译，他指的是 target 编译目录。使用我们上面提到的 `ADD_SUBDIRECTORY(src bin)` 可以更改这个变量的值。使用 `SET(EXECUTABLE_OUTPUT_PATH < 新路径>)` 并不会对这个变量造成影响，它仅仅修改了最终目标文件存放的路径。

:::tip

CMake 的 in-source（源内编译）会在源码目录生成构建文件，导致源码污染，不推荐使用；而 out-of-source（源外编译）在独立目录构建，保持源码整洁，方便清理，是 CMake 推荐的标准化做法。

:::

## 系统信息

| 变量 | 描述 |
|:-----|:-----|
| `CMAKE_MAJOR_VERSION` | CMake 主版本号，比如 5.2.0 中的 5 |
| `CMAKE_MINOR_VERSION` | CMake 次版本号，比如 5.2.0 中的 2 |
| `CMAKE_PATCH_VERSION` | CMake 补丁号，比如 5.2.0 中的 0 |
| `CMAKE_SYSTEM` | 系统名称，比如 Linux-5.2.0 |
| `CMAKE_SYSTEM_NAME` | 不含版本的系统名，比如 Linux |
| `CMAKE_SYSTEM_VERSION` | 系统版本，比如 5.2.0 |
| `CMAKE_SYSTEM_PROCESSOR` | 处理器名称，比如 x86_64 |
| `UNIX` | 在所有类 UNIX 平台（含 macOS、Cygwin）为 `TRUE` |
| `WIN32` | 在所有 Win32 平台（含 Cygwin）为 `TRUE` |

CMake 判断操作系统示例可参考：[cmake-courses/which-os](https://github.com/getiot/cmake-courses/tree/main/which-os)。

## 环境变量

CMake 可以调用系统的环境变量，调用方法是使用 `$ENV{NAME}` 指令包含环境变量。

例如，打印 HOME 和 PATH 变量值：

```cmake showLineNumbers
message(STATUS "HOME dir: $ENV{HOME}")
message(STATUS "PATH dir: $ENV{PATH}")
```同时，你也可以在 CMake 中设置环境变量（仅影响当前 CMake 运行过程）。例如，设置 CC 编译器环境变量：

```cmake showLineNumbers
set(ENV{CC} gcc)
message(STATUS "Compiler: $ENV{CC}")
```

CMake 环境变量示例：[cmake-courses/env](https://github.com/getiot/cmake-courses/tree/main/env)。
