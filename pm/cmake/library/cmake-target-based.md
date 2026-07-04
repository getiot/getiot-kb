---
sidebar_position: 2
slug: /cmake-target-based
authors: [luhuadong]
---

# 现代 CMake：Target-based 编程

“Target-based”是指以**目标**（target）为中心组织构建：每个可执行文件、每个库都是一个目标，依赖和属性都挂在目标上，而不是用全局变量“撒胡椒面”。这是现代 CMake 的推荐写法。



## 核心思想

- **目标**：由 `add_executable()`、`add_library()` 创建，有名字、类型（可执行文件、静态库、动态库等）。
- **属性按目标设置**：编译选项、包含目录、链接库、编译定义等，都通过 `target_*` 命令绑定到具体目标，而不是全局 `include_directories()`、`link_libraries()`。
- **依赖关系显式化**：用 `target_link_libraries(A PRIVATE B)` 表示“A 依赖 B”，CMake 会自动把 B 的包含目录、链接库、编译定义等按可见性传给 A。



## 旧写法 vs 新写法

**不推荐（全局式）：**

```cmake showLineNumbers
include_directories(${PROJECT_SOURCE_DIR}/include)   # 所有目标都看到
add_library(mylib src/foo.cpp)
add_executable(myapp main.cpp)
target_link_libraries(myapp mylib)   # 未指定 PRIVATE/PUBLIC/INTERFACE
```

**推荐（target-based）：**

```cmake showLineNumbers
add_library(mylib src/foo.cpp)
target_include_directories(mylib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE mylib)
```

这样，只有“链接了 mylib”的目标才会获得 mylib 的 include 路径，且通过 `PUBLIC` 自动传递，无需再写全局 `include_directories`。



## 常用 target_* 命令

| 命令 | 作用 |
|------|------|
| `target_include_directories(目标 PUBLIC/PRIVATE 目录...)` | 为该目标指定头文件搜索路径 |
| `target_compile_definitions(目标 PUBLIC/PRIVATE 宏...)` | 为该目标添加编译定义 |
| `target_compile_options(目标 PUBLIC/PRIVATE 选项...)` | 为该目标添加编译选项 |
| `target_link_libraries(目标 PUBLIC/PRIVATE 库...)` | 为该目标指定链接的库 |
| `target_sources(目标 PRIVATE 源文件...)` | 为已有目标追加源文件 |

`PUBLIC` / `PRIVATE` / `INTERFACE` 的含义见 [库的可见性：PUBLIC/PRIVATE/INTERFACE](/cmake/cmake-visibility/)。



## 小结

- 现代 CMake 以**目标**为单位设置包含目录、编译选项、链接库等，避免全局污染。
- 使用 `target_*` 系列命令，并明确写出 `PRIVATE`/`PUBLIC`/`INTERFACE`，便于维护和正确传递依赖。
