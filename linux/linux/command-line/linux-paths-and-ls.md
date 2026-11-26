---
sidebar_position: 1
sidebar_label: 路径与工作目录
slug: /linux-paths-and-ls
---

# Linux 路径与工作目录：pwd、cd、ls

在 Linux 中，几乎所有操作都和“路径”有关。你要打开文件、运行程序、查看日志、复制目录，都必须先知道自己在哪里，以及目标在哪里。

这一篇会带你掌握 [pwd](/linux-command/pwd/)、[cd](/linux-command/cd/) 和 [ls](/linux-command/ls/)。

## 当前工作目录

当前工作目录就是你现在所在的位置。打开终端后运行：

```bash
pwd
```

你可能会看到：

```text
/home/rudy
```

这表示你当前在用户 `rudy` 的家目录。后续命令如果使用相对路径，都会以这里为起点。

## 绝对路径和相对路径

Linux 的目录树从 `/` 开始。以 `/` 开头的路径叫绝对路径：

```text
/home/rudy/linux-practice
/etc/hosts
/var/log
```

不以 `/` 开头的路径叫相对路径：

```text
linux-practice
../Downloads
./notes.txt
```

你可以这样理解：

- 绝对路径：从整个系统的根目录开始找。
- 相对路径：从当前工作目录开始找。

## 几个特殊路径

| 写法 | 含义 |
| --- | --- |
| `/` | 根目录 |
| `.` | 当前目录 |
| `..` | 上一级目录 |
| `~` | 当前用户家目录 |
| `-` | 上一次所在目录，常用于 `cd -` |

试着运行：

```bash
cd ~
pwd
cd /
pwd
cd -
pwd
```

你会看到工作目录在不同位置之间切换。

## 使用 ls 查看目录

最常用的目录查看命令是 `ls`：

```bash
ls
```

如果想查看更详细的信息：

```bash
ls -l
```

如果想显示隐藏文件：

```bash
ls -a
```

两个选项可以合并：

```bash
ls -la
```

在 Linux 中，以 `.` 开头的文件或目录默认会被隐藏，例如 `.bashrc`、`.ssh`。

## 看懂 ls -l

运行：

```bash
ls -l
```

你会看到类似输出：

```text
drwxr-xr-x 2 rudy rudy 4096 Jul 24 10:00 notes
-rw-r--r-- 1 rudy rudy   18 Jul 24 10:01 hello.txt
```

从左到右大致表示：

- 文件类型和权限。
- 链接数量。
- 所有者。
- 所属用户组。
- 文件大小。
- 修改时间。
- 文件名。

现在你只需要先看懂第一列的开头：

- `d` 表示目录。
- `-` 表示普通文件。
- `l` 表示符号链接。

文件类型和权限会在后续章节详细讲。

## 建立练习目录

进入你的练习目录：

```bash
mkdir -p ~/linux-practice/path-demo
cd ~/linux-practice/path-demo
pwd
```

创建一些子目录：

```bash
mkdir docs src logs
ls
```

预期会看到：

```text
docs  logs  src
```

进入 `docs`，再回到上一级：

```bash
cd docs
pwd
cd ..
pwd
```

## 常见错误

### No such file or directory

如果你运行：

```bash
cd not-exist
```

会看到类似：

```text
bash: cd: not-exist: No such file or directory
```

说明当前目录下没有 `not-exist`。你可以先用 `ls` 检查名字是否写对。

### 路径中有空格

如果目录名叫 `my notes`，应该这样进入：

```bash
cd "my notes"
```

更简单的习惯是文件名尽量使用 `my-notes` 或 `my_notes`。

## 小结

你已经掌握了 Linux 中最基础的三件事：

- 用 `pwd` 确认自己在哪里。
- 用 `cd` 切换目录。
- 用 `ls` 查看目录内容。

这三条命令会贯穿整个 Linux 学习过程。任何时候不确定当前位置，都先运行 `pwd`。
