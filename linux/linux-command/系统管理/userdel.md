---
sidebar_position: 7
slug: /userdel
---

# userdel 命令



## 介绍

在 Linux 系统中，**userdel** 命令用于删除指定的用户及与该用户相关的文件。在实现上，userdel 命令其实只是修改了系统的用户账号文件 /etc/passwd、/etc/shadow 以及 /etc/group 文件。这与 Linux系统“一切操作皆文件”的思想正好吻合。

值得注意的是，如果有该要删除用户相关的进程正在运行，userdel 命令通常不会删除该用户账号。如果确实必须要删除，建议先终止用户进程，然后再执行 userdel 命令进行删除。不过，userdel 命令也提供了一个面对这种情况的选项，即 `-f` 选项。

:::tip

使用 `userdel` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
userdel [选项] 用户名
```

**选项**：

- `-f, --force`：强制删除用户账号。
- `-r, --remove`：删除用户主目录及其中的所有文件。
- `-R, --root CHROOT_DIR`：chroot 到指定目录。
- `-Z, --selinux-user`：为用户删除所有的 SELinux 用户映射。
- `-h, --help`：显示帮助信息。



## 示例

删除用户 getiot，但不删除其家目录及文件：

```bash
userdel getiot
```

删除用户 getiot，并将其家目录及文件一并删除：

```bash
userdel -r getiot
```

