---
sidebar_label: apt-cache 命令
sidebar_position: 4
slug: /apt-cache
---

# Linux apt-cache 命令 - 查询软件包信息



## 介绍

**apt-cache** 命令是一个用于查询 APT 软件包缓存的工具，它提供了有关已安装或可用软件包的信息，包括软件包的描述、依赖关系、版本号、可用性等。它是 Debian 和基于 Debian 的 Linux 发行版（例如 Ubuntu）中 APT 软件包管理系统的一部分。

**语法**：

```bash
apt-cache [选项] 命令
apt-cache [选项] show 软件包1 [软件包2 ...]
```

**常用命令**：

- `showsrc`：显示源文件的各项记录。
- `search`：根据正则表达式搜索软件包列表。
- `depends`：显示该软件包的依赖关系信息。
- `rdepends`：显示所有依赖于该软件包的软件包名字。
- `show`：以便于阅读的格式介绍该软件包。
- `pkgnames`：列出所有软件包的名字。
- `policy`：显示软件包的安装设置状态。



## 示例

搜索包含关键词的软件包

```bash
apt-cache search firefox
```

显示特定软件包的详细信息

```bash
apt-cache show firefox
```

