---
sidebar_label: type 命令
sidebar_position: 38
slug: /type
---

# type 命令 - 显示命令类型



## 介绍

**type** 命令用于显示指定命令的类型，判断给出的指令是内部指令还是外部指令。

**语法**：

```shell
type [-afptP] NAME [NAME ...]
```

**选项**：

- `-a` ：显示所有包含名称为 NAME 的可执行文件的位置；包括别名、内建和函数。仅当 `-p` 选项没有使用时
- `-f` ：抑制 shell 函数查询
- `-P` ：为每个 NAME 名称惊醒 PATH 路径搜索（显示绝对路径），即使它是别名、内建或函数，并且返回将被执行的磁盘上文件的名称。
- `-p` ：返回将被执行的磁盘上文件的名称，或者当 `type -t NAME` 不返回 `file` 时，不返回任何值。
- `-t` ：返回下列词中的任何一个：
  - `alias` ：别名。
  - `keyword` ：关键字，Shell 保留字。
  - `function` ：函数，Shell 函数。
  - `builtin` ：内建命令，Shell 内建命令。
  - `file` ：文件，磁盘文件，外部命令。
  - `unfound` ：没有找到。

**参数**：NAME，将要解析的命令。



## 示例

别名

```shell
$ type ls
ls is aliased to `ls --color=tty'
```

Shell 关键字

```shell
$ type if
if is a shell keyword
```


Shell 内建命令

```shell
$ type cd
cd is a shell builtin
```

一般文件（外部命令）

```shell
$ type date
date is /bin/date
```

```shell
$ type mysql
mysql is /usr/bin/mysql
```

没有找到

```shell
$ type nginx
-bash: type: nginx: not found
```

