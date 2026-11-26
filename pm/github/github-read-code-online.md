---
sidebar_position: 10
---

# GitHub 在线阅读代码



众所周知，GitHub 是一个代码托管平台，用户可以在线上查看他人公开的代码。只需要登录 [github.com](https://github.com) 网站，搜索你想要查看的仓库（repository），或通过 URL 直接访问仓库页面，即可在线查看该仓库的代码。

不过，这样查看代码只能一个个页面去翻，太低效了！那有没有更好的在线阅读 GitHub 仓库代码的方法呢？

下面介绍两种方法，可以在浏览器上使用 VS Code 编辑器，在线阅读或编辑 GitHub 上的代码。



## 方法一：使用 GitHub1s

github1s 是一个第三方服务，它可以帮助用户在浏览器上使用 VS Code 编辑器，开发和编辑 GitHub 项目中的代码。它可以将代码仓库（repository）中的任何代码文件以编程方式在浏览器中打开，并提供几乎与本地 Visual Studio Code 编辑器相同的环境和功能。

你可以使用 github1s，通过在浏览器访问 [https://github1s.com](https://github1s.com) 网站，然后输入 GitHub 仓库的 URL 来打开任意一个公开的代码仓库。github1s 的服务是基于开源项目 OneDark Pro 主题创建的，它包括了所有标准编程语言的语法高亮，也支持代码自动完成、错误检查、调试等功能。除此之外，github1s 还会将你的代码和 GitHub 仓库实时同步，所以你可以放心进行代码的修改和保存。

例如，Linux 内核仓库 URL 是：

```bash showLineNumbers
https://github.com/torvalds/linux
```

我们将其修改为：

```bash showLineNumbers
https://github1s.com/torvalds/linux
```

即可使用 github1s 提供的服务在线阅读代码。

![使用 GitHub1s 在线阅读代码](https://static.getiot.tech/github1s-linux.png#center)



## 方法二：使用 Codespaces

GitHub 官方在 2022 年上线了 Codespaces 服务，支持在线代码查看功能，也支持在代码文件页面上进行修改，然后再进行提交（commit）。Codespaces 可以实现基于 VS Code 的云端代码编译，这意味着，你在手机、平板上都可以直接进行开发，可以称得上是一个云端 IDE 了。

具体操作方法如下：

首先，找到你要访问的仓库，例如 [https://github.com/torvalds/linux](https://github.com/torvalds/linux)，点击 Code 按钮，选择 Codespaces 选项卡，点击 “Create codespace on master”。

![](https://static.getiot.tech/github-codespaces-button.png#center)

这将会使用 Codespaces 加载 master 分支的代码，如果你想查看其他分支，请先切换分支在重新点击 Code 按钮。

现在，你可以在线阅读代码了。

![使用 Codespaces 在线阅读代码](https://static.getiot.tech/github-codespaces-linux.png#center)

Codespaces 由 Visual Studio technology 提供技术支持，集成了浏览器版的完全 VS Code 编辑程序，支持代码补全与导航、扩展插件以及终端访问等多项功能于一身。如果开发者更倾向于使用桌面版 IDE 进行开发，也可以在 GitHub 中打开 Codespace 之后再将其连接到桌面 IDE 中。

