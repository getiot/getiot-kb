---
sidebar_position: 4
slug: /cmake-gui
authors: [luhuadong]
---

# CMake 图形界面

`cmake-gui` 是 CMake 的图形用户界面工具，用于辅助用户配置和生成项目的构建系统。通过 `cmake-gui`，你可以在可视化的界面中进行各种配置，而不必直接编辑 CMakeLists.txt 文件。

## 使用步骤

使用 `cmake-gui` 图形界面配置工程的基本步骤如下：

**1. 启动 cmake-gui**

可以通过命令行运行 `cmake-gui`，或者在图形界面中找到 CMake 安装目录中的 `cmake-gui` 可执行文件并运行。

**2. 设置源代码路径和构建路径**

在 `cmake-gui` 窗口中，首先设置**源代码路径**（即项目根目录），然后设置**构建路径**（用于存放生成的构建系统文件）。构建路径通常使用项目下的 `build` 目录。

**3. 点击 Configure 按钮**

点击 “Configure” 按钮，`cmake-gui` 将尝试根据你的源代码和构建路径配置项目。如果是第一次配置，它会提示选择生成器和配置选项。

**4. 选择生成器**

在第一次配置时，你需要选择**生成器**（Generator），它决定了使用何种构建系统，例如：

- **Unix Makefiles**：生成 Makefile，配合 make 使用；
- **Ninja**：生成 Ninja 构建文件；
- **Visual Studio 17 2022** 等：生成 Visual Studio 解决方案。

选择后点击 “Finish”。

**5. 配置项目**

在 Configure 过程中，`cmake-gui` 会列出各种配置选项（如 `CMAKE_BUILD_TYPE`、`CMAKE_INSTALL_PREFIX` 等），你可以根据项目需求调整这些选项。配置完成后再次点击 “Configure”，直至没有红色条目或错误提示。

**6. 点击 Generate 按钮**

配置完成后，点击 “Generate” 按钮，`cmake-gui` 将生成所选生成器需要的构建系统文件，例如 Makefile 或 Visual Studio 工程文件。

**7. 打开生成的构建系统（可选）**

根据你选择的生成器，你可以使用 `make`、`ninja`、Visual Studio 等工具打开生成的构建系统，开始编译和构建项目。
