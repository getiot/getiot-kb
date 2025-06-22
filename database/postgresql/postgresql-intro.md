---
sidebar_position: 1
slug: /postgresql-intro
authors: [luhuadong]
---

# PostgreSQL 简介

![PostgreSQL 数据库教程](https://static.getiot.tech/postgresql-tutorial-banner.webp#center)

**PostgreSQL** 是一款功能强大、开源、面向对象的关系型数据库系统，具有强大的可扩展性和可靠性，适合多种开发场景。无论你是准备构建企业级应用，还是开发个人项目，PostgreSQL 都能为你提供稳定而灵活的数据库解决方案。

在开始使用 PostgreSQL 数据库之前，了解它的历史背景和特性会帮助你更高效地掌握这门数据库技术。



## 什么是 PostgreSQL？

**PostgreSQL** 是一个开源的对象-关系型数据库管理系统（ORDBMS），它基于 POSTGRES 项目，最初由加州大学伯克利分校（University of California, Berkeley）开发。PostgreSQL 支持大部分 SQL 标准，并在此基础上增加了许多现代特性，比如复杂查询、外键、触发器、视图、事务完整性和多版本并发控制（MVCC）。

它广泛应用于金融、制造业、政府、地理信息系统（GIS）等领域。



## PostgreSQL 发展历程

如果你第一次听说 PostgreSQL 数据库，可能以为它是一个新的数据库，但其实它的历史最早可以追溯到 1986 年，比很多现代数据库还要悠久。

PostgreSQL 最初只是加州大学伯克利分校（UC Berkeley）计算机科学系发起的一个名为 **POSTGRES** 的研究项目，项目负责人是著名数据库专家 [Michael Stonebraker](https://en.wikipedia.org/wiki/Michael_Stonebraker) 教授。该项目旨在改进当时的 Ingres 数据库系统，并引入更多面向对象的特性和更强的事务处理能力。

下面是 PostgreSQL 项目的重要发展节点：

- **1986 年**：POSTGRES 项目启动，旨在探索新的数据库概念，如规则系统、对象继承等。
- **1989 年**：发布第一个 POSTGRES 原型系统。
- **1994 年**：项目重构为支持 SQL 查询语言，并更名为 **Postgres95**，增加了 SQL 支持、性能优化等改进。
- **1996 年**：Postgres95 更名为 **PostgreSQL**，从此成为一个正式的开源数据库项目。
- **1996 年以后**：PostgreSQL 社区逐步建立，吸引全球开发者参与，不断添加新特性和扩展插件。
- **2005 年以后**：PostgreSQL 在企业级场景中得到广泛应用，成为 MySQL 之外最受欢迎的开源数据库系统之一。
- **近年来**：PostgreSQL 已发展为支持并发控制（MVCC）、逻辑复制、JSON/JSONB 数据类型、并行查询等现代数据库特性的领先系统。

PostgreSQL 的发展离不开全球开源社区的支持。如今，每个新版本的发布都由 PostgreSQL 全球开发组（PostgreSQL Global Development Group）负责协调，同时也得到了企业（如 Red Hat、Microsoft、EDB 等）的大力支持。

它的名字中，“PostgreSQL” 保留了对 POSTGRES 项目的致敬，而 SQL 则强调了对标准查询语言的支持。你在日常交流中也可以简称为 **Postgres**。



## PostgreSQL 的特性

PostgreSQL 提供了以下一些关键特性，使其在众多数据库系统中脱颖而出：

- **开源免费**：你可以自由下载、使用和修改 PostgreSQL，无需支付许可费用。
- **跨平台支持**：支持各种操作系统，包括 Linux、Windows 和 macOS。
- **标准 SQL 支持**：兼容大多数 SQL 标准，支持复杂查询和联合（JOIN）操作。
- **多版本并发控制（MVCC）**：确保数据库的高并发性和一致性。
- **事务支持**：支持 ACID（原子性、一致性、隔离性、持久性）事务。
- **完整的数据类型支持**：内置如 `INTEGER`、`VARCHAR`、`BOOLEAN` 等数据类型，也支持用户自定义类型。
- **可扩展性强**：你可以添加自定义函数（使用 C/C++、PL/pgSQL、Python、Perl 等语言），并通过插件扩展其功能。
- **丰富的索引机制**：包括 B-tree、Hash、GIN、GiST 和 SP-GiST 等索引类型。
- **支持外键、视图、触发器、存储过程**：帮助你构建健壮的数据逻辑层。
- **高可靠性**：支持日志记录、故障恢复、并发控制等机制。



## PostgreSQL 的架构

PostgreSQL 的架构遵循典型的客户端-服务器模型。如下图所示：

```bash
                        +----------------------+
                        |        Client        |
                        |----------------------|
                        | psql / pgAdmin / ORM |
                        +----------+-----------+
                                   |
                                   v
                        +----------------------+
                        |   PostgreSQL Server  |
                        +----------+-----------+
                                   |
     +-----------------------------+-----------------------------+
     |                             |                             |
     v                             v                             v
+-------------+            +---------------+            +-----------------+
| Connection  | <--------> | Query Engine  | <--------> |  Storage Engine |
|  Manager    |            | (Parser,      |            | (Tables, Index, |
| (Postmaster)|            | Planner,      |            |   WAL files)    |
+-------------+            | Optimizer,    |            +-----------------+
                           | Executor)     |
                           +-------+-------+
                                   |
                                   v
                           +---------------+
                           | Transaction   |
                           |   Manager     |
                           |  (MVCC, Locks)|
                           +---------------+

```

📌 图示说明：

- **客户端（Client）**：你可以通过各种工具连接 PostgreSQL，例如 `psql` 命令行、pgAdmin 图形界面，或者使用程序代码（如 Python、Java、Node.js）与服务器通信。
- **服务器（Server）**：负责处理来自客户端的请求，并执行相应的数据库操作。
- **连接管理器（Connection Manager / Postmaster）**：负责接受来自客户端的连接请求，创建独立的后端进程或线程来处理每个连接。
- **查询引擎（Query Engine）**：包括 SQL 的解析器（Parser）、查询规划器（Planner）、优化器（Optimizer）以及执行器（Executor），负责将 SQL 转换为数据库内部操作。
- **事务管理器（Transaction Manager）**：处理事务的原子性、隔离性等特性，内部采用 MVCC（多版本并发控制）机制，并负责锁管理。
- **存储引擎（Storage Engine）**：实际负责数据的存储与读取，管理表、索引、写前日志（WAL）等物理文件。



## PostgreSQL 的优缺点

😃 选择 PostgreSQL 的理由有很多，以下是它的一些显著优点：

- 免费开源，社区活跃
- 高度稳定，适合生产环境
- 支持 NoSQL 特性（如 JSON、HSTORE）
- 高度可定制和可扩展
- 丰富的文档和开发工具支持

😟 尽管 PostgreSQL 功能强大，但它也存在一些不足：

- 相比某些专有数据库，学习曲线可能稍陡峭
- 默认配置下性能可能不如某些为特定场景优化过的数据库
- 对于大数据量下的写入密集型场景，调优工作较复杂



## PostgreSQL 应用场景

PostgreSQL 在多个领域都有广泛应用，包括但不限于：

- **Web 应用开发**：与 Python（Django）、Node.js、Ruby on Rails 等框架良好集成
- **地理信息系统（GIS）**：通过 PostGIS 插件增强空间数据支持
- **数据仓库**：支持复杂查询和大数据量分析
- **金融、电商系统**：需要事务一致性和高并发处理能力的系统



## 相关链接

- [PostgreSQL 项目官网](https://www.postgresql.org)
- [PostgreSQL 官方文档](https://wiki.postgresql.org)
- [PostgreSQL 代码仓库（GitHub）](https://github.com/postgres/postgres)
