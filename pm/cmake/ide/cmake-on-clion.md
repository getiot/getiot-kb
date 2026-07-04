---
sidebar_position: 3
slug: /cmake-on-clion
authors: [luhuadong]
---

# CMake + CLion 编译调试

CLion 是 JetBrains 的 C/C++ IDE，以 CMake 为默认构建系统，适合在 Windows、macOS、Linux 上做 CMake 项目的开发与调试。



## 打开项目

- **文件 → 打开**，选择包含顶层 **CMakeLists.txt** 的目录。
- CLion 会识别为 CMake 项目并自动加载、配置；首次会提示选择 CMake 可执行文件（或使用系统 PATH 中的 cmake）。



## 配置与构建

- 在 **设置/偏好 → 构建、执行、部署 → CMake** 中可添加多个配置（如 Debug、Release），指定构建目录、CMake 选项（如 `-DCMAKE_BUILD_TYPE=Debug`）等。
- 顶部工具栏可选择当前配置并执行 **构建**（Ctrl+F9）；构建产物在对应配置的 build 目录下。



## 运行与调试

- 在 CMakeLists.txt 中通过 `add_executable` 定义的目标会出现在运行配置下拉列表中；选择目标后点击“运行”或“调试”即可。
- 调试使用内置 GDB/LLDB 集成，支持断点、变量查看等；需本机已安装对应调试器。



## 小结

- CLion 原生支持 CMake，打开项目目录即可加载。
- 通过 CMake 配置管理构建类型与选项，运行/调试直接针对 CMake 目标。
