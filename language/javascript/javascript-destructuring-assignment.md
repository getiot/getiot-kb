---
sidebar_position: 24
---

# JavaScript 解构赋值



JavaScript 提供了一种「解构赋值」的语法，用于将属性/值从对象/数组中取出，赋值给其他变量。这是 ES6 新增的特性，目的是为对象和数组提供一种简单的定义一个特定的数据组的方法。

下面通过几个示例来讲解如何使用 JavaScript 解构赋值的特性。



## 解构示例

### 示例 1

假设有一个数组 arr，如果我们想获取数组的前两项数据，可以直接在表达式左边使用方括号提取。如下：

```javascript showLineNumbers
var arr = [1, 2, 3, 4, 5];
var [a, b] = arr;
console.log(a);  // 1
console.log(b);  // 2
```

当然，我们也可以提取一项，或者更多项。例如：

```javascript showLineNumbers
var [a] = arr;   // a = 1
var [a, b, c, d, e] = arr;
```



### 示例 2

上述例子扩展一下，现在我们想提取数组的剩余项，该怎么办？

```javascript showLineNumbers
var arr = [1, 2, 3, 4, 5];
var a, b, rest;

[a, b, ...rest] = arr;
console.log(a);    // 1
console.log(b);    // 2
console.log(rest); // [3, 4, 5]
```

当然，也可以直接提取剩余项，例如：

```javascript showLineNumbers
[...rest] = arr;
console.log(rest); // [1, 2, 3, 4, 5]
```



### 示例 3

如果是对象，也可以进行解构赋值。例如：

```javascript showLineNumbers
var obj = { a: 10, b: 20 };
var a, b;

({ a, b } = obj);
console.log(a);  // 10
console.log(b);  // 20
```

同样，可以提取剩余项，例如：

```javascript showLineNumbers
var obj = {a: 10, b: 20, c: 30, d: 40};
var a, b, rest;

({a, b, ...rest} = obj);
console.log(a);     // 10
console.log(b);     // 20
console.log(rest);  // {c: 30, d: 40}
```

**注意**：赋值语句周围的圆括号 `( ... )` 在使用对象字面量无声明解构赋值时是必须的。



### 示例 4

为了防止从数组或对象中取出一个值为 `undefined` 的数据，可以在表达式左边的数组中为任意对象预设默认值。例如：

```javascript showLineNumbers
var a, b;

[a=5, b=7] = [1];
console.log(a);  // 1
console.log(b);  // 7
```



### 示例 5

我们可以利用解构赋值，在一个解构表达式中可以交换两个变量的值。这样就不需要设置一个临时变量，使代码更简洁。例如：

```javascript showLineNumbers
var a = 1;
var b = 3;

[a, b] = [b, a];
console.log(a);  // 3
console.log(b);  // 1
```



### 示例 6

从一个函数返回一个数组是十分常见的情况，解构使得处理返回值为数组时更加方便。例如下面例子中，函数 `f()` 返回 `[1, 2]`，调用者可以使用解构在一行内完成解析。

```javascript showLineNumbers
function f() {
  return [1, 2];
}

var a, b;
[a, b] = f();
console.log(a); // 1
console.log(b); // 2
```

这种方式与 Python 很相似！


