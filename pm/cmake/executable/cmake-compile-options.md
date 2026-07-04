---
sidebar_position: 3
slug: /cmake-compile-options
authors: [luhuadong]
---

# CMake 编译选项

如需向编译器传递参数（如优化级别、警告级别、C++ 标准等），可以通过 CMake 变量或目标属性来设置。



## 全局设置

在 `project()` 之前或之后设置全局编译选项（`CMAKE_CXX_FLAGS` / `CMAKE_C_FLAGS`）：

```cmake showLineNumbers
# C++ 编译选项（对所有 C++ 目标生效）
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
# C 编译选项
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
```

按构建类型区分的变量（在设置 `CMAKE_BUILD_TYPE` 后生效）：

- `CMAKE_CXX_FLAGS_DEBUG`：Debug 模式下的 C++ 选项
- `CMAKE_CXX_FLAGS_RELEASE`：Release 模式下的 C++ 选项
- 还有 `RELWITHDEBINFO`、`MINSIZEREL` 等

例如只希望在 Release 下开启某种优化：

```cmake showLineNumbers
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
```

:::tip

全局方式会影响该 CMakeLists.txt 及其子目录中的所有同语言目标。更推荐用下面的“按目标设置”。

:::



## 按目标设置

有时候，你可能希望编译选项只对某个目标生效，便于维护且不影响其他目标。那么可以使用 `target_compile_options` 命令：

```cmake showLineNumbers
add_executable(myapp main.cpp)
target_compile_options(myapp PRIVATE -Wall -Wextra -std=c++17)
```

若希望指定 C++ 标准，更推荐用 `target_compile_features` 或设置 `CMAKE_CXX_STANDARD`：

```cmake showLineNumbers
set(CMAKE_CXX_STANDARD 17)
# 或仅对某目标
set_target_properties(myapp PROPERTIES CXX_STANDARD 17)
```



## 常用选项示例

| 目的 | GCC/Clang 选项 | MSVC 大致对应 |
|:----:|:--------------:|:--------------:|
| 警告 | `-Wall -Wextra` | `/W4` |
| C++ 标准 | `-std=c++17` | 用 `CXX_STANDARD` 更稳妥 |
| 优化 | `-O2` / `-O3` | `/O2` |
| 调试信息 | `-g` | 由 `CMAKE_BUILD_TYPE=Debug` 等控制 |

生成器表达式可做到“仅对某构建类型添加选项”，详见 [CMake 生成器表达式](/cmake/cmake-generator-expressions/)。



## 输出目录

若希望可执行文件输出到统一目录：

```cmake showLineNumbers
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
```

只对某个目标设置：

```cmake showLineNumbers
set_target_properties(myapp PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
```



## 小结

- 全局：`CMAKE_CXX_FLAGS`、`CMAKE_CXX_FLAGS_DEBUG` / `_RELEASE` 等。
- 推荐：`target_compile_options(目标 PRIVATE ...)` 和 `CXX_STANDARD`。
- 输出目录可用 `RUNTIME_OUTPUT_DIRECTORY` 或 `CMAKE_RUNTIME_OUTPUT_DIRECTORY`。
