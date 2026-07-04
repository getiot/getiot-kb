---
sidebar_position: 1
sidebar_label: CMake 基础语法
slug: /cmake-basic-syntax
authors: [luhuadong]
---

# CMake 基础语法（CMakeLists.txt 基础结构）

CMake 的编写过程实际上是“编程”的过程，与使用 autotools 类似，只不过你编写的是 **CMakeLists.txt**（每个目录一个），使用的是“CMake 语言和语法”。它上手简单，但要写好并不容易。

一个最基础的 CMakeLists.txt 示例：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.0)

project(HELLO VERSION 0.0.1)

add_executable(hello main.cpp)
```

- `cmake_minimum_required`：指定 CMake 最低版本；
- `project`：定义工程名称和版本，并会隐式定义 `PROJECT_BINARY_DIR`、`PROJECT_SOURCE_DIR` 等变量；
- `add_executable`：用列出的源文件生成可执行文件。

可执行文件的名字由 `add_executable` 的第一个参数决定，与 `project` 中的工程名无关。例如可以写成：

```cmake showLineNumbers
add_executable(t1 main.cpp)
```

编译后会生成可执行文件 `t1`。

## CMake 语法规则

- **变量引用**：使用 `${变量名}` 取值；在 `if()` 等控制语句中则直接使用变量名，不加 `${}`。
- **命令格式**：`命令(参数1 参数2 ...)`，参数用括号括起，参数之间用空格或分号分隔。

  例如若有多个源文件：

  ```cmake showLineNumbers
  add_executable(hello main.cpp func.cpp)
  ```

  或：

  ```cmake showLineNumbers
  add_executable(hello main.cpp;func.cpp)
  ```

- **大小写**：命令（指令）大小写不敏感，变量和参数大小写敏感。现代 CMake 推荐使用**小写**命令（如 `add_executable`），以便与内置和第三方用法一致。
- **字符串与变量**：在双引号内也可以使用 `${变量名}`，例如：

  ```cmake showLineNumbers
  message(STATUS "This is BINARY dir: ${HELLO_BINARY_DIR}")
  ```

## 小结

CMakeLists.txt 是 CMake 的入口；每个目录可有自己的 CMakeLists.txt，通过 `add_subdirectory` 纳入父工程。后续章节会介绍变量、命令、消息打印以及如何组织多目录项目。
