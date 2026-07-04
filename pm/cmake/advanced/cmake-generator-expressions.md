---
sidebar_position: 1
slug: /cmake-generator-expressions
authors: [luhuadong]
---

# CMake 生成器表达式

**生成器表达式**（Generator Expressions） 在生成构建系统时求值，而不是在配置阶段，因此可以根据最终构建类型、目标属性等动态生成编译选项、路径等。常用于 `target_compile_options`、`target_link_libraries`、`target_include_directories` 等需要“按配置区分”的场景。



## 常见形式

- **`$<CONFIG:cfg>`**：当前构建类型为 cfg 时为 1，否则为 0；cfg 可为 Debug、Release、RelWithDebInfo、MinSizeRel。
- **`$<IF:cond,true_val,false_val>`**：条件为真取 true_val，否则取 false_val。
- **`$<TARGET_FILE:target>`**：目标生成的文件路径（可执行文件或库的完整路径）。
- **`$<BUILD_INTERFACE:...>`** / **`$<INSTALL_INTERFACE:...>`**：在 `target_include_directories` 等中区分构建时与安装时的路径。



## 示例：按构建类型添加编译选项

```cmake showLineNumbers
target_compile_options(myapp PRIVATE
  "$<$<CONFIG:Release>:-O3>"
  "$<$<CONFIG:Debug>:-O0 -g>"
)
```

这样只有在 Release 时加 `-O3`，Debug 时加 `-O0 -g`，无需在 CMake 里写 `if(CMAKE_BUILD_TYPE)`。



## 小结

- 生成器表达式在“生成”阶段求值，可依赖具体配置和目标。
- 常用于“按 Debug/Release 区分选项”“按目标取输出路径”等；详细语法见 [CMake 文档 Generator Expressions](https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html)。

