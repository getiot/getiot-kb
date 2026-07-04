---
sidebar_position: 2
slug: /cmake-gtest
authors: [luhuadong]
---

# CMake 配置 GTest 单元测试

使用 **Google Test（GTest）** 时，需要先获取 GTest 并链接到你的测试可执行文件，再通过 **add_test()** 把该可执行文件注册为 CTest 测试。

## 方式一：find_package（系统已安装 GTest）

若系统或工具链已安装 GTest 并提供 CMake 配置：

```cmake showLineNumbers
find_package(GTest REQUIRED)

add_executable(mytest test_main.cpp)
target_link_libraries(mytest PRIVATE GTest::gtest GTest::gtest_main)
# 使用 gtest_main 时无需手写 main()，否则链接 GTest::gtest 并自写 main 调用 RUN_ALL_TESTS()

enable_testing()
add_test(NAME MyTest COMMAND mytest)
```

## 方式二：FetchContent（从源码拉取）

无系统包时可用 FetchContent 在配置时拉取 Google Test 源码并构建：

```cmake showLineNumbers
include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        v1.14.0
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

add_executable(mytest test_main.cpp)
target_link_libraries(mytest PRIVATE GTest::gtest GTest::gtest_main)

enable_testing()
add_test(NAME MyTest COMMAND mytest)
```

这样 GTest 会作为当前项目的一部分被构建，无需预先安装。

## 编写测试代码

test_main.cpp 示例（使用 gtest_main，无需自己写 main）：

```cpp showLineNumbers
#include <gtest/gtest.h>

TEST(Sample, Basic) {
  EXPECT_EQ(1 + 1, 2);
}
```

若链接的是 GTest::gtest（未链接 gtest_main），需自己写 main：

```cpp showLineNumbers
#include <gtest/gtest.h>
int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
```

## 运行

在构建目录执行：

```bash
ctest
# 或直接运行可执行文件
./mytest
```

## 小结

- 系统有 GTest 时用 **`find_package(GTest)`** 并 **`target_link_libraries(测试目标 PRIVATE GTest::gtest GTest::gtest_main)`**。
- 无系统包时用 **FetchContent** 拉取 googletest 再 **FetchContent_MakeAvailable**，同样链接 `GTest::gtest` / `GTest::gtest_main`。
- 用 **`add_test(NAME ... COMMAND 测试可执行文件)`** 将用例纳入 CTest，便于 **ctest** 统一运行。
