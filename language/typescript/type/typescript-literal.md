---
sidebar_position: 13
slug: /typescript-literal-types
draft: true
---

# TypeScript - 字面量类型

在 TypeScript 中，**字面量类型（Literal Types）** 是一组非常强大的类型工具，它允许你将变量限制为某些固定的值，而不是任意的类型。

换句话说，字面量类型的值 **不是某个类型的实例，而是一个具体的值本身**。这在你希望变量只能接受特定值时非常有用，例如状态标识、命令选项、方向指示等。



## 语法

在 TypeScript 中，你可以按照以下语法定义字面量类型：

```typescript
type lit_type = type_1 | type_2 | type_3 | ...
```

其中，`type` 是用于创建类型别名的关键字。`lit_type` 是类型的名称。`type_1`、`type_2` 和 `type_3` 分别是字符串、布尔值或数字类型的值。



## 字符串字面量类型

字符串字面量类型允许你将变量或函数参数定义为包含一组特定字符串的值。例如：

```typescript
type Direction = "North" | "East" | "South" | "West";

function move(direction: Direction) {
    console.log(`Moving in the direction: ${direction}`);
}
move("North");
move("East");
```

输出结果：

```bash
Moving in the direction: North
Moving in the direction: East
```

如果你尝试赋值其他值，将会报错。例如：

```typescript
let dir: Direction;

dir = "North"; // ✅ 合法
dir = "Up";    // ❌ 报错：不能将 "Up" 赋值给类型 "Direction"
```



## 数字字面量类型

字面量类型不仅限于字符串，也可以使用数字。例如：

```typescript
type StatusCode = 200 | 404 | 500;

let code: StatusCode;

code = 200; // ✅
code = 403; // ❌
```

这种写法在定义 API 状态码、HTTP 响应码等非常常见。



## 布尔字面量类型

虽然布尔值只有两个，但你依然可以通过字面量方式限制某个值只能是 `true` 或 `false`：

```typescript
type Truth = true;

let isTrue: Truth = true;   // ✅
isTrue = false;             // ❌
```

在实际开发中，布尔字面量不太常用，但它确实存在。



## 组合字面量类型

你可以使用联合类型将不同类型的字面量（字符串、数字、布尔值）组合在一起，允许变量包含一组指定的值。

示例：

```typescript showLineNumbers
type MixedLiterals = "Click" | 404 | true;
let action: MixedLiterals;

action = "Click";
console.log(action);

action = 404;
console.log(action);

action = true;
console.log(action);
```

输出结果：

```bash
Click
404
true
```



## 字面量类型的使用场景

字面量类型在多种场景中非常有用：

- **配置**：用于定义只能取特定值的变量或函数参数的配置。
- **状态管理**：用于状态管理。
- **API 响应处理**：根据 API 响应状态处理 API 响应。



## 小结

字面量类型增强了应用程序的类型安全性，允许你指定可接受的确切值。它们帮助开发者维护代码的复杂性并提高可读性。通过使用字面量类型，你可以确保变量只能取一组预定义的值，从而减少错误并提高代码的可维护性。
