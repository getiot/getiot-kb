---
sidebar_label: debootstrap 命令
sidebar_position: 18
slug: /debootstrap
---

# Linux debootstrap 命令 - 创建 Debian 基础文件系统



## 介绍

**debootstrap** 是 Debian/Ubuntu 下的一个工具，用于构建一套基本的系统（根文件系统）。生成的目录符合 Linux 文件系统标准（FHS），即包含了 /boot、/etc、/bin、/usr 等等目录，但它比发行版本的 Linux 体积小很多，当然功能也没那么强大，因此，只能说是“基本的系统”。

debootstrap 通常用于安装基本的 Debian 系统到一个指定目录，以便在该目录中进行 [chroot](/linux-command/chroot/) 操作；或者用于创建一个用于安装新系统的基础文件系统，以测试不同 Debian 版本和系统架构。

**语法**：

```bash
debootstrap [OPTION]... <suite> <target> [<mirror> [<script>]]
```

**选项**：

- `--arch=A`：指定目标系统的架构，如 amd64、i386、powerpc 等。
- `--variant=X`：指定文件系统的变种，常见的有 `buildd`、`fakechroot`、`minbase` 等。
- `--components=A,B,C`：指定要包含的软件包组件，如 `main`、`contrib`、`non-free`。
- `--include=A,B,C`：指定要包含在安装中的额外软件包。
- `--exclude=A,B,C`：指定要从安装中排除的软件包。



## 示例

在指定目录中创建一个基本的 Debian 系统：

```bash
sudo debootstrap stable /path/to/installation/directory
```

在指定目录中创建一个基本的 Debian 系统，并指定架构和变种：

```bash
sudo debootstrap --arch amd64 --variant=minbase buster /path/to/installation/directory
```

在指定目录中创建一个基本的 Debian 系统，并包含 `build-essential` 和 `git` 软件包：

```bash
sudo debootstrap buster /path/to/installation/directory --include=build-essential,git
```

在指定目录中创建一个基本的 Debian 系统，但排除安装 `python` 软件包：

```bash
sudo debootstrap buster /path/to/installation/directory --exclude=python
```

在指定目录中创建一个基本的 Debian 系统，使用指定的本地镜像源：

```bash
sudo debootstrap --arch amd64 --variant=minbase --include=build-essential,git,locales buster /path/to/installation/directory http://ftp.us.debian.org/debian
```

:::tip

请注意，`debootstrap` 命令需要在具有 `sudo` 权限的系统上运行。上述示例中的版本（如 `buster`）和软件包名称应根据实际需求进行调整。此外，要在创建的 Debian 系统中进行 chroot，你可能需要额外的配置，如 `mount`、`chroot` 等。

:::

