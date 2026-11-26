---
sidebar_position: 5
slug: /visual-studio-import-cmake-project
---

# Visual Studio 导入 CMake 项目

如果你已经有了一个 CMake 工程，可以在 Visual Studio 中打开直接打开它。打开的方式如下：

1. 在 Visual Studio 主菜单中选择 “文件” -> “打开” -> “文件夹”。

   或者在开发人员命令提示窗口中键入命令：

   ```bash
   devenv.exe <foldername>
   ```

2. 打开的文件夹中应该有一个 CMakeLists.txt 文件，选择该文件即可。

Visual Studio 不会修改你的 CMakeLists.txt 文件，但是会使用 CMake 缓存中的变量来自动配置 IntelliSense 和生成，并将本地配置和调试设置将存储在 JSON 文件中。

