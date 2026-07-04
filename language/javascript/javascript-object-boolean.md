---
sidebar_position: 17
---

# JavaScript Boolean 对象



JavaScript 内置的 Boolean 对象，用于将非布尔值转换为布尔值（true 或者 false），即表示逻辑真和逻辑假。



## 创建 Boolean 对象

在 JavaScript 中，我们可以直接给变量赋值一个布尔值，例如：

```javascript showLineNumbers
var flag = true;
typeof flag  // boolean
```

和 Number 对象一样，这里的 `flag` 是原始类型的布尔变量，它本身没有属性和方法。不过，我们还是可以调用 Boolean 对象的属性和方法。

下面的代码定义了一个名为 myBoolean 的布尔对象：

```javascript showLineNumbers
var myBoolean = new Boolean();
```

如果布尔对象无初始值或者其值为 `0`、`-0`、`null`、`""`、`false`、`undefined`、`NaN`，那么对象的值为 `false`；否则，其值为 `true`（即使当变量值为字符串 "false" 时）。



