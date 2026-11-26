---
sidebar_position: 4
---

# 优秀 C 语言开源项目


这里收集 C 语言相关的优秀开源项目，包括构建系统、编译器、数据库、加密、网络库等。



## 标准库

- Bionic：谷歌为 Android 开发的 C 标准库。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](https://github.com/android/platform_bionic)
- dietlibc：标准 C 库，可能是最小的二进制文件。[GNU GPL2.1](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html)。[官网](http://www.fefe.de/dietlibc/)
- glibc：GNU C 库。一个 C 标准库的实现。 [GNU LGPL2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)。[官网](http://www.gnu.org/software/libc/)
- musl：标准 C 库，兼容 POSIX 2008 和 C11，为静态链接设计。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](http://www.musl-libc.org/)



## 数据库

- BerkeleyDB：一个高性能的嵌入式键值对数据库。[GNU AGPLv3](https://gnu.org/licenses/agpl.html)。[官网](http://www.oracle.com/us/products/database/berkeley-db/overview/index.html)
- Hiredis：一个极简的 Redis 客户端。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](https://github.com/redis/hiredis)
- LMDB：一个极快，极简的嵌入式键值对数据存储系统。[newOpenLDAP](http://directory.fsf.org/wiki/License:OpenLDAPv2.7)。[官网](http://symas.com/mdb/)
- MariaDB：一个强壮，可扩展和可靠的 SQL 服务器，设计来作为 MySQL 的替代品。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](https://mariadb.com/)
- mongo-c-driver：一个高性能的 MongoDB 客户端。[Apache2.0](http://directory.fsf.org/wiki/License:Apache2.0).[官网](https://github.com/mongodb/mongo-c-driver)
- PostgreSQL：一个强大的对象关系数据库系统。[PostgreSQL licence](http://opensource.org/licenses/postgresql)。[官网](http://www.postgresql.org/)
- recutils：一个工具和 C 库的集合，用于访问可编辑，纯文本的名为 recfiles 的数据库文件。[GNU GPL3](http://www.gnu.org/licenses/gpl.html) 或更高版本。[官网](https://www.gnu.org/software/recutils/)
- Redis：一个先进的键值对存储系统。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](http://redis.io/)
- sophia：一个现代，可嵌入的键值对数据库。[FreeBSD](http://directory.fsf.org/wiki?title=License:FreeBSD)。[官网](https://github.com/pmwkaa/sophia)
- SQLite：一个自包含，无服务器，零配置，支持事务的 SQL 数据库引擎，包括 C 接口。公开领域。[官网](http://www.sqlite.org/)
- [TDengine](https://github.com/taosdata/TDengine)：一个为物联网设计优化的开源时序数据库及大数据平台。AGPL-3.0，[官网](https://www.taosdata.com)
- UnQLite：一个自包含，无服务器，零配置，支持事务的 NoSQL 数据库引擎，包括 C 接口。[FreeBSD](http://directory.fsf.org/wiki?title=License:FreeBSD)。[官网](http://unqlite.org/)



## 网络编程

- asnlc：一个把 ASN.1 规范转换为 C 代码的编译器。[FreeBSD](http://directory.fsf.org/wiki?title=License:FreeBSD)。[官网](http://lionet.info/asn1c/compiler.html)
- czmq：一个 ZeroMQ 的高级绑定。[官网](https://github.com/zeromq/czmq)
- GNU adns：一个高级，易用，异步的 DNS 客户端和实用工具。[GNU GPL3](http://www.gnu.org/licenses/gpl.html) 及更高版本。[官网](https://gnu.org/software/adns/)
- GNU SASL：一个简单身份认证和安全层和一些常见 SASL 机制的实现。[GNU GPL3](http://www.gnu.org/licenses/gpl.html) 及更高版本。[官网](https://gnu.org/software/gsasl/)
- GnuTLS：一个安全通信库，实现了 SSL，TLS 和 DTLS。[GNU LGPL2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) 及更高版本。[官网](http://www.gnutls.org/)
- gumbo-parser：一个 C99 标准的 HTML5 解析库。[Apache2.0](http://directory.fsf.org/wiki/License:Apache2.0)。[官网](https://github.com/google/gumbo-parser)
- http-parser：一个 HTTP 请求回应解析器。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](https://github.com/nodejs/http-parser)
- ldns：一个简化 DNS 编程的库。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](http://www.nlnetlabs.nl/projects/ldns/index.html)
- libcurl：一个客户端的 URL 转换库，支持多种格式。[curl license](http://curl.haxx.se/docs/copyright.html)。[官网](http://curl.haxx.se/libcurl/)
- LibEtPan：一个邮件库，支持 IMAP，SMTP，POP 和 NNTP 网络协议。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](https://github.com/dinhviethoa/libetpan)
- libev：一个事件驱动库。[FreeBSD](http://directory.fsf.org/wiki?title=License:FreeBSD).[官网](http://software.schmorp.de/pkg/libev.html)
- [libevent](http://hao.importnew.com/libevent/)：一个在网络服务器中事件驱动库的可替代品。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](http://libevent.org/)
- libgss：通用安全服务。[GNU GPL3](http://www.gnu.org/licenses/gpl.html) 或更高版本。[官网](https://gnu.org/software/gss/)
- libhttpd：一个给应用或嵌入式设备添加基本 Web 服务器功能的库。[GNU GPL2](http://www.gnu.org/licenses/gpl.html)。[官网](http://www.hughes.com.au/products/libhttpd/)
- libhv：一个比libevent、libuv更易用的国产网络库，可用来开发 TCP/UDP/SSL/HTTP/WebSocket 客户端/服务端。[3-clause BSD](http://directory.fsf.org/wiki/License:BSD_3Clause)。[官网](https://github.com/ithewei/libhv)
- libidn：Stringprep，Punycode 和 IDNA 规范的实现。[GNU GPL3](http://www.gnu.org/licenses/gpl.html) 或更高版本。[官网](https://gnu.org/software/libidn/)
- libmicrohttpd：一个迷你库，可作为其他应用的一部分，让运行 HTTP 服务器变得简单。[GNU LGPL2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) 或更高版本。[官网](https://gnu.org/software/libmicrohttpd/)
- libsoup：一个 GNOME HTTP 客户端/服务器库，使用了 GObject。[GNU LGPL2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)。[官网](https://wiki.gnome.org/action/show/Projects/libsoup?action=show&redirect=LibSoup)
- lwan：一个实验性，可扩展，高性能的 HTTP 服务器。 [GNU GPL2.1](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html)。[官网](https://github.com/lpereira/lwan)
- [mongoose](http://hao.importnew.com/mongoose/)：基于 C 的嵌入式 Web 服务器。[GNU GPL2.1](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html)。[官网](https://github.com/cesanta/mongoose)
- nanomsg：一个基于 C 的 ZeroMQ 实现。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](https://github.com/nanomsg/nanomsg)
- onion：易于使用的 HTTP 服务器库。[Apache2.0](http://directory.fsf.org/wiki/License:Apache2.0)。[官网](https://github.com/davidmoreno/onion)
- OpenSSL：一个 SSL 和 TLS 协议的实现，还包括一个加密库。[Dual Licensed under the OpenSSL License and the SSLeay License](https://www.openssl.org/source/license.html)。[官网](https://www.openssl.org/)
- oSip：一个基于 C 的 SIO 实现，没有额外的依赖。[GNU LGPLv2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) 或更高版本。[官网](https://gnu.org/software/osip/)
- s2n：一个 C99 标准的 TLS/SSL 协议的实现，简单，快并且以安全优先。[Apache2.0](http://directory.fsf.org/wiki/License:Apache2.0)。[官网](https://github.com/awslabs/s2n)
- socket99：BSD 套接字 API 的 C99 封装。[ISC](http://directory.fsf.org/wiki/License:ISC)。[官网](https://github.com/silentbicycle/socket99)
- Tox：一个通信平台，被设计为 Skype 杀手。[GNU GPL3](http://www.gnu.org/licenses/gpl.html)。[官网](https://github.com/irungentoo/toxcore)
- twitc：一个与 Twitter OAuth API 交互的迷你 C 库。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](https://github.com/sinemetu1/twitc)



## 图形界面

- [lvgl](https://github.com/lvgl/lvgl) ：一个免费的开源图形库（GUI），也称为 LittlevGL，具有强大且易于使用的图形元素、美观的视觉效果，支持触摸屏操作，移植简单方便，适用于 MCU 级别的设备，支持各类输入输出接口与芯片，支持使用 GPU。



## JSON

- [cJSON](https://github.com/DaveGamble/cJSON)：一个 ANSI C 实现的超轻量级 JSON 解析器。MIT License。
- Jansson：一个编码，解码和处理 JSON 的 C 库。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](http://www.digip.org/jansson/)
- jsmn：一个极简的 JSON 解析器。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](http://zserge.com/jsmn.html)
- json-c：一个处理 JSON 的库。[Expat](http://directory.fsf.org/wiki/License:Expat)。[官网](https://github.com/json-c/json-c/wiki)
- WJElement：高级 JSON 处理库，支持 JSON Schema。任意版本的 LGPL。[官网](https://github.com/netmail-open/wjelement/)
- YAJL：一个很快的 JSON 流解析 C 库。[ISC](http://directory.fsf.org/wiki/License:ISC)。[官网](https://lloyd.github.io/yajl/)



## 实用工具库

一个“包罗万象”的类别，适用于不适合其他任何地方的任何内容。

- [libnfc](https://github.com/nfc-tools/libnfc) - Platform-independent Near-Field Communication library. [`LGPL-3.0-only`](https://spdx.org/licenses/LGPL-3.0-only.html)
- [libusb](https://libusb.info/) - Provides generic access to USB devices. [`LGPL-2.1-or-later`](https://spdx.org/licenses/LGPL-2.1-or-later.html)
- [zlog](http://hardysimpson.github.io/zlog/) - Reliable, pure C logging library. [`LGPL-2.1-only`](https://spdx.org/licenses/LGPL-2.1-only.html)



