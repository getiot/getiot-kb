---
sidebar_position: 1
slug: /typescript-types
---

# TypeScript - 数据类型

TypeScript 是一种**静态类型语言**，这意味着你在编写代码时就需要为变量指定类型，编译器会在编译阶段对类型进行检查。这不仅能让你的代码更安全，也能让工具如 VS Code 提供更智能的代码补全和错误提示。

在本章中，你会了解 TypeScript 支持的各种**数据类型（Data Types）**，并学会如何在代码中使用它们。



## TypeScript 支持的数据类型

TypeScript 中的数据类型分类如下所示：

![TypeScript 数据类型](https://static.getiot.tech/typescript-types-overview.png#center)

### Any 类型（任意类型）

在 TypeScript 中，`any` 类型是所有类型的超类型，表示动态类型。使用 `any` 可以暂时跳过变量的类型检查。

在实际开发中，有时候你可能无法提前知道变量的类型，比如来自第三方库或用户输入的数据，这时可以使用 `any` 类型：

```typescript
let notSure: any = 4;
notSure = "maybe a string instead";
notSure = false;
```

你也可以使用 `any[]` 来表示任意类型的数组：

```typescript
let mixedList: any[] = [1, "hello", true];
```



### 内置类型（Built-in）

TypeScript 提供了多种基本数据类型，下表列出了 TypeScript 中的所有内置类型。

| 数据类型  |   关键词    | 描述                                                         |
| :-------: | :---------: | :----------------------------------------------------------- |
|  Number   |  `number`   | 数字类型。使用双精度 64 位浮点值。它既可以用来表示整数，也可以用来表示分数。 |
|  String   |  `string`   | 字符串类型。表示 Unicode 字符序列。                          |
|  Boolean  |  `boolean`  | 布尔类型。表示逻辑值，真和假。                               |
|   Void    |   `void`    | 无返回值。用于函数返回类型来表示无返回函数。                 |
|   Null    |   `null`    | 空值。表示对象值的故意缺失。                                 |
| Undefined | `undefined` | 表示赋予所有未初始化变量的值。                               |
|  Symbol   |  `symbol`   | ES2015 中引入的独特且不可变的原语。                          |
|  Object   |  `object`   | 表示用户定义的类、数组、函数等的实例。                       |
|   Never   |   `never`   | 表示永远不会发生的值。                                       |

:::tip

TypeScript 和 JavaScript 中没有整数类型。

:::



## 基本类型

### Number（数字）

`number` 类型用于表示数字，包括整数、浮点数、二进制、十进制和十六进制数。在 TypeScript 中，所有数字都以浮点数形式存储。

```typescript
let age: number = 30; // 整数
let marks: number = 30.5; // 浮点数
```



### String（字符串）

`string` 类型用于存储文本值。你可以使用单引号、双引号或反引号来定义字符串。反引号允许创建多行字符串或模板字符串。

```typescript
let first_name: string = 'John'; // 单引号
let last_name: string = "Doe"; // 双引号
let full_name: string = `${first_name} ${last_name}`; // 模板字符串
```



### Boolean（布尔值）

`boolean` 类型用于表示逻辑值，只有 `true` 和 `false` 两个值。布尔变量通常用于条件判断。

```typescript
let isReady: boolean = true;
```



### Symbol（标识符）

`symbol` 是一种原始数据类型，用于创建唯一的值。它通常用于创建对象的唯一键，避免键名冲突。

```typescript
const UNIQUE_KEY = Symbol();
let obj = {
  [UNIQUE_KEY]: "SecretValue"
};
```



### Null 和 Undefined 类型

- `null` 表示有意为空的对象值。
- `undefined` 表示未初始化的变量值。

```typescript
let empty: null = null;
let undef: undefined;
```



### Object（对象）

`object` 类型用于表示非原始类型的数据，如对象、数组和函数等。

```typescript
let person: object = { name: "Bob" };
```



### Void（无返回值）

`void` 类型用于表示没有返回值的函数。

```typescript
function log(): void {
  console.log("log");
}
```



### Never（永不）

`never` 类型表示永远不会发生的值，通常用于表示永远不会返回的函数，比如抛出异常或者无限循环。

```typescript
function throwError(message: string): never {
  throw new Error(message);
}

function infiniteLoop(): never {
  while (true) {}
}
```





## 用户自定义类型

### Array（数组）

数组是相同类型元素的集合。你可以通过 `type[]` 或 `Array<type>`  两种方式来定义数组。

```typescript
let list1: number[] = [1, 2, 3];
let list2: Array<number> = [4, 5, 6];
```



### Tuple（元组）

元组是一种特殊的数组，具有固定数量和类型的元素。它允许你表示一个已知**元素数量和类型**的数组，并且每个元素的类型可以不同。

```typescript
let tuple: [string, number];
tuple = ["hello", 10]; // 正确
// tuple = [10, "hello"]; // 错误
```

你可以通过索引访问元组中的元素：

```typescript
console.log(tuple[0].substring(1)); // "ello"
```



### Enum（枚举）

枚举是一种定义相关值集合的方式，使用 `enum` 可以为一组数值赋予有意义的名字，使代码更清晰：

```typescript
enum Color { Red, Green, Blue }
let c: Color = Color.Green;
console.log(c); // 输出：1
```

你也可以改变默认的枚举值：

```typescript
enum Color2 { Red = 1, Green, Blue }
let c2: Color2 = Color2.Blue; // 值为 3
```



## 小结

TypeScript 提供了丰富的数据类型，包括基本类型（如 `number`、`string`、`boolean` 等）、特殊类型（如 `any`、`void` 等）和用户自定义类型（如 `array`、`tuple`、`enum` 等）。通过使用这些类型，你可以提高代码的可读性、可维护性，并减少运行时错误。类型系统是 TypeScript 的核心特性之一，建议在实际项目中充分利用这些类型来提升代码质量。

