---
sidebar_position: 52
slug: /lsb_release
---

# lsb_release 命令



## 介绍

**lsb_release** 命令用于打印 Linux 发行版的系统信息，其中 LSB 是 Linux Standard Base 的缩写。需要注意，该命令并非在所有 Linux 系统上都可用，只在一部分 Linux 系统可用，例如 Ubuntu。

lsb_release 命令输出的信息通常位于 `/etc/lsb-release` 文件。另外，在所有基于 systemd 的 Linux 发行版中，都会使用 `/etc/os-release` 文件作为发行版的信息存储，保存诸如 Linux 发行版的类型、版本型号等基本信息。



**语法**：

```bash
lsb_release [options]
```

**选项**：

- `-h`, `--help`：显示帮助信息。
- `-v`, `--version`：显示系统支持的 LSB 模块。
- `-i`, `--id`：显示发行版的 ID。
- `-d`, `--description`：显示发行版的描述信息。
- `-r`, `--release`：显示发行版的发布版本号。
- `-c`, `--codename`：显示发行版的代号。
- `-a`, `--all`：显示发行版的所有信息。
- `-s`, `--short`：以简短格式显示，和其他选项配合使用。



## 示例

显示当前 Linux 发行版的所有信息：

```bash
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.4 LTS
Release:	20.04
Codename:	focal
```

作为对比，这里将 `/etc/lsb-release` 文件内容打印出来：

```bash
$ cat /etc/lsb-release 
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.4 LTS"
```

同时将 `/etc/os-release` 文件内容也打印出来：

```bash
$ cat /etc/os-release 
NAME="Ubuntu"
VERSION="20.04.4 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.4 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

