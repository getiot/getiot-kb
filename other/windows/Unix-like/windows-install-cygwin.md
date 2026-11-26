---
sidebar_position: 2
slug: /windows-install-cygwin
sidebar_label: Windows 安装 Cygwin
---

# Windows 安装 Cygwin 详细步骤

**Cygwin** 是在 Windows 平台上运行的类 UNIX 模拟环境，支持绝大多数的 GNU 软件。如果你有在 Windows 系统中开发 Linux 程序的需求，那么 Cygwin 是一个很好的选择。Cygwin 在 Windows 系统中，就好比 Wine 在 Linux 系统中一样的概念。



## 安装 Cygwin

在 [Cygwin 官网](https://www.cygwin.com) 下载 Cygwin 安装包，如下图所示。

![](https://static.getiot.tech/windows-install-cygwin-01.png#center)

双击 setup-x86_64.exe 开始安装 Cygwin，一直按“下一步”到 Select Packages 窗口。在这里，你可以搜索你想要的软件包一并安装（当然你也可以后续有需要的时候再安装）。例如，在 Search 框输入“wget”，选择要安装的 wget 版本即可，如下图所示。

![](https://static.getiot.tech/windows-install-cygwin-02.png#center)

点击“下一步”，安装程序就会自动下载并安装前面选择的所有软件包。待安装完成后，点击“完成”。

现在，Cygwin 已经安装好了！你可以通过 Start 菜单或桌面图标启动它，启动后你会看到一个类似于 CMD 的命令行窗口，如下图所示。

![](https://static.getiot.tech/windows-install-cygwin-03.png#center)

你可以在 Cygwin 窗口输入 Linux 的常用命令（例如 ls、cd 等）。



## 使用 apt-cyg 安装软件

假设你的目标是要在 Windows 中开发 Linux 程序，那么你就需要用到 GCC 编译工具。你当然可以使用前面介绍的方法，在 Select Packages 窗口进行安装。不过，如果你错过了，又不想重新双击打开一遍 Cygwin 的安装程序，那么可以使用 apt-cyg 工具在终端完成软件包的安装。

首先，你需要安装 apt-cyg 工具，它是专门为 Cygwin 设计的类似于 apt-get 的命令行工具。你可以在 [GitHub](https://github.com/transcode-open/apt-cyg) 找到它，下载 zip 包即可。解压后的 apt-cyg 目录结构如下：

```bash
$ tree
.
├── LICENSE
├── apt-cyg
├── changelog.md
├── readme.md
└── status.md
```

将 apt-cyg 脚本拷贝到 Cygwin 安装路径的 bin 目录，例如 C:\cygwin64\bin。

现在，打开 Cygwin 终端就可以使用 apt-cyg 工具了！

安装 GCC 编译工具

```bash
apt-cyg install gcc-core
```

安装 Vim 编辑器

```bash
apt-cyg install vim
```

好啦，赶紧写个 Hello World 程序测试一下吧！



## 相关链接

- [Cygwin 项目官网](https://www.cygwin.com)
- [Cygwin 代码仓库](https://www.cygwin.com/cgit/newlib-cygwin/)

