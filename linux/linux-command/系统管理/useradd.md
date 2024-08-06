---
sidebar_position: 6
slug: /useradd
---

# useradd 命令



## 介绍

在 Linux 系统中，**useradd** 命令用来创建新的用户或更改用户的信息。

useradd 可用来建立用户帐号，而当帐号建好之后，再通过 [passwd](/linux-command/passwd) 命令设定帐号的密码。使用 useradd 命令所建立的帐号，实际上是保存在 /etc/passwd 文本文件中。

:::tip

使用 `useradd` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
useradd [选项] 用户名
useradd -D
useradd -D [选项]
```

**选项**：

- `-b, --base-dir BASE_DIR`：新账户的主目录的基目录。
- `-c, --comment COMMENT`：新账户的 GECOS 字段。
- `-d, --home-dir HOME_DIR`：新账户的主目录。
- `-D, --defaults	`：显示或更改默认的 useradd 配置。
- `-e, --expiredate EXPIRE_DATE`：新账户的过期日期。
- `-f, --inactive INACTIVE`：新账户的密码不活动期。
- `-g, --gid GROUP	`：新账户主组的名称或 ID。
- `-G, --groups GROUPS`：新账户的附加组列表。
- `-h, --help`：显示帮助信息。
- `-k, --skel SKEL_DIR`：使用此目录作为骨架目录。
- `-K, --key KEY=VALUE`：不使用 /etc/login.defs 中的默认值。
- `-l, --no-log-init`：不要将此用户添加到最近登录和登录失败数据库。
- `-m, --create-home`：创建用户的主目录。
- `-M, --no-create-home	`：不创建用户的主目录。
- `-N, --no-user-group`：不创建同名的组。
- `-o, --non-unique	`：允许使用重复的 UID 创建用户。



## 示例

创建新用户 getiot：

```bash
useradd getiot
```

创建新用户 getiot，但不创建家目录，并且禁止登录：

```bash
useradd -M -s /sbin/nologin getiot
```

创建新用户 getiot，并指定 UID 为 888，指定归属用户组为 root、dialout 成员，其 shell 类型为 /bin/sh：

```bash
useradd -u 888 -s /bin/sh -G root,dialout getiot
```

创建新用户 getiot，设置家目录为 /data/getiot，用户过期时间为 2030/12/31，过期后两天停权：

```bash
useradd -e "2030/12/31" -f 2 -d /data/getiot getiot
```

