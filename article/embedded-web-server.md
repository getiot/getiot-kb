---
sidebar_position: 23
slug: /embedded-web-server
---

# 常见的嵌入式 Web 服务器



本文介绍在嵌入式领域中常用的一些 Web 服务器（HTTP 服务器），包括 Lighttpd、Shttpd、Mongoose、Thttpd、Boa、Mini_httpd、Appweb、Goahead、Althttpd 等。

 

## Lighttpd

Lighttpd 是一个开源轻量级嵌入式 Web server，是提供一个专门针对高性能网站，安全、快速、兼容性好并且灵活的 Web server 环境。具有非常低的内存开销，CPU 占用率低，效能好，以及丰富的模块等特点。

Lighttpd 适合静态资源类的服务，比如图片、资源文件、静态 HTML 等等的应用，性能应该比较好，同时也适合简单的 CGI 应用的场合，Lighttpd 可以很方便的通过 fastcgi 支持 php。

项目网址：[https://www.lighttpd.net](https://www.lighttpd.net)



## Shttpd

Shttpd，开源。它是另一个轻量级的 Web server，具有比 thttpd 更丰富的功能特性，支持 CGI、SSL、cookie、MD5 认证，还能嵌入（embedded）到现有的软件里。最有意思的是不需要配置文件！由于 shttpd 可以轻松嵌入其他程序里，因此 shttpd 是较为理想的 Web server 开发原形，开发人员可以基于 shttpd 开发出自己的 Web server，官方网站上称 shttpd 如果使用 uclibc/dielibc（libc 的简化子集）则开销将非常非常低。

项目网址：[https://docs.huihoo.com/shttpd/](https://docs.huihoo.com/shttpd/)



## Mongoose

Mongoose Web Server 是一款易于使用的 web 服务器，它可以嵌入到其它应用程序中，为其提供 Web 接口。Mongoose 的前身是 shttpd，它完全开源和自由使用。Mongoose web 服务器的执行是自满足的，只需要使用 mongoose.c 和 mongoose.h 两个文件，它不依赖于任何其他服务。跨平台，支持 Windows、OS X 和 Linux，支持 CGI、SSL、SSI、Digest (MD5) 认证，WebSocket 和 WebDAV，支持断点续传和 URL 重写，基于 IP 的 ACL，支持 Windows 服务，支持 GET、POST、HEAD、PUT、DELETE 方法。

项目网址：[https://mongoose.ws](https://mongoose.ws)



## Thttpd

Thttpd 是一款比较精巧的开源 Web 服务器。它的初衷是提供一款简单、小巧、易移植、快速和安全的 HTTP 服务器。对于并发请求不使用 fork 来派生子进程处理，而是采用多路复用（Multiplex）技术来实现。

Thttpd 至少和主流的 Web server 一样快，在高负载下更快，因为其资源占用小的缘故。

Thttpd 还有一个较为引人注目的特点：基于 URL 的文件流量限制，这对于下载的流量控制而言是非常方便的。像 Apache 就必须使用插件实现，效率较 thttpd 低。Thttp 是开源的，采用 C 语言编写，得到广泛使用。

项目网址：[https://acme.com/software/thttpd/](https://acme.com/software/thttpd/)



## Boa

Boa 服务器是一个小巧高效的 Web 服务器，是一个运行于 Unix 或 Linux 下的，支持 CGI 的、适合于嵌入式系统的单任务的 http 服务器，源代码开放、性能高。

Boa 是一种非常小巧的 Web 服务器，其可执行代码只有大约 60KB 左右。作为一种单任务 Web 服务器，Boa 只能依次完成用户的请求，而不会 fork 出新的进程来处理并发连接请求。但 Boa 支持 CGI，能够为 CGI 程序 fork 出一个进程来执行。Boa 的设计目标是速度和安全。

项目网址：[http://www.boa.org](http://www.boa.org)



## Mini_httpd

Mini_httpd 是一个小型的 HTTP 服务器。开源，它的性能不强，但是它非常适合于中小访问量的站点。Mini_httpd 和 thttpd 都是 ACME Labs 开发的软件，功能没有 thttpd 强。

项目网址：[https://acme.com/software/mini_httpd/](https://acme.com/software/mini_httpd/)



## Appweb

Appweb 是下一代嵌入式 Web 服务器，它天生是为嵌入式开发的，它的最初设计理念就是安全。Appweb 是一个快速、低内存使用量、标准库、方便的服务器。与其它嵌入式 Web 服务器相比，Appweb 最大特点就是功能多和高度的安全保障。

项目网址：[https://www.embedthis.com/appweb/](https://www.embedthis.com/appweb/)



## GoAhead

GoAhead 是为嵌入式实时操作系统（RTOS）量身定制的 Web 服务器。GoAhead 是跨平台的服务器软件，可以稳定地运行在 Windows，Linux 和 Mac OS X 操作系统之上。GoAhead 开放源代码的，这意味着你可以随意修改 Web 服务器的功能。这款 Web 服务器非常小巧，它的 Win CE 版本编译后的大小还不到 60k，它的输出通常也是面向一些小屏幕设备。在性能方面，使用一颗 24MHz 的 68040 处理器，它的响应速度为 20 次/秒，使用 266MHz 的 Pentium 处理器可以达到 50 次/秒的响应速度。

项目网址：[https://www.embedthis.com/goahead/](https://www.embedthis.com/goahead/)



## Althttpd

Althttpd 是一个开源、简单的 Web 服务器，目标是实现一个简单、安全和低资源使用率的 Web 服务。如果你阅读它的源代码，就会发现这个项目只有一个 althttpd.c 源文件。

Althttpd 的作者是大名鼎鼎的 SQLite 作者 [D. Richard Hipp](https://en.wikipedia.org/wiki/D._Richard_Hipp)。

项目网址：[https://sqlite.org/althttpd/](https://sqlite.org/althttpd/doc/trunk/althttpd.md)

