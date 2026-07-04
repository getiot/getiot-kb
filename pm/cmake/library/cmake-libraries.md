---
sidebar_position: 1
slug: /cmake-libraries
authors: [luhuadong]
---

# CMake 构建库（静态库和动态库）

CMake 用 **add_library()** 生成库，常见类型为**静态库**（.a / .lib）和**动态库**（.so / .dll）。同一套源文件可以按需生成其中一种或两种。



## 构建静态库（STATIC）

静态库在链接时被完整打包进可执行文件，运行时不再依赖该库文件。

```cmake showLineNumbers
add_library(mylib STATIC src/foo.cpp src/bar.cpp)
```

- Linux 下一般生成 `libmylib.a`，Windows 下为 `mylib.lib`（MSVC）或 `libmylib.a`（MinGW）。
- 不写 `STATIC` 时，若未设置 `BUILD_SHARED_LIBS`，默认也是静态库。



## 构建动态库（SHARED）

动态库在运行时由系统加载，可被多个程序共享，便于升级而不重新链接可执行文件。

```cmake showLineNumbers
add_library(mylib SHARED src/foo.cpp src/bar.cpp)
```

- Linux 下生成 `libmylib.so`，Windows 下为 `mylib.dll`（及导入库）。
- 设置 `set(BUILD_SHARED_LIBS ON)` 后，不写类型时默认生成动态库。



## 设置库的版本

动态库可设置版本号和 soversion，便于系统区分兼容性，这种用法常见于动态库。

```cmake showLineNumbers
add_library(mylib SHARED src/foo.cpp)
set_target_properties(mylib PROPERTIES
  VERSION 1.2.3
  SOVERSION 1
)
```

会生成例如 `libmylib.so.1.2.3`、符号链接 `libmylib.so.1`、`libmylib.so` 等（具体依平台和策略而定）。



## 设置链接库

可执行文件或其它库需要用到该库时，用 **`target_link_libraries`** 链接：

```cmake showLineNumbers
add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE mylib)
```

`PRIVATE` 表示仅 myapp 使用 mylib，不向依赖 myapp 的目标传递。若 mylib 是头文件库或需要把 mylib 的头文件/链接信息传给“使用 myapp”的人，可用 `PUBLIC` 或 `INTERFACE`，见 [库的可见性：PUBLIC/PRIVATE/INTERFACE](/cmake/cmake-visibility/)。



## 同时构建静态库和动态库

如果你希望同一套源码编译同时得到静态库和动态库，那么可以定义两个目标，例如：

```cmake showLineNumbers
add_library(mylib_shared SHARED src/foo.cpp src/bar.cpp)
add_library(mylib_static STATIC src/foo.cpp src/bar.cpp)
```

注意：两个目标会各编译一次源文件。若想只编译一次、通过接口库等方式复用，可查阅“Object 库”或按项目需要选择其一为主。



## 小结

- **静态库**：`add_library(名 STATIC 源文件...)`，链接时打入可执行文件。
- **动态库**：`add_library(名 SHARED 源文件...)`，可设置 `VERSION`/`SOVERSION`。
- 使用库：`target_link_libraries(目标 PRIVATE 库名)`。
- 现代写法推荐以 target 为中心，并配合 [Target-based 编程](/cmake/cmake-target-based/) 和 [可见性](/cmake/cmake-visibility/) 管理依赖。
