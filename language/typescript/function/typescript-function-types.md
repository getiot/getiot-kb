---
sidebar_position: 2
slug: /typescript-function-types
---

# TypeScript - 函数类型

在 TypeScript 中，函数也是一种“值”，这意味着你可以像使用其他类型一样来描述它的结构。你可以为函数指定参数类型和返回值类型，从而获得更强的类型检查与代码提示能力，高代码的可读性和可维护性。



## 函数类型的定义

要定义一个函数的类型，你需要指定它的**参数类型**和**返回值类型**。例如：

```typescript
function add(x: number, y: number): number {
    return x + y;
}

let addNums = function (x: number, y: number): number {
    return x + y;
};
```

在第一个例子中，我们为参数 `x` 和 `y` 指定了 `number` 类型，并明确了函数的返回值类型为 `number`。TypeScript 会根据参数类型推断返回值类型，因此返回值类型有时可以省略。

在第二个例子中，我们将一个函数赋值给变量 `addNums`。尽管我们没有显式定义 `addNums` 的类型，TypeScript 仍然可以推断出它的类型。



## 函数类型表达式

函数类型表达式提供了一种简洁的方式来定义函数类型。其语法如下：

```typescript
(para1: type1, para2: type2, ...) => returnType
```

- `(para1: type1, para2: type2, ...)`：定义函数的参数及其类型。
- `=>`：分隔参数列表和返回值类型。
- `returnType`：函数的返回值类型。

你可以先定义一个函数类型，然后将函数赋值给该类型的变量。这种方式更灵活，也更适合回调函数等用法：

```typescript
let myAdd: (x: number, y: number) => number;
myAdd = function (x: number, y: number): number {
  return x + y;
};
```

也可以将函数类型定义和函数主体写在一起，例如：

```typescript
let myAdd: (x: number, y: number) => number = function (x: number, y: number): number {
    return x + y;
};
console.log(myAdd(2, 3));
```

在这个例子中，我们定义了一个变量 `myAdd`，其类型为 `(x: number, y: number) => number`，表示一个接受两个 `number` 类型参数并返回 `number` 类型值的函数。



## 函数类型推断

下面再来讲讲函数的类型推断。由于 TypeScript 会根据上下文自动推断函数参数和返回值的类型，因此有时候你不需要显式标注类型。例如：

```typescript
let myAdd = function (x: number, y: number) {
  return x + y;
};
```

另外，如果你已经声明了 `myAdd` 的类型，那在函数实现里就可以省略类型注解：

```typescript
let myAdd: (baseValue: number, increment: number) => number =
  function (x, y) {
    return x + y;
  };
```



## 使用类型别名定义函数类型

你可以使用类型别名来简化函数类型的定义：

```typescript
type AddFunction = (x: number, y: number) => number;

function greet(fn: AddFunction) {
    console.log(fn(2, 3));
}

function add(x: number, y: number): number {
    return x + y;
}

greet(add);
```

在这个例子中，我们定义了一个类型别名 `AddFunction`，表示一个接受两个 `number` 类型参数并返回 `number` 类型值的函数。然后，我们将这个类型别名用作函数参数的类型。

使用类型别名定义函数类型具有以下作用：

1. **简化复杂类型定义**：当函数的类型定义较为复杂时，使用类型别名可以简化代码，提高可读性。
2. **提高代码可维护性**：通过为函数类型定义别名，可以在多处使用该类型时保持一致性，减少重复定义，便于后续维护。
3. **增强类型安全性**：明确指定函数参数和返回值的类型，有助于在编译时捕获类型错误，提高代码的健壮性。



## 小结

函数类型是 TypeScript 中一个强大的特性，允许你明确指定函数的参数类型和返回值类型。通过函数类型表达式和类型别名，你可以更加灵活和简洁地定义函数类型。掌握函数类型的使用方法，可以帮助你编写出更加清晰、安全和可维护的 TypeScript 代码。
