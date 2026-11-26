---
sidebar_position: 2
sidebar_label: 第一个 Shell 脚本
slug: /linux-first-shell-script
---

# Linux 第一个 Shell 脚本

这一篇我们写一个最小可用的 Shell 脚本。你会学到脚本文件、执行权限、运行方式和基本输出。

## 创建脚本文件

进入练习目录：

```bash
mkdir -p ~/linux-practice/shell-demo
cd ~/linux-practice/shell-demo
```

创建文件：

```bash
vim hello.sh
```

写入内容：

```bash
#!/usr/bin/env bash

echo "Hello, Linux"
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
```

保存退出。

如果你还不熟悉 Vim，可以先阅读 [Vim 文本编辑器](../command-line/linux-vim-text-editor.md)。

## 运行脚本

第一种方式是直接交给 Bash：

```bash
bash hello.sh
```

预期输出类似：

```text
Hello, Linux
Current user: rudy
Current directory: /home/rudy/linux-practice/shell-demo
```

第二种方式是先添加执行权限：

```bash
chmod u+x hello.sh
```

然后运行：

```bash
./hello.sh
```

这里的 `./` 表示当前目录。默认情况下，Shell 不会自动到当前目录查找命令，所以需要明确写出来。

## 为什么需要执行权限

脚本也是文件。如果你想把它当作程序运行，就需要执行权限。

查看权限：

```bash
ls -l hello.sh
```

你应该看到类似：

```text
-rwxr--r-- 1 rudy rudy 95 Jul 24 10:00 hello.sh
```

所有者权限中的 `x` 表示可以执行。

## 添加注释

Shell 脚本中的注释以 `#` 开头：

```bash
# Print current user
echo "Current user: $(whoami)"
```

第一行的 `#!` 是特殊的 shebang，不是普通注释。

## 使用变量

改写脚本：

```bash
#!/usr/bin/env bash

name="Linux"
echo "Hello, $name"
```

变量赋值时等号两边不要加空格。下面写法是错误的：

```bash
name = "Linux"
```

## 接收输入

可以使用 `read` 从键盘读取：

```bash
#!/usr/bin/env bash

read -r -p "Your name: " name
echo "Hello, $name"
```

`-r` 可以避免反斜杠被特殊处理，写脚本时通常建议加上。

## 常见错误

### Permission denied

如果运行：

```bash
./hello.sh
```

提示权限不足，执行：

```bash
chmod u+x hello.sh
```

### command not found

如果你输入：

```bash
hello.sh
```

提示找不到命令，改成：

```bash
./hello.sh
```

或把脚本所在目录加入 `PATH`。入门阶段先用 `./脚本名`。

## 小结

你已经完成第一个 Shell 脚本：

- 用 `.sh` 文件保存命令。
- 用 shebang 指定解释器。
- 用 `chmod u+x` 添加执行权限。
- 用 `./hello.sh` 运行当前目录脚本。
- 用 `echo` 输出，用 `read` 接收输入。

后面会继续介绍参数、退出状态和基本流程控制。
