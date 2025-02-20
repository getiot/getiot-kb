---
sidebar_position: 23
slug: /git-gui-client
---

# Git 图形化客户端



本文收集一些好用的 GUI 图形界面 Git 客户端，例如 Gitk、GitHub Desktop、Fork、Sourcetree、Sublime Merge、GitKraken 等，覆盖 Windows、Linux 和 macOS 操作系统。



## Gitk

Gitk 是 Git 提供的一个 GUI 工具，现在安装 Git 的时候就会自动安装 Gitk 工具。Gitk 的主界面主要包含五个部分：

1. 主菜单栏显示区
2. 提交信息显示区，显示提交的基本信息，包括节点树、message、提交人和提交时间
3. 查询条件检索区，根据检索条件查找的窗口
4. 具体内容显示区，显示 commit 的变更记录或两个 commit 的 diff 内容
5. 文件列表显示区，显示的 commit 的文件列表或两个 commit 的 diff 文件列表

Gitk 的界面并不是最美观的，但胜在方便，满足 Git 操作的大部分需求，可以清晰地查看搜索提交历史及 git 相关操作。

![](https://static.getiot.tech/gitk-ubuntu-screenshot.png#center)

在 Linux 系统中，打开终端 Git 仓库目录，输入 `gitk` 命令即可使用。Windows 系统则对应 Git GUI 图形工具。



## GitHub Desktop

GitHub Desktop 是由 GitHub 开发的完全免费且开源的可自定义的 GUI 客户端程序，基于 Electron 开发，提供 Windows 和 macOS 版本。虽然它是 GitHub 推出的软件，但它不仅允许你与 GitHub 交互，还可以和其他 Git 平台（包括 Bitbucket 和 GitLab）进行交互。

GitHub Desktop 的特点包括漂亮的分区方法，可以轻松地检查带有 pull 请求的分支，你可以检查图片和代码区块之间的差异，甚至可以使用拖拽的方式从应用程序中添加项目进行管理。

下载地址：[https://desktop.github.com](https://desktop.github.com/)

![](https://static.getiot.tech/github-desktop-screenshot-windows.png#center)



## Fork

Fork 是 Mac 和 Windows 的免费高级 Git 图形化客户端，专注于速度，用户友好性和效率。它的功能包括带有快速操作按钮的主题布局，内置的合并冲突帮助器和解析器，仓库管理器，GitHub 通知等。

在免费的 Git 客户端中，我喜欢 Fork 的大部分功能。我知道的功能包括漂亮 UI 中的交互式 rebase、Git 流、Git LFS、精选、恢复、子模块等。

下载地址：[https://git-fork.com](https://git-fork.com/)

![](https://static.getiot.tech/git-fork-screenshot.jpg#center)



## Sourcetree

Sourcetree 是适用于 macOS 和 Windows 的免费 Git 图形化客户端。它简化了版本控制过程，让你可以专注于重要的事情 —— 编码。

Sourcetree 拥有专业的 UI，可以通过直接访问 Git 流、子模块、远程 repo 管理器、本地提交搜索、支持 Git 大文件等可视化管理版本库，来执行 Git 任务和访问 Git 流。

Sourcetree 最早由 Atlassian 为 Bitbucket 开发，但已不限于此。它可以与其他 Git 平台结合使用，并具有对 Mercurial 存储库的内置支持。

下载地址：[https://www.sourcetreeapp.com](https://www.sourcetreeapp.com/)

![](https://static.getiot.tech/sourcetree-mac-screenshot.png#center)



## SmartGit

SmartGit 是适用于 macOS、Linux 和 Windows 的功能丰富的 Git 客户端，支持 SVN、GitHub 和 Bitbucket 的 Pull Request。它的功能包括用于 Git 的 CLI、图形合并和提交历史记录、SSH 客户端、Git-Flow、文件合并、冲突解决程序等。

SmartGit 是一个商业工具，但也可以免费用于非商业项目。商业许可证的费用从每月 5.99 美元、每年 99 美元到终身费用 229 美元不等。根据你选择的支持期限，费用可能会有所不同。另外还有一些其它升级功能，比如分布式评审（Distributed Reviews）和智能同步（SmartSynchronize），这两个工具每个许可证需要另加 15 美元。如果只用于非商业用途，你也可以通过下载源码或者 deb 安装包进行安装。

下载地址：[https://www.syntevo.com/smartgit/](https://www.syntevo.com/smartgit/)

![](https://static.getiot.tech/smartgit-windows-screenshot.png#center)

注意：仅当 SmartGit 被用于以下情况时，才被视为非商业用途。

- 从事开源项目的工作；
- 在公共学术机构学习或教学；
- 在您的业余时间管理项目没有经济补偿（业余爱好使用）；
- 公共慈善机构主要针对慈善事业，健康研究，教育或社会福祉。



## Sublime Merge

Sublime Merge 是一款适用于 macOS、Windows 和 Linux 的 Git 客户端，由同一开发者继流行的 Sublime Text 源代码编辑器之后创建。

它包含了 Sublime Text 用户满意的所有品质，包括快速的性能、集成的合并工具、强大的搜索工具、高级差异检查器等。它是免费的，但是像 Sublime Text 一样，你需要支付 99 美元的扩展许可。

下载地址：[https://www.sublimemerge.com](https://www.sublimemerge.com/)

![](https://static.getiot.tech/sublime-merge-mac-screenshot.png#center)



## GitKraken

GitKraken 是一个免费的跨平台 Git 图形化客户端，支持 Windows、macOS、Linux 操作系统，并且提供 VS Code 插件版本，可用于版本控制系统（包括 GitHub，Bitbucket，GitLab 等）。

GitKraken 旨在通过为你提供直观的 UI、任务跟踪、内置代码编辑器、合并冲突编辑器以及对与其他平台集成的支持，使你成为富有生产力的 Git 用户。

出于商业目的和 Pro 版本中包含的其他特性（如合并冲突编辑器、多个配置文件和自托管存储库），GitKraken 的成本为每月4.08 美元，而企业版本的成本更高。

下载地址：[https://www.gitkraken.com](https://www.gitkraken.com/)

![](https://static.getiot.tech/gitkraken-screenshot.png#center)



## GitUp

GitUp 是面向 Mac 用户的免费开源 Git 客户端，重点在于速度，简单性，效率和易用性。它绕过 Git 二进制工具并直接与仓库数据库进行交互，这使其比其他 Git 客户端快得多。例如，它在一秒钟内加载并呈现 40,000 个 GitUp 仓库提交的内容。

GitUp 具有所有 Git 功能的 GUI 替代方案，并且可以直观地实现输入命令和实时更改。

下载地址：[https://gitup.co](https://gitup.co/)



## Ungit

尽管市场上有许多不同版本的 GUI，但是开发人员可能会寻找一种非常简单的使用 git 的方法。是的，如果你很难选择哪种 GUI 更好，Ungit 将解决你的选择问题。

Ungit 在不牺牲 git 多功能性的情况下为 git 带来了用户友好性，并且它在所有平台上均可运行。

下载地址：[https://github.com/FredrikNoren/ungit](https://github.com/FredrikNoren/ungit)

