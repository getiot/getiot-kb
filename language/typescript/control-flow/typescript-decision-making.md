---
sidebar_position: 1
slug: /typescript-decision-making
---

# TypeScript - 决策结构

在编写代码时，我们经常需要根据不同的条件来控制代码的执行流程。TypeScript 提供了多种决策结构，帮助你根据条件执行不同的代码块。TypeScript 支持 ES6 中的所有决策结构，包括 `if`、`if...else` 和 `switch` 语句。



## 决策结构分类

下表列举了 TypeScript 中几种种常见的决策结构。

| 序号 | 语句及描述                                                   |
| :--: | ------------------------------------------------------------ |
|  1   | **`if` 语句**：由一个布尔表达式后跟一条或多条语句组成。      |
|  2   | **`if...else` 语句**：`if` 语句后可以跟一个可选的 `else` 语句，当布尔表达式为假时执行。 |
|  3   | **`elseif` 和嵌套 `if` 语句**：可以在一个 `if` 或 `else if` 语句内使用另一个 `if` 或 `else if` 语句。 |
|  4   | **`switch` 语句**：允许将变量与一系列值进行比较。            |



## if 语句

`if` 语句用于在条件为 `true` 时执行特定的代码块。

```typescript showLineNumbers
let num: number = 10;

if (num > 0) {
  console.log("Number is positive");
}
```

在这个例子中，如果 `num` 大于 0，控制台将输出 "Number is positive"。



## if...else 语句

`if...else` 语句允许你在条件为 `false` 时执行另一个代码块。

```typescript showLineNumbers
let num: number = -5;

if (num > 0) {
  console.log("Number is positive");
} else {
  console.log("Number is not positive");
}
```

在这个例子中，如果 `num` 不大于 0，控制台将输出 "Number is not positive"。



## if...else if...else 语句

当你有多个条件需要判断时，可以使用 `if...else if...else` 结构。

```typescript showLineNumbers
let num: number = 0;

if (num > 0) {
  console.log("Number is positive");
} else if (num < 0) {
  console.log("Number is negative");
} else {
  console.log("Number is zero");
}
```

这个例子中，程序会根据 `num` 的值输出相应的信息。



## 嵌套 if 语句

你可以在一个 `if` 或 `else` 块中嵌套另一个 `if` 语句，以处理更复杂的条件。

```typescript showLineNumbers
let num: number = 5;

if (num >= 0) {
  if (num === 0) {
    console.log("Number is zero");
  } else {
    console.log("Number is positive");
  }
} else {
  console.log("Number is negative");
}
```

在这个例子中，程序首先判断 `num` 是否大于等于 0，然后在内部进一步判断其具体值。



## switch 语句

`switch` 语句用于基于不同的值执行不同的代码块，通常用于替代多个 `if...else if` 条件判断。

```typescript showLineNumbers
let day: number = 3;

switch (day) {
  case 1:
    console.log("Monday");
    break;
  case 2:
    console.log("Tuesday");
    break;
  case 3:
    console.log("Wednesday");
    break;
  case 4:
    console.log("Thursday");
    break;
  case 5:
    console.log("Friday");
    break;
  default:
    console.log("Weekend");
}
```

在这个例子中，根据 `day` 的值，程序会输出相应的星期几。



## 小结

TypeScript 提供了多种决策结构，如 `if`、`if...else`、`if...else if...else`、嵌套 `if` 和 `switch` 语句，帮助你根据不同的条件控制代码的执行流程。掌握这些结构将使你能够编写更灵活和高效的程序。
