---
sidebar_label: yum 命令
sidebar_position: 7
slug: /yum
---

# Linux yum 命令 - 管理 RPM 软件包



## 介绍

**yum** 是用于在基于 RPM 的 Linux 发行版（例如 RHEL、CentOS、Fedora 等）中进行软件包管理的工具。其作用包括安装、升级和删除 rpm 软件包、搜索和显示软件包信息、处理软件包的依赖关系，以及管理软件源配置等。

:::tip

yum 是“Yellowdog Updater, Modified”的缩写，其中的 “Yellow Dog” 是指由 Fixstars 公司发布 Yellow Dog Linux 发行版（最后一个版本是2012年8月发布的 7.0）。

:::

**语法**：

```bash
yum [command] [package ...]
```

**选项**：

- `install`：安装一个或多个 rpm 软件包。
- `update`：升级系统中所有已安装的 rpm 软件包。
- `check-update`：检查系统中所有已安装的 rpm 软件包是否有可用的更新。
- `remove`：卸载一个或多个已安装的 rpm 软件包。
- `list`：列出已安装的软件包信息。
- `search`：搜索可用的软件包。
- `info`：显示指定的 rpm 软件包的描述信息和概要信息。
- `clean`：清理 yum 过期的缓存。
- `shell`：进入 yum 的 shell 交互界面。
- `resolvedep`：显示 rpm 软件包的依赖关系。
- `localinstall`：安装本地的 rpm 软件包。
- `localupdate`：显示本地 rpm 软件包进行更新。
- `deplist`：显示 rpm 软件包的所有依赖关系。
- `provides`：查询某个程序所在安装包。



## 示例

安装 nginx 软件包：

```bash
sudo yum install nginx
```

升级所有已安装的软件包：

```bash
sudo yum update
```

删除已安装的 nginx 软件包：

```bash
sudo yum remove nginx
```

查询 nginx 软件包信息：

```bash
yum info nginx
```

搜索可用的软件包（例如 apache）：

```bash
yum search apache
```

显示已安装软件包列表：

```bash
yum list installed
```

检查系统中所有已安装软件包是否有可用的更新：

```bash
yum check-update
```

