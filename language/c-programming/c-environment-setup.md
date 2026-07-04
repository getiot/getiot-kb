---
sidebar_position: 3
---

# C 语言开发环境



在开始编写 C 程序之前，我们需要先准备好 C 的编程环境。实际上，如果单纯“编写” C 代码，任意选择一个文本编辑器即可。但由于 C 语言是一门编译型语言，并且在不同的平台上存在多个不同的版本，因此还需要安装相应的编译器和函数库。

目前，最常用的 C 编译器是 GCC，本文也会着重以 GCC 为例介绍如何搭建 C 语言的开发环境。



## 代码编辑器

代码编辑器可大致分为两种：文本编辑器（Text Editor）和集成开发环境（IDE）。

### 代码编辑器

世界上有很多文本编辑器，相信你已经用过其中一些，例如 Windows 的记事本（Notepad）。没错，你可以直接在记事本上编写 C 程序！当然啦，对于程序员来说，还有更好的选择，例如 [Sublime Text 3](https://www.sublimetext.com/3)、[Atom](https://github.com/atom/atom)、[Visual Studio Code](https://code.visualstudio.com/) 等等，以及有些历史的 [Emacs](https://www.gnu.org/software/emacs/) 和 [Vim](https://www.vim.org/)。

实际上，工作在不同操作系统上的程序员可能有不同的偏好，比如 Windows 用户更喜欢用图形化的编辑器，而一些 Linux 用户可能更喜欢用纯文本的编辑器，例如 Vim。如果你不知道选择哪款编辑器，那我推荐你尝试一下 [Visual Studio Code](/vscode/)，它是开源、免费、跨平台的，而且有大量扩展插件。

> 江湖流传着这么一句话：世界上只有三种编辑器 —— Vim、Emac 和其他编辑器，其中 Vim 是编辑器之神，Emac 是神的编辑器，而其他编辑器永远只能是其他编辑器。

### 集成开发环境

相对来说，使用 IDE 对初学者更加友好，因为 IDE 集成了代码编辑器、编译器、调试器等功能，并且有图形操作界面，用户不需要关系程序如何编译等问题，可以专心学习 C 语言语法。

所以，我们在这里为你推荐一些 IDE 软件工具：

- [Visual Studio](https://visualstudio.microsoft.com/)
- [Visual C++ 6.0](https://answers.microsoft.com/zh-hans/windows/forum/all/visual-c/ffdff72a-9be9-4d16-8099-d576201f2fb0)
- [Dev C++](https://www.bloodshed.net/)
- [Code::Blocks](https://www.codeblocks.org/)
- [Turbo C](https://turbo-c.net/)

### 源文件和头文件

我们使用编辑器创建的文件称为源代码（source code）文件，可以在其中编写程序源代码。

对于 C 程序而言，源代码又分为源文件和头文件，源文件通常以扩展名 `.c` 命名，头文件则以扩展名 `.h` 命名。前者提供实现，后者提供接口声明和类型定义。



## GCC 编译器

C 语言源代码是以人类可读的形式编写的，想要运行它，还需要把 C 源代码编译成机器语言，才能得到可运行的 C 程序，完成这个“翻译”任务的就是**编译器**（compiler）。

源文件中编写的源代码是程序的人类可读源。 它需要被“编译”成机器语言，以便您的 CPU 可以实际按照给定的指令执行程序。

编译器将源代码编译成最终的可执行程序，这样 CPU 就可以按照给定的指令执行程序。目前，最常用且免费的编译器是 GNU C/C++ 编译器（也就是 GCC），主流的操作系统 Linux、macOS 和 Windows 都有相应的版本。如果你使用其他操作系统，例如 Solaris，则可以使用该平台提供的编译器。对于单片机一类嵌入式开发，芯片厂商或 IDE 厂商往往会提供特定的 C 编译器工具。

下面我们以通用操作系统 Linux、macOS 和 Windows 为例，介绍如何安装 GNU C/C++ 编译器。是的，虽然本教程是 C 语言教程，但 GCC 编译器适用于 C 和 C++ 编程语言。



### 在 Linux 上安装 GCC

Linux 发行版通常已经预装 GCC 编译器，如果你正在使用 Linux 或 UNIX 系统，可以先执行下面命令查看你的系统是否已经安装了 GCC。

```bash
$ gcc -v
```

如果看到类似下面的信息，则说明你的系统已经安装好 GCC 了。

```bash
Using built-in specs.
Target: x86_64-linux-gnu
Configured with: ../configure --prefix=/usr .......
Thread model: posix
gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)
```

如果没有安装，那么可以参考下面命令进行安装：

```bash
# RedHat/CentOS/Fedora
$ sudo yum -y install gcc
# Debian/Ubuntu
$ sudo apt -y install gcc
```

更多的安装指南可参考《[Installing GCC](https://gcc.gnu.org/install/)》。

提示：本教程基于 Linux，所有示例均在 Ubuntu 20.04 下编写并经过 GCC 9.4.0 编译。



### 在 Mac OS 上安装 GCC

如果你使用 Mac OS X，获取 GCC 的最简单方法是从 Apple 网站下载 Xcode 开发环境并按照其安装说明进行操作。设置 Xcode 后，你将能够使用 C/C++ 的 GNU 编译器。

详情请参考 [developer.apple.com/technologies/tools/](https://developer.apple.com/technologies/tools/)。



### 在 Windows 上安装 GCC

要在 Windows 上安装 GCC，你可以安装 MinGW、Cygwin 等开发环境。

- **MinGW** 是 Minimalist GNU for Windows 的缩写，是用于开发原生（32位） Windows 应用的一个开发环境。它主要提供了针对 win32 应用的 GCC、GNU binutils 等工具，以及对等于 Windows SDK（的子集）的头文件和用于 MinGW 版本 linker 的库文件（so、a 等，而不是 VC 的 lib）。
- **Cygwin** 是运行于 Windows 平台的 POSIX “子系统”，提供 Windows 下的类 Unix 环境，并提供将部分 Linux 应用“移植”到 Windows 平台的开发环境的一套软件。

下面以 MinGW 为例介绍安装步骤：

1. 首先访问 MinGW 主页 [www.mingw.org](https://www.mingw.org)，然后点击链接进入 MinGW 下载页面。下载最新版本的 MinGW 安装程序，该程序应命名为 `MinGW-<version>.exe`。
2. 安装 MinGW 时，至少必须安装 gcc-core、gcc-g++、binutils 和 MinGW 运行时。
3. 将 MinGW 安装的 bin 子目录添加到 **PATH** 环境变量中，以便你可以在命令行上通过简单名称指定这些工具。
4. 安装完成后，将能够从 Windows 命令行运行 gcc、g++、ar、ranlib、dlltool 和其他几个 GNU 工具。

实际上，在 Windows 系统中进行 C 语言编程，你还有很多选择。例如使用 Visual Studio 开发环境，安装时勾选 “**使用C++的桌面开发**”，即可支持 C 语言编程。或者安装 Dev-C++ 这样的集成开发环境，本身也会自带 MinGW 和 GDB 等编译、调试工具。
