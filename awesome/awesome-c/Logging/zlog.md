---
sidebar_position: 1
slug: /zlog
---

# zlog 使用教程

<!-- ![](https://static.getiot.tech/zlog-logo.png#center) -->

![](https://static.getiot.tech/zlog-cover.png#center-600)

## 简介

zlog 是一个高可靠性、高性能、线程安全、灵活、概念清晰的纯 C 日志函数库。

使用 zlog 来记录程序运行时产生的 log 日志的优势是 —— 可以通过改变配置文件从而改变该 log 日志的格式或输出文件，也就是我们可以根据需要，来决定日志的格式以及分类匹配，而不必通过改动程序代码。并且日志记录可以精确到微秒、不依赖其他任何库、每秒可以记录日志条数可达万条以上，以及在程序运行时输出 zlog 自己的日志和配置状态等优点。经测试，zlog 的写速度可达到 syslog 配合 rsyslogd 的数百倍。

虽然 zlog 的性能强劲，不过其目标一直是成为一个“简而精的日志函数库”。也就是说，zlog 不会直接支持网络输出或者写入数据库，也不会直接支持日志内容的过滤和解析，而仅仅是专门记录 log 日志功能的函数库。不过这并不意味着使用 zlog 无法实现网络输出、数据库写入，以及过滤等功能。你仍然可以通过集成其他软件（或者自己编写上层软件）来实现，因为在 zlog 的设计哲学中，zlog 始终是一个高效的日志库，而日志的输出和过滤等功能则属于应用程序。

如果你仍然希望直接使用这些特性，那么可以关注一下 rsyslog、zLogFabric、Logstash 等项目，它们包含了日志搜集、过滤、存储等功能。当然，为了达到这个目的，这些日志模块不仅仅是一个库，而是存在单独运行的进程。

代码仓库：[https://github.com/HardySimpson/zlog](https://github.com/HardySimpson/zlog)



## 安装

你可以在 zlog 的 [GitHub 主页](https://github.com/HardySimpson/zlog) 下载最新的 Release 版本，例如 zlog-1.2.15.tar.gz，下载后解压缩源码包。

```shell
$ tar -zxvf zlog-1.2.15.tar.gz
```

你也可以使用 git 直接克隆 zlog 仓库。

```bash
git clone https://github.com/HardySimpson/zlog.git
```

获取源码后，就可以切换到 zlog 源码目录，编译并安装到系统中。

```bash
$ cd zlog
$ make 
$ sudo make install
```

zlog 库的默认安装位置是 /usr/local/lib，头文件的安装位置是 /usr/local/include。

如果需要指定安装位置，那么可以手动设定安装路径的前缀，例如：

```bash
$ make PREFIX=/usr/local/
$ sudo make PREFIX=/usr/local/ install
```



## 接口说明

zlog 提供了两类接口，分别是 `zlog_xxx` 和 `dzlog_xxx` 接口。其中 dzlog 接口是忽略分类（zlog_category_t）的一组简单的 zlog 接口，它采用内置的一个默认分类，这个分类置于锁的保护下。

这里的 `xxx` 表示日志级别，在 zlog 日志库中，一共有 6 个默认的级别，分别是 `DEBUG`、`INFO`、`NOTICE`、`WARN`、`ERROR` 和 `FATAL`。

zlog 接口的六个等级接口函数：

```c showLineNumbers
zlog_fatal(cat, format, args...);
zlog_error(cat, format, args...);
zlog_warn(cat, format, args...);
zlog_notice(cat, format, args...);
zlog_info(cat, format, args...);
zlog_debug(cat, format, args...);
```

dzlog 接口的六个等级接口函数：

```c showLineNumbers
dzlog_fatal(format, args...);
dzlog_error(format, args...);
dzlog_warn(format, args...);
dzlog_notice(format, args...);
dzlog_info(format, args...);
dzlog_debug(format, args...);
```

dzlog 接口忽略了分类，意味着用户不需要操心创建、存储、传输 zlog_category_t 类型的变量。当然，你也可以在用 dzlog 接口的同时用一般的 zlog 接口函数，这样会更灵活。

除此之外，zlog 还提供了以字母 `v` 和 `h` 开头的另外两组接口 —— `vzlog_xxx` 和 `hzlog_xxx`。vzlog 和 zlog 接口函数根据 format 输出，就像 vprintf 和 printf 一样，而 hzlog 接口则使用 16 进制的形式表示。

当然，在使用 zlog 或 dzlog 接口之前，需要先调用 `zlog_init()` 或 `dzlog_init()` 进行初始化。初始化函数原型如下：

```c
int zlog_init(const char *config);
int dzlog_init(const char *confpath, const char *cname);
```

如果使用 `zlog_init()` 初始化，还需要调用 `zlog_get_category()` 接口设置分类名称，函数原型如下：

```c
zlog_category_t *zlog_get_category(const char *cname);
```

关于 zlog 日志库的更多接口函数及其详细使用，请仔细阅读 zlog.h 头文件。



## 应用示例

下面通过两个示例程序演示 zlog 和 dzlog 接口的使用，完整代码可以在 [getiot/linux-c](https://github.com/getiot/linux-c/tree/main/log/zlog) 仓库获取。

### zlog_example.c 程序

```c showLineNumbers title="zlog_example.c"
#include <stdio.h>
#include "zlog.h"

#define LOG_FILE "./zlog.conf"  //指定配置文件路径，若当前文件夹直接写名字

int main(int argc, char **argv)
{
    int rc;
    zlog_category_t *c;
    char hex_buf[32];

    rc = zlog_init(LOG_FILE);
    if (rc) {
        printf("init failed, please check file %s.\n", LOG_FILE);
        return -1;
    }

    c = zlog_get_category("GetIoT");
    if (!c) {
        printf("get cat fail\n");
        zlog_fini();
        return -2;
    }

    zlog_debug(c, "hello, zlog - debug");
    zlog_info(c, "hello, zlog - info");
    zlog_notice(c, "hello, zlog - notice");
    zlog_warn(c, "hello, zlog - warn");
    zlog_error(c, "hello, zlog - error");
    zlog_fatal(c, "hello, zlog - fatal");

    for (int i = 0; i < sizeof(hex_buf); i++) {
        hex_buf[i] = i;
    }
    hzlog_debug(c, hex_buf, sizeof(hex_buf));

    zlog_fini();

    return 0;
}
```

### dzlog_example.c 程序

```c showLineNumbers title="dzlog_example.c"
#include <stdio.h>
#include "zlog.h"

#define LOG_FILE "./zlog.conf" //指定配置文件路径，若当前文件夹直接写名字

int main(int argc, char **argv)
{
    int rc;
    char hex_buf[32];

    rc = dzlog_init(LOG_FILE, "GetIoT");
    if (rc) {
        printf("init failed, please check file %s.\n", LOG_FILE);
        return -1;
    }

    dzlog_debug("hello, zlog - debug");
    dzlog_info("hello, zlog - info");
    dzlog_notice("hello, zlog - notice");
    dzlog_warn("hello, zlog - warn");
    dzlog_error("hello, zlog - error");
    dzlog_fatal("hello, zlog - fatal");

    for (int i = 0; i < sizeof(hex_buf); i++) {
        hex_buf[i] = i;
    }
    hdzlog_debug(hex_buf, sizeof(hex_buf));

    zlog_fini();

    return 0;
}
```

### zlog.conf 文件

zlog 程序依赖配置文件 zlog.conf，一个简单的配置如下：

```ini showLineNumbers title="zlog.conf"
[formats]
simple = "%m%n"
[rules]
GetIoT.DEBUG    >stdout; simple
```



## 编译运行

如果你已经参照本文开头正确安装 zlog 库，那么可以直接使用 gcc 编译示例程序。例如：

```bash
$ gcc zlog_example.c -lzlog -o zlog_example
$ gcc dzlog_example.c -lzlog -o dzlog_example
```

此时可执行文件 zlog_example 和 dzlog_example 可能运行失败，原因是运行时无法找到 libzlog.so 动态库。解决办法是在环境变量 `LD_LIBRARY_PATH` 中设置链接库路径，如下：

```bash
export LD_LIBRARY_PATH=/usr/local/lib
```

现在，执行 zlog_example 或 dzlog_example 程序，输出内容如下：

```bash
hello, zlog - debug
hello, zlog - info
hello, zlog - notice
hello, zlog - warn
hello, zlog - error
hello, zlog - fatal

             0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F    0123456789ABCDEF
0000000001   00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f   ................
0000000002   10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f   ................
```

CMake 编译示例请参考 [getiot/linux-c](https://github.com/getiot/linux-c/tree/main/log/zlog) 仓库示例。



## 相关链接

- 项目官网：[https://hardysimpson.github.io/zlog/](https://hardysimpson.github.io/zlog/)
- 使用手册：[https://hardysimpson.github.io/zlog/UsersGuide-CN.html](https://hardysimpson.github.io/zlog/UsersGuide-CN.html)



