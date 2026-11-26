---
sidebar_position: 3
---

# Python 网络爬虫工具



了解网络爬虫的工作原理之后，可以知道网络爬虫所使用的技术主要分为「数据抓取」和「数据解析」两部分。



## 数据抓取

对于数据抓取，涉及的过程主要是模拟浏览器向服务器发送构造好的 http 请求，常见类型有：GET/POST。在爬虫实现上，除了 scrapy 框架之外，Python 有许多与此相关的库可供使用。其中，在数据抓取方面包括：

- **urllib**：Python3 内置的 urllib 模块，用于访问网络资源。用起来比较麻烦，缺少很多实用的高级功能。
- **urllib2**：Python2.7 的模块，在 python3.3 以后的版本不能再用 urllib2，使用 `urllib.request` 和 `urllib.error` 代替。 
- **urllib3**：urllib3 并非 python 的内置模块，需要额外安装。拥有高效的 http 连接池管理及 http 代理服务的功能库。
- **requests**：一个通过 urllib3 实现的很实用的 HTTP 客户端库，编写爬虫和测试服务器响应数据时经常会用到。可以说，Requests 完全满足如今网络的需求。
- **mechanize**：一个用于模拟浏览器的 python 模块，该模块在面对验证码问题时是个非常好的办法。
- **selenium**：一套完整的 web 应用程序测试系统，包含了测试的录制（seleniumIDE）、编写及运行（SeleniumRemoteControl）和测试的并行处理（SeleniumGrid）。它的核心 SeleniumCore 基于 JsUnit，完全由 JavaScript 编写，因此可以用于任何支持 JavaScript 的浏览器上。selenium 可以模拟真实浏览器，爬虫中主要用来解决 JavaScript 渲染问题。在 python 爬虫中主要用的是 selenium 的 Webdriver。
- **splinter**：Splinter 是用 Python 开发的一个开源 web 自动化测试的工具集，它可以帮你自动化浏览器的行为，比如浏览 URLs 并和页面进行交互。

其中 urllib2（urllib3）、requests、mechanize 用来获取 URL 对应的原始响应内容；而 selenium、splinter 通过加载浏览器驱动，获取浏览器渲染之后的响应内容，模拟程度更高。

考虑效率、当然能使用 urllib2（urllib3）、requests、mechanize 等解决的尽量不用 selenium、splinter，因为后者因需要加载浏览器而导致效率较低。



## 数据解析

在数据解析方面，相应的库包括：

- **xpath**：XPath（全称 XML Path Language，即 XML 路径语言）是一门在 XML 文档中查找信息的语言，XPath 可用来在 XML 文档中对元素和属性进行遍历。XPath 使用路径表达式来选取 XML 文档中的节点或者节点集。
- **lxml**：lxml 是 python 的一个解析库，支持 HTML 和 XML 的解析，支持 XPath 解析方式，而且解析效率很高。
- **beautifulsoup4**：Beautiful Soup 是一个可以从 HTML 或 XML 文件中提取数据的 python 库，它能够通过你喜欢的转换器实现惯用的文档导航、查找、修改。配合 Requests 使用，能大大提高爬虫效率。
- **re**：正则表达式模块。
- **pyquery**：PyQuery 是一个非常强大而且灵活的网页解析库，PyQuery 是 python 仿照 jQuery 的严格实现，语法与 jQuery 几乎完全相同。

对于数据解析，主要是从响应页面里提取所需的数据，常用的方法有：xpath 路径表达式、CSS 选择器、正则表达式等。其中，xpath 路径表达式、CSS 选择器主要用于提取结构化的数据，而正则表达式主要用于提取非结构化的数据。

