---
sidebar_position: 2
slug: /cmake-build-multiple-executables
authors: [luhuadong]
---

# CMake 构建多个可执行文件

在同一份 CMakeLists.txt 中，可以多次调用 `add_executable()`，从而在同一构建树中生成多个可执行文件。适合工具集、示例程序、多入口应用等场景。



## 同一目录下多个可执行文件

在同一个 CMakeLists.txt 里为每个程序写一个 `add_executable` 即可：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.0)
project(tools VERSION 0.0.1)

add_executable(tool_a tool_a.cpp)
add_executable(tool_b tool_b.cpp)
add_executable(tool_c tool_c.cpp)
```

构建时（在 build 目录下执行 `cmake --build .`）会同时生成 `tool_a`、`tool_b`、`tool_c`。若只想构建其中一个，可使用：

```bash
cmake --build . --target tool_a
```



## 共享公共代码

如果有多个可执行文件共用部分源文件，通常有两种做法：

1. 把公共代码做成一个静态库（`add_library(common STATIC ...)`），再用 `target_link_libraries(tool_a PRIVATE common)` 链接；
2. 直接把公共源文件列在每个 `add_executable` 中（简单但会重复编译）。

推荐用静态库方式，便于维护和复用。库的写法见《第四部分：库的管理》。



## 与“多子项目”的区别

- **本节的“多个可执行文件”**：一个 CMakeLists.txt、一个构建目录，多个 `add_executable`。
- **多目录/多子项目**：通过 `add_subdirectory()` 把子目录纳入，每个子目录可有自己的 CMakeLists.txt 和可执行文件或库，见 [CMake 编译多个子项目](/cmake/cmake-build-multiple-projects)。



## 小结

- 同一 CMakeLists.txt 中多个 `add_executable()` 即可生成多个可执行文件。
- 公共代码建议抽成库并用 `target_link_libraries` 链接。
- 多目录、多子项目结构请使用 `add_subdirectory`，参见第五部分“项目组织”。
