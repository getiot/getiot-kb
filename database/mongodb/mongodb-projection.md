---
sidebar_position: 13
---

# MongoDB 投影

在处理 MongoDB 数据时，有时你只需要查询文档中的部分字段，而不是整个文档的所有字段。这种操作称为“投影”（Projection）。投影可以帮助你优化查询性能，减少数据传输量。接下来，就让我们一起学习如何在 MongoDB 中使用投影吧！



## 使用 `find()` 方法进行投影

`find()` 方法不仅可以用来查询文档，还可以通过第二个参数指定需要返回的字段。在 MongoDB 中，当你执行 `find()` 方法时，默认会返回文档的所有字段。如果你只想返回部分字段，可以通过设置字段值为 `1`（显示该字段）或 `0`（隐藏该字段）来实现。

**语法：**

```javascript
db.COLLECTION_NAME.find({}, {KEY: 1})
```

**示例：**

假设你有一个名为 `mycol` 的集合，其中包含以下文档：

```javascript
{ "_id" : ObjectId("507f191e810c19729de860e1"), "title": "MongoDB Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e2"), "title": "NoSQL Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e3"), "title": "IoT Overview" }
```

如果你只想显示文档的 `title` 字段，可以使用以下命令：

```javascript
> db.mycol.find({}, {"title": 1, "_id": 0})
{ "title": "MongoDB Overview" }
{ "title": "NoSQL Overview" }
{ "title": "IoT Overview" }
```

请注意，`_id` 字段在执行 `find()` 方法时默认会显示。如果你不想显示 `_id` 字段，需要将其设置为 `0`。



## 小结

通过本文，你已经学会了如何在 MongoDB 中使用投影来查询部分字段。投影不仅可以帮助你优化查询性能，还可以减少不必要的数据传输。你可以通过在 `find()` 方法中设置字段值为 `1` 或 `0` 来控制返回的字段。希望这些内容能帮助你更好地使用 MongoDB！
