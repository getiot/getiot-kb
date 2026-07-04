---
sidebar_position: 2
slug: /cmake-toolchain
authors: [luhuadong]
---

# CMake 工具链文件

**工具链文件** 是一份在 CMake 配置早期被加载的 .cmake 脚本，用于设置目标平台、编译器、sysroot、find 行为等，常用于**交叉编译**和**指定编译器**。无需改项目里的 CMakeLists.txt，只需在配置时通过 **`-DCMAKE_TOOLCHAIN_FILE= path`** 指定即可。

## 使用方式

```bash
cmake -DCMAKE_TOOLCHAIN_FILE=/path/to/toolchain.cmake ..
```

CMake 会在处理 project() 之前加载该文件，因此其中设置的 **CMAKE_C_COMPILER**、**CMAKE_SYSTEM_NAME** 等会生效。

## 常见内容

- **`CMAKE_SYSTEM_NAME`**：目标系统（如 Linux、Windows、Darwin）。
- **`CMAKE_SYSTEM_PROCESSOR`**：目标处理器（如 aarch64、x86_64）。
- **`CMAKE_C_COMPILER`** / **`CMAKE_CXX_COMPILER`**：C/C++ 编译器完整路径或名称。
- **`CMAKE_FIND_ROOT_PATH`**：目标环境的根目录（如 sysroot），供 find_* 搜索。
- **`CMAKE_FIND_ROOT_PATH_MODE_PROGRAM`** / **`LIBRARY/INCLUDE/PACKAGE`**：控制在 root 下是否只查库/头文件等，避免用到宿主机程序。

交叉编译的完整示例见 [CMake 交叉编译](/cmake/cmake-cross-compile/) 中的 `arm_linux_setup.cmake`。

## 小结

- 工具链文件在配置早期加载，用于设定系统、编译器与查找规则。
- 通过 **`-DCMAKE_TOOLCHAIN_FILE=...`** 传入，便于同一项目切换本机/交叉编译而不改 CMakeLists.txt。
