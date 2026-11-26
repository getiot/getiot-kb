---
sidebar_position: 6
sidebar_label: MongoDB 创建数据库
---

# MongoDB 数据库创建与删除

在使用 MongoDB 时，创建和删除数据库是常见的操作。MongoDB 提供了非常简单直观的命令来完成这些任务。接下来，就让我们一起学习如何在 MongoDB 中创建和删除数据库吧！



## 创建数据库

在 MongoDB 中，创建数据库非常简单。你可以使用 `use` 命令来创建或切换到一个数据库。如果数据库不存在，MongoDB 会在你插入第一个文档时自动创建它。

#### 使用 `use` 命令

`use` 命令的基本语法如下：

```javascript
use DATABASE_NAME
```

例如，如果你想创建一个名为 `mydb` 的数据库，可以执行以下命令：

```javascript
> use mydb
switched to db mydb
```

此时，MongoDB 会切换到 `mydb` 数据库。如果该数据库不存在，MongoDB 会在你插入第一个文档时自动创建它。

#### 检查当前数据库

如果你想查看当前选择的数据库，可以使用以下命令：

```javascript
> db
mydb
```

#### 查看所有数据库

如果你想查看系统中所有的数据库，可以使用以下命令：

```javascript
> show dbs
local      0.78125GB
test       0.23012GB
```

注意：在 MongoDB 中，数据库只有在插入至少一个文档后才会真正被创建。因此，如果你刚刚创建了一个数据库，它可能不会立即出现在 `show dbs` 的输出中。

#### 示例

以下是一个完整的示例：

1. 创建一个名为 `mydb` 的数据库：

   ```javascript
   > use mydb
   switched to db mydb
   ```

2. 插入一个文档以确保数据库被创建：

   ```javascript
   > db.movie.insert({"name": "getiot"})
   ```

3. 查看所有数据库：

   ```javascript
   > show dbs
   local      0.78125GB
   mydb       0.23012GB
   test       0.23012GB
   ```



## 删除数据库

删除数据库也非常简单。你可以使用 `db.dropDatabase()` 命令来删除当前选择的数据库。

#### 使用 `db.dropDatabase()` 命令

`db.dropDatabase()` 命令的基本语法如下：

```javascript
db.dropDatabase()
```

如果你想删除一个名为 `mydb` 的数据库，可以执行以下命令：

```javascript
> use mydb
switched to db mydb
> db.dropDatabase()
{ "dropped" : "mydb", "ok" : 1 }
```

此时，`mydb` 数据库会被删除。

#### 示例

以下是一个完整的示例：

1. 查看所有数据库：

   ```javascript
   > show dbs
   local      0.78125GB
   mydb       0.23012GB
   test       0.23012GB
   ```

2. 删除 `mydb` 数据库：

   ```javascript
   > use mydb
   switched to db mydb
   > db.dropDatabase()
   { "dropped" : "mydb", "ok" : 1 }
   ```

3. 再次查看所有数据库：

   ```javascript
   > show dbs
   local      0.78125GB
   test       0.23012GB
   ```



## 小结

通过本文，你已经学会了如何在 MongoDB 中创建和删除数据库。使用 `use` 命令可以创建或切换到一个数据库，而 `db.dropDatabase()` 命令可以删除当前选择的数据库。需要注意的是，MongoDB 的数据库只有在插入至少一个文档后才会真正被创建。希望这些内容能帮助你快速掌握 MongoDB 的基本操作！
