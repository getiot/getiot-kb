---
sidebar_label: apt 命令
sidebar_position: 1
slug: /apt
---

# apt 命令



## 介绍

**apt**（英文全拼：Advanced Packaging Tool）是 Debian/Ubuntu 系统中的 Shell 前端软件包管理器。该命令提供了查找、安装、升级、删除某一个、一组甚至全部软件包的命令，而且命令简洁而又好记。

提示：apt 命令执行需要超级管理员权限（root）。

**语法**：

```bash
apt [options] [command] [package ...]
```

**选项**：

- `options` ：可选选项，例如：
  - `-h` ：显示帮助信息。
  - `-y` ：将安装过程中所有提示选择设为 yes。
  - `-q` ：不显示安装的过程等等。
- `command` ：要进行的操作，例如：
  - `update` ：更新软件包索引信息。
  - `upgrade` ：升级当前已安装的软件包（如果可更新）。
  - `full-upgrade` ：升级当前已安装的软件包（升级前先删除需要更新软件包）。
  - `install` ：安装软件包。
  - `reinstall` ：重新安装软件包。
  - `remove` ：卸载软件包（保留软件的配置文件）。
  - `purge` ：卸载软件包（不保留软件的配置文件）。
  - `autoremove` ：清理不再使用的依赖和库文件。
  - `satisfy` ：使系统满足依赖关系字符串（Apt 1.9 的新命令）。
  - `search` ：查找软件包。
  - `show` ：显示软件包具体信息，例如版本号、安装大小、依赖关系等信息。
  - `list` ：列出可更新的软件包及版本信息。
  - `edit-sources` ：编辑 sources.list 配置文件。
- `package` ：安装的包名。

提示：在使用 apt 命令时，如果不太记得完整的软件包名称，可以只输入前面一部分的字符，然后按下 **Tab** 键自动搜索和补全。

## 示例

更新软件包索引信息（可通过该方式查看近期可更新的软件包）

```bash
sudo apt update
```

更新软件包索引信息后升级软件包（使用 yes 选项）

```bash
sudo apt update && sudo apt upgrade -y
```

安装 vim 软件包

```bash
sudo apt install vim
```

安装 vim 软件包，如果软件包已经存在，则不要升级它

```bash
sudo apt install vim --no-upgrade
```

只升级 vim 软件包，如果不存在就不要安装它

```bash
sudo apt install vim --only-upgrade
```

安装指定软件包版本（**package_name** 为包名，**version_number** 为版本号。）

```bash
sudo apt install <package_name>=<version_number>
```

卸载 vim 软件包

```bash
sudo apt remove vim
```

查找名为 libiphone 的相关包

```bash
apt search libiphone
```

查看 vim 包的相关信息

```bash
apt show vim
```

列出所有已安装的软件包的版本信息

```bash
apt list --all-versions
```

列出所有已安装的软件包

```bash
apt list --installed
```

列出可更新的软件包及版本信息

```bash
apt list --upgradeable
```

