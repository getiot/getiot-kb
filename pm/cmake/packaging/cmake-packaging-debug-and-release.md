---
sidebar_position: 3
slug: /cmake-packaging-debug-and-release
authors: [luhuadong]
---

# CMake 打包 Debug 和 Release 版本

:::note

本节适用于**单配置生成器**（如 Unix Makefiles、Ninja）。多配置生成器（如 Visual Studio）的用法不同，通常直接在 IDE 中选择配置并打包。

:::

默认情况下，一个构建目录只对应一种配置（Debug、Release、RelWithDebInfo、MinSizeRel）。如果希望同一个安装包里同时包含 Debug 和 Release，可以分别构建两个目录，再用 CPack 的自定义配置把两次安装结果打成一个包。



## 1. 区分 Debug 与 Release 的输出名称

避免两个配置的同名目标互相覆盖，可给 Debug 目标加后缀（例如 `d`）：

在顶层 CMakeLists.txt 中：

```cmake showLineNumbers
set(CMAKE_DEBUG_POSTFIX "d")

add_executable(Getiot getiot.cxx)
set_target_properties(Getiot PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})
```

这样会得到两个可执行文件，分别是 Debug 构建得到的 `Getiotd`，以及 Release 构建得到的 `Getiot`。

同理，库也可以设置 **`DEBUG_POSTFIX`**。



## 2. 分别构建 debug 与 release

在项目根目录下创建两个构建目录并分别配置、构建：

```bash
# Debug
mkdir debug && cd debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build .
cd ..# Release
mkdir release && cd release
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
cd ..
```



## 3. 用自定义 CPack 配置打包两者

在项目根目录（与 debug、release 同级）创建 `MultiCPackConfig.cmake`，把两个构建目录的安装都纳入打包：

```cmake showLineNumbers
include("release/CPackConfig.cmake")

set(CPACK_INSTALL_CMAKE_PROJECTS
    "debug;Getiot;ALL;/"
    "release;Getiot;ALL;/"
)
```

表示：先安装 debug 下的 Getiot 到 `/`，再安装 release 下的 Getiot 到 `/`（结合 DEBUG_POSTFIX，可执行文件名不同，不会冲突）。

在项目根目录执行：

```bash
cpack --config MultiCPackConfig.cmake
```

即可生成同时包含 Debug 和 Release 的安装包（具体格式由 CPack 生成器决定）。



## 小结

- 单配置生成器下，用不同构建目录分别做 Debug 和 Release 构建。
- 用 **CMAKE_DEBUG_POSTFIX** / **DEBUG_POSTFIX** 区分同名目标，避免覆盖。
- 通过自定义 CPack 配置（**CPACK_INSTALL_CMAKE_PROJECTS**）将多个构建目录的安装结果打成一个包。
