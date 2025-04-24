---
sidebar_position: 37
slug: /database-management-tools
---

# 数据库管理工具



本文主要介绍几款常用的数据库管理软件（客户端），包括开源/免费的、商用收费的，其中有一些是专用于 MySQL 数据库的，例如 MySQL Workbench、phpMyAdmin，有一些是支持多种 SQL、NoSQL 数据库的，例如 Navicat、DBeaver 等。



## MySQL Workbench

MySQL Workbench 是官方提供的图形化管理工具，支持数据库的创建、设计、迁移、备份、导出和导入等功能，支持 Windows、Linux 和 macOS 等主流操作系统。MySQL Workbench 分为社区版和商业版，社区版完全免费，而商业版则是按年收费，相对于免费版，商业版扩展了很多新功能（重型功能）。

![](https://static.getiot.tech/MySQL_Workbench_Editor_General_Mac.png#center)

功能特点：

- MySQL 官方出品，稳定迭代，安全放心，不会因为免费，作者中途不维护了。
- 免费，不仅免费，而且功能齐全，可跟收费的 Navicat 一拼，免费中的王者。
- 跨平台，支持 Windows、Linux、macOS，随意切换。
- 完美支持所有版本的 MySQL，最奇怪的早期版本也支持，毕竟是官方出品。
- 支持各种收费软件才有的复杂功能：
  - 支持 ER 建模管理、正向工程、逆向功能、模式同步；
  - 支持大规模数据迁移；
  - 有数据仪表盘，可以显示服务器状态。

MySQL Workbench 的缺点是有点臃肿，内存占用比较大。

社区版下载地址：[https://dev.mysql.com/downloads/workbench/](https://dev.mysql.com/downloads/workbench/)



## phpMyadmin

phpMyAdmin 是一个以 PHP 为基础，以 Web-Base 方式架构在网站主机上的 MySQL 的数据库管理工具。也就是说，它是一个跨平台在线版 MySQL 管理工具，用户可以通过网页界面管理 MySQL 数据库，非常方便易用，并且完全免费，因此成为同类软件中最受欢迎的工具之一。

![](https://static.getiot.tech/phpmyadmin.png#center)

功能特点：

- phpMyadmin 使用 PHP 语言开发，因此它可以直接部署在服务器上，在任何设备上都可以直接通过浏览器访问 phpMyadmin 来对你的 MySQL 数据库进行维护。
- 真正的跨平台，支持中文，操作逻辑迭代了无数代，上手及其容易。
- 关键还是免费的。

phpMyadmin 的缺点应该是只支持 MySQL 数据库吧。

软件下载地址：[https://www.phpmyadmin.net/downloads/](https://www.phpmyadmin.net/downloads/)



## Navicat

Navicat 可以说是付费软件中的霸主，之所以它能有这样的占有率，完全是因为在数据库管理软中使用的所有功能，它做到了极致。

![](https://static.getiot.tech/Navicat.png#center)

功能特点：

- 付费
- 跨平台
- 稳定
- 重型功能
- 有中文版

Navicat 的缺点是需要付费才能使用，不过你可以尝试申请 JetBrains 的免费账号。

软件下载地址：[https://www.navicat.com](https://www.navicat.com)



## DBeaver

DBeaver 是一款非常有名的通用数据库管理软件，基于 Java 开发，支持目前几乎所有的主流数据库，包括 MySQL、PostgreSQL、Oracle、DB2 等（只要具有 JDBC 驱动即可），可以轻松查看数据库目录结构、导入导出数据库及执行相关脚本操作，对于管理 MySQL 数据库来说，也是一个非常不错的选择。

![](https://static.getiot.tech/DBeaver.png#center)

DBeaver 也分为社区版和专业版，社区版免费，支持主流的关系型数据库，连 Hive 都支持。专业版除了支持关系型数据库外，还支持非关系型数据库，比如 MongoDB、redis等等。

功能特点：

- 免费
- 跨平台
- 功能大合集式
- 多数据库
- 有中文版

软件下载地址：[https://dbeaver.io](https://dbeaver.io)



## Sequel Pro

Sequel Pro 是一款高颜值的 MySQL 数据库管理工具，界面简洁易用，可以执行所有基本任务，例如添加、修改、删除、浏览、过滤数据库、表、记录，以及执行查询等功能。Sequel Pro 是完全免费，不过目前仅支持 macOS 平台，如果你日常主要使用的是 macOS 系统，那么将它作为首选的 MySQL 客户端工具。

![](https://static.getiot.tech/Sequel_Pro.png#center)

功能特点：

- 支持所有版本的 MySQL 服务器
- 界面非常的简洁，很容易上手
- 目前只支持 macOS 平台

软件下载地址：[https://sequelpro.com](https://sequelpro.com)

GitHub 地址：[https://github.com/sequelpro/sequelpro](https://github.com/sequelpro/sequelpro)



## HeidiSQL

HeidiSQL 是一款轻量级免费的 MySQL 客户端工具，可用于处理 MySQL 数据库，其中包括浏览/编辑数据、创建/修改表、管理用户权限和其他任务，功能比较齐全。如果你日常主要使用的是 Windows 系统，那么选择 HeidiSQL 作为 Mysql 客户端会是一个非常不错的选择。

![](https://static.getiot.tech/HeidiSQL.png#center)

功能特点：

- 安装包非常小，界面操作简单，很容易上手
- 提供免安装操作，不必安装在硬盘上，打开程序可以直接使用
- 目前只支持 Windows 平台

软件下载地址：[https://www.heidisql.com](https://www.heidisql.com)

GitHub 地址：[https://github.com/HeidiSQL/HeidiSQL](https://github.com/HeidiSQL/HeidiSQL)

