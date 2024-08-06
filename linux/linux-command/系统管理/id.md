---
sidebar_position: 37
slug: /id
---

# id 命令



## 介绍

**id** 命令可以显示真实有效的用户 ID（UID）和组 ID（GID）。UID 是对一个用户的单一身份标识。组 ID（GID）则对应多个 UID。id 命令已经默认预装在大多数 Linux 系统中。要使用它，只需要在你的控制台输入 id。

当我们想知道某个用户的 UID 和 GID 时，id 命令是非常有用的。一些程序可能需要 UID/GID 来运行。id 使我们更加容易地找出用户的 UID 以 GID 而不必在 /etc/group 文件中搜寻。

**语法**：

```bash
id [OPTION]... [USER]
```

**选项**：

- `-g`, `--group` ：显示用户所属群组的 ID。
- `-G`, `--groups` ：显示用户所属附加群组的 ID。
- `-n`, `--name` ：显示用户，所属群组或附加群组的名称。
- `-r`, `--real` ：显示实际 ID（UID）。
- `-u`, `--user` ：显示用户 ID（EUID）。
- `--help` ：显示帮助。
- `--version` ：显示版本信息。



## 示例

不带选项输入 id 会显示如下，结果会使用活跃用户：

```bash
$ id
uid=1000(rudy) gid=1000(rudy) groups=1000(rudy),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),120(lpadmin),131(lxd),132(sambashare)
```

解释：用户 rudy 的用户 ID 是 1000，组 ID 是 1000。同时，用户 rudy 是下面组的成员：

- rudy 组（GID = 1000）
- adm 组（GID = 4）
- cdrom 组（GID = 24）
- sudo 组（GID = 27）
- dip 组（GID = 30）
- plugdev 组（GID = 46）
- lpadmin 组（GID = 120）
- lxd 组（GID = 131）
- sambashare 组（GID = 132）

输出所有不同的组 ID（包括有效的、真实的和补充的）：

```bash
$ id -G
1000 4 24 27 30 46 120 131 132
```

结果只会显示 GID 号。你可以和 `/etc/group` 文件比较。下面是 `/etc/group` 文件的示例内容：

只输出有效的组 ID：

```bash
$ id -g
1000
```

输出特定用户信息：

```bash
$ id mysql
uid=112(mysql) gid=116(mysql) groups=116(mysql)
```

