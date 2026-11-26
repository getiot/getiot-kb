---
sidebar_position: 2
sidebar_label: 文件和目录操作
slug: /linux-file-directory-commands
---

# Linux 文件和目录操作：touch、mkdir、cp、mv、rm

学会移动之后，下一步就是创建、复制、移动和删除文件。Linux 不会频繁弹窗确认，所以你要先在练习目录中熟悉这些命令。

本文会介绍 [touch](/linux-command/touch/)、[mkdir](/linux-command/mkdir/)、[cp](/linux-command/cp/)、[mv](/linux-command/mv/) 和 [rm](/linux-command/rm/)。

## 准备练习目录

先进入安全的练习目录：

```bash
mkdir -p ~/linux-practice/file-demo
cd ~/linux-practice/file-demo
pwd
```

后面的命令都在这里执行。

## 创建空文件：touch

`touch` 常用于创建空文件：

```bash
touch notes.txt
ls -l
```

如果文件已经存在，`touch` 会更新它的修改时间。

你也可以一次创建多个文件：

```bash
touch a.txt b.txt c.txt
ls
```

## 创建目录：mkdir

创建目录使用 `mkdir`：

```bash
mkdir docs
```

如果想一次创建多级目录，使用 `-p`：

```bash
mkdir -p project/src project/logs
```

`-p` 的意思是：父目录不存在时一并创建；如果目录已经存在，也不报错。

## 复制文件：cp

复制文件：

```bash
cp notes.txt notes-copy.txt
```

复制到目录中：

```bash
cp notes.txt docs/
```

复制目录需要加 `-r`：

```bash
cp -r project project-backup
```

这里的 `-r` 表示 recursive，也就是递归复制目录中的内容。

## 移动和重命名：mv

`mv` 既可以移动文件，也可以重命名文件。

重命名：

```bash
mv notes-copy.txt old-notes.txt
```

移动到目录：

```bash
mv old-notes.txt docs/
```

移动目录也使用同一个命令：

```bash
mv project-backup docs/
```

## 删除文件和目录：rm

删除普通文件：

```bash
rm a.txt
```

删除空目录可以用 `rmdir`，但更常见的是使用 `rm -r` 删除目录及其内容：

```bash
rm -r docs/project-backup
```

:::warning
`rm` 删除文件后通常不会进入回收站。练习时请确认你在 `~/linux-practice` 目录中，不要在不了解含义时复制包含 `rm -rf` 的命令。
:::

## 更安全地删除

初学时可以加 `-i`，让 `rm` 在删除前询问：

```bash
rm -i b.txt
```

删除目录时：

```bash
rm -ri docs
```

如果你不确定目标是什么，先用 `ls` 看一眼：

```bash
ls docs
```

确认后再删除。

## 常见组合

创建项目目录：

```bash
mkdir -p app/{src,tests,docs}
touch app/README.md
```

备份配置文件：

```bash
cp config.conf config.conf.bak
```

把日志文件移动到归档目录：

```bash
mkdir -p archive
mv app.log archive/
```

## 常见错误

### cp: omitting directory

如果你复制目录时忘记 `-r`：

```bash
cp project project-copy
```

可能会看到：

```text
cp: -r not specified; omitting directory 'project'
```

解决方法是：

```bash
cp -r project project-copy
```

### Permission denied

如果提示权限不足，先判断目标是不是系统目录。不要马上加 `sudo`。你可以先运行：

```bash
pwd
ls -ld .
```

确认自己正在操作哪里。

## 小结

这一篇的核心命令是：

- `touch`：创建空文件或更新时间。
- `mkdir`：创建目录。
- `cp`：复制文件或目录。
- `mv`：移动或重命名。
- `rm`：删除文件或目录。

掌握这些命令后，你已经可以完成日常文件管理的大部分操作。
