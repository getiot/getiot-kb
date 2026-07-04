---
sidebar_position: 4
sidebar_label: CMake 编译模式
slug: /cmake-build-debug-release
authors: [luhuadong]
---

# CMake 编译模式（Debug 和 Release）

C/C++ 项目通常需要区分 **调试版本**（Debug）和 **发布版本**（Release），CMake 通过 `CMAKE_BUILD_TYPE` 控制。



## Debug 与 Release 的区别

- **Debug（调试版本）**
  - 包含调试信息，体积较大，一般不进行激进优化，便于单步调试。
  - Linux 下生成 elf 可执行文件（及调试符号）；Windows 下除 exe/dll 外还可生成 .pdb 等调试信息文件。
- **Release（发布版本）**
  - 侧重优化，代码体积和运行速度更优，一般不包含调试符号（调试信息可单独生成到 PDB 等）。



## 在 CMake 中设置编译模式

单配置生成器（如 Unix Makefiles、Ninja）下，通过 **CMAKE_BUILD_TYPE** 指定：

**在命令行指定（推荐）**

```bash showLineNumbers
# Debug
mkdir build-debug && cd build-debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .

# Release
mkdir build-release && cd build-release
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build ..
```

**在 CMakeLists.txt 中指定默认值**

```cmake showLineNumbers
# 若用户未指定，则默认为 Debug；用户通过 -D 可覆盖
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
endif()
# 或写死一种（不推荐，不利于在命令行切换）
# set(CMAKE_BUILD_TYPE "Release")
```

:::tip

不要在没有 `if(NOT CMAKE_BUILD_TYPE)` 的情况下直接 `set(CMAKE_BUILD_TYPE "Release")`，否则会覆盖用户在命令行传入的 `-DCMAKE_BUILD_TYPE=Debug`。默认值建议用 `if(NOT ...)` 仅在未设置时赋值。

:::



## 其他构建类型

除了 `Debug`、`Release` 之外，CMake 还常用于：

- **RelWithDebInfo**：带调试信息的 Release 风格优化
- **MinSizeRel**：最小体积优化

对应变量有 `CMAKE_CXX_FLAGS_RELWITHDEBINFO`、`CMAKE_CXX_FLAGS_MINSIZEREL` 等。



## 检查是否带调试信息

Linux 下可用 `readelf` 查看可执行文件是否包含调试段：

```bash
readelf -S build-debug/myapp | grep debug
```

若有 `.debug_info`、`.debug_line` 等段，说明包含调试信息（如下示例），而 Release 构建通常没有这些段。

```bash
$ readelf -S build-debug/myapp | grep debug
  [28] .debug_aranges    PROGBITS         0000000000000000  0000609b
  [29] .debug_info       PROGBITS         0000000000000000  0000615b
  [30] .debug_abbrev     PROGBITS         0000000000000000  00007c79
  [31] .debug_line       PROGBITS         0000000000000000  0000823b
  [32] .debug_str        PROGBITS         0000000000000000  00008cdc
```



## 小结

- 单配置生成器下用 `-DCMAKE_BUILD_TYPE=Debug` 或 `Release` 控制编译模式。
- 在 CMakeLists.txt 中设置默认值时，用 `if(NOT CMAKE_BUILD_TYPE)` 避免覆盖命令行。
- 多配置生成器（如 Visual Studio）在 IDE 里选择 Debug/Release 配置，不依赖 `CMAKE_BUILD_TYPE`。
