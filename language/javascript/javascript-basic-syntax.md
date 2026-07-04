---
sidebar_position: 2
---

# JavaScript 基础语法



**JavaScript** 的语法类似于 C/C++ 和 Java，如果学过这些语言，那么入门 JavaScript 会非常容易。虽然 JavaScript 的核心语法不难，但是并不意味着你能轻松掌握 JavaScript 开发，因为其复杂性主要体现在另外两个方面。

- 首先，它涉及大量的外部 API。JavaScript 要发挥作用，必须与其他组件配合，这些外部组件五花八门，数量极其庞大，几乎涉及网络应用的各个方面，掌握它们绝非易事。
- 其次，JavaScript 语言有一些设计缺陷。某些地方相当不合理，另一些地方则会出现怪异的运行结果。学习 JavaScript，很大一部分时间是用来搞清楚哪些地方有陷阱。后来出现的 CoffeeScript、TypeScript、Dart 等新语言，就是为了解决这个问题。

下面我们先来简单了解一下 JavaScript 的基础语法。



## 定义变量

和绝大多数语言一样，我们可以在 JavaScript 中使用变量来临时存储和访问程序中的数据。变量既可以指向简单的数据类型，比如数字或字符串；也可以指向更复杂的数据类型，比如对象。

在 JavaScript 中定义变量，需要使用 `var` 关键字，例如：

```javascript showLineNumbers
var myString = "GetIoT.tech";
```

提示：ES6 增加了 `let` 和 `const` 关键字，因此你可以使用 `var`、`let` 和 `const` 来声明变量。它们的区别主要在于作用域的不同，具体我们将在后面介绍。

JavaScript 的变量名区分大小写，必须以字母、`$` 或 `_` 开头，并且不能包含空格。



## 语句

JavaScript 的每一个语句以逗号 `;` 结束，但并不强制要求，因为浏览器中负责执行 JavaScript 代码的引擎会自动在每个语句的结尾补上 `;` 符号。

在 JavaScript 中，语句块使用花括号 `{...}` 包裹，例如：

```javascript showLineNumbers
if (2 > 1) {
    x = 1;
    y = 2;
    z = 3;
}
```



## 注释

在 JavaScript 中，单行注释以 `//` 开头，多行注释使用 `/* */` 包裹。例如：

```javascript showLineNumbers
/*
这是多行注释：
第一行
第二行
*/
if (2 > 1) {
    x = 1;  // 这是单行注释
    y = 2;  // 这也是单行注释
    z = 3;
}
```

