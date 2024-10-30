---
sidebar_label: usermod 命令
sidebar_position: 8
slug: /usermod
---

# usermod 命令 - 修改用户属性



## 介绍

在 Linux 系统中，**usermod** 命令用于修改用户账号的各项设定。在实现上，usermod 命令其实只是修改了系统的用户账号文件 /etc/passwd、/etc/shadow 以及 /etc/group 文件。

usermod 命令不允许你改变正在线上的使用者帐号名称。另外，当 usermod 命令用来改变 user id，必须确认系统中没有该用户相关的进程正在运行。

:::tip

使用 `usermod` 命令需要具有足够的权限，通常需要以超级用户（root）或具有 sudo 权限的用户身份运行。

:::

**语法**：

```bash
usermod [选项] 用户名
```

**选项**：

- `-c, --comment 注释`：修改用户账号的备注文字（GECOS 字段）。
- `-d, --home HOME_DIR`：设置用户的新主目录。
- `-e, --expiredate EXPIRE_DATE`：设定帐户过期的日期为 `EXPIRE_DATE`。
- `-f, --inactive INACTIVE`：过期 `INACTIVE` 天数后，设定密码为失效状态。
- `-g, --gid GROUP`：强制使用 `GROUP` 为新主组。
- `-G, --groups GROUPS`：新的附加组列表 `GROUPS`。
- `-a, --append GROUP`：将用户追加至上边 `-G` 中提到的附加组中，并不从其它组中删除此用户。
- `-h, --help`：显示帮助信息。
- `-l, --login LOGIN`：设置新的登录名称。
- `-L, --lock`：锁定用户帐号。
- `-m, --move-home`：将家目录内容移至新位置（仅于 `-d` 一起使用）。
- `-o, --non-unique`：允许使用重复的（非唯一的）UID。
- `-p, --password PASSWORD`：将加密过的密码（`PASSWORD`）设为新密码。
- `-R, --root CHROOT_DIR`：chroot 到指定目录。
- `-s, --shell SHELL`：该用户帐号的新登录 shell。
- `-u, --uid UID`：用户帐号的新 UID。
- `-U, --unlock`：解锁用户帐号。
- `-v, --add-subuids FIRST-LAST`：添加子 UID 范围。
- `-V, --del-subuids FIRST-LAST`：移除子 UID 范围。
- `-w, --add-subgids FIRST-LAST`：添加子 GID 范围。
- `-W, --del-subgids FIRST-LAST`：移除子 GID 范围。
- `-Z, --selinux-user  SEUSER`：用户账户的新 SELinux 用户映射。



## 示例

更改用户 getiot 的家目录为 /home/linux：

```bash
usermod -d /home/linux getiot
```

将用户 getiot 添加到组 dialout 中：

```bash
usermod -G dialout getiot
```

修改 getiot 的用户名为 linux：

```bash
usermod -l linux getiot
```

锁定账号 getiot：

```bash
usermod -L getiot
```

解除对 getiot 的锁定：

```bash
usermod -U getiot
```

