---
sidebar_position: 1
sidebar_label: 软件包管理
slug: /linux-package-management
authors: [luhuadong]
---

# Linux 软件包管理

在 Linux 中，安装软件通常不是去网站下载一个安装包再一路下一步，而是使用发行版提供的软件包管理器。软件包管理器会帮你处理下载、安装、升级、卸载和依赖关系。

这一篇会带你建立软件包管理的基本概念，并认识 `apt`、`dnf`、`yum`、`dpkg` 等常见工具。

## 什么是软件包

软件包可以理解为发行版打包好的软件。它通常包含：

- 可执行程序。
- 配置文件模板。
- 库文件。
- 文档和手册页。
- 安装、升级、卸载脚本。
- 依赖关系声明。

比如你安装 `curl`，系统不只复制一个 `curl` 命令，还会确认它依赖的库是否存在。

## 软件源是什么

软件源也叫仓库，是发行版维护的软件包集合。你的系统会从配置好的软件源获取软件包列表和安装包。

Debian/Ubuntu 的软件源配置通常在：

```text
/etc/apt/sources.list
/etc/apt/sources.list.d/
```

Fedora/RHEL 系统的软件源配置通常在：

```text
/etc/yum.repos.d/
```

初学阶段不要随意添加来历不明的软件源。软件源具有很高权限，错误或恶意的软件源可能影响整个系统。

## Debian/Ubuntu：apt

Debian、Ubuntu 及其衍生发行版常用 [apt](/linux-command/apt/)。

更新软件包索引：

```bash
sudo apt update
```

安装软件：

```bash
sudo apt install curl
```

升级已安装软件包：

```bash
sudo apt upgrade
```

搜索软件：

```bash
apt search nginx
```

查看软件包信息：

```bash
apt show curl
```

卸载软件：

```bash
sudo apt remove curl
```

如果希望同时删除不再需要的依赖：

```bash
sudo apt autoremove
```

## apt 和 apt-get

[apt-get](/linux-command/apt-get/) 是较早、脚本中常见的工具；`apt` 更适合人类交互使用，输出更友好。

一般来说：

- 你在终端手动操作，可以用 `apt`。
- 写脚本或遵循旧文档时，可能会看到 `apt-get`。

两者底层都属于 Debian/Ubuntu 软件包管理体系。

## dpkg：底层 deb 包工具

[dpkg](/linux-command/dpkg/) 是 Debian 软件包的底层工具。它可以直接安装本地 `.deb` 文件：

```bash
sudo dpkg -i package.deb
```

但 `dpkg` 不会像 `apt` 那样自动从软件源解决依赖。如果安装后提示依赖缺失，可以尝试：

```bash
sudo apt -f install
```

日常安装软件优先使用 `apt`，只有处理本地 `.deb` 包时才直接接触 `dpkg`。

## Fedora/RHEL：dnf 和 yum

Fedora、RHEL、CentOS Stream、Rocky Linux、AlmaLinux 等系统常见 [dnf](/linux-command/dnf/)：

```bash
sudo dnf install curl
sudo dnf update
sudo dnf remove curl
dnf search nginx
dnf info curl
```

旧系统或旧教程中常见 [yum](/linux-command/yum/)：

```bash
sudo yum install curl
```

在较新的系统中，`yum` 可能只是指向 `dnf` 的兼容命令。

## Snap、Flatpak 和其他格式

有些桌面软件会通过 [snap](/linux-command/snap/) 或 [flatpak](/linux-command/flatpak/) 分发。它们和传统发行版软件包不同，更强调跨发行版分发和应用隔离。

你可以这样简单理解：

- `apt`、`dnf`：发行版原生软件包管理。
- `snap`、`flatpak`：更偏应用分发，常用于桌面软件。
- `.deb`、`.rpm`：具体的软件包文件格式。

初学阶段先掌握发行版原生包管理器即可。

## 安装软件前先查

安装软件前，建议先查包名和用途：

```bash
apt search package-name
apt show package-name
```

或：

```bash
dnf search package-name
dnf info package-name
```

不要看到命令缺失就随便复制安装命令。不同发行版包名可能不同。

## 常见问题

### Unable to locate package

在 Ubuntu/Debian 上可能是：

- 没有先运行 `sudo apt update`。
- 包名写错。
- 当前发行版软件源没有这个包。
- 需要启用额外软件源。

### Could not get lock

说明另一个包管理进程正在运行，例如系统更新器或另一个终端中的 `apt`。

不要随便删除 lock 文件。先等待，或确认没有其他包管理进程后再处理。

### 依赖冲突

依赖冲突通常来自混用软件源、手动安装第三方包、系统版本过旧等原因。解决前先读完整错误信息，不要盲目执行网上的强制修复命令。

## 小结

你需要掌握：

- Debian/Ubuntu 使用 `apt`。
- Fedora/RHEL 系常用 `dnf`，旧系统常见 `yum`。
- `.deb` 可用 `dpkg` 处理，但日常优先 `apt`。
- 安装前先 `search` 和 `show`。
- 不要随意添加不可信软件源。

如果软件源中没有你要的软件，再考虑官方二进制包、容器或 [从源码安装软件](linux-install-from-source.md)。
