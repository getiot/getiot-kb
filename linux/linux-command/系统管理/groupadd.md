---
sidebar_label: groupadd 命令
sidebar_position: 9
slug: /groupadd
---

# groupadd 命令



## 介绍

**groupadd** 命令用于在 Linux 系统中创建新的用户组（group）。它允许系统管理员通过命令行创建和管理用户组。

:::tip

使用 `groupadd` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
groupadd [选项] group
```

**选项**：

- `-f, --force`：若用户组已存在，则以成功状态退出。
- `-g, --gid GID`：指定用户组的组 ID（GID）。如果不指定，系统将自动分配。
- `-h, --help`：显示帮助信息。
- `-K, --key KEY=VALUE`：设置新用户组的属性（覆盖配置文件 /etc/login.defs）。这允许管理员设置各种用户组属性。
- `-o, --non-unique`：允许使用重复的 GID。这在某些情况下可能有用。
- `-p, --password PASSWORD`：设置用户组密码。
- `-r, --system`：创建系统用户组。注意，系统工作组的组 ID 小于 500。
- `-R, --root CHROOT_DIR`：应用 `CHROOT_DIR` 目录中的更改并使用 `CHROOT_DIR` 目录中的配置文件。
- `-P, --prefix PREFIX_DIR`：应用 `PREFIX_DIR` 目录中的更改并使用 `PREFIX_DIR` 目录中的配置文件。此选项不会 chroot，旨在准备交叉编译目标。一些限制：NIS 和 LDAP 用户/组未经过验证；PAM 身份验证使用主机文件；没有 SELINUX 支持。



## 示例

创建一个名为 students 的新用户组：

```bash
sudo groupadd students
```

创建一个名为 students 的新用户组，并指定组 ID（GID）为 1001：

```bash
sudo groupadd -g 1001 students
```

