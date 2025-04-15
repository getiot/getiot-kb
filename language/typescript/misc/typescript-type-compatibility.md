---
sidebar_position: 6
slug: /typescript-type-compatibility
---

# TypeScript - 类型兼容性

在 TypeScript 中，类型兼容性是指一个类型的值是否可以赋值给另一个类型的变量。TypeScript 采用的是结构类型系统（structural type system），这意味着类型的兼容性是基于它们的结构（即成员）而非名称或继承关系来判断的。



## 结构类型系统

TypeScript 的类型兼容性基于结构子类型（structural subtyping）。这意味着如果两个类型具有相同的成员结构，那么它们就是兼容的，即使它们的名称不同。

例如，考虑以下代码：

```typescript
interface Pet {
  name: string;
}

class Dog {
  name: string;
}

let pet: Pet;
pet = new Dog(); // 合法，因为 Dog 的结构符合 Pet 的要求
```

在这个例子中，尽管 `Dog` 类和 `Pet` 接口没有显式的关系，但由于它们都具有一个 `name` 属性，TypeScript 认为它们是兼容的。



## 基本类型的兼容性

对于基本类型，如 `string` 和 `number`，TypeScript 是严格的，不允许它们之间的赋值：

```typescript
let str: string = "Hello";
let num: number = 123;

str = num; // 错误：不能将 'number' 类型赋值给 'string' 类型
num = str; // 错误：不能将 'string' 类型赋值给 'number' 类型
```

这种严格的类型检查有助于在编译时捕获潜在的错误。



## 函数的兼容性

在函数类型的兼容性方面，TypeScript 主要关注参数和返回值的类型。如果一个函数的参数类型是另一个函数参数类型的子集，并且返回值类型兼容，那么这两个函数就是兼容的。

例如：

```typescript
let func1 = (a: number) => 0;
let func2 = (b: number, s: string) => 0;

func2 = func1; // 错误：func1 的参数少于 func2
func1 = func2; // 合法：func2 的参数可以被 func1 忽略
```

在这个例子中，`func1` 可以被赋值给 `func2`，因为 `func1` 的参数是 `func2` 的子集，但反过来则不行。



## 类的兼容性

类的兼容性也基于结构类型系统。如果两个类具有相同的成员结构，那么它们就是兼容的，即使它们之间没有继承关系。

例如：

```typescript
class Animal {
  feet: number;
  constructor(name: string, numFeet: number) {}
}

class Size {
  feet: number;
  constructor(numFeet: number) {}
}

let a: Animal;
let s: Size;

a = s; // 合法
s = a; // 合法
```

在这个例子中，`Animal` 和 `Size` 都有一个 `feet` 属性，因此它们是兼容的。



## 枚举的兼容性

枚举类型在 TypeScript 中与数字类型是兼容的，但不同枚举类型之间不兼容：

```typescript
enum Status { Ready, Waiting };
enum Color { Red, Blue, Green };

let status: Status = Status.Ready;
let num: number = status; // 合法

status = num; // 合法

status = Color.Red; // 错误：不能将 'Color' 类型赋值给 'Status' 类型
```

在这个例子中，`Status` 和 `Color` 是不同的枚举类型，不能互相赋值，但它们都可以与数字类型互相赋值。



## 泛型的兼容性

在泛型类型中，如果泛型参数不被使用，那么不同泛型参数的类型是兼容的：

```typescript
interface Empty<T> {
}

let x: Empty<number>;
let y: Empty<string>;

x = y; // 合法，因为 Empty<T> 没有使用 T
```

然而，如果泛型参数被使用，那么只有在泛型参数类型相同的情况下，类型才是兼容的：

```typescript
interface NotEmpty<T> {
  data: T;
}

let m: NotEmpty<number>;
let n: NotEmpty<string>;

m = n; // 错误：'string' 类型不能赋值给 'number' 类型
```



## 小结

TypeScript 的类型兼容性基于结构类型系统，这使得类型之间的兼容性取决于它们的成员结构而非名称或继承关系。这种灵活性有助于编写更通用和可重用的代码，但也要求开发者对类型的结构有清晰的理解，以避免潜在的类型错误。
