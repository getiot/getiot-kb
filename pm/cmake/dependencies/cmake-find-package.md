---
sidebar_position: 2
sidebar_label: find_package 详解
slug: /cmake-find-package
---

# CMake find_package 详解

`find_package()` 是 CMake 里最常用、也最容易“看起来能用但用法不规范”的依赖查找方式。写好它的关键是：**让依赖以 target 的形式进入你的工程**，再用 `target_link_libraries()` 连接起来，而不是手动拼 include/lib 路径。



## find_package 的两种模式

`find_package(<Package> ...)` 常见有两种工作方式：

- **Config 模式**：依赖提供 `<Package>Config.cmake`（或 `<package>-config.cmake`）。这是“现代 CMake”推荐方式，通常会导出 `Package::Target` 这种 **Imported Target**。
- **Module 模式**：CMake 自带或项目自己提供 `Find<Package>.cmake`（例如 `FindZLIB.cmake`）。它可能只给出变量（如 `ZLIB_INCLUDE_DIRS`），也可能给出 target（取决于模块质量）。

优先顺序通常是 **先找 Config，再找 Module**（可用 `NO_MODULE` / `MODULE` 强制）。



## 示例：使用一个提供 Config 的库

很多第三方库会导出形如 `fmt::fmt`、`spdlog::spdlog` 的 target。使用方式非常固定：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(demo LANGUAGES CXX)

add_executable(app main.cpp)

find_package(fmt CONFIG REQUIRED)
target_link_libraries(app PRIVATE fmt::fmt)
```

你不需要写 `include_directories()`、也不需要写 `link_directories()`；依赖的头文件、编译选项、传递依赖（transitive dependencies）都由 target 表达。



## 用 REQUIRED / QUIET / COMPONENTS

例如：

```cmake showLineNumbers
find_package(OpenSSL REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Widgets Network)
find_package(Python3 QUIET COMPONENTS Interpreter Development)
```

三者的区别：

- **REQUIRED**：找不到就直接报错并停止配置（最常用）。
- **QUIET**：找不到不刷屏（适合可选依赖）。
- **COMPONENTS**：对“有子模块/子包”的依赖（Qt、Boost、Python3 等）常用。



## 找不到包时怎么做？

下面方法的优先级从推荐到不推荐。

### 1) 依赖安装到标准前缀

Linux 下系统包通常安装在 `/usr`、`/usr/local`、`/lib`、`/usr/lib` 等，很多包开箱即用。

### 2) 指定前缀：`CMAKE_PREFIX_PATH`

如果你把依赖安装在自定义目录（如 `~/deps/install`），可以：

```bash
cmake -S . -B build -DCMAKE_PREFIX_PATH="$HOME/deps/install"
```

或在 CMake 里追加（更推荐通过命令行传入，避免写死路径）：

```cmake
list(APPEND CMAKE_PREFIX_PATH "/opt/mylibs")
```

### 3) 指定 `<Package>_DIR`

当你知道 `<Package>Config.cmake` 所在目录时，那么可以：

```bash
cmake -S . -B build -Dfmt_DIR="$HOME/deps/install/lib/cmake/fmt"
```

### 4) 自定义查找模块：`CMAKE_MODULE_PATH`

如果只能用 `FindFoo.cmake`，可把它放进项目 `cmake/Modules/`：

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")
find_package(Foo REQUIRED) # 触发 FindFoo.cmake
```

这种方法仅当没有 Config 时推荐使用。



## 常见问题

- **把“库文件路径”当作依赖管理**：手动设置 `include_directories()` / `link_directories()` 会造成全局污染，且难以传递到下游 target。
- **混用 Config 与 Module 变量**：Config 模式通常导出 target；Module 模式可能只有变量。优先写 target 方式，必要时再兼容变量。
- **只在本机能找到**：把路径写死在 `CMakeLists.txt` 里会导致 CI/同事机器失败；优先用 `CMAKE_PREFIX_PATH`、`<Pkg>_DIR` 通过命令行配置。



## 排错清单

- 打印 CMake 查找路径（快速定位为什么找不到）：

```cmake
message(STATUS "CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}")
```

- 配置时开启更详细的查找日志：

```bash
cmake -S . -B build --debug-find
```

- 如果你确定必须用 Config（拒绝 Module）：

```cmake
find_package(Foo CONFIG REQUIRED)
```



## 小结

- 优先使用 **Config 模式 + Imported Targets**，再用 `target_link_libraries()` 连接依赖。
- 找不到包时，优先用 `CMAKE_PREFIX_PATH` 或 `<Package>_DIR` 从命令行注入路径。
