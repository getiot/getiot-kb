---
sidebar_label: passwd 命令
sidebar_position: 5
slug: /passwd
---

# Linux passwd 命令 - 更改用户密码



## 介绍

在 Linux 系统中，**passwd** 命令用于设置用户的认证信息，包括用户密码、账户锁定、密码失效等。直接运行 passwd 命令修改当前的用户密码，对其他用户的密码操作需要管理员权限。

**语法**：

```bash
passwd [选项] [用户名]
```

**选项**：

- `-a, --all`：报告所有帐户的密码状态。
- `-d, --delete`：删除指定帐户的密码。
- `-e, --expire`：强制使指定帐户的密码过期。
- `-h, --help`：显示此帮助信息并推出。
- `-k, --keep-tokens`：仅在过期后修改密码。
- `-i, --inactive INACTIVE`：密码过期后设置密码不活动为 `INACTIVE`。
- `-l, --lock`：锁定指定的帐户。
- `-n, --mindays MIN_DAYS`：设置到下次修改密码所须等待的最短天数为 `MIN_DAYS`。
- `-q, --quiet`：安静模式。
- `-r, --repository REPOSITORY`：在 `REPOSITORY` 库中改变密码。
- `-R, --root CHROOT_DIR`：chroot 到的目录。
- `-S, --status`：报告指定帐户密码的状态。
- `-u, --unlock`：解锁被指定帐户。
- `-w, --warndays WARN_DAYS`：设置过期警告天数为 `WARN_DAYS`。
- `-x, --maxdays MAX_DAYS`：设置到下次修改密码所须等待的最多天数为 `MAX_DAYS`。



## 示例

修改当前登陆的账户密码：

```bash
passwd
```

修改其他用户密码（假设有 getiot 用户）：

```bash
passwd getiot
```

锁定 getiot 用户密码，不允许修改其密码：

```bash
passwd -l getiot
```

解除锁定 getiot 用户密码，允许修改其密码：

```bash
passwd -u getiot
```

下次登录 getiot 账号时强制修改其密码：

```bash
passwd -e getiot
```

清除登录 getiot 账号密码（清除之后登录时无需密码，风险极大）：

```bash
passwd -d getiot
```

查询密码状态：

```bash
passwd -S getiot
```

