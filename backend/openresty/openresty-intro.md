---
sidebar_position: 1
---

# OpenResty 简介



## OpenResty 是什么

OpenResty 是一个基于 Nginx 与 LuaJIT 的高性能 Web 平台，其内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态 Web 应用、Web 服务和动态网关。

OpenResty 通过汇聚各种设计精良的 Nginx 模块（主要由 OpenResty 团队自主开发），从而将 Nginx 有效地变成一个强大的通用 Web 应用平台。这样，Web 开发人员和系统工程师可以使用 Lua 脚本语言调动 Nginx 支持的各种 C 以及 Lua 模块，快速构造出足以胜任 10K 乃至 1000K 以上单机并发连接的高性能 Web 应用系统。

OpenResty 的目标是让你的Web服务直接跑在 Nginx 服务内部，充分利用 Nginx 的非阻塞 I/O 模型，不仅仅对 HTTP 客户端请求，甚至于对远程后端诸如 MySQL、PostgreSQL、Memcached 以及 Redis 等都进行一致的高性能响应。



## 名字由来

为什么要取 OpenResty 这个名字呢？

OpenResty 最早是顺应 OpenAPI 的潮流做的，所以 Open 取自“开放”之意，而 Resty 便是 REST 风格的意思。



## 项目起源

OpenResty 最早是雅虎中国的一个公司项目，起步于 2007 年 10 月。当时兴起了 OpenAPI 的热潮，用于满足各种 Web Service 的需求，就诞生了 OpenResty。在公司领导的支持下，最早的 OpenResty 实现从一开始就开源了。最初的定位是服务于公司外的开发者，像其他的 OpenAPI 那样，但后来越来越多地是为雅虎中国的搜索产品提供内部服务。这是第一代的 OpenResty，当时的想法是，提供一套抽象的 web service，能够让用户利用这些 web service 构造出新的符合他们具体业务需求的 Web Service 出来，所以有些“meta web service”的意味，包括数据模型、查询、安全策略都可以通过这种 meta web service 来表达和配置。同时这种 web service 也有意保持 REST 风格。与这种概念相对应的是纯 AJAX 的 web 应用，即 web 应用几乎都使用客户端 JavaScript 来编写，然后完全由 web service 让 web 应用“活”起来。用户把 .html, .js, .css, .jpg 等静态文件下载到 web browser 中，然后 js 开始运行，跨域请求雅虎提供的经过站长定制过的 web service，然后应用就可以运行起来。不过随着后来的发展，公司外的用户毕竟还是少数，于是应用的重点是为公司内部的其他团队提供 web service，比如雅虎中国的全能搜索产品，及其外围的一些产品。从那以后，开发的重点便放在了性能优化上面。

章亦春在加入淘宝数据部门的量子团队之后，决定对 OpenResty 进行重新设计和彻底重写，并把应用重点放在支持像量子统计这样的 web 产品上面，所以量子统计 3.0 开始也几乎完全是 web service 驱动的纯 AJAX 应用。这是第二代的 OpenResty，一般称之为 ngx_openresty，以便和第一代基于 Perl 和 Haskell 实现的 OpenResty 加以区别。章亦春和他的同事王晓哲一起设计了第二代的 OpenResty。在王晓哲的提议下，选择基于 nginx 和 lua 进行开发。

第二代的 OpenResty 致力于通过一系列 Nginx 模块，把 Nginx 扩展为全功能的 web 应用服务器。如今，用户可以基于 ngx_openresty 实现任何形式的 web service 或者传统的 web 应用。也就是说，Nginx 不再是一个简单的静态网页服务器，也不再是一个简单的反向代理了。



## 相关链接

- 官方网站：[https://openresty.org](https://openresty.org)
- GitHub 主页：[https://github.com/openresty](https://github.com/openresty)

