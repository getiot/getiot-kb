---
sidebar_label: adduser 命令
sidebar_position: 12
slug: /adduser
---

# Linux adduser 命令 - 添加新用户



## 介绍

**adduser** 命令用于在 Linux 系统中添加新用户。在一些发行版中，`adduser` 实际上是 [`useradd`](/linux-command/useradd) 命令的一个符号链接，而另一些发行版中，`adduser` 是一个对 [`useradd`](/linux-command/useradd)、[`groupadd`](/linux-command/groupadd) 和 [`usermod`](/linux-command/usermod) 命令进行封装的脚本程序，提供一些交互式的步骤以更方便地配置用户信息。大多数情况下，两者可以互相替代。

:::tip

使用 `adduser` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
adduser [options] user
adduser [options] user group
```

**选项**：

- `--conf FILE`：使用指定的配置文件替代默认的 /etc/adduser.conf。
- `--disabled-login`：不要运行 `passwd` 来设置密码。在设置密码之前，用户将无法使用其帐户。
- `--disabled-password`：类似于 `--disabled-login` 选项，但仍然可以登录（例如使用 SSH RSA 密钥），但不能使用密码身份验证。
- `--force-badname`：默认情况下，将根据配置文件中指定的可配置正则表达式 `NAME_REGEX`（如果指定了 `--system`，则为 `NAME_REGEX_SYSTEM`）检查用户和组名称。此选项强制 adduser 和 addgroup 仅对名称的有效性应用弱检查。`NAME_REGEX` 在 adduser.conf 中描述。
- `--gecos GECOS`：为生成的新条目设置 gecos 字段。如果给出此选项，adduser 将不会询问指纹信息。
- `--gid ID`：创建组时，此选项强制新的组 ID 为给定的数字。创建用户时，此选项会将用户放入该组中。
- `--group`：与 `--system` 结合使用时，将创建与系统用户具有相同名称和 ID 的组。如果不与 `--system` 结合使用，则会创建具有给定名称的组。如果程序作为 addgroup 调用，则这是默认操作。
- `--help`：显示帮助信息。



## 示例

添加名为 getiot 的新用户，并按照提示设置密码等信息：

```bash
$ sudo adduser getiot
```

