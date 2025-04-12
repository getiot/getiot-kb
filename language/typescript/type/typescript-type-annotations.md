---
sidebar_position: 2
slug: /typescript-type-annotations
---

# TypeScript - 类型注解

在 TypeScript 中，类型注解（Type Annotation）是一种显式指定变量、函数参数、返回值等的类型的方式。通过类型注解，你可以在编译阶段捕获潜在的错误，提升代码的可靠性和可维护性。



## 什么是类型注解？

“类型注释”指的是分配数据类型。即在变量、函数参数或返回值等标识符后面使用冒号 `:` 加上类型名称，明确指定该标识符的数据类型。例如：

```typescript
let age: number;
```

在这个例子中，`age` 被注解为 `number` 类型，这意味着你只能为 `age` 赋予数字类型的值。如果尝试赋值其他类型的值，TypeScript 编译器会报错。



## 变量和常量的类型注解

你可以在声明变量或常量时添加类型注解：

```typescript
let counter: number;
const name: string = "Alice";
```

如果你尝试为 `counter` 赋予非数字类型的值，TypeScript 编译器会报错：

```typescript
counter = "Hello"; // 错误：不能将类型“string”分配给类型“number”
```



## 函数的类型注解

为函数的参数和返回值添加类型注解，可以提高函数的类型安全性：

```typescript
function greet(name: string): string {
  return `Hello, ${name}`;
}
```

在这个例子中，`greet` 函数接受一个 `string` 类型的参数，并返回一个 `string` 类型的值。

你也可以为函数表达式添加类型注解：

```typescript
let add: (a: number, b: number) => number;
add = function (x: number, y: number): number {
  return x + y;
};
```



## 数组的类型注解

你可以使用以下两种方式为数组添加类型注解：

```typescript
let numbers: number[] = [1, 2, 3];
let fruits: Array<string> = ["apple", "banana", "cherry"];
```

这两种方式都表示一个由特定类型元素组成的数组。



## 对象的类型注解

为对象添加类型注解，可以明确对象的属性及其类型：

```typescript
let person: { name: string; age: number };
person = {
  name: "John",
  age: 30,
};
```

你也可以使用接口（interface）来定义对象的结构：

```typescript
interface Person {
  name: string;
  age: number;
}

let employee: Person = {
  name: "Jane",
  age: 25,
};
```



## 类型注解的好处

- **提前捕获错误**：类型注解可以帮助你在编译时发现类型错误，减少运行时错误。
- **增强代码可读性**：明确变量和函数的类型，提高代码的可读性和可维护性。
- **更好的开发体验**：类型信息可以提升代码编辑器的自动补全和类型提示功能。



## 小结

TypeScript 的类型注解为变量、函数参数和返回值等提供了明确的类型定义，有助于提高代码的可读性和可维护性。通过静态类型检查，可以在编译时捕获类型错误，减少运行时错误的发生。虽然 TypeScript 支持动态类型，但合理使用类型注解可以充分利用 TypeScript 的类型系统，提升代码质量。
