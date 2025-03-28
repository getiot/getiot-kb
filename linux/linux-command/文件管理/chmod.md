---
sidebar_label: chmod 命令
sidebar_position: 4
slug: /chmod
---

# Linux chmod 命令 - 改变文件权限



## 介绍

**chmod**（英文全拼：change mode）是 Linux 系统中用于改变文件权限的一个命令。对于文件或者目录的普通权限，共有 3 种，分别是 r（读取）、w（写入）和 x（执行）。chmod 是 Linux 系统中关于权限的重要命令之一，另外一个是 [`chown`](/linux-command/chown) 命令。

**语法**：

```bash
chmod [who] [operator] [permission] FILE...
chmod [OPTION]... OCTAL-MODE FILE...
```

**选项**：

- `-c`：若该文件权限确实已经更改，才显示其更改动作。
- `-f`：若该文件权限无法被更改也不要显示错误讯息。
- `-v`：显示权限变更的详细资料。
- `-R`：对目前目录下的所有文件与子目录进行相同的权限变更（即以递归的方式逐个变更）。

每个模式字符串都应该匹配如下格式：`[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=][0-7]+`。

其中，who 包含的选项及其含义：

- `u`：文件属主权限（Owner）
- `g`：属组用户权限（Group）
- `o`：其他用户权限（Other Users）
- `a`：所有用户（文件属主、属组用户及其他用户）

operator 包含的选项及其含义：

- `+`：增加权限
- `-`：取消权限
- `=`：设定权限

permission 包含的选项及其含义：

- `r`：读权限
- `w`：写权限
- `x`：执行权限
- `s`：文件属主和组 set-ID
- `t`：粘性位 *
- `l`：给文件加锁，使其他用户无法访问

另外，权限也可以使用“八进制模式”来描述，针对文件属主、属组用户及其他用户，均可用 rwx 表示，组成一个八进制数字。

![](https://static.getiot.tech/chmod-permission.jpg#center-600)

每个数字代表一种权限：

| r (read) | w (write) | x (execute) |    -     |
| :------: | :-------: | :---------: | :------: |
|  读权限  |  写权限   | 可执行权限  | 没有权限 |
|    4     |     2     |      1      |    0     |

这样就会产生 8 x 8 x 8 = 256 种权限组合，例如：

- `400` 文件属主可读 
- `200` 文件属主可写 
- `100` 文件属主可执行 
- `040` 属组用户可读 
- `020` 属组用户可写 
- `010` 属组用户可执行 
- `004` 其他用户可读 
- `002` 其他用户可写 
- `001` 其他用户可执行 
- `777` 所有用户可读可写可执行



## 示例

下面以文件 getiot 为例说明。

赋予文件属主执行权限：

```bash
chmod u+x getiot
```

赋予属组用户写权限：

```bash
chmod g+w getiot
```

赋予属组用户和其他用户执行权限：

```bash
chmod go+x getiot
```

收回所有用户的执行权限：

```bash
chmod a-x getiot
```

收回属组用户和其他用户的写权限：

```bash
chmod og-w getiot
```

将文件权限修改为 755：

```bash
chmod 755 getiot
```

将 /temp 目录下的所有文件权限修改为 755：

```bash
chmod -R 755 getiot
```

