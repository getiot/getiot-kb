---
sidebar_position: 2
---

# KiCad 安装



我们可以在 [https://www.kicad.org/download/](https://www.kicad.org/download/) 中找到 KiCad 的安装包和安装方法。[前面](/kicad/kicad-intro/)说过，KiCad 是一个开源、跨平台的设计工具，支持 Windows、macOS 和多种 Linux 发行版。因此，根据你所使用的操作系统不同，安装方法也有所不同。

![](https://static.getiot.tech/kicad-install-version.png#center)

根据 [KiCad 稳定版本发布政策](http://ci.kicad.org/job/kicad-doxygen/ws/Documentation/doxygen/html/md_Documentation_development_stable-release-policy.html)，KiCad 定期发布。新功能不断添加到开发分支中。如果你想利用这些新功能并通过测试帮助，请下载适用于你平台的最新每晚（nightly）构建包。每夜构建可能会引入诸如文件损坏、生成坏 Gerbers 等错误，但 KiCad 开发团队的目标是在新功能开发期间尽可能保持开发分支的可用性。



## GNU/Linux 平台

下面以 Ubuntu 为例，介绍如何在 Linux 中安装 KiCad。

当前最新的稳定版是 KiCad 5.1.12，已在 [PPA for KiCad: 5.1 releases](https://launchpad.net/~kicad/+archive/ubuntu/kicad-5.1-releases) 发布。所以我们只需要将 PPA 添加到 Ubuntu 的软件管理器，便可以方便地安装和更新 KiCad。

1、打开软件管理器（Software Manager）；

2、打开“其它软件”（Other Software）选项卡；

3、点击“添加...”（Add...），输入 PPA 地址 `ppa:kicad/kicad-5.1-releases`，点击“添加源”（Add Source）；

4、这时候可能需要输入管理员密码，更新软件源列表；

![](https://static.getiot.tech/kicad-ubuntu-software-manager.png#center)

5、接着打开 Ubuntu 软件中心，搜索“kicad”，安装即可。

![](https://static.getiot.tech/kicad-ubuntu-software-search.png#center)

**注意**：KiCad 原理图库和文档位于单独的包中。如果你想要其中任何一个，请分别安装 kicad-library 和 kicad-doc。

如果你更喜欢使用终端命令行，可以用下面命令完成上述的操作：

```bash
sudo add-apt-repository --yes ppa:kicad/kicad-5.1-releases
sudo apt update
sudo apt install --install-recommends kicad
# If you want demo projects
sudo apt install kicad-demos
```

上面命令会安装完整版的 KiCad，如果你不想安装所有包，可以用下面命令：

```bash
sudo apt install --no-install-recommends kicad
```

如果不安装完整版，那么你可能对下面这些包感兴趣：

- `kicad-libraries`：一个虚拟包，将推荐你安装封装（footprints）、符号（symbols）、模板（templates）和 3D；
- `kicad-symbols`、`kicad-templates`、`kicad-footprints`、`kicad-packages3d`：如果要手动选择要安装的库。

另外，还可以根据你的语言安装其他软件包：

- `kicad-locale-XX`：语言包（XX 是你的国家/地区代码，请参阅 `apt search kicad-locale` 以查找可用语言）；
- `kicad-doc-XX`：对应语言编写的说明文档。

比如安装中文包：

```bash
sudo apt install kicad-locale-zh
```

然后在菜单栏中选择 *Preferences > Set Language > Chinese simplified* 切换成简体中文。



## macOS 平台

稳定版本（Stable）：[https://downloads.kicad.org/kicad/macos/explore/stable](https://downloads.kicad.org/kicad/macos/explore/stable)

每夜版本（Unstable nightly）：[https://downloads.kicad.org/kicad/macos/explore/nightlies](https://downloads.kicad.org/kicad/macos/explore/nightlies)



## Windows 平台

稳定版本（Stable）：[https://downloads.kicad.org/kicad/windows/explore/stable](https://downloads.kicad.org/kicad/windows/explore/stable)

每夜版本（Unstable nightly）：[https://downloads.kicad.org/kicad/windows/explore/nightlies](https://downloads.kicad.org/kicad/windows/explore/nightlies)





## 参考

- [下载和安装 KiCad](https://docs.kicad.org/5.1/zh/getting_started_in_kicad/getting_started_in_kicad.html)
- [Install on Ubuntu](https://www.kicad.org/download/ubuntu/)
