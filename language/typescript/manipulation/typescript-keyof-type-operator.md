---
sidebar_position: 2
slug: /typescript-keyof-type-operator
---

# TypeScript - keyof 运算符

在 TypeScript 中，`keyof` 是一个**类型操作符**（type operator），它用于获取某个对象类型的所有键名，生成一个联合类型（union type）。

简单来说，`keyof` 可以帮助你获取一个对象类型的“键名集合”，而这些键会以字符串字面量类型的形式存在。这个特性在泛型编程中非常有用，能让你的代码更加类型安全和灵活。



## keyof 的语法

`keyof` 运算符的语法如下：

```typescript
type Keys = keyof SomeType;
```

这里，`Keys` 就是 `SomeType` 的所有键组成的联合类型。`keyof` 关键字后面跟一个类型名，返回一个由指定类型的所有键（属性名）组成的联合类型。这允许你动态地访问和操作对象的键。



## 示例：基本用法

```typescript showLineNumbers
interface Person {
  name: string;
  age: number;
}

type PersonKeys = keyof Person;
```

在这个例子中，`PersonKeys` 的类型等价于：

```typescript
type PersonKeys = "name" | "age";
```

也就是说，`keyof Person` 会返回 `name` 和 `age` 这两个键的字符串字面量联合类型。



## 示例：与泛型结合使用

`keyof` 运算符常常与泛型函数一起使用，比如下面这个例子：

```typescript showLineNumbers
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}
```

这个函数可以从对象 `obj` 中安全地获取某个属性，属性名 `key` 的类型是 `T` 的键之一。

**使用示例：**

```typescript showLineNumbers
let person: Person = { name: "Tom", age: 25 };

let personName = getProperty(person, "name"); // 类型是 string
let personAge = getProperty(person, "age");   // 类型是 number
```

尝试访问一个不存在的键，比如 `"gender"`，会直接在编译时报错：

```bash
Error: Argument of type '"gender"' is not assignable to parameter of type 'keyof Person'
```

这就是 `keyof` 带来的类型安全性。



## 示例：映射对象属性

`keyof` 关键字在将一个对象的属性映射到另一个对象时也很有用。

```typescript showLineNumbers
interface Fruit {
    name: string;
    color: string;
}

type FruitMapped = {
    [K in keyof Fruit]: string;
};

const fruit: FruitMapped = {
    name: 'Apple',
    color: 'Red',
};

console.log(fruit);
```

输出结果：

```bash
{ name: 'Apple', color: 'Red' }
```



## 示例：条件类型映射

`keyof` 关键字的另一个强大应用是条件类型映射。这允许我们根据某些条件选择性地映射属性。

```typescript showLineNumbers
interface Product {
    name: string;
    price: number;
    inStock: boolean;
}

type DiscountedProducts<T> = {
    [K in keyof T]: T[K] extends number ? T[K] | null : T[K];
};

const product: DiscountedProducts<Product> = {
    name: 'Widget',
    price: 10,
    inStock: true,
};

console.log(product);
```

输出结果：

```bash
{ name: 'Widget', price: 10, inStock: true }
```



## 示例：用于约束类型

你还可以利用 `keyof` 来限制泛型类型的取值范围：

```typescript showLineNumbers
function prop<T, K extends keyof T>(obj: T, key: K) {
  return obj[key];
}
```

这样可以确保传入的 `key` 参数**只能是对象中已有的属性名**。



## 注意事项

- `keyof` 运算符返回的类型是联合类型（即多个值用 `|` 连接），你可以使用它进行进一步类型操作。
- 如果你对 `any` 或 `unknown` 使用 `keyof`，结果是 `string | number | symbol`，因为它们可以拥有任意键。
- 如果你使用的是 `type SomeType = string | number` 这样的联合类型，那么 `keyof SomeType` 会返回一个[**交叉类型的键**](/ts/typescript-intersection-types/)，这通常不是你想要的结果。要小心这类情况。



## 小结

`keyof` 是 TypeScript 提供的一个强大类型工具，它可以提取对象类型的所有键，并返回一个键名的联合类型。你可以结合泛型和 `keyof` 构建出既灵活又安全的工具函数，避免访问不存在的属性，从而让代码更加健壮。在处理复杂对象或构建通用组件时，掌握 `keyof` 会极大提升你的类型操控能力。
