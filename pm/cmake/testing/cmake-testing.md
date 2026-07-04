---
sidebar_position: 1
slug: /cmake-testing
authors: [luhuadong]
---

# CMake 单元测试

CMake 通过 **CTest** 与 **add_test()** 集成测试：在 CMakeLists.txt 里定义测试用例，构建后用 **ctest** 或 **cmake --build . --target test** 运行。

## 启用测试

在顶层 CMakeLists.txt 中启用测试模块（通常 project() 之后）：

```cmake showLineNumbers
enable_testing()
```

## 添加测试

**add_test()** 用于添加一个测试，名称和运行命令由你指定：

```cmake showLineNumbers
add_executable(mytest test_main.cpp)
target_link_libraries(mytest PRIVATE mylib)add_test(NAME MyTest COMMAND mytest)
```

- **NAME**：测试名称，在 ctest 输出和脚本中用于区分。
- **COMMAND**：要执行的命令（通常是本工程生成的可执行文件，或脚本）。可指定工作目录、环境、超时等：

```cmake showLineNumbers
add_test(NAME MyTest COMMAND mytest)
set_tests_properties(MyTest PROPERTIES
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  TIMEOUT 10
)
```

## 运行测试

在构建目录下：

```bash
ctest
# 或
cmake --build . --target test
```

输出详细结果可加 `-V` 或 `--output-on-failure`。

## 与 GTest 等框架结合

若使用 Google Test 等框架，可在 add_executable 里链接 gtest，再 add_test(NAME ... COMMAND 该可执行文件)。详见 [CMake 配置 GTest 单元测试](/cmake/cmake-gtest/)。

## 小结

- **enable_testing()** 启用测试；**`add_test(NAME 名 COMMAND 命令)`** 添加测试。
- 测试命令一般为本工程构建出的可执行文件；用 **set_tests_properties** 可设置工作目录、超时等。
- 运行 **`ctest`** 或 **`cmake --build . --target test`** 执行所有已添加的测试。
