---
sidebar_position: 16
---

# MongoDB 索引

在 MongoDB 中，索引是提高查询效率的关键工具。没有索引时，MongoDB 需要扫描集合中的每个文档来选择匹配查询语句的文档，这种全扫描非常低效，尤其是当数据量很大时。索引通过存储数据集中一小部分数据的易遍历结构，极大地提高了查询性能。接下来，就让我们一起学习如何在 MongoDB 中创建和管理索引吧！



## 创建索引

### 使用 `createIndex()` 方法

你可以使用 `createIndex()` 方法来创建索引。这个方法接受一个文档作为参数，该文档指定了要索引的字段及其排序顺序（升序或降序）。

**语法：**

```javascript
db.COLLECTION_NAME.createIndex({KEY: 1})
```

- `KEY`：要索引的字段名称。
- `1`：表示按升序排序。如果需要按降序排序，使用 `-1`。

**示例：**

假设你有一个名为 `mycol` 的集合，你可以按 `title` 字段创建升序索引：

```javascript
> db.mycol.createIndex({"title": 1})
{
	"createdCollectionAutomatically" : false,
	"numIndexesBefore" : 1,
	"numIndexesAfter" : 2,
	"ok" : 1
}
```

你也可以为多个字段创建复合索引：

```javascript
> db.mycol.createIndex({"title": 1, "description": -1})
```

### 索引选项

`createIndex()` 方法还接受一些可选参数，例如：

- `background`：在后台构建索引，避免阻塞其他数据库活动。默认值为 `false`。
- `unique`：创建唯一索引，确保索引字段的值唯一。默认值为 `false`。
- `name`：索引的名称。如果不指定，MongoDB 会自动生成。
- `sparse`：如果为 `true`，索引只引用包含指定字段的文档。默认值为 `false`。
- `expireAfterSeconds`：设置 TTL（生存时间），控制文档在集合中的保留时间。
- `weights`：用于文本索引，指定字段的权重。
- `default_language`：指定文本索引的语言，默认为英语。
- `language_override`：指定文档中包含的语言字段名称。



## 删除索引

### 使用 `dropIndex()` 方法

你可以使用 `dropIndex()` 方法删除特定的索引。

**语法：**

```javascript
db.COLLECTION_NAME.dropIndex({KEY: 1})
```

或者直接指定索引名称：

```javascript
db.COLLECTION_NAME.dropIndex("name_of_the_index")
```

**示例：**

```javascript
> db.mycol.dropIndex({"title": 1})
{
	"ok" : 0,
	"errmsg" : "can't find index with key: { title: 1.0 }",
	"code" : 27,
	"codeName" : "IndexNotFound"
}
```

### 使用 `dropIndexes()` 方法

你可以使用 `dropIndexes()` 方法删除集合中的所有索引。

**语法：**

```javascript
db.COLLECTION_NAME.dropIndexes()
```

**示例：**

```javascript
> db.mycol.dropIndexes()
{ "nIndexesWas" : 2, "ok" : 1 }
```



## 查看索引

### 使用 `getIndexes()` 方法

你可以使用 `getIndexes()` 方法查看集合中的所有索引。

**语法：**

```javascript
db.COLLECTION_NAME.getIndexes()
```

**示例：**

```javascript
> db.mycol.getIndexes()
[
	{
		"v" : 2,
		"key" : { "_id" : 1 },
		"name" : "_id_",
		"ns" : "test.mycol"
	},
	{
		"v" : 2,
		"key" : { "title" : 1, "description" : -1 },
		"name" : "title_1_description_-1",
		"ns" : "test.mycol"
	}
]
```



## 小结

通过本文，你已经学会了如何在 MongoDB 中创建、删除和查看索引。索引可以显著提高查询性能，尤其是在处理大量数据时。你可以通过 `createIndex()` 方法创建索引，并使用 `dropIndex()` 和 `dropIndexes()` 方法删除索引。希望这些内容能帮助你更好地优化 MongoDB 数据库的性能！
