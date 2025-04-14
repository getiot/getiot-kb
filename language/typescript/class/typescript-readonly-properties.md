---
sidebar_position: 4
slug: /typescript-readonly-properties
---

# TypeScript - 只读属性

在 TypeScript 中，如果你希望某个属性在对象创建后就不能再被修改，可以使用 `readonly` 修饰符。只读属性可以在类外部访问，但不能修改。这在你希望保护对象的某些关键字段时非常有用，比如 ID、创建时间等。

使用 `readonly` 能帮助你防止意外修改，提高代码的健壮性。



## 语法

定义只读属性的语法如下：

```typescript
readonly propName: type;
```

- `readonly` 是关键字。
- `propName` 是只读属性的名称。
- `type` 是只读属性的类型。



## 声明只读属性

你可以在类中使用 `readonly` 关键字来声明只读属性。一旦赋值（通常是在构造函数中），这个属性就不能再被修改。

示例：

```typescript
class Employee {
  readonly empCode: number;
  empName: string;

  constructor(code: number, name: string) {
    this.empCode = code;
    this.empName = name;
  }
}

let emp = new Employee(1001, "Jack");
console.log(emp.empCode);   // 输出: 1001
emp.empName = "Tom";        // 正确：empName 是可变的
// emp.empCode = 1002;      // 错误：无法修改只读属性
```

你可以看到，`empCode` 一旦在构造函数中赋值，就不能在类的外部（或内部的其他方法中）修改。



## 类属性的只读限制

你可能会好奇，`readonly` 是不是意味着“永远不能赋值”？其实不是。你可以在以下两个地方给只读属性赋值：

1. 声明时赋初值；
2. 构造函数中赋值。

示例：

```typescript
class Student {
  readonly rollNumber: number = 1;  // 声明时赋值
  readonly name: string;

  constructor(name: string) {
    this.name = name;              // 构造函数中赋值
  }
}
```

一旦超出这两个时机，你就不能再更改只读属性。



## 接口中的只读属性

`readonly` 也可以用于接口中，用于定义对象的不可变属性。

示例：

```typescript
interface Person {
  readonly id: number;
  name: string;
}

let person: Person = {
  id: 101,
  name: "Alice"
};

person.name = "Bob";     // 正确
// person.id = 102;      // 错误：无法修改只读属性
```

接口中的 `readonly` 同样表示你不能修改这个字段，哪怕它是一个普通对象。



## 类型别名中的只读属性

类型别名也可以包含只读属性，类似于接口。

示例：

```typescript
type Point = {
    readonly x: number;
    readonly y: number;
};

let p1: Point = { x: 10, y: 20 };
// 错误：无法分配到 'x'，因为它是只读属性。
// p1.x = 5;

console.log(p1.x, p1.y); // 输出: 10 20
```



## 与 `const` 的区别

`readonly` 和 `const` 都有“不可变”的意味，但作用范围不同：

- `const` 是用于 **变量** 的，意味着变量绑定不能更改。
- `readonly` 是用于 **属性（class 或 interface）** 的，表示属性的值不能被修改。

举个例子：

```typescript
const x = 10; // x 不能重新赋值
```

而：

```typescript
class A {
  readonly value = 42; // this.value 不能重新赋值
}
```



## 何时使用只读属性

- **数据完整性**：当你希望确保对象的某些属性在初始化后不会被更改时。
- **函数式编程**：在强调不可变性的编程范式中。
- **API 合约**：当你创建的对象将暴露给外部用户，并需要保证内部状态不会被意外更改时。



## 小结

TypeScript 的只读属性为确保数据完整性和不可变性提供了强大的支持。通过 `readonly` 关键字，你可以控制对象属性的可修改性，从而提高代码的安全性和可维护性。在实际开发中，合理使用只读属性可以帮助你避免不必要的副作用，特别是在处理复杂对象和 API 设计时。掌握只读属性的使用，是成为 TypeScript 高级开发者的必经之路。
