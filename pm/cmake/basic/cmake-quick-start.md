---
sidebar_position: 3
slug: /cmake-quick-start
authors: [luhuadong]
---

# CMake 快速上手

本文我们将创建一个简单的 CMake 工程示例 —— 使用 C++ 的 Hello World 程序。

在开始之前，先使用 [`mkdir`](/linux-command/mkdir/) 和 [`cd`](/linux-command/cd/) 命令创建并切换到该工作目录，例如：

```bash
mkdir projectzero
cd projectzero
```

接着，我们创建一个 C++ 源文件 main.cpp，它要做的就是打印一串“Hello World”。

你可以使用习惯的编辑器打开并输入如下内容：

```cpp showLineNumbers
#include <iostream>

int main() {
    std::cout << "Hello World!" << std::endl;
    return 0;
}
```

接着，我们要创建一个 **CMakeLists.txt** 文件（要注意大小写），这个文件是 CMake 必需的。

```bash
vi CMakeLists.txt
```

CMake 工程的根目录（本案例是 `~/projectzero` 目录）必须包含一个 CMakeLists.txt 文件，其中的每一行都有一个命令，用于描述构建信息。

我们这个项目的 CMakeLists.txt 文件非常简单，只包含以下三行：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.0)

project(hello VERSION 0.0.1)

add_executable(hello main.cpp)
```

- 第一行表示 CMake 的最低版本要求；
- 第二行描述该工程的基本信息（比如这里描述名称和版本）；
- 第三行表示使用源文件 main.cpp 编译可执行目标 hello。

一个好习惯是将编译目录与工程文件分开，通常会建一个 `build` 目录，将构建过程产生的所有文件存放于此。

```bash
mkdir build
```

此时，整个工程目录结构大致如下：

```
├── build
├── CMakeLists.txt
└── main.cpp
```

切换到 `build` 目录，然后执行 `cmake ..` 生成构建系统文件（如 Makefile）：

```bash
$ cd build
$ cmake ..
-- The C compiler identification is GNU 9.3.0
-- The CXX compiler identification is GNU 9.3.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
...
-- Configuring done
-- Generating done
-- Build files have been written to: /home/getiot/projectzero/build
```

这里的 `..` 表示当前目录的上一级目录（也就是 `~/projectzero` 目录），用于告诉 CMake 到哪里去找 CMakeLists.txt 文件。输出信息中的 CXX 表示 C++。

执行完成后，会在 `projectzero/build` 目录生成一些配置文件：

```bash
$ ls
CMakeCache.txt  CMakeFiles  cmake_install.cmake  Makefile
```

现在可以开始编译了，输入下面命令就会构建出可执行文件 hello：

```bash
cmake --build .
```

你也可以直接执行 make 命令：

```bash
$ make
Scanning dependencies of target hello
[ 50%] Building CXX object CMakeFiles/hello.dir/main.cpp.o
[100%] Linking CXX executable hello
[100%] Built target hello
```

编译完成后，运行程序：

```bash
$ ./hello
Hello World!
```

恭喜你完成了第一个 CMake 工程。虽然只是一个简单的示例，但这是学习 CMake 的一个很好的起点。想学习更多示例，可以参阅 [GitHub 上的 cmake-examples](https://github.com/ttroy50/cmake-examples)。

## 小结

本节我们完成了在 Linux 上使用 CMake 构建一个简单的 Hello World 程序。CMake 是 C/C++ 开发中非常实用的构建工具，更多信息可参考 [CMake 官方文档](https://cmake.org/documentation/)。
