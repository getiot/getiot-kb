---
sidebar_position: 8
---

# MongoDB 数据类型

在开始使用 MongoDB 存储和操作数据之前，了解其支持的数据类型是非常重要的。MongoDB 提供了丰富多样的数据类型来满足不同的存储需求。接下来，就让我们一起了解一下 MongoDB 中常用的数据类型吧！



## 常见数据类型

### 1. String（字符串）

这是 MongoDB 中最常用的数据类型，用于存储文本数据。MongoDB 中的字符串必须是 UTF-8 编码的有效字符串。

```javascript
{ "name": "MongoDB教程" }
```

### 2. Integer（整数）

用于存储数值。根据你的服务器配置，整数可以是 32 位或 64 位。

```javascript
{ "age": 25 }
```

### 3. Boolean（布尔值）

用于存储布尔值，即 `true` 或 `false`。

```javascript
{ "isAdmin": true }
```

### 4. Double（双精度浮点数）

用于存储浮点数。

```javascript
{ "score": 89.5 }
```

### 5. Arrays（数组）

用于存储数组或列表，可以包含多个值。

```javascript
{ "hobbies": ["阅读", "编程", "旅行"] }
```

### 6. Object（对象）

用于存储嵌套的文档。

```javascript
{ "address": { "city": "北京", "state": "北京市" } }
```

### 7. Null（空值）

用于存储空值。

```javascript
{ "middleName": null }
```

### 8. Date（日期）

用于存储日期和时间，格式为 UNIX 时间戳。你可以通过创建 `Date` 对象来指定日期和时间。

```javascript
{ "createdAt": new Date("2025-04-26T12:00:00Z") }
```

### 9. Object ID（对象 ID）

MongoDB 中的每个文档都有一个唯一的 `_id` 字段，通常存储为 `ObjectID` 类型。

```javascript
{ "_id": ObjectId("5f4c8b9e4f6a6b7b7b000001") }
```

### 10. Binary Data（二进制数据）

用于存储二进制数据。

```javascript
{ "fileContent": BinData(0, "c3RyaW5n") }
```

### 11. Code（代码）

用于存储 JavaScript 代码。

```javascript
{ "script": Code("function(x) { return x * x; }") }
```

### 12. Regular Expression（正则表达式）

用于存储正则表达式。

```javascript
{ "pattern": /^abc/ }
```



## 小结

通过本文，你已经了解了 MongoDB 中常见的数据类型，包括字符串、整数、布尔值、数组、对象、日期等。每种数据类型都有其特定的用途和存储方式。掌握这些数据类型将帮助你在设计 MongoDB 数据模型时更加灵活和高效。希望这些内容能帮助你更好地使用 MongoDB！
