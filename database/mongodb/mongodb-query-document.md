---
sidebar_position: 10
---

# MongoDB 查询文档

在 MongoDB 中，查询文档是操作数据库时最常见的任务之一。无论是查找特定的数据，还是获取集合中的所有文档，你都需要学会如何使用查询方法。MongoDB 提供了多种查询方法，接下来就让我们一起学习这些方法吧！



## 查询文档的方法

### 使用 `find()` 方法

`find()` 方法是最基本的查询方法，用于从集合中检索文档。

**语法：**

```javascript
db.COLLECTION_NAME.find()
```

`find()` 方法默认会返回集合中的所有文档，但你可以通过传递查询条件来筛选特定的文档。

**示例：**

假设你已经创建了一个名为 `mycol` 的集合，并插入了以下文档：

```javascript
> db.mycol.insert([
...   {
...     title: "MongoDB Overview",
...     description: "MongoDB is no SQL database",
...     by: "getiot.tech",
...     url: "http://www.getiot.tech",
...     tags: ["mongodb", "database", "NoSQL"],
...     likes: 100
...   },
...   {
...     title: "NoSQL Database",
...     description: "NoSQL database doesn't have tables",
...     by: "getiot.tech",
...     url: "http://www.getiot.tech",
...     tags: ["mongodb", "database", "NoSQL"],
...     likes: 20,
...     comments: [
...       {
...         user: "user1",
...         message: "My first comment",
...         dateCreated: new Date(2024, 11, 10, 2, 35),
...         like: 0
...       }
...     ]
...   }
... ])
```

你可以使用以下命令查询所有文档：

```javascript
> db.mycol.find()
```



### 使用 `pretty()` 方法

`pretty()` 方法用于以更易读的格式显示查询结果。

**示例：**

```javascript
> db.mycol.find().pretty()
{
	"_id" : ObjectId("5dd4e2cc0821d3b44607534c"),
	"title" : "MongoDB Overview",
	"description" : "MongoDB is no SQL database",
	"by" : "getiot.tech",
	"url" : "http://www.getiot.tech",
	"tags" : [
		"mongodb",
		"database",
		"NoSQL"
	],
	"likes" : 100
}
{
	"_id" : ObjectId("5dd4e2cc0821d3b44607534d"),
	"title" : "NoSQL Database",
	"description" : "NoSQL database doesn't have tables",
	"by" : "getiot.tech",
	"url" : "http://www.getiot.tech",
	"tags" : [
		"mongodb",
		"database",
		"NoSQL"
	],
	"likes" : 20,
	"comments" : [
		{
			"user" : "user1",
			"message" : "My first comment",
			"dateCreated" : ISODate("2024-12-09T21:05:00Z"),
			"like" : 0
		}
	]
}
```



### 使用 `findOne()` 方法

`findOne()` 方法用于返回单个文档。如果没有找到匹配的文档，则返回 `null`。

**示例：**

```javascript
> db.mycol.findOne({title: "MongoDB Overview"})
{
	"_id" : ObjectId("5dd6542170fb13eec3963bf0"),
	"title" : "MongoDB Overview",
	"description" : "MongoDB is no SQL database",
	"by" : "getiot.tech",
	"url" : "http://www.getiot.tech",
	"tags" : [
		"mongodb",
		"database",
		"NoSQL"
	],
	"likes" : 100
}
```



### 条件查询

MongoDB 支持多种条件查询，类似于 SQL 中的 `WHERE` 子句。下面通过一些示例演示：

- **等于（`$eq`）**

  ```javascript
  > db.mycol.find({"by": "getiot.tech"}).pretty()
  ```

- **小于（`$lt`）**

  ```javascript
  > db.mycol.find({"likes": {$lt: 50}}).pretty()
  ```

- **小于等于（`$lte`）**

  ```javascript
  > db.mycol.find({"likes": {$lte: 50}}).pretty()
  ```

- **大于（`$gt`）**

  ```javascript
  > db.mycol.find({"likes": {$gt: 50}}).pretty()
  ```

- **大于等于（`$gte`）**

  ```javascript
  > db.mycol.find({"likes": {$gte: 50}}).pretty()
  ```

- **不等于（`$ne`）**

  ```javascript
  > db.mycol.find({"likes": {$ne: 50}}).pretty()
  ```

- **在数组中（`$in`）**

  ```javascript
  > db.mycol.find({"name": {$in: ["get", "iot", "tech"]}}).pretty()
  ```

- **不在数组中（`$nin`）**

  ```javascript
  > db.mycol.find({"name": {$nin: ["get", "iot"]}}).pretty()
  ```



### 使用 `AND` 和 `OR` 条件

`AND` 条件：

```javascript
> db.mycol.find({$and: [{"by": "getiot.tech"}, {"title": "MongoDB Overview"}]}).pretty()
```

`OR` 条件：

```javascript
> db.mycol.find({$or: [{"by": "getiot.tech"}, {"title": "MongoDB Overview"}]}).pretty()
```

使用 `NOT` 条件：

```javascript
> db.mycol.find({"Age": {$not: {$gt: "25"}}})
```



## 小结

通过本文，你已经学会了如何在 MongoDB 中查询文档。你可以使用 `find()`、`findOne()` 方法来查询单个或多个文档，并通过条件查询来筛选特定的数据。希望这些内容能帮助你更好地操作 MongoDB 数据库！
