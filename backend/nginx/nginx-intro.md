---
sidebar_position: 1
---

# Nginx 简介



## 什么是 Nginx

**Nginx （engine x）** 是一款轻量级的 Web 服务器 、反向代理服务器及电子邮件（IMAP/POP3）代理服务器。

![](https://static.getiot.tech/what-is-nginx.jpg)



## 什么是反向代理

反向代理（Reverse Proxy）方式是指以代理服务器来接受 Internet 上的连接请求，然后将请求转发给内部网络上的服务器，并将从服务器上得到的结果返回给 Internet 上请求连接的客户端，此时代理服务器对外就表现为一个反向代理服务器。

![](https://static.getiot.tech/reverse-proxy.png)



## 负载均衡

前面的例子中，代理仅仅指向一个服务器。但是，网站在实际运营过程中，大部分都是以集群的方式运行，这时需要使用负载均衡来分流。Nginx 也可以实现简单的负载均衡功能。

![](https://static.getiot.tech/nginx-load-balance.png)



