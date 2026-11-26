---
sidebar_position: 2
---

# Python 网络爬虫原理



简单来说，网络爬虫就是自动抓取网页信息的代码，可以简单地将其理解为代替繁琐的复制、粘贴操作的手段。

爬虫的对象通常是公开访问的网页，例如新闻网站上的新闻标题、内容、作者、日期、阅读量等信息。

一个最简单的完整爬虫流程如下图所示：

![](https://static.getiot.tech/web-crawler-working-principle.png#center)

- 首先，从 URL 管理器中获取 URL 地址，也就是将要爬取的目标；
- 然后，下载该 URL 对应的 HTML 网页；
- 最后，解析该 HTML 网页内容，获取您关注的信息。

