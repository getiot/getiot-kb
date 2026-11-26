---
sidebar_position: 14
---

# MongoDB 限制记录数量

在使用 MongoDB 时，你可能需要限制查询结果中的记录数量，或者跳过某些记录。这在处理大量数据时非常有用，可以帮助你优化查询性能并提高用户体验。MongoDB 提供了 `limit()` 和 `skip()` 方法来实现这些功能。接下来，就让我们一起学习如何使用这些方法吧！



## 使用 `limit()` 方法限制记录数量

`limit()` 方法用于限制查询结果中的记录数量。它接受一个数字类型的参数，表示你希望显示的文档数量。

**语法：**

```javascript
db.COLLECTION_NAME.find().limit(NUMBER)
```

**示例：**

假设你有一个名为 `mycol` 的集合，其中包含以下文档：

```javascript
{ "_id" : ObjectId("507f191e810c19729de860e1"), "title": "MongoDB Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e2"), "title": "NoSQL Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e3"), "title": "IoT Overview" }
```

如果你只想显示前两条记录，可以使用以下命令：

```javascript
> db.mycol.find({}, {"title": 1, "_id": 0}).limit(2)
{ "title": "MongoDB Overview" }
{ "title": "NoSQL Overview" }
```

如果你不指定 `limit()` 方法中的数字参数，它将默认显示集合中的所有文档。



## 使用 `skip()` 方法跳过记录

除了 `limit()` 方法外，MongoDB 还提供了 `skip()` 方法，用于跳过指定数量的文档。`skip()` 方法也接受一个数字类型的参数，表示要跳过的文档数量。

**语法：**

```javascript
db.COLLECTION_NAME.find().limit(NUMBER).skip(NUMBER)
```

**示例：**

以下示例将跳过第一条记录，只显示第二条记录：

```javascript
> db.mycol.find({}, {"title": 1, "_id": 0}).limit(1).skip(1)
{ "title": "NoSQL Overview" }
```

请注意，`skip()` 方法的默认值为 `0`，表示不跳过任何记录。



## 小结

通过本文，你已经学会了如何在 MongoDB 中使用 `limit()` 和 `skip()` 方法来限制和跳过记录。`limit()` 方法用于限制查询结果中的记录数量，而 `skip()` 方法用于跳过指定数量的记录。这些方法在处理分页数据或优化查询时非常有用。希望这些内容能帮助你更好地操作 MongoDB 数据库！
