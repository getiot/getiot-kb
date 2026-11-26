---
sidebar_position: 4
sidebar_label: 用户、用户组与 sudo
slug: /linux-users-groups-sudo
---

# Linux 用户、用户组与 sudo

Linux 是多用户系统。即使你的电脑只有你一个人在用，系统里也有很多用户：你的普通用户、root 用户、运行服务的系统用户等。

理解用户、用户组和 `sudo`，是理解权限问题的第一步。

## 普通用户和 root 用户

普通用户用于日常操作，root 用户拥有系统最高权限。

查看当前用户：

```bash
whoami
```

查看当前用户的身份信息：

```bash
id
```

输出类似：

```text
uid=1000(rudy) gid=1000(rudy) groups=1000(rudy),27(sudo)
```

你可以这样读：

- `uid` 是用户 ID。
- `gid` 是默认用户组 ID。
- `groups` 是当前用户所属的用户组列表。

## 为什么不要长期使用 root

root 可以修改系统中的几乎任何文件，也可以停止服务、删除用户、格式化磁盘。它很有用，但也很危险。

日常操作建议使用普通用户。只有安装软件、修改系统配置、管理服务时，才临时提升权限。

这就是 `sudo` 的作用。

## 使用 sudo

`sudo` 表示用管理员权限执行一条命令：

```bash
sudo apt update
```

系统会要求输入当前用户密码。输入密码时，终端通常不会显示星号，这是正常现象。

查看自己是否可以使用 `sudo`：

```bash
sudo -v
```

如果没有权限，可能会看到类似：

```text
user is not in the sudoers file
```

这说明当前用户没有被授权使用 `sudo`。

## sudo 和 su 的区别

[sudo](/linux-command/sudo/) 是“临时用更高权限执行命令”。

[su](/linux-command/su/) 是“切换用户”。例如切换到 root：

```bash
su -
```

在很多 Ubuntu 系统中，root 密码默认未启用，所以直接 `su -` 可能失败。更常见的做法是：

```bash
sudo -i
```

这会启动一个 root Shell。初学阶段不建议长期停留在 root Shell 中，因为你很容易忘记自己正在用最高权限操作。

## 用户组是什么

用户组用于给一组用户分配权限。比如：

- `sudo` 组：通常允许成员使用 `sudo`。
- `adm` 组：可能允许读取某些系统日志。
- `docker` 组：允许用户直接操作 Docker daemon。

查看当前用户所属组：

```bash
groups
```

或：

```bash
id
```

## 创建和管理用户

不同发行版命令略有差异。Debian/Ubuntu 常用 [adduser](/linux-command/adduser/)：

```bash
sudo adduser alice
```

更底层、更通用的命令是 [useradd](/linux-command/useradd/)：

```bash
sudo useradd -m alice
```

修改密码使用 [passwd](/linux-command/passwd/)：

```bash
sudo passwd alice
```

把用户加入某个组，常用 [usermod](/linux-command/usermod/)：

```bash
sudo usermod -aG sudo alice
```

其中 `-aG` 的意思是追加到附加组。不要漏掉 `-a`，否则可能覆盖原有附加组。

## 文件属于谁

运行：

```bash
ls -l
```

你会看到类似：

```text
-rw-r--r-- 1 rudy rudy 18 Jul 24 10:01 notes.txt
```

两个 `rudy` 分别表示：

- 文件所有者。
- 文件所属用户组。

后面学习文件权限时，你会看到权限判断正是围绕“所有者、所属组、其他人”展开的。

## 常见误区

### 看到 Permission denied 就加 sudo

不要急。先确认你在操作什么文件：

```bash
pwd
ls -l target-file
```

如果是自己家目录下的文件，权限异常可能是因为文件所有者被改坏了。盲目 `sudo` 可能让问题越来越乱。

### 把普通用户加进太多高权限组

加入 `sudo`、`docker` 等组会扩大权限范围。尤其是 `docker` 组，在很多场景下接近 root 权限。只在确实需要时添加。

## 小结

这一篇你需要记住：

- Linux 是多用户系统。
- root 权限最高，日常不要长期使用。
- `sudo` 用于临时提升权限。
- 用户组用于组织权限。
- `ls -l` 可以看到文件所有者和所属组。

下一篇会继续讲文件权限，解释 `rwx` 和 `chmod 755` 到底是什么意思。
