---
sidebar_label: groupmod 命令
sidebar_position: 11
slug: /groupmod
---

# groupmod 命令



## 介绍

**groupmod** 命令用于在 Linux 系统中修改用户组的属性。通过 `groupmod` 命令，管理员可以更改用户组的名称或 GID（组 ID），以及其他一些属性。

不过建议大家不要随意修改用户名、组名和 GID，因为非常容易造成管理员逻辑混乱。如果非要修改用户名或组名，建议先删除旧的，再建立新的。

:::tip

使用 `groupmod` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
groupmod [选项] GROUP
```

**选项**：

- `-g, --gid GID`：将组 ID 改为 `GID`。
- `-h, --help`：显示帮助信息。
- `-n, --new-name NEW_GROUP`：将组名修改为 `NEW_GROUP`。
- `-o, --non-unique`：允许使用重复的 GID。
- `-p, --password PASSWORD`：将密码更改为（加密过的）`PASSWORD`。
- `-R, --root CHROOT_DIR`：在 `CHROOT_DIR` 目录中应用更改并使用 `CHROOT_DIR` 目录中的配置文件。
- `-P, --prefix PREFIX_DIR`：应用 `PREFIX_DIR` 目录中的更改并使用 `PREFIX_DIR` 目录中的配置文件。此选项不会 chroot，旨在准备交叉编译目标。一些限制：NIS 和 LDAP 用户/组未经过验证；PAM 身份验证使用主机文件；没有 SELINUX 支持。



## 示例

修改用户组的名称：

```bash
sudo groupmod -n newgroupname oldgroupname
```

修改用户组的组 ID（GID）：

```bash
sudo groupmod -g 1001 groupname
```

