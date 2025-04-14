---
sidebar_position: 3
slug: /typescript-typeof-type-operator
---

# TypeScript - typeof 运算符

在 TypeScript 中，`typeof` 是一个非常有用的**类型查询操作符**（type query operator），你可以用它来获取一个变量或表达式的类型，并在类型系统中重复使用这个类型。

也就是说，当你已经声明了某个变量后，`typeof` 允许你“引用”这个变量的类型，而不需要手动重复定义。



## typeof 的语法

`typeof` 运算符的语法如下：

```typescript
let type = typeof <variable>;
```

其中，`variable` 是需要检查类型的标识符。

当你使用 `typeof` 关键字时，TypeScript 会提取指定变量或表达式的静态类型。



## 示例：基本用法

```typescript
let someVar = { name: "Alice", age: 30 };
type SomeVarType = typeof someVar;
```

在这个例子中，`SomeVarType` 的类型等价于：

```typescript
{
  name: string;
  age: number;
}
```

也就是说，`typeof someVar` 提取了 `someVar` 的类型结构并赋值给类型别名 `SomeVarType`。

你可以像下面这样再声明一个具有相同结构的新变量：

```typescript
let anotherVar: SomeVarType = { name: "Bob", age: 25 };
```

这样可以避免重复书写冗长的类型定义。



## 示例：函数类型的使用

你还可以使用 `typeof` 获取函数的类型：

```typescript
function multiply(x: number, y: number): number {
  return x * y;
}

type MultiplyType = typeof multiply;

const anotherMultiply: MultiplyType = (a, b) => a * b;
```

这里，`MultiplyType` 是一个函数类型，它接收两个 `number` 参数并返回一个 `number`。使用 `typeof` 提取函数类型后，你可以非常方便地在多个地方复用这个类型定义。



## 示例：与 `keyof` 联合使用

```typescript
const person = {
  name: "Charlie",
  age: 40,
};

type PersonType = typeof person;
type PersonKeys = keyof PersonType; // "name" | "age"
```

这个例子展示了如何使用 `typeof` 获取类型，再用 `keyof` 提取该类型的键名。



## 注意事项

- `typeof` 运算符在类型上下文中使用时，和 JavaScript 中运行时的 `typeof` 不同。你在 TypeScript 中使用的是**类型操作符**，而不是运行时的 `typeof`。
- 你只能用 `typeof` 来获取**已声明变量**或**函数**的类型，不能直接对类型本身使用 `typeof`。
- `typeof` 常与 `keyof`、泛型等联合使用，能创建出强大的类型工具函数。



## 小结

在 TypeScript 中，`typeof` 类型操作符可以帮助你从已有变量中提取类型信息，让你的类型定义更加简洁和一致。它尤其适用于那些变量类型比较复杂的场景，能够显著减少重复代码。你可以将 `typeof` 与其他类型工具（如 `keyof`、泛型等）结合使用，从而构建出更加强大且安全的类型系统。
