---
sidebar_position: 2
---

# SQLite 安装



SQLite 是一个跨平台的单机版关系型数据库，采用纯 C 语言编写，可在 UNIX（Linux、Mac OS-X、Android、iOS）和 Windows（Win32、WinCE、WinRT）中运行，经过适配甚至可以运行在 RTOS 嵌入式实时操作系统中。

本文主要介绍 SQLite 在各平台上的安装方式。由于 SQLite 是一个进程内的库，因此不需要复杂的安装和管理。



## Linux

在 Linux 系统中安装 SQLite 有两种方式，一种是通过包管理器安装，另一种是手动编译安装。

以 Ubuntu 系统为例，执行以下代码即可安装 SQLite。

```shell
sudo apt install sqlite3
```

这样安装的是 sqlite3，除此之外还有一个 sqlite 软件包（对应 2.x 版本）。

安装好以后，输入 `sqlite3` 进行测试：

```bash
SQLite version 3.31.1 2020-01-27 19:55:54
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite>
```



## Windows

- 访问 [SQLite 下载页面](https://www.sqlite.org/download.html)，从 Windows 区下载预编译的二进制文件（Precompiled Binaries）。
- 下载对应版本的 **sqlite-tools-win32-\*.zip** 和 **sqlite-dll-win32-\*.zip** 压缩文件。
- 在电脑中创建安装文件夹（如 C:\sqlite），并在该文件夹下解压前面下载的两个压缩文件，将得到 sqlite3.def、sqlite3.dll 和 sqlite3.exe 文件。
- 添加 C:\sqlite 到 PATH 环境变量。
- 打开 CMD 命令行终端，输入 `sqlite3` 命令进行测试。

```bash
SQLite version 3.31.1 2020-01-27 19:55:54
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite>
```



## 编译安装

在 [SQLite 下载页面](https://www.sqlite.org/download.html) 下载想要版本的源代码包 **sqlite-autoconf-\*.tar.gz**，例如 sqlite-autoconf-3390200.tar.gz。按照如下方法进行解压、配置、编译、安装。

```bash
$ tar zxvf sqlite-autoconf-3390200.tar.gz
$ cd sqlite-autoconf-3390200
$ ./configure --prefix=/usr/local
$ make
$ sudo make install
```

现在，你可以在 /usr/local 找到 SQLite3 对应的库和头文件。

- 头文件路径：usr/local/include/
- 库文件路径：/usr/local/lib/

包括动态库 libsqlite3.so 和静态库 libsqlite3.a。

