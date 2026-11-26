---
sidebar_position: 7
sidebar_label: MongoDB 创建集合
---

# MongoDB 集合的创建与删除

在 MongoDB 中，集合（Collection）是存储数据的基本单位，类似于关系型数据库中的表。创建和删除集合是数据库操作中常见的任务。接下来，就让我们一起学习如何在 MongoDB 中创建和删除集合吧！



## 创建集合

MongoDB 提供了 `db.createCollection()` 方法来创建集合。不过，MongoDB 通常会在你插入第一个文档时自动创建集合，因此你并不需要手动创建集合。但如果你需要显式创建集合，可以按照以下步骤操作。

#### 使用 `db.createCollection()` 方法

`db.createCollection()` 方法的基本语法如下：

```javascript
db.createCollection(name, options)
```

- `name`：要创建的集合名称。
- `options`：（可选）一个文档，用于指定集合的配置。

`options` 参数是可选的，以下是一些常用的配置选项：

| 字段          | 类型    | 描述                                                         |
| ------------- | ------- | ------------------------------------------------------------ |
| `capped`      | Boolean | 如果为 `true`，则创建一个固定大小的集合（capped collection）。固定大小的集合在达到最大大小时会自动覆盖最旧的条目。如果指定 `true`，则必须同时指定 `size` 参数。 |
| `autoIndexId` | Boolean | 如果为 `true`，则自动在 `_id` 字段上创建索引。默认值为 `false`。 |
| `size`        | Number  | 指定固定大小集合的最大字节数。如果 `capped` 为 `true`，则必须指定此字段。 |
| `max`         | Number  | 指定固定大小集合中允许的最大文档数。                         |



#### 示例

**1、创建一个普通集合**

```javascript
> use test
switched to db test
> db.createCollection("mycollection")
{ "ok" : 1 }
```

你可以通过 `show collections` 命令查看创建的集合：

```javascript
> show collections
mycollection
system.indexes
```

**2、创建一个固定大小的集合**

```javascript
> db.createCollection("mycol", { capped: true, size: 6142800, max: 10000 })
{ "ok" : 1 }
```

:::warning

在 MongoDB 的某些版本中，`autoIndexId` 参数可能不被支持，因此可能会出现错误。如果你遇到类似问题，可以忽略该参数。

:::

**3、自动创建集合**

在 MongoDB 中，你不需要显式创建集合。当你插入第一个文档时，MongoDB 会自动创建集合：

```javascript
> db.getiot.insert({"name": "getiot.tech"})
WriteResult({ "nInserted" : 1 })
> show collections
mycol
mycollection
system.indexes
getiot
```



## 删除集合

删除集合也非常简单，你可以使用 `db.COLLECTION_NAME.drop()` 方法来删除指定的集合。

#### 使用 `db.COLLECTION_NAME.drop()` 方法

`drop()` 方法的基本语法如下：

```javascript
db.COLLECTION_NAME.drop()
```

如果集合删除成功，该方法会返回 `true`；否则返回 `false`。

#### 示例

**1、查看当前数据库中的集合**

```javascript
> use mydb
switched to db mydb
> show collections
mycol
mycollection
system.indexes
getiot
```

**2、删除名为 `mycollection` 的集合**

```javascript
> db.mycollection.drop()
true
```

**3、再次查看集合列表**

```javascript
> show collections
mycol
system.indexes
getiot
```



## 小结

通过本文，你已经学会了如何在 MongoDB 中创建和删除集合。`db.createCollection()` 方法可以显式创建集合，而 `db.COLLECTION_NAME.drop()` 方法可以删除指定的集合。需要注意的是，MongoDB 通常会在你插入第一个文档时自动创建集合，因此你并不需要手动创建集合。希望这些内容能帮助你更好地掌握 MongoDB 的集合操作！
