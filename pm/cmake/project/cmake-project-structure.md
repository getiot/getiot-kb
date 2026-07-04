---
sidebar_position: 1
slug: /cmake-project-structure
authors: [luhuadong]
---

# CMake 多目录项目结构

当项目变大时，通常会把源码按功能或模块拆到多个目录，每个目录可有自己的 CMakeLists.txt，由顶层通过 **add_subdirectory()** 引入，形成多目录项目结构。

## 典型布局

```bash
project/
├── CMakeLists.txt          # 顶层：最低版本、project、add_subdirectory
├── src/
│   ├── CMakeLists.txt      # 可执行文件、应用层
│   └── main.cpp
├── lib/
│   ├── CMakeLists.txt      # 内部库
│   ├── foo.cpp
│   └── include/
└── tests/
    └── CMakeLists.txt      # 测试
```

顶层 CMakeLists.txt 示例：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.10)
project(MyApp VERSION 1.0)

add_subdirectory(lib)
add_subdirectory(src)
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()
```

- **add_subdirectory(子目录)** 会进入该子目录并执行其中的 CMakeLists.txt；子目录中定义的目标（库、可执行文件）对父目录可见，可用 target_link_libraries 等链接。
- 各子目录的 **CMAKE_CURRENT_SOURCE_DIR** 为该子目录路径，便于写相对路径。


## 与单目录的区别

- 单目录：所有 add_executable/add_library 写在一个 CMakeLists.txt。
- 多目录：按目录拆分，每目录一个 CMakeLists.txt，顶层用 add_subdirectory 组织，便于模块化和多人协作。

更细的用法（子目录输出目录、依赖顺序等）见 [CMake 子目录管理](/cmake/cmake-subdirectories/) 和 [CMake 编译多个子项目](/cmake/cmake-build-multiple-projects/)。
