---
sidebar_position: 23
---

# Ubuntu 离线安装软件包

我们知道，在 Ubuntu 系统通过 APT 软件包管理工具可以很方便地安装软件，但是在无法连接网络的情况下，就无法安装了。这时候就需要我们下载指定版本的 deb 软件包，在进行手动安装。通常，你可以使用 [dpkg](/linux-command/dpkg/) 或 [apt](/linux-command/apt/) 命令完成软件包的安装或升级。

## 搜索软件包

打开 [packages.ubuntu.com](https://packages.ubuntu.com/) 网页，进入 Ubuntu 软件包搜索页面，该页面会列出目前维护的 Ubuntu 发新版及其[代号](/ubuntu/ubuntu-versions/)，如下图所示。

![](https://static.getiot.tech/ubuntu-packages-main.png#center)

在下方 Keyword 关键字搜索框中输入你想要搜索的软件包名称，例如 Git，选择 Focal 发行版（Ubuntu 20.04）。

![](https://static.getiot.tech/ubuntu-packages-search-git.png#center)

点击“搜索”按钮，将列出 git 相关的所有软件包（62 个），包括 git 核心软件包及其相关开发工具。下图展示了部分软件包，例如 git-annex 是一个分布式文件同步系统，git-cola 是一个可视化 Git 工具。

![](https://static.getiot.tech/ubuntu-packages-search-git-list.png#center)

如果你只需要 git 命令行核心功能，点击 “软件包 git” 下方的链接即可进入详情页面，在这里会列出 git 软件包及其相关依赖项。在手动安装的情况下，你需要自己解决软件包的依赖问题。通常，你需要在页面最下方找到该软件包对应硬件架构的版本（例如 amd64、arm64、armhf、i386、ppc64el、s390x），对于 64 位 PC 电脑选择 amd64 平台即可。

![](https://static.getiot.tech/ubuntu-packages-download-git.png#center)

点击 “amd64” 链接，跳转到 git 软件包的下载页面，在该页面你可以看到软件包的完整名称 git_2.25.1-1ubuntu3.5_amd64.deb，APT 软件源[类型](/ubuntu/ubuntu-software-repositories/)为 main，对应的子目录路径是 `pool/main/g/git/`。你可以点击页面中的 [security.ubuntu.com/ubuntu](http://security.ubuntu.com/ubuntu/pool/main/g/git/git_2.25.1-1ubuntu3.5_amd64.deb) 链接下载该软件包，安装方法后面有介绍。

![](https://static.getiot.tech/ubuntu-packages-download-git-2.png#center)

如果安装顺利，那么安装完成后即可使用该软件工具；如果安装失败，通常是由于软件依赖问题导致的，这时候需要逐一解决依赖问题（注意：依赖可能又有依赖）。例如，在我们测试的 Ubuntu 20.04 系统中，缺少了 git-man 和 liberror-perl 依赖项，因此需要按照同样的方法逐一安装，最后再重新安装 git 软件包即可。

提示：你也可以到常用的 APT 镜像源服务器下载，例如华为的 Ubuntu 镜像源 [mirrors.huaweicloud.com/ubuntu-ports/](https://mirrors.huaweicloud.com/ubuntu-ports/)，将子路径 `pool/main/g/git/` 添加到 URL 后面即可找到相关的软件包。



## 安装软件包

对于已经下载到本地的 deb 格式软件包，我们通常使用 [dpkg](/linux-command/dpkg/) 命令安装，命令格式为：

```bash
sudo dpkg -i <package.deb>
```

以 git 软件包为例，完整安装命令如下：

```bash
sudo dpkg -i git_2.25.1-1ubuntu3.5_amd64.deb
```

值得注意的是，dpkg 不会自动安装依赖包，因此当出现依赖相关的错误时，需要手动解决依赖问题。

另外，也可以使用 `apt/apt-get` 命令来安装本地 deb 软件包，apt 命令会自动解决软件包依赖问题（当然，前提是你可以连通 Ubuntu 镜像源服务器）。和 dpkg 命令不同，apt 命令需要指定 deb 软件包的路径（相对路径或绝对路径），否则会尝试从网络搜索并安装同名软件包，从而导致安装失败。`apt/apt-get` 安装命令如下：

```bash
sudo apt install -y ./git_2.25.1-1ubuntu3.5_amd64.deb
sudo apt-get install -y ./git_2.25.1-1ubuntu3.5_amd64.deb
```



## 注意事项

- 查找的 deb 包一定要准确，不仅仅是指文件名，还有硬件平台和版本。
- 上述网站查找 deb 包时，可能只会列出下一级依赖或并未列出所有依赖，所以安装过程可能需要一点耐心。
- 安装结束后，如果你想确定是否安装成功，或者安装的版本不对，想卸载 deb 包，请参考 [dpkg](/linux-command/dpkg/) 命令更多用法。



