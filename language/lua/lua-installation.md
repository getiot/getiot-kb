---
sidebar_position: 2
---

# Lua 安装

本文介绍 Lua 的安装方法，包括自行手动编译和通过包管理器直接安装预编译二进制包两种方式。此外，还会简单介绍在安装好 Lua 开发环境后如何开展 Lua 编程，类似于 Python 脚本语言，Lua 也提供了交互式编程和脚本式编程两种方式。



## 安装

### 手动编译安装

Lua 的安装很简单，首先从 [https://www.lua.org/ftp/](https://www.lua.org/ftp/) 下载源码，以 lua-5.4.3.tar.gz 为例。

```shell
curl -R -O http://www.lua.org/ftp/lua-5.4.3.tar.gz
```

解压缩 lua-5.4.3.tar.gz，并进入解压目录

```shell
tar zxvf lua-5.4.3.tar.gz
cd lua-5.4.3/
```

因为 Lua 解释器使用 ANSI C 语言编写，因此使用 make 即可编译

```shell
make all test
```

编译完成后，在 src 目录会生成两个可执行文件 lua 和 luac。其中 lua 是**解释器**（lua-interpreter），luac 是**编译器**（lua-compiler）。

执行 `make install` 进行安装（默认安装到 /usr/local 目录）

```shell
$ sudo make install
cd src && mkdir -p /usr/local/bin /usr/local/include /usr/local/lib /usr/local/man/man1 /usr/local/share/lua/5.4 /usr/local/lib/lua/5.4
cd src && install -p -m 0755 lua luac /usr/local/bin
cd src && install -p -m 0644 lua.h luaconf.h lualib.h lauxlib.h lua.hpp /usr/local/include
cd src && install -p -m 0644 liblua.a /usr/local/lib
cd doc && install -p -m 0644 lua.1 luac.1 /usr/local/man/man1
```

安装完成后，可执行如下命令检查版本，确认是否安装成功

```shell
$ lua -v
Lua 5.4.3  Copyright (C) 1994-2021 Lua.org, PUC-Rio
```



### 软件包安装

除了手动编译，在许多 Linux 发行版和 Mac 上还可以使用包管理器进行安装。

例如，Ubuntu 使用 apt 安装：

```shell
sudo apt install lua5.3
```

Mac 使用 homebrew 安装：

```shell
sudo brew install lua
```

不过这种方式安装的 Lua 版本不一定是最新的，对版本有要求的，建议还是采用手动编译安装的方式。



## 测试

### 交互式编程

在终端执行 lua 命令，可进入交互式编程模式，在命令行中输入 Lua 程序即可立即查看结果。

例如，打印 Hello World：

```shell
$ lua
Lua 5.4.3  Copyright (C) 1994-2021 Lua.org, PUC-Rio
> print("Hello, World!")
Hello, World!
```

输入 `os.exit()` 可退出交互模式。



### 脚本式编程

可以将上述 Lua 程序保存到名为 hello.lua 的脚本文件

```lua showLineNumbers title="hello.lua"
print("Hello, World!")
```

然后使用 lua 命令执行该脚本：

```bash
$ lua hello.lua
Hello, World!
```

