---
sidebar_label: groupdel 命令
sidebar_position: 10
slug: /groupdel
---

# Linux groupdel 命令 - 删除用户组



## 介绍

**groupdel** 命令用于在 Linux 系统中删除指定用户组。它允许系统管理员通过命令行删除不再需要的用户组，本质上是修改的系统中的 /ect/group 和 /ect/gshadow 文件。

你可以使用 [`userdel`](/linux-command/userdel) 命令修改系统用户文件，删除与 GROUP 相关的所有项目。需要注意的是，若该群组中仍包括某些用户，则必须先删除这些用户后，才能删除群组。

:::tip

使用 `groupdel` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
groupdel [选项] GROUP
```

**选项**：

- `-h, --help`：显示帮助信息并退出。
- `-R, --root CHROOT_DIR`：在 `CHROOT_DIR` 目录中应用更改并使用 `CHROOT_DIR` 目录中的配置文件。
- `-P, --prefix PREFIX_DIR`：应用 `PREFIX_DIR` 目录中的更改并使用 `PREFIX_DIR` 目录中的配置文件。此选项不会 chroot，旨在准备交叉编译目标。一些限制：NIS 和 LDAP 用户/组未经过验证；PAM 身份验证使用主机文件；没有 SELINUX 支持。
- `-f, --force`：强制删除。



## 示例

删除名为 students 的用户组：

```bash
sudo groupdel students
```

强制删除名为 students 的用户组，即使该组有用户成员：

```bash
sudo groupdel -f students
```

