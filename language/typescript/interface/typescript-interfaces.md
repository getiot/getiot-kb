---
sidebar_position: 1
slug: /typescript-interfaces
---

# TypeScript - 接口

在 TypeScript 中，**接口（Interface）** 是一种用于定义对象类型结构的方式。你可以用接口来描述对象的属性和方法，以及类要实现的契约。接口不会编译成 JavaScript 代码，它们只存在于编译阶段，用于类型检查。



## 定义接口

你可以使用 `interface` 关键字来定义一个接口。例如，下面定义了一个简单的 `Person` 接口：

```typescript
interface Person {
  firstName: string;
  lastName: string;
}
```

这个接口表示一个对象，必须包含 `firstName` 和 `lastName` 两个属性，类型都是 `string`。

你可以像这样使用它：

```typescript
function greet(person: Person) {
  console.log("Hello, " + person.firstName + " " + person.lastName);
}

let user = { firstName: "Jane", lastName: "Doe" };
greet(user);
```



## 可选属性

你可以通过在属性名后加上问号 `?` 来定义可选属性：

```typescript
interface Person {
  firstName: string;
  lastName?: string;
}
```

这样定义后，`lastName` 就不是必需的了：

```typescript
let user = { firstName: "John" };
greet(user); // 只需要提供 firstName
```



## 只读属性（Readonly）

你还可以通过 `readonly` 关键字创建只读属性。一旦赋值，这些属性就无法更改：

```typescript
interface Person {
  readonly id: number;
  firstName: string;
}
```

使用示例：

```typescript
let person: Person = { id: 1, firstName: "Tom" };
person.firstName = "Jerry"; // OK
// person.id = 2; // ❌ 报错：无法分配只读属性
```



## 接口中的函数类型

接口也可以用于定义函数的类型。例如：

```typescript
interface SearchFunc {
  (source: string, subString: string): boolean;
}
```

你可以根据这个接口实现函数：

```typescript
let mySearch: SearchFunc;
mySearch = function (src: string, sub: string): boolean {
  return src.indexOf(sub) > -1;
};
```



## 接口与类的关系

接口还可以用来约束类的结构。类通过 `implements` 关键字来实现接口：

```typescript
interface Person {
  firstName: string;
  lastName: string;
  getFullName(): string;
}

class Employee implements Person {
  firstName: string;
  lastName: string;

  constructor(f: string, l: string) {
    this.firstName = f;
    this.lastName = l;
  }

  getFullName(): string {
    return this.firstName + " " + this.lastName;
  }
}
```

接口在这里扮演了“契约”的角色，强制类必须提供所有接口中定义的成员。



## 接口的继承

你可以通过 `extends` 关键字让一个接口继承自另一个接口，这样可以复用已有的接口定义：

```typescript
interface Person {
  firstName: string;
  lastName: string;
}

interface Employee extends Person {
  employeeId: number;
}
```

现在 `Employee` 接口包含了 `firstName`、`lastName` 和 `employeeId`。



## 接口继承多个接口

一个接口也可以继承多个接口，用逗号 `,` 分隔：

```typescript
interface Person {
  firstName: string;
}

interface Contact {
  email: string;
}

interface Employee extends Person, Contact {
  employeeId: number;
}
```



## 接口与数组（索引签名）

接口还能描述数组或对象的索引结构。例如：

```typescript
interface StringArray {
  [index: number]: string;
}

let myArray: StringArray;
myArray = ["Tom", "Jerry"];
```

这里定义了一个 `StringArray` 接口，表示使用数字索引、值为字符串的数组。



## 小结

接口是 TypeScript 中非常核心的概念，它能让你在开发过程中清晰地描述对象结构、类的契约以及函数或数组的类型要求。掌握接口能帮助你写出更健壮、可维护性更高的代码。你可以用接口统一多个对象的结构，也可以通过接口定义函数签名或组合多个类型，是构建大型 TypeScript 项目的基石之一。
