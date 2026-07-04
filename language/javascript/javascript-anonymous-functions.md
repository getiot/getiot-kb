---
sidebar_position: 10
---

# JavaScript 匿名函数



除了[前面](/js/javascript-function-definition/)那样定义拥有名称的函数，在 JavaScript 中还可以创建**匿名函数**（anonymous functions），也称为**函数表达式**。

函数表达式非常类似于函数声明，并且两者拥有几乎相同的语法。函数表达式与函数声明的最主要区别是函数名称，在函数表达式中可省略它。

例如，下面的代码定义了一个函数 `doCalc()`，它接受 3 个参数。前两个参数应该是数值，第 3 个参数是一个将被调用，并把这两个数值作为参数传入的函数：

```javascript showLineNumbers
function doCalc(num1, num2, calcFunction) {
    return calcFunction(num1, num2);
}
```

为此，你定义了一个函数 `addFunc()`，然后将不带参数的函数名传递给 `doCalc()`，如下：

```javascript showLineNumbers
function addFunc(n1, n2) {
    return n1 + n2;
}
doCalc(5, 10, addFunc);
```

除此之外，其实你还可以选择在 `doCalc()` 的调用中直接使用一个匿名函数，例如：

```javascript showLineNumbers
console.log( doCalc(5, 10, function(n1, n2){ return n1 + n2;}) );
console.log( doCalc(5, 10, function(n1, n2){ return n1 * n2;}) );
```

显然，匿名函数的好处是简单方便，你不需要正式定义将不在代码的其他任何地方使用的东西。因此，合理使用匿名函数，能使 JavaScript 代码更简洁易读。

