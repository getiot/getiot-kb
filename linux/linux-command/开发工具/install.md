---
sidebar_label: install 命令
sidebar_position: 8
slug: /install
---

# install 命令 - 复制并安装文件



## 介绍

**install** 命令用于安装、升级软件，或者备份数据。

install 的功能和 [cp](/linux-command/cp) 命令类似，都可以将文件/目录拷贝到指定的位置。不同的是，install 允许你控制目标文件的属性，通常用于程序的 Makefile 文件（执行 `make install`），使用它来将程序拷贝到目标（安装）目录。

**语法**：

```shell
install [OPTION]... [-T] SOURCE DEST
install [OPTION]... SOURCE... DIRECTORY
install [OPTION]... -t DIRECTORY SOURCE...
install [OPTION]... -d DIRECTORY...
```

**选项**：

- `--backup[=CONTROL]` ：为每个已存在的目的地文件进行备份。
- `-b` ：类似 `--backup`，但不接受任何参数。
- `-C`, `--compare` ：比较每对源文件和目标文件，在某些情况下，根本不修改目标
- `-d`, `--directory` ：所有参数都作为目录处理，而且会创建指定目录的所有主目录。
- `-D` ：创建 `DEST` 前的所有主目录，然后将 `SOURCE` 复制至 `DEST`，在第一种使用格式中有用。
- `-g`, `--group=GROUP` ：自行设定所属组，而不是进程目前的所属组。
- `-m`, `--mode=MODE` ：自行设定权限模式（类似 chmod），而不是 rwxr-xr-x。
- `-o`, `--owner=OWNER` ：自行设定所有者（只适用于 root 用户）。
- `-p`, `--preserve-timestamps` ：以 `SOURCE` 文件的访问/修改时间作为相应的目的地文件的时间属性。
- `-s`, `--strip` ：用 strip 命令删除 symbol table，只适用于第一和第二种使用格式。
- `-S`, `--suffix=SUFFIX` ：自行指定备份文件的后缀。
- `-t`, `--target-directory=DIRECTORY` ：将所有 `SOURCE` 参数复制到 `DIRECTORY` 中。
- `-T`, `--no-target-directory` ：将 `DEST` 视为普通文件。
- `-v`, `--verbose` ：处理每个文件/目录时显示详细信息（打印出名称）。
- `--help` ：显示帮助信息并退出。
- `--version` ：显示版本信息并退出。



## 示例

将 libfoo.so 安装到系统库路径

```shell
install libfoo.so /usr/local/lib
```

结果等效于

```shell
cp libfoo.so /usr/local/lib
```

将 hello 程序安装到指定目录，并创建该目录前的主目录

```shell
install -D hello /opt/bin/hello
```

结果等效于

```shell
mkdir -p /opt/bin && cp hello /opt/bin/hello
```

提示：以上所有 install 命令执行时都需要 root 权限（加上 sudo 执行）。

