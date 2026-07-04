---
sidebar_position: 2
slug: /cmake-packaging
authors: [luhuadong]
---

# CMake 打包安装

在写好 **`install()`** 规则后，除了直接执行 `cmake --install .` 安装到本机，还可以用 **CPack** 把安装结果打成安装包（如 .deb、.rpm、.zip、.msi、.dmg 等），便于分发。



## 启用 CPack

在顶层 CMakeLists.txt 的末尾（在定义好所有 install 规则之后）加入：

```cmake showLineNumbers
include(CPack)
```

或先设置若干 `CPACK_*` 变量再 include(CPack)，例如：

```cmake showLineNumbers
set(CPACK_PACKAGE_NAME "myapp")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr")
include(CPack)
```



## 生成安装包

在构建目录下执行：

```bash
cmake --build . --target package
# 或
cpack
```

会根据当前生成器与平台生成对应格式的包（如 Linux 下可能生成 .deb/.rpm/.tgz 等，取决于 CPack 配置和系统）。



## 常用 CPACK 变量

| 变量 | 含义 |
|------|------|
| `CPACK_PACKAGE_NAME` | 包名 |
| `CPACK_PACKAGE_VERSION` | 版本号 |
| `CPACK_PACKAGING_INSTALL_PREFIX` | 包内安装前缀（如 /usr） |
| `CPACK_GENERATOR` | 要使用的生成器列表，如 "DEB;RPM;TGZ" |

可查阅 [CPack 文档](https://cmake.org/cmake/help/latest/module/CPack.html) 按需配置。打包 Debug/Release 多配置见 [CMake 打包 Debug 和 Release 版本](/cmake/cmake-packaging-debug-and-release/)。



## 小结

- 在 CMakeLists.txt 末尾 **include(CPack)** 即可启用 CPack。
- 通过 **CPACK_*** 变量设置包名、版本、前缀等，再执行 **cmake --build . --target package** 或 **cpack** 生成安装包。
