---
sidebar_position: 13
slug: /deluser
---

# deluser 命令



## 介绍

在许多 Linux 发行版中，**deluser** 是一个命令行工具，是对 [`userdel`](/linux-command/userdel) 和 [`groupdel`](/linux-command/groupdel) 命令进行封装的脚本，用于删除系统中的用户账户。这个命令通常会删除用户的主目录以及与之相关的文件和组。

:::tip

使用 `deluser` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
deluser [options] user
deluser [options] user group
```

**选项**：

- `--conf FILE`：使用 `FILE` 替代默认的 /etc/deluser.conf 和 /etc/adduser.conf 文件。
- `--group`：删除一个组。如果程序作为 delgroup 调用，则这是默认操作。
- `--help`：显示帮助信息。
- `--quiet`：禁止显示进度信息。
- `--system`：仅当用户/组是系统用户/组时才删除。这可以避免意外删除非系统用户/组。此外，如果用户不存在，则不会返回错误值。该选项主要用于 Debian 软件包维护者脚本。
- `--only-if-empty`：仅在没有成员留下时才删除。
- `--backup`：将 userhome 和 mailspool 文件中包含的所有文件备份到名为 `/$user.tar.bz2` 或 `/$user.tar.gz` 的文件中。
- `--backup-to`：备份文件不放在 `/` 下，而是放在该参数指定的目录下。这也隐式设置了 `--backup`。
- `--remove-home`：删除用户的主目录及其邮件池。如果指定了 `--backup`，则执行备份后将删除文件。
- `--remove-all-files`：从该用户拥有的系统中删除所有文件。注意：`--remove-home` 不再起作用。如果指定了 `--backup`，则执行备份后将删除文件。
- `--version`：显示版本和版权信息。



## 示例

删除用户 getiot（保留主目录）：

```bash
sudo deluser getiot
```

删除用户并删除主目录：

```bash
sudo deluser --remove-home getiot
```

删除用户及其主目录和所有相关文件：

```bash
sudo deluser --remove-all-files getiot
```

备份用户主目录并删除用户：

```bash
sudo deluser --backup getiot
```

将用户从 students 组中删除：

```bash
sudo deluser getiot students
```

