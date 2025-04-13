---
sidebar_position: 11
slug: /typescript-never
---

# TypeScript - Never 类型

在 TypeScript 中，`never` 类型表示那些永远不会发生的值。当一个函数永远不会正常返回时（比如总是抛出异常或陷入无限循环），你就可以将它的返回类型标注为 `never`。

这个类型主要用于捕捉那些在设计上“不可能到达”的场景，让编译器在静态检查时帮你发现潜在问题。



## 函数返回类型

你可以将 `never` 类型用作那些永远不会返回或总是抛出异常的函数的返回类型。

**示例：抛出错误的函数**

```typescript
function showError(): never {
    throw new Error("这是一个错误消息");
}
```

**示例：无限循环的函数**

```typescript
function infiniteLoop(): never {
    while (true) {}
}
```



## 变量类型

你也可以将变量声明为 `never` 类型，但这并不常见。以下是一个示例：

```typescript
let x: never;
x = showError(); // x 被赋值为 showError() 函数的返回值，该函数的返回类型是 never
```



## 与其他类型的兼容性

`never` 类型是所有类型的子类型，可以赋值给任何类型。但是，没有任何类型（包括 `any`）可以赋值给 `never`。

**示例：类型兼容性**

```typescript
let x: never;
x = 10; // 错误：类型 'number' 不可以赋值给类型 'never'
```



## void 与 never 的区别

在 TypeScript 中，`void` 类型的变量可以存储 `undefined` 作为值。而 `never` 类型不能存储任何值。

**示例：`void` 与 `never` 的比较**

```typescript
let val1: void = undefined; // 正确
let val2: never = undefined; // 错误：类型 'undefined' 不可以赋值给类型 'never'
```



## 小结

`never` 类型在 TypeScript 中用于表示那些永远不会发生的值。它通常用于那些总是抛出错误或永远不返回的函数的返回类型。虽然 `never` 类型可以赋值给任何类型，但没有任何类型可以赋值给 `never`。在实际开发中，`never` 类型的使用场景相对较少，但在需要明确表示函数永远不会返回时非常有用。
