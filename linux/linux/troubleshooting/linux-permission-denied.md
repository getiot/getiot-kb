---
sidebar_position: 1
sidebar_label: 权限 denied 怎么排查
slug: /linux-permission-denied
---

# Linux 权限 denied 怎么排查

`Permission denied` 是初学 Linux 最常见的错误之一。它不一定意味着“必须加 sudo”，而是说明当前用户对某个文件、目录、设备或操作没有足够权限。

## 先看完整报错

不同报错位置代表不同问题：

```text
bash: ./script.sh: Permission denied
```

可能是脚本没有执行权限。

```text
touch: cannot touch '/etc/test': Permission denied
```

可能是你正在写系统目录。

```text
mkdir: cannot create directory 'data': Permission denied
```

可能是当前目录没有写权限。

## 第一步：确认当前位置

```bash
pwd
ls -ld .
```

`pwd` 告诉你当前在哪里，`ls -ld .` 显示当前目录权限。

如果你在 `/etc`、`/usr`、`/var` 等系统目录中，普通用户没有写权限是正常的。

## 第二步：检查目标权限

检查文件：

```bash
ls -l target
```

检查目录本身：

```bash
ls -ld target-dir
```

注意，查看目录权限时要用 `-d`，否则 `ls` 会列出目录里面的内容。

## 第三步：判断自己是谁

```bash
whoami
id
```

看当前用户是否是文件所有者，是否属于对应用户组。

权限判断通常按这个顺序：

1. 你是不是所有者。
2. 你是否属于所属组。
3. 否则使用其他人权限。

## 脚本不能执行

如果脚本没有执行权限：

```bash
ls -l script.sh
```

看到类似：

```text
-rw-r--r-- 1 rudy rudy 100 Jul 24 10:00 script.sh
```

没有 `x`，添加执行权限：

```bash
chmod u+x script.sh
./script.sh
```

也可以不加执行权限，直接交给 Bash：

```bash
bash script.sh
```

## 目录不能进入

目录需要执行权限才能进入：

```bash
ls -ld secret-dir
```

如果没有 `x`，即使有 `r` 也可能无法访问目录内文件。

## 文件属于 root

如果你在自己的目录里发现文件属于 root，通常是因为以前用了 `sudo` 创建文件：

```bash
ls -l
```

修正所有者：

```bash
sudo chown "$USER:$USER" file
```

修正整个目录时要谨慎：

```bash
sudo chown -R "$USER:$USER" project
```

确认 `project` 是你的项目目录，不要对系统目录递归执行。

## 什么时候使用 sudo

适合使用 `sudo` 的情况：

- 安装或删除软件包。
- 修改 `/etc` 下的系统配置。
- 管理系统服务。
- 挂载磁盘。
- 修改其他用户的文件权限。

不适合直接使用 `sudo` 的情况：

- 自己家目录里的文件权限异常。
- 路径写错。
- 脚本没有执行权限。
- 程序把数据目录放在了错误位置。

## 其他可能原因

有些权限问题不只是传统 `rwx`：

- 文件系统以只读方式挂载。
- 挂载选项包含 `noexec`，禁止执行文件。
- SELinux 或 AppArmor 限制访问。
- 容器环境限制了权限。

入门阶段先掌握普通权限排查；遇到服务器安全策略时，再深入学习对应机制。

## 小结

看到 `Permission denied` 时按顺序排查：

```bash
pwd
whoami
id
ls -ld .
ls -l target
```

先确认路径、用户、权限，再决定是否使用 `sudo`。不要把 `sudo` 当成通用止痛药。
