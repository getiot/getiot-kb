---
sidebar_position: 5
slug: /typescript-conditional-types
---

# TypeScript - 条件类型

在 TypeScript 中，**条件类型**（Conditional Types） 允许你根据类型之间的关系来选择不同的类型。它类似于 JavaScript 中的三元运算符（`condition ? trueExpr : falseExpr`），但它是在类型层面上运行的。



## 基本语法

条件类型使用三元运算符（`?:`）来根据条件选择类型。基本语法如下：

```typescript
T extends U ? X : Y
```

这表示：如果类型 `T` 可以赋值给类型 `U`，那么结果就是类型 `X`，否则就是类型 `Y`。

示例：

```typescript showLineNumbers
type Car = {
    name: string;
    model: string;
    year: number;
};

type Name = { name: string };

type carNameType = Car extends Name ? string : any;

const carName: carNameType = 'Ford';
console.log(carName);
```

输出结果：

```bash
Ford
```



## 泛型条件类型

泛型条件类型允许你在代码中多次使用条件类型，提供更大的灵活性。

语法：

```typescript
type ConditionalType<T> = T extends Type1 ? TrueType : FalseType;
```

示例：

```typescript showLineNumbers
type IsNumArray<T> = T extends number[] ? number : string;

const num: IsNumArray<number[]> = 5;
const str: IsNumArray<string[]> = '5';

console.log(num);
console.log(str);
```

输出结果：

```bash
5
5
```



## 条件类型约束

条件类型约束用于为泛型类型添加约束，确保泛型类型只能用于特定的数据类型。

语法：

```typescript
type ConditionalType<T extends T1 | T2> = T extends Type1 ? TrueType : FalseType;
```

示例：

```typescript showLineNumbers
type ConditionalType<T extends number | string> = T extends number ? number : string;

let x: ConditionalType<number> = 10;
let y: ConditionalType<string> = 'Hello';

console.log("The value of x is: ", x);
console.log("The value of y is: ", y);
```

输出结果：

```bash
The value of x is: 10
The value of y is: Hello
```



## 条件类型推断

条件类型推断允许你在条件类型中推断类型，使类型转换更加灵活。

语法：

```typescript
type Flatten<Type> = Type extends Array<infer Item> ? Item : Type;
```

示例：

```typescript showLineNumbers
type Flatten<T> = T extends (infer U)[] ? U : T;
let bool: Flatten<boolean[]> = true;

console.log(bool);
```

输出结果：

```bash
true
```



## 小结

在 TypeScript 中，条件类型允许你基于类型的关系动态选择类型。你可以利用它构建更具表现力的泛型逻辑，特别适用于类型映射、工具类型、类型推导等高级场景。掌握条件类型，会让你在类型体操（Type-level programming）上如虎添翼。
