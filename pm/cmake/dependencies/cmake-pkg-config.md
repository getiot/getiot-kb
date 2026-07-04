---
sidebar_position: 3
sidebar_label: pkg-config 集成
slug: /cmake-pkg-config
---

# CMake pkg-config 集成

`pkg-config` 是 Linux/Unix 生态里非常常见的“库元数据查询工具”，通过 `.pc` 文件提供 **编译参数（cflags）** 和 **链接参数（libs）**。当某些库没有提供 `<Package>Config.cmake`、或者你希望优先走系统包时，`pkg-config` 非常实用。



## 前置条件

- 系统安装 `pkg-config`
- 依赖库安装了对应的 `.pc` 文件（通常随 `-dev` 包一起安装）

快速验证：

```bash
pkg-config --version
pkg-config --list-all | head
pkg-config --cflags --libs zlib
```



## 在 CMake 中使用：PkgConfig 模块

CMake 内置了 `FindPkgConfig.cmake`：

```cmake
find_package(PkgConfig REQUIRED)
```

然后用 `pkg_check_modules()` 查询某个包（例如 `libcurl`）：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.15)
project(demo LANGUAGES CXX)

find_package(PkgConfig REQUIRED)
pkg_check_modules(CURL REQUIRED libcurl)

add_executable(app main.cpp)
target_include_directories(app PRIVATE ${CURL_INCLUDE_DIRS})
target_link_directories(app PRIVATE ${CURL_LIBRARY_DIRS})
target_link_libraries(app PRIVATE ${CURL_LIBRARIES})
target_compile_options(app PRIVATE ${CURL_CFLAGS_OTHER})
```

这套写法能工作，但它是“变量驱动”，不够现代。我们更推荐你使用下一节的 **`IMPORTED target` 包装**。



## 推荐做法：把 pkg-config 结果封装成 target

把 `pkg-config` 的结果封装为一个你自己定义的 imported target（或 interface target），让后续链接更像现代 CMake：

```cmake showLineNumbers
find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_CURL REQUIRED libcurl)

add_library(CURL::curl INTERFACE IMPORTED)
target_include_directories(CURL::curl INTERFACE ${PC_CURL_INCLUDE_DIRS})
target_link_directories(CURL::curl INTERFACE ${PC_CURL_LIBRARY_DIRS})
target_link_libraries(CURL::curl INTERFACE ${PC_CURL_LIBRARIES})
target_compile_options(CURL::curl INTERFACE ${PC_CURL_CFLAGS_OTHER})

add_executable(app main.cpp)
target_link_libraries(app PRIVATE CURL::curl)
```

这样你的工程内部统一用 `target_link_libraries(app PRIVATE CURL::curl)`，更易维护，也便于替换为 `find_package(CURL CONFIG)`。



## 常见问题

- **找不到 .pc**：通常是没装 `xxx-dev`/`xxx-devel` 包；或 `.pc` 不在默认路径。
- **交叉编译时混用宿主机 .pc**：交叉编译应确保 `PKG_CONFIG_LIBDIR`/`PKG_CONFIG_SYSROOT_DIR` 指向目标 sysroot。
- **链接顺序/缺少传递依赖**：有些库的 `.pc` 写得不完整，需要额外补 `target_link_libraries()`。



## 排错建议

- 看 pkg-config 搜索路径：

```bash
pkg-config --variable pc_path pkg-config
```

- 临时指定 `.pc` 目录：

```bash
export PKG_CONFIG_PATH=/opt/mylibs/lib/pkgconfig:/opt/mylibs/share/pkgconfig
```

然后重新运行 CMake 配置。



## 小结

- `pkg-config` 适合“没有 Config 包、但有系统 .pc 文件”的依赖。
- 在 CMake 里建议把查询结果 **封装成 target**，避免变量散落各处。
