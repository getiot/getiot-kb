---
sidebar_position: 15
---

# MongoDB 记录排序

在处理 MongoDB 数据时，你可能需要对查询结果进行排序，以便更好地展示数据。MongoDB 提供了 `sort()` 方法来实现这一功能。通过指定排序字段和排序顺序，你可以轻松地对文档进行排序。接下来，就让我们一起学习如何在 MongoDB 中对记录进行排序吧！



## 使用 `sort()` 方法对记录排序

`sort()` 方法用于对查询结果中的文档进行排序。它接受一个文档作为参数，该文档包含要排序的字段及其排序顺序。在 MongoDB 中，`1` 表示升序排序，而 `-1` 表示降序排序。

**语法：**

```javascript
db.COLLECTION_NAME.find().sort({KEY: 1})
```

**示例：**

假设你有一个名为 `mycol` 的集合，其中包含以下文档：

```javascript
{ "_id" : ObjectId("507f191e810c19729de860e1"), "title": "MongoDB Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e2"), "title": "NoSQL Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e3"), "title": "IoT Overview" }
```

如果你想按 `title` 字段降序排列文档，可以使用以下命令：

```javascript
> db.mycol.find({}, {"title": 1, "_id": 0}).sort({"title": -1})
{ "title": "NoSQL Overview" }
{ "title": "MongoDB Overview" }
{ "title": "IoT Overview" }
```

请注意，如果你不指定排序顺序，`sort()` 方法默认会按升序排列文档。



## 小结

通过本文，你已经学会了如何在 MongoDB 中使用 `sort()` 方法对记录进行排序。你可以通过指定字段和排序顺序（升序或降序）来控制文档的排列顺序。希望这些内容能帮助你更好地操作 MongoDB 数据库！
