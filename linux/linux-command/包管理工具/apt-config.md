---
sidebar_label: apt-config 命令
sidebar_position: 3
slug: /apt-config
---

# apt-config 命令



## 介绍

**apt-config** 命令是 Debian 系操作系统（包括 Ubuntu）中用于显示或操作 APT（Advanced Package Tool）软件包管理系统配置项的工具。它允许用户查看 APT 的各种配置选项，包括软件源、包管理器的行为和其他相关设置。通过此命令，用户可以了解系统上 APT 的当前配置，并在需要时进行相应的调整。

:::tip

apt-config 命令主要用于 Debug 和编写 Shell 脚本。

:::

**语法**：

```bash
apt-config [选项] 命令
```

**常用命令**：

- `shell`：通过 shell 求值来获取设置值。
- `dump`：显示活动的设置选项。



## 示例

显示所有配置项

```bash
apt-config dump
```

