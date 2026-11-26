---
sidebar_position: 1
---

# Django 简介

![Django 简介](https://static.getiot.tech/django-logo.jpg#center)

**Django** 是一个使用 Python 编写的开源 Web 应用框架，它是一个非常全面的 Web 框架，被称为“完美主义者的 Web 框架”。



## Django 框架

大部分开发语言中都有 MVC 框架，MVC 的含义如下：

- M 表示 Model，主要用于对数据库层的封装；
- V 表示 View，用于向用户展示结果；
- C 表示 Controller，是核心，用于处理请求、获取数据、返回结果。

Django 在 MVC 框架的基础上进行改良，更关注模型（Model）、模板（Template）和视图（Views），这也被称为 MVT 框架。

- M 表示 Model，负责与数据库交互；
- V 表示 View，是核心，负责接收请求、获取数据、返回结果；
- T 表示 Template，负责呈现内容到浏览器。



## 功能特点

Django 的主要目的是简便、快速地开发数据库驱动的网络，强调代码复用，多个组件可以很方便地以“插件”的形式服务于整个框架。

总的来说，Django 具有如下特点：

- **ORM**（对象关系映射）：以 Python 类形式定义数据模型，ORM 将模型与关系数据库连接起来，可以得到一个非常容易使用的数据库 API，同时开发者也可以在 Django 中使用原始的 SQL 语句。
- **URL 分派**：Django 使用正则表达式匹配 URL，开发者可以设计任意的 URL，没有框架的特定限定。
- **模板系统**：使用 Django 强大且可扩展的模板语言可以将设计、内容及 Python 代码分隔开来，并且具有可继承性。
- **表单处理**：开发者不仅可以方便地生成各种表单模型，实现表单的有效性检验，还可以方便地从定义的模型实例生成相应的表单。
- **Cache 系统**：可以挂在内存缓冲或其他框架实现超级缓冲，从而实现所需要的粒度。
- **会话**（session）：用户登录与权限检查，可快速开发用户会话功能。
- **国际化**：Django 内置国际化系统，方便开发出多种语言的网站。
- **自动化的管理界面**：Django 自带一个 Admin site，类似于内容管理系统，开发者可以快速定制自己的后台管理系统。



## 应用案例

- [Disqus](https://disqus.com/)：为网络社区提供网站留言功能的平台。
- [Instagram](https://www.instagram.com/)：一款以图片分享为主的移动社交应用。
- [Spotify](https://www.spotify.com/)：一个正版流媒体音乐服务平台。
- [YouTube](https://www.youtube.com/)：一个知名的视频分享网站，国内称它为“油管”。
- [The Washington Post](https://www.washingtonpost.com/)：Django 最初就是为报纸网站而生的，包括《华盛顿邮报》在内的许多新闻媒体都在使用 Django。
- [BitBucket](https://bitbucket.org/)：一个基于 Web 的版本库托管服务。
- [DropBox](https://www.dropbox.com/)：一款基于 Web 的文件同步工具。
- [Eventbrite](https://www.eventbrite.com/)：一个在线活动策划服务平台。
- [Mozilla](https://www.mozilla.org/)：Mozilla 的支持网站和浏览器的所有附加组件都是由 Django 驱动的。
- [Pinterest](https://www.pinterest.com/)：一款以兴趣为基础的社交网络应用。



## 相关链接

- [Django 官网](https://www.djangoproject.com/)
- [Django 代码仓库](https://github.com/django/django)
- [Django Stars](https://djangostars.com/)

