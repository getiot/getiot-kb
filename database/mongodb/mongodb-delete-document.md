---
sidebar_position: 12
---

# MongoDB 删除文档

在 MongoDB 中，删除文档是一项基本操作，用于移除集合中的数据。无论是删除单个文档还是多个文档，MongoDB 都提供了简单而强大的方法来完成这些任务。接下来，就让我们一起学习如何在 MongoDB 中删除文档吧！



## 删除文档的方法

### 使用 `remove()` 方法

`remove()` 方法用于从集合中删除文档。你可以通过指定删除条件来选择要删除的文档。

**语法：**

```javascript
db.COLLECTION_NAME.remove(DELETION_CRITERIA)
```

- `DELETION_CRITERIA`：（可选）删除条件，根据此条件删除文档。
- `justOne`：（可选）如果设置为 `true` 或 `1`，则只删除一个文档。

**示例：**

假设你有一个名为 `mycol` 的集合，其中包含以下文档：

```javascript
{ "_id" : ObjectId("507f191e810c19729de860e1"), "title": "MongoDB Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e2"), "title": "NoSQL Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e3"), "title": "IoT Overview" }
```

你可以使用以下命令删除标题为 "MongoDB Overview" 的文档：

```javascript
> db.mycol.remove({'title': 'MongoDB Overview'})
WriteResult({ "nRemoved" : 1 })
```

删除后，集合中的文档如下所示：

```javascript
{ "_id" : ObjectId("507f191e810c19729de860e2"), "title" : "NoSQL Overview" }
{ "_id" : ObjectId("507f191e810c19729de860e3"), "title" : "IoT Overview" }
```



### 只删除一个文档

如果你只想删除一个文档，可以将 `justOne` 参数设置为 `true` 或 `1`：

```javascript
> db.COLLECTION_NAME.remove(DELETION_CRITERIA, 1)
```

**示例：**

```javascript
> db.mycol.remove({'title': 'NoSQL Overview'}, 1)
WriteResult({ "nRemoved" : 1 })
```



### 删除所有文档

如果你想删除集合中的所有文档，可以不指定删除条件：

```javascript
> db.mycol.remove({})
WriteResult({ "nRemoved" : 2 })
```

这相当于 SQL 中的 `TRUNCATE` 命令，会清空整个集合。



## 小结

通过本文，你已经学会了如何在 MongoDB 中删除文档。你可以使用 `remove()` 方法来删除单个或多个文档，并通过指定删除条件来精确控制要删除的文档。希望这些内容能帮助你更好地操作 MongoDB 数据库！
