---
sidebar_position: 4
slug: /cmake-fetchcontent
---

# FetchContent 使用

`FetchContent` 是现代 CMake（3.11+）提供的依赖获取方式：在 **配置阶段** 拉取第三方源码，并把它作为子工程加入当前构建（通常通过 `add_subdirectory`）。它特别适合：

- 依赖规模不大、希望“一次配置就能拉齐源码”
- CI 或新同事一键构建（不要求预装依赖）
- 依赖本身也使用 CMake 构建



## 示例：拉取并使用 fmt

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(demo LANGUAGES CXX)

include(FetchContent)

FetchContent_Declare(
  fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG 10.2.1
)

FetchContent_MakeAvailable(fmt)

add_executable(app main.cpp)
target_link_libraries(app PRIVATE fmt::fmt)
```

配置与构建：

```bash
cmake -S . -B build
cmake --build build -j
```



## 常用选项

### 固定版本（强烈建议）

- 用 `GIT_TAG` 固定到某个 release/tag/commit，避免“今天能构建，明天拉最新就坏了”。

### 关闭依赖的测试/示例（常用）

很多依赖默认会编译测试/示例，会拖慢构建。通常可以在 `FetchContent_MakeAvailable()` 之前设置它的选项（不同项目选项名不同）：

```cmake showLineNumbers
set(FMT_TEST OFF CACHE BOOL "" FORCE)
set(FMT_DOC OFF CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(fmt)
```



## FetchContent 与 find_package 的配合策略

工程里常见的最佳实践是：**优先使用系统/预装依赖**，找不到再用 `FetchContent` 兜底：

```cmake showLineNumbers
find_package(fmt CONFIG QUIET)
if(NOT fmt_FOUND)
  include(FetchContent)
  FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 10.2.1
  )
  FetchContent_MakeAvailable(fmt)
endif()

add_executable(app main.cpp)
target_link_libraries(app PRIVATE fmt::fmt)
```

这样在“有包管理器的环境”走 `find_package`，在“干净环境/CI”自动拉取构建。



## 常见问题

- **构建目录膨胀**：FetchContent 会把依赖也放进同一 build 树，依赖多时 build 体积变大。
- **网络不稳定**：CI 可能需要缓存（如缓存 build 目录或依赖下载目录）。
- **依赖不是 CMake 工程**：FetchContent 只能“拿源码”，但能否 `add_subdirectory` 取决于依赖是否提供 CMakeLists。



## 何时不要用 FetchContent

- 依赖很大、编译很慢、需要严格隔离构建（更适合 `ExternalProject` 或 Superbuild）
- 交叉编译/多工具链下，需要依赖与主工程分离安装前缀



## 小结

- `FetchContent`：配置阶段拉源码、在同一 build 树里构建依赖，易用、现代、适合中小依赖。
- 与 `find_package(QUIET)` 配合，可以同时兼顾“系统包优先”和“一键构建”。
