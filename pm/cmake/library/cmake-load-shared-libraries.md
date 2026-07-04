---
sidebar_position: 4
slug: /cmake-load-shared-libraries
authors: [luhuadong]
---

# CMake 动态库加载与 RPATH

使用动态库（.so / .dll）时，运行时需要能找到库文件。如果未安装到系统路径（如 `/usr/lib`），会出现类似下面这样的错误提示：

```bash
error while loading shared libraries: libxxx.so: cannot open shared object file: No such file or directory
```

用 `ldd` 查看可执行文件依赖时，会看到该库显示 “not found”：

```bash
ldd ./myapp
# libxxx.so => not found
```

解决办法之一是在构建时为可执行文件（或依赖该库的目标）设置 **`RPATH`**，让它在指定目录下查找动态库。



## 在 CMake 中设置 RPATH

**针对某个目标设置安装后的 RPATH（INSTALL_RPATH）：**

```cmake showLineNumbers
add_executable(myapp main.cpp)
target_link_libraries(myapp PRIVATE mylib)

# 安装后，运行 myapp 时在 指定目录 下查找动态库
set_target_properties(myapp PROPERTIES
  INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib"
  # 或使用具体路径，例如依赖的第三方库安装位置：
  # INSTALL_RPATH "${onnxruntime_INSTALL_PREFIX}/lib"
)
```

**构建目录下的 RPATH（便于未安装时直接运行）：**

```cmake showLineNumbers
# 把生成的可执行文件所在目录或指定库目录加入 RPATH，便于在 build 目录直接运行
set_target_properties(myapp PROPERTIES
  BUILD_RPATH "${CMAKE_BINARY_DIR}/lib"
  BUILD_RPATH_USE_ORIGIN TRUE   # 使用 $ORIGIN 相对路径，便于拷贝 build 目录
)
```

**使用 $ORIGIN（相对路径）：**

在 Linux 上常用 `$ORIGIN` 表示“可执行文件所在目录”，便于安装到任意前缀：

```cmake showLineNumbers
set_target_properties(myapp PROPERTIES
  INSTALL_RPATH "\$ORIGIN:\$ORIGIN/../lib"
)
```

这样安装后，myapp 会在“自己的目录”以及“../lib”中查找 .so。



## 其他方式

- **安装时**：把 .so 安装到系统或 `CMAKE_INSTALL_PREFIX` 下的 lib 目录，并确保该目录在 `LD_LIBRARY_PATH` 或系统库路径中。
- **开发时**：在运行前执行 `export LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH`，或使用上面提到的 `BUILD_RPATH`。



## 小结

- 运行时找不到 .so 时，检查 `ldd` 输出，并考虑设置 **`INSTALL_RPATH`** / **`BUILD_RPATH`**。
- 使用 `set_target_properties(目标 PROPERTIES INSTALL_RPATH "路径")` 为安装后的可执行文件指定库搜索路径。
- 需要相对路径时可使用 `$ORIGIN`（在 CMake 中常写成 `\$ORIGIN` 避免被转义）。
