---
sidebar_position: 6
slug: /dnf
---

# dnf 命令



## 介绍

**dnf**（Dandified Yum）是用于在基于 RPM 的 Linux 发行版中进行软件包管理的工具，如 Fedora、RHEL（Red Hat Enterprise Linux）以及它们的衍生发行版。值得一提的是，`dnf` 是 `yum` 的下一代版本，首次出现在 Fedora 18 这个发行版中，旨在提供更快的性能和更丰富的功能。

**语法**：

```bash
dnf [参数]
```

**选项**：

- `repolist`：显示系统中可用的 dnf 软件库。
- `list`：列出用户系统上的所有来自软件库的可用软件包和所有已经安装在系统上的软件包。
- `search <包名>`：搜索软件库中的软件包。
- `provides <路径>`：查找某一文件的提供者。
- `info <包名>`：查看软件包详情。
- `install <包名>`：安装软件包。
- `update <包名>`：升级软件包。
- `check-update`：检查系统软件包的更新。
- `update`：升级所有系统软件包。
- `remove`：删除软件包。
- `autoremove`：删除无用孤立的软件包。
- `clean all`：删除缓存的无用软件包。
- `help <命令名>`：获取有关某条命令的使用帮助。
- `help`：查看所有的dnf命令及其用途。
- `history`：查看dnf命令的执行历史。
- `grouplist`：查看所有的软件包组。
- `groupinstall <软件包组名称>`：安装一个软件包组。
- `groupupdate <软件包组名称>`：升级一个软件包组中的软件包。
- `groupremove <软件包组名称>`：删除一个软件包组。
- `distro-sync`：更新软件包到最新的稳定发行版。
- `reinstall <包名>`：重新安装特定软件包。
- `downgrade <包名>`：回滚某个特定软件的版本。
- `--version`：查看 dnf 包管理器版本。



## 示例

安装软件包（安装指定名称的软件包及其依赖项）：

```bash
dnf install <软件包名称>
```

将系统中所有已安装的软件包升级到最新版本：

```bash
dnf upgrade
```

搜索软件包：

```bash
dnf search <关键词>
```

显示软件包信息（包括版本、依赖关系等详细信息）：

```bash
dnf info <软件包名称>
```

移除软件包：

```bash
dnf remove <软件包名称>
```

检查可用更新：

```bash
dnf check-update
```

列出已安装软件包：

```bash
dnf list installed
```

清理 dnf 缓存（包括软件包和元数据）：

```bash
dnf clean all
```

列出软件包的文件信息：

```bash
dnf repoquery -l <软件包名称>
```

启用/禁用指定的软件仓库：

```bash
dnf config-manager --set-enabled <仓库名称>
dnf config-manager --set-disabled <仓库名称>
```

