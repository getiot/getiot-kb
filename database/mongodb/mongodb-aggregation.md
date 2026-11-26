---
sidebar_position: 17
---

# MongoDB 聚合

在处理 MongoDB 数据时，聚合操作可以帮助你对数据进行复杂的分析和计算。聚合操作可以对多条文档中的数据进行分组，并对分组后的数据执行各种操作，最终返回一个结果。这类似于 SQL 中的 `COUNT(*)` 和 `GROUP BY` 操作。接下来，就让我们一起学习 MongoDB 的聚合功能吧！



## 使用 `aggregate()` 方法

MongoDB 的聚合操作通过 `aggregate()` 方法实现。这个方法接受一个管道（pipeline）作为参数，管道由多个阶段（stage）组成，每个阶段对数据进行特定的操作。

**语法：**

```javascript
db.COLLECTION_NAME.aggregate(AGGREGATE_OPERATION)
```

**示例：**

假设你有一个名为 `mycol` 的集合，其中包含以下文档：

```javascript
{
   _id: ObjectId("7df78ad8902c"),
   title: "MongoDB Overview",
   description: "MongoDB is no sql database",
   by_user: "getiot.tech",
   url: "http://www.getiot.tech",
   tags: ["mongodb", "database", "NoSQL"],
   likes: 100
},
{
   _id: ObjectId("7df78ad8902d"),
   title: "NoSQL Overview",
   description: "No sql database is very fast",
   by_user: "getiot.tech",
   url: "http://www.getiot.tech",
   tags: ["mongodb", "database", "NoSQL"],
   likes: 10
},
{
   _id: ObjectId("7df78ad8902e"),
   title: "Neo4j Overview",
   description: "Neo4j is no sql database",
   by_user: "Neo4j",
   url: "http://www.neo4j.com",
   tags: ["neo4j", "database", "NoSQL"],
   likes: 750
}
```

如果你想统计每个用户发布的教程数量，可以使用以下聚合操作：

```javascript
> db.mycol.aggregate([{$group: {_id: "$by_user", num_tutorial: {$sum: 1}}}])
{ "_id" : "getiot.tech", "num_tutorial" : 2 }
{ "_id" : "Neo4j", "num_tutorial" : 1 }
```

在 SQL 中，这个操作等价于 `SELECT by_user, COUNT(*) FROM mycol GROUP BY by_user`。



## 聚合表达式

以下是一些常用的聚合表达式及其示例：

|   表达式    | 描述                                       | 示例                                                         |
| :---------: | ------------------------------------------ | ------------------------------------------------------------ |
|   `$sum`    | 对集合中的所有文档计算指定值的总和         | `db.mycol.aggregate([{$group: {_id: "$by_user", num_tutorial: {$sum: "$likes"}}}])` |
|   `$avg`    | 计算集合中所有给定值的平均值               | `db.mycol.aggregate([{$group: {_id: "$by_user", num_tutorial: {$avg: "$likes"}}}])` |
|   `$min`    | 获取集合中对应值的最小值                   | `db.mycol.aggregate([{$group: {_id: "$by_user", num_tutorial: {$min: "$likes"}}}])` |
|   `$max`    | 获取集合中对应值的最大值                   | `db.mycol.aggregate([{$group: {_id: "$by_user", num_tutorial: {$max: "$likes"}}}])` |
|   `$push`   | 将值插入到结果文档的数组中                 | `db.mycol.aggregate([{$group: {_id: "$by_user", url: {$push: "$url"}}}])` |
| `$addToSet` | 将值插入到结果文档的数组中，但不创建重复项 | `db.mycol.aggregate([{$group: {_id: "$by_user", url: {$addToSet: "$url"}}}])` |
|  `$first`   | 获取分组后的第一个文档                     | `db.mycol.aggregate([{$group: {_id: "$by_user", first_url: {$first: "$url"}}}])` |
|   `$last`   | 获取分组后的最后一个文档                   | `db.mycol.aggregate([{$group: {_id: "$by_user", last_url: {$last: "$url"}}}])` |



## 管道概念

在 UNIX 命令中，管道（pipeline）意味着可以对输入执行操作，并将输出用作下一个命令的输入。MongoDB 的聚合框架也支持这种管道概念。每个阶段将一组文档作为输入，并产生一组结果文档（或最终的结果 JSON 文档）。这些结果可以继续用作下一个阶段的输入。

聚合框架中的可能阶段包括：

- **`$project`**：用于从集合中选择特定字段。
- **`$match`**：用于过滤操作，减少传递给下一个阶段的文档数量。
- **`$group`**：执行实际的聚合操作。
- **`$sort`**：对文档进行排序。
- **`$skip`**：跳过给定数量的文档。
- **`$limit`**：限制处理的文档数量。
- **`$unwind`**：展开使用数组的文档，将数组中的每个元素转换为单独的文档。



## 小结

通过本文，你已经学会了如何在 MongoDB 中使用聚合操作。`aggregate()` 方法通过管道（pipeline）实现复杂的聚合操作，支持多种聚合表达式。希望这些内容能帮助你更好地处理和分析 MongoDB 中的数据！
