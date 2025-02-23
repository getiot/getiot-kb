---
sidebar_position: 23
---

# HTML URL 编码



## URL 简介

URL 是 Uniform Resource Locators 的缩写，中文名**统一资源定位符**。

URL 可以由字母组成，由网络协议和域名或 IP 地址等多个部分组成，如 "example.com"，或互联网协议（IP）地址：192.68.20.50。你可以简单直观地认为 URL 就是一个网页地址，我们通常都是通过 URL 来进入访问某个网站。

![](https://static.getiot.tech/uniform-resource-locator-example.jpg#center)



- Web 浏览器通过 URL 从 Web 服务器请求页面
- 当我们点击 HTML 页面中的某个链接时，对应的 `<a>` 标签指向万维网上的一个地址
- 一个统一资源定位符（URL）用于定位万维网上的文档



## URL 语法规则

```http
[scheme]://[host|domain][:port]/[path/filename]
```

下表是对 URL 各个组成部分的解释

| 段       | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| scheme   | 定义因特网服务的类型，简称协议类型，最常见的类型是 http      |
| host     | 定义域主机（http 的默认主机是 www）                          |
| domain   | 定义因特网域名，比如 getiot.tech                             |
| :port    | 定义主机上的端口号（http 的默认端口号是 80）                 |
| path     | 定义服务器上的路径（如果省略，则文档必须位于网站的根目录中） |
| filename | 定义文档/资源的名称                                          |



## 常见的 URL Scheme

下表列出了一些常见的 URL 协议类型

| Scheme | 访问               | 用于...                           |
| ------ | ------------------ | --------------------------------- |
| http   | 超文本传输协议     | 以 http:// 开头的普通网页，不加密 |
| https  | 安全超文本传输协议 | 安全网页，加密所有信息交换        |
| ftp    | 文件传输协议       | 用于将文件下载或上传至网站        |
| file   | 电脑上的文件       | 访问计算机上的文件                |



## URL 字符编码

URL 只能使用 [ASCII 字符集](/computerbasics/ascii) 来通过因特网进行发送，由于 URL 常常会包含 ASCII 集合之外的字符，URL 必须转换为有效的 ASCII 格式。

1. URL 编码使用 "%" 其后跟随两位的十六进制数来替换非 ASCII 字符
2. URL 不能包含空格
3. URL 编码通常使用 + 来替换空格



## URL 编码范例

| 字符 | URL 编码 |
| ---- | -------- |
| €    | %80      |
| £    | %A3      |
| ©    | %A9      |
| ®    | %AE      |
| À    | %C0      |
| Á    | %C1      |
| Â    | %C2      |
| Ã    | %C3      |
| Ä    | %C4      |
| Å    | %C5      |

如果想要了解详细的 URL 编码，可以访问我们的 [URL 编码参考手册](https://www.twle.cn/l/yufei/htmlref/html-ref-urlencode.html)



