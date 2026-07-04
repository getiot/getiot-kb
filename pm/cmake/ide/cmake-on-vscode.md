---
sidebar_position: 1
slug: /cmake-on-vscode
authors: [luhuadong]
---

# CMake + VSCode 编译调试

在 VSCode 中使用 CMake 进行配置、编译和调试，需要安装相关扩展并正确配置构建与调试环境。



## 推荐插件

- **CMake**：CMake 语言高亮与基本支持
- **CMake Tools**：CMake 配置、构建、测试、调试集成
- **C/C++**：Microsoft 的 C/C++ 扩展，用于 IntelliSense 和调试（如 GDB/LLDB）

安装后，用 VSCode 打开项目根目录（包含顶层 CMakeLists.txt 的目录），CMake Tools 会识别并提示选择 Kit（编译器）、构建类型等。



## 基本流程

1. **选择 Kit**：在底部状态栏或命令面板中选择编译器（如 GCC、Clang）。
2. **配置**：CMake Tools 会执行 cmake 配置，生成构建文件（默认通常在 `build` 目录）。
3. **构建**：通过底部“Build”或命令 `CMake: Build` 执行构建。
4. **调试**：为可执行目标选择“Debug”并启动调试时，会使用当前 Kit 的调试器（如 GDB）；需在项目下配置 `launch.json`（或使用 CMake Tools 的“Debug”按钮）以正确传入程序路径和参数。



## 调试配置示例

若使用 `launch.json`，可指定由 CMake 生成的可执行文件路径，例如：

```json showLineNumbers
{
  "type": "cppdbg",
  "request": "launch",
  "name": "Debug myapp",
  "program": "${workspaceFolder}/build/myapp",
  "args": [],
  "cwd": "${workspaceFolder}",
  "environment": []
}
```

路径需与 CMake 实际生成的可执行文件位置一致（可能与构建目录、目标名有关）。使用 CMake Tools 自带的 “Debug” 按钮时，一般会自动使用当前选中的目标路径。

:::tip

本文原本引用了一张调试示意图，但当前目录下未找到对应图片文件。你可以：

- 直接删除图片引用（不影响正文使用）
- 或把图片放到 `docusaurus/subjects/pm/cmake/ide/`（或新建 `ide/images/`）并再引用它

:::
