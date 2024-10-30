---
sidebar_label: snap 命令
sidebar_position: 10
slug: /snap
---

# snap 命令 - 管理 Snap 应用包



## 介绍

**Snap** 是 Canonical（开发 Ubuntu 系统的公司）推出的一种新的软件打包格式，其目的是为了彻底解决 Linux 依赖性的问题，Snap 软件包拥有更加稳定和安全的特性。同时，snap 也是 Linux 上安装 snap 软件包的命令。

如果你使用的是 Ubuntu 16.04 LTS 或更高版本，那么可以直接使用 snap 命令，无需额外安装。

**语法**：

```bash
snap <command> [<options>...]
```



## 示例

snap 显示已安装的 snap 软件的基本信息：

```bash
snap list
```

snap 搜索包（在应用商店搜索）：

```bash
snap find <package_name>
```

snap 安装一个包：

```bash
snap install <package_name>
```

snap 更新所有软件包：

```bash
snap refresh
```

snap 更新指定软件包：

```bash
snap refresh <package_name>
```

snap 卸载软件包：

```bash
snap remove <package_name>
```

snap 检查系统中最近的快照更改：

```bash
snap changes
```

snap 还原到以前安装的版本：

```bash
snap revert <package_name>
```

注意：部分 snap 命令需要添加 sudo 增加 root 权限。

