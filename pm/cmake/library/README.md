---
sidebar_position: 0
---

# 第四部分：库的管理

这一部分是 CMake 工程化的核心：如何构建静态库/共享库、如何用 **target-based** 写法表达依赖、以及 `PUBLIC/PRIVATE/INTERFACE` 如何影响“依赖传播”。

## 学习目标

- 能用 `add_library()` 构建静态库与共享库，并链接到可执行文件
- 掌握现代 CMake：围绕 target 组织 include、编译选项与依赖
- 理解可见性（PUBLIC/PRIVATE/INTERFACE）并能在真实项目中正确使用

## 推荐阅读顺序

1. `CMake 构建库（静态库和动态库）`
2. `现代 CMake：Target-based 编程`
3. `库的可见性：PUBLIC/PRIVATE/INTERFACE`
4. `CMake 动态库加载与 RPATH`（平台相关，建议在理解库链接后阅读）

## 练习建议

- 把一个工具项目重构为：`lib` + `app`，并让 `app` 只通过 `target_link_libraries()` 获得头文件路径
- 在 Linux 下尝试把共享库安装到非标准目录，理解 RPATH/运行时搜索路径的影响

