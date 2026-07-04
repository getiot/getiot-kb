---
sidebar_position: 1
slug: /cmake-error-resolution
authors: [luhuadong]
---

# CMake 错误解决

本节收集一些常见 CMake 配置或构建错误及处理思路。

## 缺少 GTest

**现象：**

```bash
Could NOT find GTest (missing: GTEST_LIBRARY GTEST_INCLUDE_DIR GTEST_MAIN_LIBRARY)
Call Stack (most recent call first):
  ...
  find_package(GTest ...
```

**处理：** 安装系统提供的 GTest 开发包后再配置，例如：

```bash
sudo apt install libgtest-dev
```

若希望不依赖系统包，可在项目中用 **FetchContent** 拉取 googletest 并构建，见 [CMake 配置 GTest 单元测试](/cmake/cmake-gtest/)。

## project(VERSION) 与策略 CMP0048

**现象：**

```bash
VERSION not allowed unless CMP0048 is set to NEW
```

或：

```bash
CMake Warning (dev) at src/CMakeLists.txt: project():
  Policy CMP0048 is not set: project() command manages VERSION variables.
  ...
  The following variable(s) would be set to empty: PROJECT_VERSION, ...
```

**处理：** 在顶层 CMakeLists.txt 的 `project()` 之前设置策略为 NEW：

```cmake showLineNumbers
cmake_minimum_required(VERSION 3.0)
cmake_policy(SET CMP0048 NEW)
project(MyProject VERSION 1.0.0)
```

或使用足够新的 CMake 版本（3.0+ 对 CMP0048 的默认行为已较合理），并保证 `project(名称 VERSION x.y.z)` 写法正确。

## 链接库顺序 / 未定义引用

**现象：** 链接阶段报 `undefined reference to ...`，或 `ldd` 显示依赖库顺序/缺失异常。

**思路：**

- 使用 **`target_link_libraries(目标 PRIVATE A B C)`** 时，把**被依赖的库**放在**依赖它的目标**后面（即 A 依赖 B 时，写 `target_link_libraries(目标 PRIVATE B A)` 或按实际依赖顺序排列）。现代 CMake 和链接器一般能处理顺序，但若使用 `link_directories()` + 裸库名，顺序不当容易出错。
- 尽量用 **find_package** 得到的**导入目标**（如 `XXX::XXX`）做 `target_link_libraries`，避免手写 `-L` 和 `-l`。
- 检查是否漏链库（如数学库需 `target_link_libraries(目标 PRIVATE m)`），见 [情景速查：链接数学库](/cmake/cmake-scene-how-to/)。

## 小结

- 依赖缺失：安装对应开发包或使用 FetchContent/ExternalProject。
- 策略/版本类告警：在合适位置 `cmake_policy(SET CMPxxxx NEW)` 或升级 CMake。
- 链接错误：检查库顺序、是否使用导入目标、是否漏链（如 `m`）。
