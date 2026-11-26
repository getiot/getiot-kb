---
sidebar_position: 3
slug: /debug-qt-in-vscode
authors: [luhuadong]
---

# VS Code 编译和调试 Qt 工程

配置步骤如下：

1. 安装 Visual Studio Code。
2. 安装 C/C++ 插件，方法是在扩展管理器中搜索「C/C++」，然后点击安装即可。
3. 安装 GDB 调试器，方法是在命令行输入「sudo apt-get install gdb」（假设你的系统是 Ubuntu）。
4. 安装 QT 环境，包括 QT 库和 QT Creator。
5. 在 Visual Studio Code 中打开已有的 QT 项目或创建一个新的 QT 项目。
6. 在 Visual Studio Code 中打开设置，并配置 C/C++ 插件的设置，以使用 QT 的头文件以及库文件。
7. 在 Visual Studio Code 中打开调试面板，并配置 GDB 调试器。

这些步骤应该能帮助你配置好 Visual Studio Code 开发 QT 的环境。



## VS Code 插件

- Qt Configure
- Qt tools



