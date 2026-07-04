---
sidebar_position: 0
---

# 第八部分：测试

这一部分介绍如何在 CMake 项目中引入测试：用 CTest 组织测试目标，并集成常见的单元测试框架（如 GoogleTest）。

## 学习目标

- 能用 `enable_testing()` / `include(CTest)` 打开测试
- 能用 `add_test()` 或 `gtest_discover_tests()` 注册测试用例
- 能在 CI 中通过 `ctest` 一键运行并输出失败信息

## 推荐阅读顺序

1. `CMake 单元测试`
2. `CMake 配置 GTest 单元测试`

## 练习建议

- 为你的核心库添加 3~5 个单元测试，并在本地用 `ctest --output-on-failure` 运行

