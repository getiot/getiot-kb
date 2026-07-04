---
sidebar_position: 5
slug: /cmake-option
authors: [luhuadong]
---

# CMake 选项开关

CMake 的 **option()** 可以在配置阶段提供一个布尔开关，用户通过 `-D选项名=ON/OFF` 控制，并可在 CMake GUI 中修改。适合“可选功能、调试开关、是否启用测试”等场景。



## option 基本用法

```cmake showLineNumbers
option(USE_EXTREME_DEBUGGING "Use extreme debugging features" OFF)
```

- 第一个参数：选项名（建议全大写、下划线，便于在 C/C++ 中作为宏名使用）。
- 第二个参数：说明文字（在 cmake-gui 中显示）。
- 第三个参数：默认值，`ON` 或 `OFF`。

在命令行中可覆盖默认值：

```bash
cmake -DUSE_EXTREME_DEBUGGING=ON ..
```

## 在 CMake 中使用选项

用 `if()` 根据选项决定是否添加目标、子目录或编译定义：

```cmake showLineNumbers
option(BUILD_TESTS "Build unit tests" ON)

if(BUILD_TESTS)
  add_subdirectory(tests)
endif()
```



## 在 C/C++ 代码中使用选项（编译定义）

若要在源码里根据该选项做条件编译，需要把选项“变成”预定义宏。做法是：根据 option 变量添加编译定义，**宏名不要用带连字符的 option 名**（C/C++ 宏不能含 `-`），应单独定义一个合法的宏名：

```cmake showLineNumbers
option(USE_EXTREME_DEBUGGING "Use extreme debugging features" OFF)

if(USE_EXTREME_DEBUGGING)
  add_compile_definitions(USE_EXTREME_DEBUGGING)
  # 或对单个目标：target_compile_definitions(myapp PRIVATE USE_EXTREME_DEBUGGING)
endif()
```

在 C/C++ 中：

```cpp showLineNumbers
#ifdef USE_EXTREME_DEBUGGING
    print_extra_debugging();
#endif
```

这样，用户在配置时通过 `-DUSE_EXTREME_DEBUGGING=ON` 打开选项，编译时就会定义 `USE_EXTREME_DEBUGGING` 宏。

:::tip

`option()` 的名字若包含连字符（如 `OURAPP-DEV-USE_EXTREME_DEBUGGING`），不能直接作为 C/C++ 宏使用（预处理器会把它当成减法）。推荐 option 名与宏名一致，且仅使用字母、数字和下划线，例如 `USE_EXTREME_DEBUGGING`。

:::



## 与 cache 变量的区别

- **`option(名称 说明 默认值)`**：专门用于布尔开关，在 GUI 中显示为复选框。
- **`set(名称 值 CACHE 类型 说明)`**：可存字符串、路径等，类型为 `BOOL` 时效果与 option 类似，但 option 更语义化。



## 小结

- 用 `option(名称 "说明" 默认值)` 定义配置阶段布尔开关。
- 在 CMake 中用 `if(选项名)` 做条件逻辑。
- 要在 C/C++ 中使用，用 `add_compile_definitions` 或 `target_compile_definitions` 定义与选项对应的宏名（避免在宏名中使用连字符）。
