---
sidebar_label: dirs 命令
sidebar_position: 6
slug: /dirs
---

# Linux dirs 命令 - 显示当前目录栈



## 介绍

**dirs** 命令用于显示当前记住的目录列表（目录栈）。通过 `pushd` 命令可以将目录存入列表中；`popd` 命令可用于遍历弹出列表。

所谓的目录栈（或目录堆栈），其实就是在内存中的一个列表，这个列表用于存放目录条目信息。

和 cd 命令一样，dirs、pushd、popd 命令也是 bash 的内建命令，因此无法使用 which 命令查找，只要登录到 bash，就可以使用这几个命令。

**语法**：

```bash
dirs [选项] [参数]
```

**选项**：

- `-c`：删除所有元素以清空目录栈
- `-l`：不打印与主目录相关的波浪号前缀的目录
- `-p`：每行一个条目打印目录栈
- `-v`：每行一个条目，以栈中位置为前缀打印目录栈

**参数**：

- `+N`：显示 dirs 不带选项启动时显示的目录列表左起中第 N 个目录，从零开始。
- `-N`：显示 dirs 不带选项启动时显示的目录列表右起中第 N 个目录，从零开始。

## 示例

显示当前的目录栈

```bash
$ dirs
~/workspace
```

显示当前的目录栈（不带波浪号前缀）

```bash
$ dirs -l
/home/rudy/workspace
```

使用 pushd 命令将指定目录（/usr/lib/fonts 和 /usr/share/fonts）压入目录栈中

```bash
$ pushd /usr/lib/fonts
/usr/lib/fonts ~
$ pushd /usr/share/fonts/
/usr/share/fonts /usr/lib/fonts ~
```

按条目显示目录列表

```bash
$ dirs -p -v
 0  /usr/share/fonts
 1  /usr/lib/fonts
 2  ~
```

在最近两个目录之间切换

```bash
$ pushd
```

注意：用 pushd 不加参数在最近的两个目录之间切换时，当前目录总是位于堆栈的最上面。

在多个目录之间切换，比如切换到 **~** 目录

```bash
$ pushd +2
```

从目录堆栈中删除目录（从堆栈顶端删除）

```bash
$ popd 
```

从目录堆栈中删除指定目录（删除堆栈中第1个目录）

```bash
$ popd +1
```

清空目录堆栈

```bash
$ dirs -c
```



