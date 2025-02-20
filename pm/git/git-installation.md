---
sidebar_position: 2
slug: /git-installation
---

# Git 安装



在开始使用 Git 前，你需要将它安装在你的计算机上。即便已经安装，最好将它升级到最新的版本。你可以通过软件包或者其它安装程序来安装，或者下载源码编译安装。

### 在 Linux 上安装

如果你想在 Linux 上用二进制安装程序来安装基本的 Git 工具，可以使用发行版包含的基础软件包管理工具来安装。 

如果你在基于 Debian 的发行版上，如 Ubuntu，可以使用 `apt` 来安装。

```shell
$ sudo apt install git
```

如果你在基于 RedHat 的发行版，比如 CentOS 或 Fedora，可以使用 `dnf` 来安装。

```shell
$ sudo dnf install git
```

注意：上述命令安装的是 Git 的最小依赖版本，如果需要完整版本则安装 git-all。

要了解更多选择，[Git 官方网站](https://git-scm.com/download/linux)上有在各种 Unix 发行版的系统上安装步骤。

### 在 macOS 上安装

在 Mac 上安装 Git 有多种方式。 最简单的方法是安装 Xcode Command Line Tools。Mavericks（10.9）或更高版本的系统中，在 Terminal 里尝试首次运行 `git` 命令即可（如果没有安装过命令行开发者工具，将会提示你安装）。

```shell
$ git --version
```

如果你安装了 [Homebrew](https://brew.sh) 包管理工具，在 Terminal 运行下面命令亦可安装。

```shell
$ brew install git
```

如果你想安装更新的版本，可以使用二进制安装程序。官方维护的 macOS Git 安装程序可以在 [Git 官方网站](https://git-scm.com/download/mac)下载。

另外，你也可以直接安装 GitHub for macOS，它们的图形化 Git 工具有一个安装命令行工具的选项。你可以从 [GitHub for macOS 网站](https://mac.github.com)下载该工具。

### 在 Windows 上安装

在 Windows 上安装 Git 也有几种安装方法。官方版本可以在 [Git 官方网站](https://git-scm.com/download/win)下载 Git 安装包，下载后双击该 exe 文件即可安装。

![在 Windows 上安装 Git](https://static.getiot.tech/git-install-windows.png#center-500)

值得一提的是，[**Git for Windows**](https://gitforwindows.org/) 项目（也称为 msysGit）和 Git 是分别独立的项目。

如果想要进行自动安装，你可以使用 [Git Chocolatey 包](https://chocolatey.org/packages/git)。注意 Chocolatey 包是由社区维护的。

同样，另一个简单的方法是安装 GitHub Desktop。该安装程序包含图形化和命令行版本的 Git。它也能支持 Powershell，提供了稳定的凭证缓存和健全的换行设置。你可以在 [GitHub for Windows 网站](https://desktop.github.com)下载。

### 从源代码安装

也有人觉得从源码安装 Git 更实用，因为你能得到最新的版本。二进制安装程序倾向于有一些滞后，不过近几年 Git 已经成熟，这个差异不再显著。

如果你想从源码安装 Git，需要安装 Git 依赖的库：autotools、curl、zlib、openssl、expat 和 libiconv。

如果你的系统上有 `dnf` 或者 `apt`，可以使用对应的命令来安装最少的依赖以便编译并安装 Git 的二进制版：

```shell
$ sudo dnf install dh-autoreconf curl-devel expat-devel gettext-devel \
                   openssl-devel perl-devel zlib-devel
```

```shell
$ sudo apt install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
                   gettext libz-dev libssl-dev
```

为了添加文档的多种格式（doc、html、info），需要以下附加的依赖：

```shell
$ sudo dnf install asciidoc xmlto docbook2X
$ sudo apt install asciidoc xmlto docbook2x
```

> 注意：使用 RHEL 和 RHEL 衍生版，如 CentOS 和 Scientific Linux 的用户需要 [开启 EPEL 库](https://fedoraproject.org/wiki/EPEL#How_can_I_use_these_extra_packages.3F) 以便下载 `docbook2X` 包。

如果你使用基于 Debian 的发行版（Debian/Ubuntu/Ubuntu-derivatives），还需要 `install-info` 包：

```shell
$ sudo apt install install-info
```

如果你使用基于 RPM 的发行版（Fedora/RHEL/RHEL衍生版），还需要 `getopt` 包 （它已经在基于 Debian 的发行版中预装了）：

```shell
$ sudo dnf install getopt
```

此外，如果你使用 Fedora/RHEL/RHEL衍生版，那么你需要执行以下命令来解决二进制文件名的不同的问题。

```shell
$ sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
```

当你安装好所有的必要依赖，你可以继续从几个地方来取得最新发布版本的 tar 包。 你可以从 [Kernel.org 网站](https://www.kernel.org/pub/software/scm/git) 获取，或从 [GitHub 网站上的镜像仓库](https://github.com/git/git) 来获得。通常在 GitHub 上的是最新版本，但 kernel.org 上包含有文件下载签名，如果你想验证下载正确性的话会用到。

接着，编译并安装：

```shell
$ tar -zxf git-2.31.0.tar.gz
$ cd git-2.31.0
$ make configure
$ ./configure --prefix=/usr
$ make all doc info
$ sudo make install install-doc install-html install-info
```

完成后，你可以使用 Git 来获取 Git 的更新：

```shell
$ git clone git://git.kernel.org/pub/scm/git/git.git
```

