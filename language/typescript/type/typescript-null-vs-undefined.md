---
sidebar_position: 15
slug: /typescript-null-vs-undefined
---

# TypeScript - null 与 undefined

在 TypeScript 中，`null` 和 `undefined` 是两个特殊的类型，用于表示变量没有值或未初始化的状态。它们也是经常被混淆的两种类型，虽然它们看起来相似，但含义和使用方式是不同的。理解这两者的区别有助于你写出更健壮的代码。



## 什么是 null？

`null` 是一个原始值，表示变量被明确地赋值为空。它通常用于表示一个变量有意为空或不存在的值。

### 示例：基本使用 null

```typescript
let a: null = null;
console.log(a);
```

输出结果：

```bash
null
```

### 示例：null 的数据类型

`null` 类型变量的数据类型是 `object`。

```typescript
let a: null = null;
console.log(typeof a);
```

输出结果：

```bash
object
```

### 示例：重新初始化 null 变量

```typescript
let a: number | null = null;
console.log("变量 a 的初始值是：" + a);
a = 10;
console.log("变量 a 的值是：" + a);
```

输出结果：

```bash
变量 a 的初始值是：null
变量 a 的值是：10
```



## 什么是 undefined？

当你声明一个变量但没有给它赋值时，TypeScript 会自动将 `undefined` 赋值给该变量。同样，如果一个函数没有返回值，它也会返回 `undefined`。

### 示例：未定义的值

```typescript
let a: number;
console.log("a 的值是：" + a);
```

输出结果：

```bash
a 的值是：undefined
```

### 示例：函数不返回值

```typescript
function greet(name: string): void {
    console.log(`Hello, ${name}!`);
}
let result = greet("John");
console.log(result);
```

输出结果：

```bash
Hello, John!
undefined
```

### 示例：使用 undefined 类型

```typescript
let a: undefined = undefined;
console.log(a);
console.log(typeof a);
```

输出结果：

```bash
undefined
undefined
```



## null 与 undefined 的区别

|   特性   |               null               |         undefined          |
| :------: | :------------------------------: | :------------------------: |
|   含义   |            明确没有值            |          未初始化          |
| 典型用途 |     表示有意为空或不存在的值     |   表示变量已声明但未赋值   |
| 类型注解 |      具有自己的类型 `null`       | 具有自己的类型 `undefined` |
| 默认行为 |       不触发函数的默认参数       |     触发函数的默认参数     |
| 函数参数 |     用于明确表示参数不应有值     |  表示缺少的参数或可选参数  |
| 对象属性 | 用于明确表示属性被有意设置为空值 |   用于可能未初始化的属性   |
| 操作处理 |  必须在逻辑中显式处理以避免错误  | 通常使用默认值或可选链处理 |

### 示例：对象属性

```typescript showLineNumbers
type User = {
    name: string;
    age: number | null;
    email?: string;
};

let user1: User = {
    name: "John Doe",
    age: null,
    email: "john@example.com"
};

let user2: User = {
    name: "Jane Doe",
    age: 25
};

console.log(user1);
console.log(user2);
```

输出结果：

```bash
{ name: 'John Doe', age: null, email: 'john@example.com' }
{ name: 'Jane Doe', age: 25 }
```



## 小结

`null` 和 `undefined` 是 TypeScript 中两个重要的类型，用于表示变量没有值或未初始化的状态。通常，`null` 用于表示有意为空的值，而 `undefined` 用于表示未初始化的变量或函数返回值。在实际开发中，理解它们的区别和使用场景可以帮助你编写更清晰、更安全的代码。
