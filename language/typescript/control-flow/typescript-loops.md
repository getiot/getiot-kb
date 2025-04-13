---
sidebar_position: 6
slug: /typescript-loops
---

# TypeScript - 循环结构

在编写程序时，你可能会需要重复执行某些代码。TypeScript 提供了多种循环结构，帮助你实现这种重复执行的需求。接下来，我们将一起了解几种常见的循环方式：`for`、`while`、`do...while` 以及 `for...in` 和 `for...of` 等语法。



## for 循环

`for` 循环是最常见的一种循环结构。它适用于你知道需要循环多少次的情况。

```typescript showLineNumbers
for (let i = 0; i < 5; i++) {
  console.log("i = " + i);
}
```

上面的代码会输出 0 到 4 的值。`for` 循环由三部分组成：初始化表达式（`let i = 0`）、条件表达式（`i < 5`）和迭代表达式（`i++`）。



## for...in 循环

`for...in` 循环用于遍历对象的**可枚举属性的键名**，常用于枚举对象属性。

```typescript showLineNumbers
let obj = {a: 1, b: 2, c: 3};

for (let key in obj) {
  console.log(key + " = " + obj[key]);
}
```

输出结果：

```bash
a = 1
b = 2
c = 3
```

需要注意的是，`for...in` 适合遍历对象，不适合用来遍历数组（因为它遍历的是**索引**，而不是元素值）。



## for...of 循环

`for...of` 循环是 ES6 引入的新语法，它用于遍历**可迭代对象**（如数组、字符串等）的值。

```typescript showLineNumbers
let arr = [10, 20, 30, 40];

for (let value of arr) {
  console.log(value);
}
```

输出结果：

```bash
10
20
30
40
```

与 `for...in` 不同，`for...of` 更适合用于遍历数组的**元素值**。



## while 循环

`while` 循环会在每次迭代开始之前先检查条件表达式。

```typescript showLineNumbers
let i = 0;

while (i < 5) {
  console.log("i = " + i);
  i++;
}
```

只要条件为真，循环就会持续执行。



## do...while 循环

`do...while` 循环和 `while` 类似，不同之处在于它**先执行一次循环体**，然后再判断条件。

```typescript showLineNumbers
let i = 0;

do {
  console.log("i = " + i);
  i++;
} while (i < 5);
```

即使条件一开始为假，`do...while` 也会执行一次循环体。



## break 和 continue 语句

你可以使用 `break` 来中断循环，用 `continue` 来跳过本次迭代。

**示例：使用 break 中断循环**

```typescript showLineNumbers
for (let i = 0; i < 5; i++) {
  if (i === 3) {
    break;
  }
  console.log("i = " + i);
}
```

输出结果：

```bash
i = 0
i = 1
i = 2
```

**示例：使用 continue 跳过本次循环**

```typescript showLineNumbers
for (let i = 0; i < 5; i++) {
  if (i === 3) {
    continue;
  }
  console.log("i = " + i);
}
```

输出结果：

```bash
i = 0
i = 1
i = 2
i = 4
```

可以看到，在第一个例子中，循环在 `i` 等于 3 时就提前退出了。而第二个例子中，只是跳过了当 `i` 为 3 时的那一轮循环。



## 标签（Label）语句

TypeScript 也支持带标签的 `break` 和 `continue`，这在嵌套循环中非常有用。

```typescript showLineNumbers
outer: for (let i = 0; i < 3; i++) {
  for (let j = 0; j < 3; j++) {
    if (i === j) {
      continue outer;
    }
    console.log(`i = ${i}, j = ${j}`);
  }
}
```

输出结果：

```bash
i = 1, j = 0
i = 2, j = 0
i = 2, j = 1
```

这里，`continue outer` 会跳过外层循环的当前迭代。



## 小结

通过学习本节内容，你掌握了 TypeScript 中的多种循环结构，包括 `for`、`while`、`do...while`、`for...in` 和 `for...of`。这些循环工具可以帮你高效地处理重复任务。理解它们的使用场景和差异，有助于你编写更优雅、更具表现力的代码。
