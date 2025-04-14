---
sidebar_position: 5
slug: /typescript-anonymous-functions
---

# TypeScript - 匿名函数

在 TypeScript 中，**匿名函数**是一种**没有名称的函数表达式**。你可以将匿名函数赋值给变量，也可以作为参数传递给其他函数。这种方式常用于回调函数和临时函数场景。



## 基本匿名函数

匿名函数和普通函数的唯一区别是：**它没有名字**。其语法形式如下：

```typescript
let variable_name = function([arguments]) {
  // 函数体
}
```

你可以像调用普通函数那样，通过变量名来调用匿名函数。例如：

```typescript
let greet = function() {
  return "Hello World";
};

console.log(greet()); // 输出：Hello World
```

在这个例子中，你定义了一个匿名函数并赋值给 `greet` 变量。然后通过 `greet()` 调用了它。



## 带参数的匿名函数

你可以为匿名函数添加参数，就像命名函数一样。例如：

```typescript
let multiply = function(a: number, b: number): number {
  return a * b;
};

console.log(multiply(4, 3)); // 输出：12
```



## 使用箭头函数定义匿名函数

箭头函数是另一种定义匿名函数的方式，语法更简洁。

**语法**：

```typescript
var test: (value1: number) => number = (value1: number): number => {
   return 10 * value1;
};
```

**示例**：

```typescript
var test: (value1: number) => number = (value1: number): number => {
   return 10 * value1;
};

var result = test(12);
console.log("The returned value from the test function is " + result);
```

输出结果：

```bash
The returned value from the test function is 120
```



## 匿名函数作为参数传递

在实际开发中，匿名函数经常作为回调函数传递给其他函数。例如：

```typescript
function greetUser(callback: () => void) {
  callback();
}

greetUser(function() {
  console.log("Hello from anonymous function!");
});
```

在这个例子中，你把一个匿名函数传递给 `greetUser` 函数，并在回调中输出了一段话。



## 带参数的回调匿名函数

匿名函数也可以有参数，哪怕是作为回调时也不例外：

```typescript
function processData(data: number[], callback: (item: number) => void) {
  for (let i = 0; i < data.length; i++) {
    callback(data[i]);
  }
}

processData([1, 2, 3], function(item) {
  console.log("Processing item:", item);
});
```

在这个例子中，你定义了一个带参数的匿名函数，并在 `processData` 中对数组的每一项进行了处理。



## 匿名函数与箭头函数的区别

虽然箭头函数（Arrow Functions）也可以是匿名的，但两者语法和 `this` 的处理方式不同。匿名函数是使用传统 `function` 关键字定义的，而箭头函数使用 `=>` 符号。

匿名函数的写法：

```typescript
let message = function(name: string) {
  return "Hello, " + name;
};
```

箭头函数写法（更简洁）：

```typescript
let message = (name: string) => "Hello, " + name;
```

箭头函数还有一些作用域上的优势，尤其是在处理 `this` 时。



## 小结

匿名函数是 TypeScript 中一种灵活的工具，允许你在运行时动态创建函数。通过将匿名函数存储在变量中，你可以轻松地在代码中复用和调用它们。箭头函数提供了一种简洁的语法，特别适合用于回调函数。掌握匿名函数的使用方法，可以帮助你编写更加简洁和高效的 TypeScript 代码。在后续学习中，你会经常用到这种函数表达形式。

