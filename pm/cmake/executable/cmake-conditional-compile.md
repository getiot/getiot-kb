---
sidebar_position: 6
slug: /cmake-conditional-compile
authors: [luhuadong]
---

# CMake 条件编译

在 CMake 中可以根据平台、编译器、选项变量等条件，决定是否添加某些目标、源文件或编译定义，这就是“条件编译”的配置侧体现。



## 使用 if 做条件判断

常用写法：

```cmake showLineNumbers
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  add_compile_definitions(LINUX_BUILD)
endif()

if(WIN32)
  target_sources(myapp PRIVATE win_specific.cpp)
endif()

if(USE_FEATURE_X)
  target_compile_definitions(myapp PRIVATE USE_FEATURE_X)
endif()
```

与 **option()** 配合（见 [CMake 选项开关](/cmake/cmake-option/)）：

```cmake showLineNumbers
option(ENABLE_GPU "Enable GPU support" OFF)
if(ENABLE_GPU)
  find_package(CUDA REQUIRED)
  target_link_libraries(myapp PRIVATE CUDA::cudart)
endif()
```



## 常见条件变量

| 变量/表达式 | 含义 |
|-------------|------|
| `WIN32` | Windows 平台（含 Cygwin） |
| `UNIX` | 类 UNIX（Linux、macOS、Cygwin 等） |
| `APPLE` | macOS / iOS |
| `CMAKE_SYSTEM_NAME` | 系统名，如 `Linux`、`Windows`、`Darwin` |
| `MSVC` | 使用 MSVC 编译器时为 TRUE |
| `CMAKE_CXX_COMPILER_ID STREQUAL "GNU"` | 使用 GCC 时 |



## 条件添加目标或源文件

**按选项添加可执行文件：**

```cmake showLineNumbers
option(BUILD_TOOL_X "Build optional tool X" OFF)
if(BUILD_TOOL_X)
  add_executable(tool_x tool_x.cpp)
  target_link_libraries(tool_x PRIVATE mylib)
endif()
```

**按平台添加源文件：**

```cmake showLineNumbers
set(MYAPP_SRCS main.cpp common.cpp)
if(WIN32)
  list(APPEND MYAPP_SRCS win_impl.cpp)
elseif(APPLE)
  list(APPEND MYAPP_SRCS mac_impl.cpp)
else()
  list(APPEND MYAPP_SRCS linux_impl.cpp)
endif()
add_executable(myapp ${MYAPP_SRCS})
```



## 在 C/C++ 中的对应

CMake 通过 `target_compile_definitions()` 或 `add_compile_definitions()` 传入的宏，在源码里用 `#ifdef` / `#if` 做条件编译：

```cpp
#ifdef USE_FEATURE_X
  // 仅在开启 USE_FEATURE_X 时编译
#endif#if defined(LINUX_BUILD)
  // Linux 专用代码
#endif
```



## 小结

- 在 CMake 中用 `if()` 根据 `WIN32`、`UNIX`、`option()` 变量、`CMAKE_SYSTEM_NAME` 等做分支。
- 用 `target_compile_definitions` 把条件“传”给 C/C++，再在代码里用 `#ifdef` / `#if` 配合。
- 条件编译既包括“是否编译某目标/某源文件”，也包括“是否添加某编译定义”。
