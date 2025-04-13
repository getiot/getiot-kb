---
sidebar_position: 16
slug: /typescript-type-aliases
---

# TypeScript - 类型别名

类型别名（Type Aliases）是 TypeScript 中一种强大的功能，允许你为类型定义一个别名。这不仅有助于提高代码的可读性，还能减少重复代码，使类型定义更加清晰。



## 基本语法

类型别名的语法如下：

```typescript
type 别名 = 类型;
```

示例：原始类型别名

```typescript
type UserID = number;

let user1: UserID = 101;
console.log(user1);
```

输出结果：

```bash
101
```



## 联合类型别名

当你需要定义一个可以接受多种类型的变量时，使用联合类型别名可以使代码更加简洁。例如：

```typescript
type StringOrNumber = string | number;

function logMessage(message: StringOrNumber): void {
    console.log(message);
}

logMessage("Hello");
logMessage(123);
```

输出结果：

```bash
Hello
123
```



## 元组类型别名

元组类型别名用于定义固定大小和类型的数组结构。例如：

```typescript
type RGBColor = [number, number, number];

let red: RGBColor = [255, 0, 0];
console.log(`Red color: ${red}`);
```

输出结果：

```bash
Red color: 255,0,0
```



## 对象类型别名

对象类型别名允许你定义具有特定结构的对象类型。例如：

```typescript
type User = {
    id: string;
    name: string;
};

let user: User = { id: "101", name: "Alice" };
console.log(user);
```

输出结果：

```bash
{ id: '101', name: 'Alice' }
```



## 函数类型别名

函数类型别名可以用于定义函数的参数和返回值类型，特别适用于高阶函数或回调函数。例如：

```typescript
type GreeterFunction = (name: string) => string;

const greet: GreeterFunction = name => `Hello, ${name}!`;
console.log(greet("TypeScript"));
```

输出结果：

```bash
Hello, TypeScript!
```



## 泛型类型别名

泛型类型别名允许你在定义类型时使用类型参数，从而创建更加灵活的类型。例如：

```typescript
type Container<T> = { value: T };

let numberContainer: Container<number> = { value: 123 };
let stringContainer: Container<string> = { value: "Hello World" };

console.log(numberContainer);
console.log(stringContainer);
```

输出结果：

```bash
{ value: 123 }
{ value: 'Hello World' }
```



## 小结

类型别名是 TypeScript 中一个非常有用的特性，它允许你为复杂类型定义一个简洁的别名，从而提高代码的可读性和可维护性。通过使用类型别名，你可以减少重复代码，使类型定义更加清晰。无论是原始类型、联合类型、元组类型、对象类型还是函数类型，都可以通过类型别名来简化代码。掌握类型别名的使用方法，可以帮助你在开发中编写更简洁、更易读的代码。
