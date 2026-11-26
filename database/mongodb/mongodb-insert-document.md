---
sidebar_position: 9
---

# MongoDB 插入文档

在 MongoDB 中，插入文档是操作数据库时最常见的任务之一。无论是存储用户信息、文章内容还是其他数据，你都需要学会如何将数据插入到集合中。MongoDB 提供了多种方法来插入文档，接下来就让我们一起学习这些方法吧！



## 插入文档的方法

### 使用 `insert()` 方法

`insert()` 方法是最常用的插入文档的方法。你可以使用它向集合中插入单个或多个文档。

**语法：**

```javascript
db.COLLECTION_NAME.insert(document)
```

**示例：**

假设你想在 `users` 集合中插入一个文档，可以使用以下命令：

```javascript
> db.users.insert({
...   _id: ObjectId("507f191e810c19729de860ea"),
...   title: "MongoDB Overview",
...   description: "MongoDB is no sql database",
...   by: "getiot.tech",
...   url: "http://www.getiot.tech",
...   tags: ["mongodb", "database", "NoSQL"],
...   likes: 100
... })
WriteResult({ "nInserted" : 1 })
```

如果集合不存在，MongoDB 会自动创建它并插入文档。

在插入文档时，如果你没有指定 `_id` 字段，MongoDB 会自动生成一个唯一的 `ObjectId`。



### 使用 `insertOne()` 方法

如果你只需要插入一个文档，可以使用 `insertOne()` 方法。这个方法更简洁，返回的结果也更清晰。

**语法：**

```javascript
db.COLLECTION_NAME.insertOne(document)
```

**示例：**

```javascript
> db.empDetails.insertOne({
...   First_Name: "张",
...   Last_Name: "三",
...   Date_Of_Birth: "1995-09-26",
...   e_mail: "zhangsan@gmail.com",
...   phone: "13800138000"
... })
{
...   "acknowledged" : true,
...   "insertedId" : ObjectId("5dd62b4070fb13eec3963bea")
... }
```



### 使用 `insertMany()` 方法

如果你需要一次性插入多个文档，可以使用 `insertMany()` 方法。这个方法接受一个文档数组作为参数。

**示例：**

```javascript
> db.empDetails.insertMany([
...   {
...     First_Name: "张",
...     Last_Name: "三",
...     Date_Of_Birth: "1995-09-26",
...     e_mail: "zhangsan@gmail.com",
...     phone: "13800138333"
...   },
...   {
...     First_Name: "李",
...     Last_Name: "四",
...     Date_Of_Birth: "1996-02-16",
...     e_mail: "lisi@gmail.com",
...     phone: "13800138444"
...   },
...   {
...     First_Name: "王",
...     Last_Name: "五",
...     Date_Of_Birth: "1997-10-08",
...     e_mail: "wangwu@gmail.com",
...     phone: "13800138555"
...   }
... ])
{
...   "acknowledged" : true,
...   "insertedIds" : [
...     ObjectId("5dd631f270fb13eec3963bed"),
...     ObjectId("5dd631f270fb13eec3963bee"),
...     ObjectId("5dd631f270fb13eec3963bef")
...   ]
... }
```



### 使用 `save()` 方法

`save()` 方法也可以用来插入文档。如果你不指定 `_id`，它和 `insert()` 方法的作用相同。如果你指定了 `_id`，它会替换掉集合中具有相同 `_id` 的文档。

示例：

```javascript
> db.post.save({
...   title: "MongoDB Overview",
...   description: "MongoDB is no sql database",
...   by: "getiot",
...   url: "http://www.getiot.tech",
...   tags: ["mongodb", "database", "NoSQL"],
...   likes: 100
... })
WriteResult({ "nInserted" : 1 })
```



## 小结

通过本文，你已经学会了如何在 MongoDB 中插入文档。你可以使用 `insert()`、`insertOne()`、`insertMany()` 和 `save()` 方法来插入单个或多个文档。这些方法各有特点，可以根据你的需求选择合适的方法。希望这些内容能帮助你更好地操作 MongoDB 数据库！
