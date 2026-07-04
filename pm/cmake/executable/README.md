---
sidebar_position: 0
---

# 第三部分：构建可执行文件

这一部分聚焦“把代码编成能跑的程序”，并把编译选项、构建类型、条件编译等工程常用能力串起来。

## 学习目标

- 能用 `add_executable()` 组织单个/多个可执行文件
- 能用 `target_compile_options()` / `target_compile_definitions()` 管理编译选项与宏
- 理解 Debug/Release 与单配置/多配置生成器的区别

## 推荐阅读顺序

1. `CMake 构建单个可执行文件`
2. `CMake 构建多个可执行文件`
3. `CMake 编译选项`
4. `CMake 编译模式（Debug 和 Release）`
5. `CMake 选项开关`
6. `CMake 条件编译`

## 练习建议

- 给程序加一个 `option(ENABLE_LOG ...)`，用条件编译控制日志输出
- 在 Debug 与 Release 下分别编译并对比二进制大小与符号信息

