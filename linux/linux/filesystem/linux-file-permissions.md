---
sidebar_position: 5
sidebar_label: 文件权限
slug: /linux-file-permissions
---

# Linux 文件权限：chmod、chown、umask

Linux 权限看起来像一串密码：

```text
-rwxr-xr--
```

其实它非常有规律。你只要理解“谁可以做什么”，就能读懂大部分权限问题。

## 三类对象

Linux 文件权限面向三类对象：

- 所有者 user：文件属于哪个用户。
- 所属组 group：文件属于哪个用户组。
- 其他人 others：不是所有者，也不在所属组中的其他用户。

运行：

```bash
ls -l
```

输出类似：

```text
-rw-r--r-- 1 rudy developers 120 Jul 24 10:00 notes.txt
```

这里 `rudy` 是所有者，`developers` 是所属组。

## rwx 分别代表什么

权限由三个字母表示：

| 权限 | 文件上的含义 | 目录上的含义 |
| --- | --- | --- |
| `r` | 读取文件内容 | 查看目录中的文件名 |
| `w` | 修改文件内容 | 在目录中创建、删除、重命名文件 |
| `x` | 执行文件 | 进入目录 |

目录的 `x` 很容易被忽略。如果一个目录没有执行权限，你即使能看到名字，也可能无法进入或访问其中的文件。

## 看懂权限字符串

```text
-rwxr-xr--
```

可以拆成四部分：

```text
- rwx r-x r--
```

- 第一位：文件类型，`-` 表示普通文件，`d` 表示目录，`l` 表示符号链接。
- 第一组三位：所有者权限。
- 第二组三位：所属组权限。
- 第三组三位：其他人权限。

上面的例子表示：

- 所有者可以读、写、执行。
- 所属组可以读、执行。
- 其他人只能读。

## chmod：修改权限

[chmod](/linux-command/chmod/) 可以修改权限。

符号写法比较直观：

```bash
chmod u+x script.sh
chmod g-w notes.txt
chmod o-r secret.txt
```

含义分别是：

- 给所有者增加执行权限。
- 去掉所属组的写权限。
- 去掉其他人的读权限。

也可以一次设置：

```bash
chmod u=rw,g=r,o= notes.txt
```

## 数字权限

数字权限把 `rwx` 映射成数字：

| 权限 | 数字 |
| --- | --- |
| `r` | 4 |
| `w` | 2 |
| `x` | 1 |

所以：

- `7` 等于 `rwx`。
- `6` 等于 `rw-`。
- `5` 等于 `r-x`。
- `4` 等于 `r--`。

常见权限：

```bash
chmod 644 notes.txt
chmod 755 script.sh
chmod 700 ~/.ssh
```

对应含义：

- `644`：所有者可读写，其他人只读。
- `755`：所有者可读写执行，其他人可读执行。
- `700`：只有所有者可读写执行。

## chown：修改所有者

[chown](/linux-command/chown/) 用于修改文件所有者和所属组：

```bash
sudo chown alice notes.txt
sudo chown alice:developers notes.txt
```

递归修改目录：

```bash
sudo chown -R alice:developers project
```

:::warning
递归修改所有者前，请先确认目录路径。不要在不了解后果时对 `/`、`/usr`、`/etc` 等系统目录执行递归 `chown`。
:::

## umask：默认权限

[umask](/linux-command/umask/) 决定新建文件和目录默认去掉哪些权限。

查看当前 umask：

```bash
umask
```

常见输出：

```text
0022
```

一般情况下：

- 新建文件默认不会带执行权限。
- 新建目录通常需要执行权限，否则无法进入。

你不需要一开始就精通 `umask`，但要知道它解释了“为什么新建文件默认是 644、目录默认是 755”这类现象。

## 常见权限问题

### 脚本不能执行

如果运行脚本时报错：

```text
Permission denied
```

先检查权限：

```bash
ls -l script.sh
```

如果没有 `x`，添加执行权限：

```bash
chmod u+x script.sh
```

### 目录能看到但进不去

检查目录权限：

```bash
ls -ld dirname
```

目录需要 `x` 权限才能进入。

## 小结

文件权限可以用一句话概括：谁能对这个文件做什么。

你需要掌握：

- `r`、`w`、`x` 在文件和目录上的含义。
- `chmod` 修改权限。
- `chown` 修改所有者。
- `umask` 影响默认权限。
- 遇到权限问题先用 `ls -l` 和 `ls -ld` 检查。
