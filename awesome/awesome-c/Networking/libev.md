---
sidebar_position: 3
slug: /libev
---

# libev 使用教程



项目主页：[http://software.schmorp.de/pkg/libev.html](http://software.schmorp.de/pkg/libev.html)



## 目录结构

```bash
rudy@Latitude-3420:~/libev-4.33$ ls
aclocal.m4    configure     ev_epoll.c     ev_poll.c    libev.m4       README
autogen.sh    configure.ac  ev++.h         ev_port.c    LICENSE        Symbols.ev
Changes       depcomp       ev.h           ev_select.c  ltmain.sh      Symbols.event
compile       ev.3          ev_iouring.c   ev_vars.h    Makefile.am    TODO
config.guess  ev.c          ev_kqueue.c    ev_win32.c   Makefile.in
config.h.in   event.c       ev_linuxaio.c  ev_wrap.h    missing
config.sub    event.h       ev.pod         install-sh   mkinstalldirs
```



## 编译

### 一般编译

正常编译(正常编译一般不需要指定安装目录、编译器以及宿主环境，所以直接默认即可)：

```bash
./configure
make
sudo make install
```

至于使用时一个是加上头文件

```c
#include <ev.h>
```

一个就是链接时

```bash
-lev
```



### 交叉编译

交叉编译（confgure脚本配置交叉编译器、宿主环境、安装位置）：

```bash
CC=arm-linux-gcc ./configure --host=arm-linux --prefix=/home/zy/work_dir/libev-4.24/arm-linux-ev/
make
make install
```



```bash
CC=aarch64-buildroot-linux-gnu-gcc ./configure --host=arm-linux --prefix=/home/zy/work_dir/libev-4.24/arm-linux-ev/
make
make install
```



```bash
$ tree .libs/
.libs/
├── event.o
├── ev.o
├── libev.a
├── libev.la -> ../libev.la
├── libev.lai
├── libev.so -> libev.so.4.0.0
├── libev.so.4 -> libev.so.4.0.0
└── libev.so.4.0.0

0 directories, 8 files
```

