---
sidebar_position: 3
slug: /cmake-command
authors: [luhuadong]
---

# CMake 常用命令

CMake 命令不区分大小写（大写、小写、混合均可），但推荐统一使用**小写**，与官方文档和现代用法一致。

## 常用预定义变量

```cmake showLineNumbers
PROJECT_NAME              # 项目名称
CMAKE_SOURCE_DIR          # 最外层 CMakeLists.txt 所在目录
PROJECT_SOURCE_DIR        # 当前 project() 定义的源码根目录
CMAKE_CURRENT_SOURCE_DIR  # 当前 CMakeLists.txt 所在目录
CMAKE_CURRENT_BINARY_DIR  # 当前 CMakeLists.txt 对应的构建输出目录
CMAKE_CURRENT_LIST_FILE   # 当前 CMakeLists.txt 的绝对路径
CMAKE_CURRENT_LIST_LINE   # 当前所在行号
```

## 系统信息变量

```cmake showLineNumbers
CMAKE_MAJOR_VERSION       # CMake 主版本号，如 3.22.0 中的 3
CMAKE_MINOR_VERSION       # CMake 次版本号，如 3.22.0 中的 22
CMAKE_PATCH_VERSION       # CMake 补丁号，如 3.22.0 中的 0
CMAKE_SYSTEM              # 系统名称
CMAKE_SYSTEM_NAME         # 不包含版本的系统名
CMAKE_SYSTEM_VERSION      # 系统版本
CMAKE_SYSTEM_PROCESSOR    # 处理器名称
UNIX                      # 类 UNIX 平台为 TRUE（含 macOS、Cygwin）
WIN32                     # Win32 平台为 TRUE（含 Cygwin）
```

## 典型 CMakeLists.txt 流程

### 设置最低 CMake 版本

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.10)
```

### 设置工程名称

```cmake showLineNumbers
project(project_name)
```

### 收集源文件

```cmake showLineNumbers
set(SOURCES main.cpp)
# 或使用 aux_source_directory 自动收集
aux_source_directory(<dir> <variable>)
```

`aux_source_directory` 将指定目录下的所有源文件列表放入变量，例如：

```cmake showLineNumbers
aux_source_directory(. DIR_SRCS)
```

:::tip

`aux_source_directory` 会递归到子目录吗？不会，只收集当前目录。且无法按扩展名过滤，新项目更推荐用 `target_sources()` 或 `file(GLOB ...)` 显式列出源文件。

:::

### 添加头文件搜索目录

```cmake showLineNumbers
include_directories([AFTER|BEFORE] [SYSTEM] dir1 [dir2 ...])
```

例如：

```cmake showLineNumbers
include_directories(${DIR})
include_directories("${PROJECT_SOURCE_DIR}/inc")
```

现代写法更推荐用 `target_include_directories(目标名 PRIVATE/PUBLIC 目录)`，便于按目标管理。

### 生成可执行文件

```cmake showLineNumbers
add_executable(${PROJECT_NAME} ${SOURCES})
```

### 生成库（静态库 / 动态库）

```cmake showLineNumbers
add_library(libname [SHARED|STATIC|MODULE] [EXCLUDE_FROM_ALL] source1 source2 ...)
```

- **SHARED**：动态库（.so / .dll）
- **STATIC**：静态库（.a / .lib）
- **MODULE**：模块库（如插件），在支持 dyld 的系统中使用，否则类似 SHARED

不写类型时，由 `BUILD_SHARED_LIBS` 决定默认是静态还是动态。`EXCLUDE_FROM_ALL` 表示默认不构建该库，除非被其他目标依赖或手动指定构建。

示例：

```cmake showLineNumbers
add_library(StaticLib STATIC src/Main.cpp)
add_library(ShareLib SHARED src/Main.cpp)
```

### 链接库

```cmake showLineNumbers
target_link_libraries(hello_binary PRIVATE StaticLib)
```

### 添加子目录并链接子工程产物

```cmake showLineNumbers
add_subdirectory(sublibrary)
target_link_libraries(${PROJECT_NAME} PRIVATE sublibrary)
```

### 输出消息

```cmake showLineNumbers
message(STATUS "Message")
```

详见 [CMake 消息打印](/cmake/cmake-message/)。

## set 命令

```cmake showLineNumbers
set(<variable> <value> [CACHE <type> <docstring> [FORCE]] | PARENT_SCOPE)
```

- 普通变量：`set(MY_VAR "value")`
- 缓存变量：`set(MY_VAR "value" CACHE STRING "说明")`，可选 `FORCE` 覆盖已有缓存
- 父作用域：`set(MY_VAR "value" PARENT_SCOPE)`，在子目录中设置父目录的变量
