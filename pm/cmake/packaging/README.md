---
sidebar_position: 0
---

# 第七部分：安装和打包

这一部分把“能构建”推进到“能交付”：写安装规则、生成安装包、区分 Debug/Release 的产物与符号管理等。

## 学习目标

- 能用 `install(TARGETS ...)` / `install(DIRECTORY ...)` 安装二进制与头文件
- 理解安装前缀（`CMAKE_INSTALL_PREFIX`）与 GNUInstallDirs
- 能用 CPack 生成可分发的安装包（tar/zip/deb/rpm 等视平台而定）

## 推荐阅读顺序

1. `CMake INSTALL 指令`
2. `CMake 打包安装`
3. `CMake 打包 Debug 和 Release 版本`

## 练习建议

- 给你的库项目添加安装规则，并安装到 `$HOME/.local`
- 用 `cmake --install build` 做本地安装，再用另一个工程 `find_package` 进行验证（进阶）

