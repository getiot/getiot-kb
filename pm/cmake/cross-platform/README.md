---
sidebar_position: 0
---

# 第十部分：跨平台和工具链

这一部分关注“在不同平台/不同架构上稳定构建”的能力：交叉编译、工具链文件、sysroot、以及与依赖查找相关的路径策略。

## 学习目标

- 理解交叉编译与本机构建的关键差异
- 能编写并使用 `CMAKE_TOOLCHAIN_FILE` 工具链文件
- 能排查交叉编译场景下 `find_package`/`pkg-config` 找错库的问题

## 推荐阅读顺序

1. `CMake 交叉编译`
2. `CMake 工具链文件`

## 练习建议

- 写一个最小工具链文件，把编译器切到 `aarch64-linux-gnu-gcc`（若本机有该工具链）
- 在交叉编译时验证 `CMAKE_FIND_ROOT_PATH_MODE_*` 的影响

