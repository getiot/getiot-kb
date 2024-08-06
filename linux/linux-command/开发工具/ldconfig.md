---
sidebar_position: 3
slug: /ldconfig
---

# ldconfig 命令



## 介绍

**ldconfig** 命令用于管理 Linux 系统的动态链接库。

执行 ldconfig 命令，默认会在 `/lib` 和 `/usr/lib` 目录以及动态库配置文件 `/etc/ld.so.conf` 内所列出的目录下，搜索出可共享的动态链接库（格式如 `lib*.so*`），进而创建出动态装入程序（ld.so）所需的连接和缓存文件。缓存文件默认为 `/etc/ld.so.cache`，此文件保存已排好序的动态链接库名字列表，为了让动态链接库为系统所共享，就需要运行动态链接库的管理命令 ldconfig。

ldconfig 通常在系统启动时运行，当用户安装了一个新的动态链接库时，就需要手动运行该命令，以更新缓存文件。ldconfig 所做操作只与程序运行时有关，和编译过程没有关系，因此编译时需要加 `-L` 指定库路径的还得加上。

**语法**：

```bash
ldconfig [-nNvXV] [-f conf] [-C cache] [-r root] directory...
ldconfig -l [-v] library...
ldconfig -p
```

**选项**：

- `-v` 或 `--verbose` ：用此选项时，ldconfig 将显示正在扫描的目录及搜索到的动态链接库，还有它所创建的连接的名字。
- `-n` ：用此选项时，ldconfig 仅扫描命令行指定的目录，不扫描默认目录（/lib、/usr/lib），也不扫描配置文件 /etc/ld.so.conf 所列的目录。
- `-N` ：指示 ldconfig 不重建缓存文件（/etc/ld.so.cache），若未用 `-X` 选项，ldconfig 照常更新文件的连接。
- `-X` ：指示 ldconfig 不更新文件的连接，若未用 `-N` 选项，则缓存文件正常更新。
- `-f CONF` ：指定动态链接库的配置文件为 CONF，系统默认为 /etc/ld.so.conf。
- `-C CACHE` ：指定生成的缓存文件为 CACHE，系统默认的是 /etc/ld.so.cache，此文件存放已排好序的可共享的动态链接库的列表。
- `-r ROOT` ：改变应用程序的根目录为 ROOT（是调用 chroot 函数实现的）。选择此项时，系统默认的配置文件 /etc/ld.so.conf，实际对应的为 ROOT/etc/ld.so.conf。如用 -r /usr/zzz 时，打开配置文件 /etc/ld.so.conf 时，实际打开的是 /usr/zzz/etc/ld.so.conf 文件。用此选项，可以大大增加动态链接库管理的灵活性。
- `-l` ：通常情况下，ldconfig 搜索动态链接库时将自动建立动态链接库的连接，选择此项时，将进入专家模式，需要手工设置连接，一般用户不用此项。
- `-p` 或 `--print-cache` ：指示 ldconfig 打印出当前缓存文件所保存的所有共享库的名字。
- `-c FORMAT` 或 `--format=FORMAT` ：指定缓存文件所使用的格式，共有三种：old（老格式），new（新格式）和 compat（兼容格式，此为默认格式）。
- `-V`, `--version` ：显示版本信息并退出。
- `-?` 或 `--help` 或 `--usage` ：显示帮助信息并退出。



## 示例

将 libfoo.so 共享库添加到系统标准库路径

```bash
$ cp /home/username/foo/libfoo.so /usr/lib
$ chmod 0755 /usr/lib/libfoo.so
```

更新共享库缓存列表

```bash
$ sudo ldconfig
```

更新完成后检查（从当前缓存文件的中搜索 libfoo.so 库）

```bash
$ ldconfig -p | grep foo
	libfoo.so (libc6) => /usr/lib/libfoo.so
```

