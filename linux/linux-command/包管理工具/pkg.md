---
sidebar_label: pkg 命令
sidebar_position: 8
slug: /pkg
---

# pkg 命令 - 管理 FreeBSD 软件包



## 介绍

**pkg** 命令是 FreeBSD 操作系统中用于管理软件包的工具，包括安装、升级、删除软件包，以及查询软件包信息等功能。

**语法**：

```bash
pkg [command] [package ...]
```

**选项**：

- `-i, install`：安装一个或多个软件包。
- `-u, upgrade`：升级已安装的软件包。
- `-r, remove`：卸载一个或多个已安装的软件包。
- `-f, fetch`：下载软件包但不安装。
- `-l, list`：列出已安装的软件包。
- `-s, search`：搜索可用的软件包。
- `-I, info`：显示软件包的详细信息。
- `-q, query`：查询已安装文件属于哪个软件包。



## 示例

安装 nginx 软件包：

```bash
sudo pkg install nginx
```

升级系统中所有已安装的软件包：

```bash
sudo pkg upgrade
```

卸载已安装的 nginx 软件包：

```bash
sudo pkg remove nginx
```

查询软件包信息：

```bash
pkg info nginx
```

搜索可用的软件包（例如 apache）：

```bash
pkg search apache
```

显示已安装软件包列表：

```bash
pkg list
```

查询 `/usr/local/bin/nginx` 文件属于哪个软件包：

```bash
pkg query %n /usr/local/bin/nginx
```

