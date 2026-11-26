---
sidebar_position: 1
---

# MongoDB 简介

在现代应用程序中，数据的多样性和规模正以前所未有的速度增长。传统的关系型数据库（如 MySQL 或 PostgreSQL）虽然稳定可靠，但在处理结构灵活、变化频繁或大规模数据时往往显得不够灵活。这时，MongoDB 这样的 NoSQL 数据库便成为了一个更具吸引力的选择。

如果你是第一次接触 MongoDB，建议你从本章开始学习，我们将带你了解它的基本概念、优势、核心特性，以及它是如何在众多数据库中脱颖而出的。

![MongoDB Logo](https://static.getiot.tech/img/subjects/mongodb-logo-simple.png#center-200)



## 什么是 MongoDB？

**MongoDB** 是一个基于文档的 **NoSQL** 数据库，它使用 JSON 类似的 **BSON**（Binary JSON）格式来存储数据。由 MongoDB Inc. 维护开发，并基于服务器端 C++ 编写，MongoDB 旨在为现代应用程序提供高性能、高可用性和易扩展性的数据存储方案。

与传统的表格结构不同，MongoDB 中的数据以“文档”的形式保存在“集合”中。每个文档都可以拥有不同的结构，非常适合处理非结构化或半结构化的数据。

MongoDB 使用客户端-服务器架构。你可以通过 Mongo Shell、驱动程序（如 Python、Node.js、Java 等）或图形界面工具与 MongoDB 服务器通信。你还可以部署 Replica Sets 和 Sharding Cluster 来提升可用性和扩展性。



## MongoDB 的特性

MongoDB 拥有以下核心特性：

- **面向文档的数据模型**：使用类似 JSON 的文档格式（BSON），字段可以包含不同类型的值，甚至嵌套文档或数组。
- **高性能**：支持嵌入式数据模型和索引，能够提升读写性能。
- **高可用性**：通过内置的复制机制（Replica Sets）提供故障恢复能力。
- **水平扩展性**：支持分片（Sharding），可以轻松应对大规模数据的分布式存储。
- **丰富的查询语言**：支持过滤器、排序、聚合等复杂操作。



## MongoDB 与 RDBMS 的对比

以下表格展示了 MongoDB 和传统关系型数据库（RDBMS）在关键术语上的对应关系：

|    RDBMS 中的术语    |        MongoDB 中的术语        |
| :------------------: | :----------------------------: |
|  Database（数据库）  |       Database（数据库）       |
|     Table（表）      |       Collection（集合）       |
|  Tuple / Row（行）   | Document / Record（文档/记录） |
|     Column（列）     |         Field（字段）          |
| Table Join（表连接） | Embedded Documents（嵌入文档） |
| Primary Key（主键）  |           `_id` 字段           |

:::tip

MongoDB 中的 `_id` 字段是每个文档的唯一标识符，相当于关系型数据库中的主键。

:::



## 为什么选择 MongoDB？

你可能会问，为什么要选择 MongoDB 而不是传统数据库？原因包括：

- **灵活的数据模型**：你无需预先定义固定的表结构，可以轻松适应需求的变化。
- **快速开发**：结构自由让你更专注于业务逻辑，尤其适合敏捷开发。
- **横向扩展**：当数据量增长时，只需添加更多节点即可提升系统容量。
- **强大的生态系统**：MongoDB 提供丰富的工具，如 Compass（图形化管理工具）、Atlas（云托管平台）、Mongoose（Node.js ODM）等。



## MongoDB 的用途

MongoDB 广泛应用于多种场景，包括但不限于：

- 内容管理系统（CMS）
- 实时分析和日志存储
- 物联网（IoT）设备数据收集
- 社交平台、用户资料存储
- 电商网站的商品与订单数据处理



## MongoDB 文档示例

假设你正在为一个图书管理系统设计数据库。在 MongoDB 中，你可以创建一个名为 `books` 的集合，并插入如下文档：

```json showLineNumbers
{
  "_id": ObjectId("661e3e4c13d3f89f2babc123"),
  "title": "深入浅出 MongoDB",
  "author": {
    "name": "阿基米东",
    "email": "archimedong@getiot.tech"
  },
  "tags": ["数据库", "NoSQL", "教程"],
  "published_year": 2024,
  "available": true,
  "copies": 5
}
```

在这个文档中：

- `title` 是书名，类型是字符串；
- `author` 是一个嵌套的子文档，包含作者姓名和邮箱；
- `tags` 是一个字符串数组；
- `published_year` 是出版年份；
- `available` 表示是否可借阅，类型是布尔值；
- `copies` 表示库存数量，类型是整数。

你不需要事先定义集合的“结构”，每个文档可以有不同的字段，非常灵活。这正是 MongoDB 的优势之一。



## MongoDB 的局限性

虽然 MongoDB 有很多优势，但它也有一些需要注意的局限性：

- 不支持复杂的事务（MongoDB 4.0 之后已支持多文档事务，但仍不如传统 RDBMS 完善）。
- 不适合强一致性要求特别高的场景（如银行业务）。
- 数据模型过于灵活，可能导致维护成本增加，特别是团队协作时。



## 小结

MongoDB 是一个灵活、强大且现代化的 NoSQL 数据库，非常适合快速开发和大数据处理场景。在本章中，你了解了 MongoDB 的核心概念、关键特性以及它与传统数据库的不同。接下来，你将学习如何在本地或云端安装 MongoDB，并动手创建你的第一个数据库。
