---
sidebar_position: 13
slug: /mongoose-web-server
---

# Mongoose 嵌入式 Web 服务器



![](https://static.getiot.tech/mongoose.png#center-400)

Mongoose 是一款易于使用的轻量级 Web 服务器，它专为需要联网的嵌入式设备而设计，可以嵌入到其它应用程序中，为其提供 Web 接口。自2004年以来，就被大量的开源产品或者商业产品所使用，它甚至已经运行在了空间站的设备中。Mongoose 使嵌入式网络编程更为快速、稳健和简单。

- 官方网站：[https://mongoose.ws](https://mongoose.ws)
- GitHub 仓库：[https://github.com/cesanta/mongoose](https://github.com/cesanta/mongoose)



## 功能特性

- 跨平台：支持 Linux/UNIX、MacOS、QNX、eCos、Windows、Android、iPhone、FreeRTOS、RT-Thread 等操作系统。
- 支持 CGI、SSL、SSI、Digest (MD5) 认证，WebSocket 和 WebDAV。
- 单线程、异步、基于简单事件的非阻塞内核的 API。
- 支持 PicoTCP 嵌入式 TCP/IP 协议栈 与 LWIP 嵌入式 TCP/IP 协议栈。
- 支持断点续传和 URL 重写。
- 基于 IP 的 ACL，支持 Windows 服务，支持 GET、POST、HEAD、PUT、DELETE 方法。
- 内置协议：
  - plain TCP, plain UDP, SSL/TLS (over TCP, one-way or two-way)
  - HTTP client, HTTP server
  - WebSocket client, WebSocket server
  - MQTT client, MQTT broker
  - CoAP client, CoAP server
  - DNS client, DNS server, async DNS resolver
- 源代码遵循 ISO C 和 ISO C++。
- 体积小，可执行文件只有 40k 左右。
- 集成简单：只需要将 mongoose.c 和 mongoose.h 移植到你的项目中。
- 提供 Python 和 C# 版本。
- 采用 MIT 授权协议。



## 应用案例

Mongoose 经常被用来在 WebSocket 中实现仪表盘和实时数据交换。

![](https://static.getiot.tech/mongoose-diagram.jpg#center)



## 更多资料

- [Mongoose Web Server](https://mongoose.ws/)
- [mongoose 论坛](http://forum.cesanta.com/index.php?p=/categories/mongoose)
- [安装](https://www.cesanta.com/products/binary)
- [API 文档](https://docs.cesanta.com/mongoose/dev/)
- [官方博客](https://blog.cesanta.com/)
- [mongoose github](https://github.com/cesanta/mongoose)
- [基于固件或云的解决方案](https://github.com/cesanta/mongoose-iot)
- [Mongoose MongoDB ODM](https://www.npmjs.com/package/mongoose)





## 参考

- [Cesanta - IoT Software Platform (ap-folio.com)](http://ces.ap-folio.com/index.html)
- [mongoose Web服务器 嵌入式 web服务器_abc-CSDN博客](https://blog.csdn.net/wowocpp/article/details/116206013)
- [安装 brew command not found_小龙在线-CSDN博客](https://blog.csdn.net/lilongsy/article/details/99589702)

