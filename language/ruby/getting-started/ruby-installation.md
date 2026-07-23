---
sidebar_position: 3
sidebar_label: 安装与版本管理
slug: /ruby-installation
---

# Ruby 安装与版本管理

学习 Ruby 前，你需要安装 Ruby 解释器，以及 RubyGems、Bundler 等常用工具。Ruby 官方下载页会显示当前稳定版本；截至 2026 年 7 月，官方页面显示 current stable version 为 Ruby 4.0.6。

## 先检查本机环境

打开终端，运行：

```bash
ruby -v
gem -v
bundle -v
```

你需要理解这三个命令的作用：

- `ruby`：Ruby 解释器，用来运行 `.rb` 文件。
- `gem`：RubyGems 命令，用来安装和管理 gem。
- `bundle`：Bundler 命令，用来管理一个项目自己的依赖。

如果这些命令都能输出版本号，说明你的 Ruby 基础环境已经可用。

## 为什么需要版本管理

不同项目可能依赖不同 Ruby 版本。例如一个旧 Rails 项目可能还在 Ruby 3.2，一个新项目可能要求 Ruby 4.0。如果你只用系统自带 Ruby，很容易遇到版本冲突。

版本管理工具可以让你为不同项目选择不同 Ruby 版本。常见工具包括：

- `rbenv`
- `RVM`
- `asdf`
- RubyInstaller for Windows

在 macOS 和 Linux 上，很多 Ruby 开发者会使用 `rbenv`。在 Windows 上，RubyInstaller 是更直接的选择。

## macOS 安装 Ruby

macOS 可能自带 Ruby，但通常不建议把系统 Ruby 当作开发环境。系统 Ruby 主要服务于系统工具，版本可能偏旧，也不适合随意升级。

如果你只是想快速体验，可以用 Homebrew 安装 Ruby：

```bash
brew install ruby
ruby -v
```

不过更推荐使用 `rbenv` 管理 Ruby 版本：

```bash
brew install rbenv ruby-build
rbenv init
```

执行 `rbenv init` 后，终端会提示你把初始化代码加入当前 shell 配置文件，例如 `~/.zshrc` 或 `~/.bashrc`。按提示配置后，重新打开终端，检查：

```bash
rbenv --version
```

然后安装 Ruby：

```bash
rbenv install 4.0.6
rbenv global 4.0.6
ruby -v
```

如果 `ruby -v` 仍然显示系统 Ruby，通常说明 shell 初始化没有生效。你可以重新打开终端，或检查 `rbenv init` 提示的配置是否已写入 shell 配置文件。

:::tip
如果你使用 Apple Silicon Mac，Homebrew 可能安装在 `/opt/homebrew`；Intel Mac 常见路径是 `/usr/local`。遇到命令找不到时，先确认 Homebrew 已正确加入 `PATH`。
:::

## Linux 安装 Ruby

Linux 上有两种常见方式：使用发行版包管理器，或使用 `rbenv` 等版本管理工具。

使用包管理器最简单，适合快速体验：

```bash title="Debian / Ubuntu"
sudo apt update
sudo apt install ruby-full
ruby -v
```

```bash title="Fedora"
sudo dnf install ruby
ruby -v
```

```bash title="Arch Linux"
sudo pacman -S ruby
ruby -v
```

这种方式的优点是简单；缺点是发行版仓库里的 Ruby 版本可能不是最新版本，也不方便为不同项目切换版本。

如果你要长期学习 Ruby、Rails 或维护多个项目，建议使用 `rbenv`。在编译 Ruby 前，通常需要先安装构建依赖。下面以 Debian / Ubuntu 为例：

```bash
sudo apt update
sudo apt install git build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libreadline-dev libffi-dev libgdbm-dev
```

然后安装 `rbenv`。如果你的系统包管理器提供的 `rbenv` 版本较旧，可以按 rbenv 官方文档使用 Git 安装；如果只是学习，也可以先用包管理器安装：

```bash
sudo apt install rbenv
rbenv init
```

根据 `rbenv init` 的提示配置 shell 后，重新打开终端，再安装 Ruby：

```bash
rbenv install 4.0.6
rbenv global 4.0.6
ruby -v
```

:::note
不同 Linux 发行版的依赖包名称可能不同。遇到 Ruby 编译失败时，优先查看错误信息中缺少的库，并参考 Ruby 官方安装文档、rbenv 文档和发行版文档。
:::

## 使用 rbenv 的基本流程

安装 `rbenv` 和 `ruby-build` 后，常见流程是：

```bash
rbenv install 4.0.6
rbenv global 4.0.6
ruby -v
```

如果你只想给当前项目指定版本，可以在项目目录使用：

```bash
rbenv local 4.0.6
```

这会生成 `.ruby-version` 文件。团队协作时，这个文件能告诉别人项目使用哪个 Ruby 版本。

:::note
不同系统安装 `rbenv` 的方式不同。请以 Ruby 官方安装页面、rbenv 官方文档和你的操作系统包管理器说明为准。
:::

## Windows 用户

Windows 用户可以使用 RubyInstaller。它会提供 Ruby 运行环境，并可搭配 MSYS2/Devkit 编译带有 C extension 的 gem。

安装后同样检查：

```bash
ruby -v
gem -v
bundle -v
```

## 常见问题

`ruby -v` 能运行，但版本太旧：你可能正在使用系统 Ruby。安装版本管理工具后，确认 shell 初始化配置是否生效。

`bundle` 命令不存在：可以尝试查看 Ruby 是否已附带 Bundler，或通过 RubyGems 安装 Bundler。

安装 gem 失败：如果错误里出现编译相关内容，可能缺少编译工具、头文件或 Windows Devkit。

## 小结

初学阶段，你的目标是让 `ruby -v`、`gem -v`、`bundle -v` 都可用。项目变多后，要养成用 `.ruby-version` 和 `Gemfile` 固定环境的习惯。
