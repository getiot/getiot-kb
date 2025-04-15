---
sidebar_position: 3
slug: /typescript-generic-interfaces
---

# TypeScript - 泛型接口

在 TypeScript 中，**接口**（interface）可以用来定义对象的结构，而**泛型接口**则是在接口的基础上引入泛型参数，让接口更加灵活、通用。你可以为接口添加一个或多个泛型类型参数，从而让它适用于不同的数据类型。

通过泛型接口，你可以创建可复用的结构定义，这在处理类似结构但数据类型不同的场景下特别有用。



## 定义泛型接口

你可以像下面这样为接口添加一个泛型参数 `T`，并在接口内部使用这个泛型：

```typescript
interface IGeneric<T> {
    value1: T;
    value2: T;
}
```

- `IGeneric` 是接口的名称。
- `T` 是类型参数，用于指定接口中属性的类型。



## 示例

### 示例 1：基本泛型接口

在下面的代码中，我们创建了具有自定义类型 `T` 的 `IGeneric` 接口。它具有类型为 `T` 的 value1 和 value2 属性。然后，我们定义了 `IGeneric` 接口类型的 `obj` 对象，并将 `number` 数字类型作为该接口的泛型类型。

```typescript showLineNumbers
interface IGeneric<T> {
    value1: T;
    value2: T;
}

let obj: IGeneric<number> = {
    value1: 10,
    value2: 20
};

console.log(obj.value1); // 输出：10
```



### 示例 2：多类型参数

在该示例中，我们将 `T` 和 `U` 这两种数据类型与 `IGeneric` 接口一起使用。接口中的 value1 属性为 `T` 类型，value2 属性为 `U` 类型。

```typescript showLineNumbers
interface IGeneric<T, U> {
    value1: T;
    value2: U;
}

let obj: IGeneric<number, string> = {
    value1: 10,
    value2: "Hello"
};

console.log(obj.value2); // 输出：Hello
```



### 示例 3：泛型接口中的方法

这个示例在上一个示例的基础上，在 `IGeneric` 接口增加了 `merge()` 方法，它接收 `U` 类型的参数并返回 `U` 类型的值。然后在定义 `obj` 对象时，我们在接口中使用了 number 和 string 数据类型。这意味着 `merge()` 方法将接受两个字符串参数，并返回一个字符串值。

```typescript showLineNumbers
interface IGeneric<T, U> {
    value1: T;
    merge: (a: U, b: U) => U;
}

let obj: IGeneric<number, string> = {
    value1: 10,
    merge: (a, b) => a + b
};

console.log(obj.merge("Hello", "world!")); // 输出：Helloworld!
```



## 泛型接口作为函数类型

泛型接口也可以用作函数类型，这允许你在不同的类型和场景中重用相同的函数接口，同时确保类型安全。

在下面示例代码中，`FuncInterface` 接受泛型类型 `T` 和 `U`。它定义了函数的结构，该函数接收类型 `T` 的参数并返回类型 `U` 的值。然后，我们定义了一个函数表达式，它返回字符串的长度并将其存储在 `stringToLength` 变量中。该函数表达式的类型使用带有字符串和数字类型的通用接口定义。类似地，我们还定义了另一个将数字转换为字符串的函数 `numberToString`。

```typescript showLineNumbers
interface FuncInterface<T, U> {
    (input: T): U;
}

const stringToLength: FuncInterface<string, number> = (input) => {
    return input.length;
};

const result = stringToLength("Hello, TypeScript!");
console.log(result); // 输出：18

const numberToString: FuncInterface<number, string> = (input) => {
    return `Number: ${input}`;
};

const output = numberToString(123);
console.log(output); // 输出：Number: 123
```



## 泛型接口的类型别名

除了使用 `interface` 关键字，你也可以用 `type` 创建泛型结构（可选替代用法）。例如：

```typescript
type KeyValuePair<T, U> = {
  key: T;
  value: U;
};
```

这个 `type` 与 `interface` 在用法上非常相似，在实际开发中你可以根据需要选择。



## 为泛型参数提供默认值

从 TypeScript 2.3 起，你可以为泛型接口中的类型参数提供默认值：

```typescript
interface ApiResponse<T = any> {
  data: T;
  status: number;
}

const response1: ApiResponse<string> = { data: "OK", status: 200 };
const response2: ApiResponse = { data: [1, 2, 3], status: 200 }; // 推断为 any
```

这让你在不显式传入类型参数的情况下，也能拥有灵活的数据结构。



## 小结

泛型接口是 TypeScript 中实现代码复用和类型安全的重要工具之一。通过为接口添加泛型参数，你可以构建既通用又灵活的结构定义，非常适合处理各种不同类型的数据。在实际开发中，无论是定义通用的对象结构、API 响应格式，还是工具函数的参数类型，泛型接口都能帮你写出更清晰、更强健的代码。掌握它，会让你的 TypeScript 技能更上一层楼。
