---
sidebar_position: 5
slug: /cmake-external-project
---

# ExternalProject 使用

`ExternalProject`（来自 `ExternalProject` 模块）用于把“第三方项目”作为 **独立的外部构建步骤** 来管理：下载/更新 → 配置 → 构建 → 安装。它与 `FetchContent` 最大区别是：依赖通常不混进主工程的 `add_subdirectory`，而是独立 build，并通过“安装前缀”再被主工程消费。

典型适用场景：

- 依赖很大、构建时间长，希望与主工程隔离
- 依赖不是 CMake 工程（需要自定义 configure/build/install 命令）
- 你在做 **Superbuild**：先构建并安装依赖，再构建主工程



## 示例：用 ExternalProject 构建并安装一个依赖

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(demo LANGUAGES CXX)

include(ExternalProject)

set(DEPS_INSTALL_DIR "${CMAKE_BINARY_DIR}/deps-install")

ExternalProject_Add(ext_fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG 10.2.1
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX=${DEPS_INSTALL_DIR}
    -DFMT_TEST=OFF
  UPDATE_DISCONNECTED 1
)
```

上面只是“把依赖装到一个前缀目录”。接下来你需要让主工程能找到它。



## 主工程使用 ExternalProject 的安装结果

最常见的做法是把安装前缀加入 `CMAKE_PREFIX_PATH`，然后 `find_package`：

```cmake
list(PREPEND CMAKE_PREFIX_PATH "${DEPS_INSTALL_DIR}")
find_package(fmt CONFIG REQUIRED)

add_executable(app main.cpp)
add_dependencies(app ext_fmt) # 确保先构建依赖
target_link_libraries(app PRIVATE fmt::fmt)
```

注意：如果你把 `find_package` 放在 `ExternalProject_Add` 之前，配置阶段可能还找不到（因为依赖尚未构建安装）。在“单次配置就要求能 find 到”的需求下，更适合 `FetchContent`；而 `ExternalProject` 更适合“构建阶段产出依赖，再构建主工程”的 superbuild 结构。



## 常见实践：Superbuild 结构

很多工程会把 superbuild 放在顶层，把“真正的主工程”放在子目录：

```bash
repo/
├── CMakeLists.txt          # superbuild：ExternalProject_Add 依赖 + ExternalProject_Add 主工程
└── src/
    └── CMakeLists.txt      # 主工程：正常 add_library/add_executable + find_package
```

这样顶层负责依赖生命周期，`src/` 只做产品本身，结构更清晰。



## 常见问题

- **配置阶段找不到包**：`ExternalProject` 在构建阶段才会安装依赖；不要指望第一次 configure 就能 `find_package` 成功（除非你做了分阶段配置或已有缓存安装结果）。
- **并行构建依赖顺序**：记得用 `add_dependencies()` 保证 target 构建顺序。
- **交叉编译**：外部项目也需要工具链参数（把 `-DCMAKE_TOOLCHAIN_FILE=...` 透传到 `CMAKE_ARGS`）。



## 小结

- `ExternalProject`：依赖独立构建/安装，适合大型依赖、非 CMake 依赖、或 Superbuild。
- 消费方式通常是：依赖安装到前缀 → 主工程 `CMAKE_PREFIX_PATH` + `find_package` + `add_dependencies`。
