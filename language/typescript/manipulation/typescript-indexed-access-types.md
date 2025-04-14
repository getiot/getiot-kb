---
sidebar_position: 4
slug: /typescript-indexed-access-types
---

# TypeScript - 索引访问类型

在 TypeScript 中，**索引访问类型**（Indexed Access Types） 让你可以通过索引操作符 `[]` 来获取某个类型中具体属性的类型。简单来说，你可以使用已有类型和属性名来构造一个新类型，而不需要重复定义。

你可以将它类比为访问对象属性的方式，只不过是在类型层面进行的。



## 基本语法

索引访问类型的语法如下：

```typescript
type newType = TypeName[Key];
```

- `type` 是定义新类型的关键词。
- `TypeName` 是现有的类型（你想要提取属性的类型）。
- `key` 是 `TypeName` 的属性，也就是你想访问的属性名称。



## 示例 ：访问对象属性类型

索引访问类型在你需要获取现有类型中特定属性的类型时非常有用。

```typescript
type User = {
    id: number;
    name: string;
    age: number;
};

// 从 User 中访问 'name' 属性的类型
type UserNameType = User['name'];  // 类型为 string

let userName: UserNameType;
userName = "Alice";  // 正确
console.log(userName);  // 输出：Alice

// userName = 123;   // 错误：类型 'number' 无法分配给类型 'string'。
```



## 示例：访问嵌套对象属性类型

索引访问类型在处理复杂类型结构时特别有用。

```typescript
type Product = {
    id: number;
    details: {
        name: string;
        price: number;
    };
};

// 访问嵌套的 'price' 属性的类型
type ProductPriceType = Product['details']['price'];  // 类型为 number

let price: ProductPriceType;
price = 19.99;  // 正确用法
console.log(price);  // 输出：19.99

// price = "20.00"; // 错误：类型 'string' 无法分配给类型 'number'。
```



## 示例：与 keyof 操作符结合使用

你可以将 `keyof` 操作符与索引访问类型结合使用，以获取对象所有属性的类型联合。

```typescript
type User = {
    id: number;
    name: string;
    age: number;
};

// 获取 User 类型所有属性的类型联合
type UserNameType = User[keyof User];  // 类型为 number | string

let userName: UserNameType;
userName = "Hello";  // 正确用法
console.log(userName);  // 输出：Hello

userName = 123;   // 正确用法
console.log(userName);  // 输出：123
```



## 示例：与数组结合使用

当你需要获取数组元素的类型时，可以使用 `number` 作为索引。

```typescript
type StringArray = string[];
// 获取数组元素的类型
type ElementType = StringArray[number];  // 类型为 string

let element: ElementType;
element = "Hello";  // 正确用法
console.log(element);

// element = 123;    // 错误：类型 'number' 无法分配给类型 'string'。
```



## 小结

通过索引访问类型，你可以从现有类型中提取属性类型，无需重复书写类型定义。这对于构建灵活的类型系统尤为重要。你不仅可以访问单个属性类型，还可以组合多个属性生成联合类型，甚至结合 `keyof` 动态提取所有属性类型。掌握这一特性，将大大提升你在类型系统上的表达能力和代码复用性。
