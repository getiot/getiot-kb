---
sidebar_position: 21
---

# 内容管理系统



本文收集一些好用且值得推荐的开源 CMS 内容管理系统。根据系统架构不同，可分为 **传统 CMS** 和 **无头 CMS** 两大类。后者的特点是仅包含内容管理的后台，没有现成的前台展示，前台需要用户自己实现。这样的好处是可以做到内容和展示完全分离，用户可以根据自己的喜好选择前端框架、接入 [静态站点生成器](/tools/static-site-generators) 或 APP，创建丰富的展示体验。



## 传统 CMS

CMS 是内容管理系统（Content management system）的英文简称，用于管理和发布包括文章、图片、商品等内容的系统。博客系统就是最常见的一种 CMS，作者可以登录管理后台编辑、发布文章，用户即可通过网页访问文章内容。



### WordPress

WordPress 是全球最流行的 CMS，它的市场占有率一直处于独占鳌头的地位（64.2%）。得益于其傻瓜式的安装、丰富的主题和插件，哪怕是在 CMS 领域之外，WordPress 依然有一席之地。据不完全统计，全世界正在运行的网站中大约有三分之一是基于 WordPress 搭建的。

官方网站：[https://wordpress.com](https://wordpress.com/)



### Joomla!

Joomla! 是和 WordPress 同时期开源的 PHP CMS 项目，目前是由 Open Source Matters 开源组织进行开发与支持，自 2012 年以来，Joomla 连续多年成为 CMS 评奖的冠军。

和 WordPress 不同，Joomla 更加灵活，但学习曲线也更陡峭。由于具有较强的通用性，再加上丰富多元的扩展，常用来搭建商业网站、个人博客、信息管理系统、Web 服务等。

官方网站：[https://www.joomla.org](https://www.joomla.org/)



### Drupal

Drupal 是由德赖斯·布伊泰尔特创立的自由开源内容管理系统，用 PHP 语言写成。在业界，Drupal 常被视为内容管理框架，而非一般意义上的内容管理系统。 整套平台把所有内容视为一个“节点”，背后由大量“模块” 控制其显示、修改、排列、分类等方式。

值得一提的是，Drupal 用户还可以使用 [DrupalGap](https://github.com/signalpoint/DrupalGap) 插件实现 APP 开发。

官方网站：[https://www.drupal.org](https://www.drupal.org/)



### Django-CMS

从名字可以看出，Django-CMS 是一款基于 Django 编写的企业级 CMS。Django-CMS 功能实用、安全可靠，支持拖拽上传图片，支持 Docker 部署，可轻松进行二次开发。常用于构建企业官网，比如 [国家地理](http://education.nationalgeographic.org/) 等网站就是基于 Django-CMS 开发而成。

官方网站：[https://www.django-cms.org](https://www.django-cms.org/)



### Halo

Halo 是一款由国人开发的现代化开源 CMS，采用 Spring Boot + Vue.js 编写而成。优势是可以轻松接入国内的云存储服务，而且文档、社区和操作界面都是中文的。

官方网站：[https://halo.run](https://halo.run/)



## 无头 CMS

无头 CMS（headless CMS）是一种没有显示功能的 CMS。在软件系统中，当我们说无头（headless）时，是指不存在显示/操作屏幕，或将显示/操作屏幕分开以便可以以其他方式操作/使用它们。例如，可以通过从 OS 等输入命令来启动和操作 Web 浏览器的方法。



### Wagtail

Wagtail 是一款基于 Django 框架实现的无头内容管理系统，它拥有清爽的 UI 和简洁易用的编辑器。独特的 StreamField 技术，可以让内容排版灵活又不失结构，再加上强大的多语言系统，让它在众多开源 CMS 中脱颖而出。

官方网站：[https://wagtail.org](https://wagtail.org/)



### Ghost

Ghost 是一款基于 Node.js 编写、功能强大的无头 CMS。它的强大之处在于提供了丰富、免费、可自定义的主题，用户可以自由搭配轻松建站。

专业的会员订阅和数据可视化功能，让内容创作者可以围绕内容，尝试发展商业化业务。除此之外，Ghost 还拥有先进的所见即所得编辑器。

官方网站：[https://ghost.org](https://ghost.org/)



### Strapi

Strapi 是一款完全免费、基于 JavaScript 构建的无头内容管理系统。它拥有开箱即用的 API 和友好的管理面板，自带权限管理、默认安全、SEO 友好等特点。目前已成为多家世界 500 强企业的首选 CMS。

Strapi 背后有商业公司支持，吃透了可以谋个远程全职。

官方网站：[https://strapi.io](https://strapi.io/)

