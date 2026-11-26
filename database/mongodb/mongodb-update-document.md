---
sidebar_position: 11
---

# MongoDB 更新文档

在使用 MongoDB 时，更新文档是一项非常常见的操作。无论是修改用户信息、更新文章内容还是其他数据，你都需要学会如何更新文档。MongoDB 提供了多种方法来更新文档，接下来就让我们一起学习这些方法吧！



## 更新文档的方法

### 使用 `update()` 方法

`update()` 方法用于更新集合中的文档。默认情况下，它只会更新匹配的第一个文档。

**语法：**

```javascript
db.COLLECTION_NAME.update(SELECTION_CRITERIA, UPDATED_DATA)
```

**示例：**

假设你有一个名为 `mycol` 的集合，其中包含以下文档：

```javascript
{ "_id" : ObjectId("5983548781331adf45ec5"), "title":"MongoDB Overview"}
{ "_id" : ObjectId("5983548781331adf45ec6"), "title":"NoSQL Overview"}
{ "_id" : ObjectId("5983548781331adf45ec7"), "title":"IoT Overview"}
```

你可以使用以下命令将标题为 "MongoDB Overview" 的文档的标题更新为 "New MongoDB Tutorial"：

```javascript
> db.mycol.update({'title':'MongoDB Overview'}, {$set:{'title':'New MongoDB Tutorial'}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
```

如果你想更新多个文档，可以设置 `multi` 参数为 `true`：

```javascript
> db.mycol.update({'title':'MongoDB Overview'}, {$set:{'title':'New MongoDB Tutorial'}}, {multi:true})
```



### 使用 `save()` 方法

`save()` 方法用于替换集合中的现有文档。它会用传递给 `save()` 方法的新文档替换现有文档。

**语法：**

```javascript
db.COLLECTION_NAME.save({_id:ObjectId(), NEW_DATA})
```

**示例：**

假设你想替换 `_id` 为 `507f191e810c19729de860ea` 的文档，可以使用以下命令：

```javascript
> db.mycol.save({
...   "_id" : ObjectId("507f191e810c19729de860ea"),
...   "title":"IoT New Topic",
...   "by":"IoT"
... })
WriteResult({
...   "nMatched" : 0,
...   "nUpserted" : 1,
...   "nModified" : 0,
...   "_id" : ObjectId("507f191e810c19729de860ea")
... })
```



### 使用 `findOneAndUpdate()` 方法

`findOneAndUpdate()` 方法用于更新匹配的第一个文档，并返回更新后的文档。

**语法：**

```javascript
db.COLLECTION_NAME.findOneAndUpdate(SELECTIOIN_CRITERIA, UPDATED_DATA)
```

**示例：**

假设你有一个名为 `empDetails` 的集合，其中包含以下文档：

```javascript
> db.empDetails.insertMany([
...   {
...     First_Name: "张",
...     Last_Name: "三",
...     Age: "26",
...     e_mail: "zhangsan@gmail.com",
...     phone: "13800138333"
...   },
...   {
...     First_Name: "李",
...     Last_Name: "四",
...     Age: "25",
...     e_mail: "lisi@gmail.com",
...     phone: "13800138444"
...   },
...   {
...     First_Name: "王",
...     Last_Name: "五",
...     Age: "24",
...     e_mail: "wangwu@gmail.com",
...     phone: "13800138555"
...   }
... ])
```

你可以使用以下命令更新名为 "五" 的文档的年龄和电子邮件：

```javascript
> db.empDetails.findOneAndUpdate(
...   {Last_Name: '五'},
...   { $set: { Age: '30', e_mail: 'wangwu555@gmail.com' }}
... )
{
...   "_id" : ObjectId("5dd6636870fb13eec3963bf5"),
...   "First_Name" : "王",
...   "Last_Name" : "五",
...   "Age" : "30",
...   "e_mail" : "wangwu555@gmail.com",
...   "phone" : "13800138555"
... }
```



### 使用 `updateOne()` 方法

`updateOne()` 方法用于更新匹配的第一个文档。

**语法：**

```javascript
db.COLLECTION_NAME.updateOne(<filter>, <update>)
```

**示例：**

```javascript
> db.empDetails.updateOne(
...   {Last_Name: '五'},
...   { $set: { Age: '30', e_mail: 'wangwu555@gmail.com' }}
... )
{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 0 }
```



### 使用 `updateMany()` 方法

`updateMany()` 方法用于更新所有匹配的文档。

**语法：**

```javascript
db.COLLECTION_NAME.updateMany(<filter>, <update>)
```

**示例：**

```javascript
> db.empDetails.updateMany(
...   {Age: { $gt: "25" }},
...   { $set: { Age: '00' }}
... )
{ "acknowledged" : true, "matchedCount" : 2, "modifiedCount" : 2 }
```

你可以通过 `find()` 方法查看更新后的文档：

```javascript
> db.empDetails.find()
```



## 小结

通过本文，你已经学会了如何在 MongoDB 中更新文档。你可以使用 `update()`、`save()`、`findOneAndUpdate()`、`updateOne()` 和 `updateMany()` 方法来更新单个或多个文档。这些方法各有特点，可以根据你的需求选择合适的方法。希望这些内容能帮助你更好地操作 MongoDB 数据库！
