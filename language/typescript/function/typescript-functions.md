---
sidebar_position: 1
slug: /typescript-functions
---

# TypeScript - 函数

函数（Function）是组织代码的基本方式之一。在 TypeScript 中，函数不仅支持 JavaScript 的基本语法，还增强了类型系统的支持。你可以指定函数的参数类型、返回值类型，还能使用默认参数、可选参数和剩余参数等高级功能。



## 什么是函数？

函数是一组执行特定任务的语句集合。你可以根据需要重复调用它们，提高代码复用性。

TypeScript 提供两种主要的函数定义方式：

- **具名函数（Named Function）**
- **匿名函数（Anonymous Function）**



## 函数声明（具名函数）

你可以使用标准的方式来定义函数，并为参数和返回值添加类型：

```typescript
function greet(name: string): string {
  return "Hello, " + name;
}
```

你还可以省略返回值类型，TypeScript 会自动推断：

```typescript
function greet(name: string) {
  return "Hello, " + name;
}
```



## 匿名函数（函数表达式）

你也可以将函数赋值给变量：

```typescript
let greet = function(name: string): string {
  return "Hello, " + name;
};
```

这种方式常用于回调函数或作为参数传递。



## 使用构造函数创建函数

虽然不推荐，但你可以使用 `Function` 构造函数来创建函数：

```typescript
let myFunction = new Function("a", "b", "return a + b");
console.log(myFunction(1, 2));
```

:::warning 注意

这种方式不支持静态类型检查，也可能影响性能，不建议在实际开发中使用。

:::



## 可选参数

通过在参数后加 `?`，你可以定义可选参数：

```typescript
function greet(name: string, age?: number): string {
  return age ? `${name} is ${age} years old.` : `Hello, ${name}`;
}
```



## 默认参数

你可以为参数设置默认值，如果调用时没有传入该参数，则使用默认值：

```typescript
function greet(name: string = "Guest"): string {
  return "Hello, " + name;
}
```



## 剩余参数（Rest Parameters）

当你需要接收任意数量的参数时，可以使用剩余参数：

```typescript
function addNumbers(...numbers: number[]): number {
  return numbers.reduce((sum, current) => sum + current, 0);
}

console.log(addNumbers(1, 2, 3)); // 6
```

`...numbers` 表示接收所有参数，并作为数组处理。



## 函数重载

TypeScript 支持为同一个函数提供多个类型签名：

```typescript
function greet(person: string): string;
function greet(persons: string[]): string;
function greet(person: any): string {
  if (typeof person === "string") {
    return "Hello, " + person;
  } else {
    return "Hello, " + person.join(", ");
  }
}
```

重载定义列在函数体上方，函数实现必须兼容所有声明。



## 箭头函数（Arrow Functions）

箭头函数是简洁的函数表达式形式，尤其适用于回调场景：

```typescript
let greet = (name: string): string => {
  return "Hello, " + name;
};
```

如果只有一个表达式，可以省略花括号和 `return`：

```typescript
let square = (x: number) => x * x;
```

箭头函数还自动绑定 `this`，避免你在回调中丢失上下文。



## 函数中的类型推断

即使你不显式指定参数或返回值类型，TypeScript 也会自动推断：

```typescript
function multiply(x: number, y: number) {
  return x * y; // 推断为 number
}
```

不过，显式声明类型可以提高代码的可读性和可维护性。



## 小结

本节你学习了 TypeScript 中函数的多种定义方式，包括具名函数、匿名函数、箭头函数、函数重载、可选参数、默认参数以及剩余参数等内容。掌握这些函数特性，将帮助你编写更加灵活、强大且具有类型保障的代码。函数不仅是重用逻辑的重要工具，也是构建 TypeScript 应用的基石。
