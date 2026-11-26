---
sidebar_position: 2
authors: [luhuadong]
---

# Linux 开发环境配置

要开始 Linux 系统编程，你首先需要一个稳定的开发环境。和图形界面开发不同，系统编程更强调底层资源的控制，因此你需要掌握命令行、编译工具链、调试工具等。

本节将带你完成以下内容：

- 选择合适的 Linux 开发平台；
- 安装系统编程常用工具（如 GCC、GDB、Make）；
- 配置编程和调试环境（以 VS Code 为例）；
- 编写并运行你的第一个系统程序。

无论你是在虚拟机、实体机还是远程服务器上学习，只要完成这些配置，你就可以无障碍地开始 Linux 系统编程之旅。



## 选择 Linux 开发环境

你有以下几种方式可以开始 Linux 系统编程：

1. **直接使用 Linux 桌面系统**

   比如 Ubuntu、Debian、Fedora、Arch 等。推荐新手使用 [Ubuntu](/ubuntu/ubuntu-intro/)，因为它用户社区庞大、资料丰富。

2. **在 Windows 上安装 [WSL](/windows/windows-subsystem-for-linux/)（Windows Subsystem for Linux）**

   WSL 允许你在 Windows 上运行原生 Linux 命令行环境。对于不方便安装双系统的用户，是一个不错的选择。

3. **使用虚拟机安装 Linux**

   可以用 VirtualBox 或 VMware 安装 Ubuntu 等发行版，适合希望完全隔离开发环境的情况。

4. **远程连接到一台 Linux 服务器（比如树莓派、云服务器）**

   通过 SSH 连接并编写、调试程序。这种方式在嵌入式开发和云端部署中非常常见。

:::tip

建议初学者使用 Ubuntu 20.04 或 22.04，因其兼容性和文档支持较好。

:::



## 安装开发工具

系统编程离不开一套工具链。以下是你需要安装的核心工具：

### 安装 GCC（GNU 编译器集合）

GCC 是 Linux 下最常用的 C/C++ 编译器。可以通过以下命令安装：

```bash
sudo apt update
sudo apt install build-essential
```

这会安装：

- `gcc`（C 编译器）
- `g++`（C++ 编译器）
- `make`（构建工具）
- `libc6-dev`（C 标准库头文件）

### 安装 GDB（GNU 调试器）

GDB 是 Linux 下的标准调试工具：

```bash
sudo apt install gdb
```

你可以用它调试 C 程序，查看变量值、设置断点等，是开发系统级程序不可或缺的工具。



## 选择开发工具和编辑器

你可以根据自己的习惯选择不同的开发方式。

### 使用 VS Code + 插件

- 安装 [VS Code](/vscode/vscode-installation/) 编辑器
- 推荐安装以下扩展：
  - C/C++（官方插件）
  - Remote - WSL（在 WSL 上开发）
  - Remote - SSH（远程开发）
- 配置任务运行和调试器（`.vscode/launch.json`）

VS Code 支持语法高亮、代码跳转、调试断点、变量查看等功能，非常适合初学者使用。

### 使用命令行 + Vim / Nano

如果你习惯在终端工作，可以使用 Vim：

```bash
sudo apt install vim
```

或者 Nano：

```bash
sudo apt install nano
```

搭配 `make`、`gcc`、`gdb`，你可以实现全命令行下的开发流程。



## 编写你的第一个系统程序

新建一个文件 `hello_sys.c`，编写一个简单的程序：

```c showLineNumbers title="hello_sys.c"
#include <unistd.h>

int main() {
    const char *msg = "Hello, Linux system programming!\n";
    write(1, msg, 36);  // 直接使用系统调用 write 写入标准输出
    return 0;
}
```

这是一个非常简洁的系统级 Hello World，没有使用 `printf`，而是调用了系统调用 `write` 来向标准输出写入信息。

编译并运行：

```bash
gcc -o hello_sys hello_sys.c
./hello_sys
```

你应该能看到输出：

```bash
Hello, Linux system programming!
```

这就是你的第一个系统调用程序！



## 小结

在这一节中，你学会了：

- 如何选择 Linux 开发环境（如 Ubuntu、WSL、虚拟机）；
- 如何安装开发工具（GCC、GDB、Make）；
- 如何配置开发编辑器（推荐 VS Code）；
- 如何编写并运行你的第一个系统调用程序。

这些准备工作虽然看起来琐碎，但却是你系统编程之旅中不可跳过的基础。下一节，我们将深入 Linux 的文件系统，从最基本的 `open`、`read`、`write` 系统调用开始，学习如何通过代码操作文件。
