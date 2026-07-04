---
sidebar_position: 2
slug: /cmake-on-qtcreator
authors: [luhuadong]
---

# CMake + Qt Creator 编译调试

Qt Creator 对 CMake 有良好支持，可直接打开 CMake 项目进行配置、构建和调试。



## 打开项目

1. 菜单 **文件 → 打开文件或项目**，选择项目根目录下的 **CMakeLists.txt**（或包含它的目录）。
2. Qt Creator 会解析 CMake 并提示选择 Kit（编译器、Qt 版本等）和构建目录；确认后生成构建系统。



## 配置与构建

- **构建目录** 默认在项目目录下的 `build-*` 中，可在“项目”模式中修改。
- 在“项目”中可切换 **Build Type**（Debug/Release 等）和 **Kit**。
- 点击左下角“锤子”图标或按 Ctrl+B 执行构建。



## 运行与调试

- 在左侧“项目”中可设置**运行目标**（默认会列出 `add_executable` 定义的可执行文件）。
- 点击“运行”或“调试”即可运行/调试当前选中的目标；调试需本机已安装 GDB/LLDB，Qt Creator 会自动使用对应调试器。



## 小结

- 用 Qt Creator 打开 CMakeLists.txt 即可加载 CMake 项目。
- 通过“项目”配置 Kit、构建目录和构建类型；运行与调试直接针对 CMake 定义的可执行目标。
