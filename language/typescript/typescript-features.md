---
sidebar_position: 5
slug: /typescript-features
---

# TypeScript 核心特性

TypeScript 作为一种静态类型语言，提供了许多强大的特性，帮助开发者编写更可靠、更易维护的代码。在本文，我们将介绍一些 TypeScript 的核心特性，加深你对 TypeScript 的理解。



## 类型注解（Type Annotation）

类型注解是 TypeScript 的核心特性之一。它允许你在编写代码时声明变量、函数参数和返回值的类型。这种静态类型系统可以在编译时捕获类型相关的错误，而不是等到运行时才发现问题。这使得代码更加可靠。

一个简单的类型注解示例：

```typescript showLineNumbers
let a: number = 10;
function printNumber(num: number) {
  console.log(num);
}
printNumber(a);
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
var a = 10;
function printNumber(num) {
    console.log(num);
}
printNumber(a);
```



## 类型推断（Type Inference）

在很多情况下，你无需显式声明类型，TypeScript 会根据赋值内容自动推断类型。

```typescript showLineNumbers
let message = "Hello"; // 推断为 string 类型
message = 100; // 编译时报错
```

虽然类型推断很方便，但在大型项目中显式声明类型会更清晰。



## 接口（Interfaces）

接口类似于其他编程语言（如 Java）中的抽象类。它允许开发者定义对象的结构，但不提供实现。通过接口，开发者可以确保相似对象的结构一致性。

一个简单的接口示例：

```typescript showLineNumbers
interface IPerson {
  firstName: string;
  lastName: string;
  getFullName(): string;
}

// 定义一个实现接口的对象
let obj: IPerson = {
  firstName: "John",
  lastName: "Doe",
  getFullName(): string {
    return this.firstName + " " + this.lastName;
  }
};
console.log(obj.getFullName());
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
let obj = {
   firstName: "John",
   lastName: "Doe",
   getFullName() {
      return this.firstName + " " + this.lastName;
   }
};
console.log(obj.getFullName());
```



## 类（Classes）

类（Classes）是对象（Objects）的蓝图。类可以包含属性和方法，这些属性和方法可以通过类的实例来访问。你可以使用构造函数来初始化类的属性，还可以定义静态成员，这些成员可以通过类名直接访问，而无需创建类的实例。

一个简单的类示例：

```typescript showLineNumbers
class Greeter {
  greeting: string;
  // 构造函数
  constructor(message: string) {
    this.greeting = message;
  }
  // 类方法
  greet() {
    return "Hello, " + this.greeting;
  }
}

// 创建类的实例
let greeter = new Greeter("world");
console.log(greeter.greet()); // Hello, world
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
class Greeter {
    constructor(message) {
        this.greeting = message;
    }
    greet() {
        return "Hello, " + this.greeting;
    }
}
let greeter = new Greeter("world");
console.log(greeter.greet());
```



## 继承（Inheritance）

TypeScript 支持面向对象编程的所有特性，包括多态（polymorphism）、抽象（abstraction）、封装（encapsulation）和继承（Inheritance）。继承允许你重用其他类的属性和方法。

```typescript showLineNumbers
// 基类
class Person {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  display(): void {
    console.log(this.name);
  }
}

// 派生类
class Employee extends Person {
  empCode: number;
  constructor(name: string, code: number) {
    super(name);
    this.empCode = code;
  }
  show(): void {
    console.log(this.empCode);
  }
}

let emp: Employee = new Employee("John", 123);
emp.display(); // John
emp.show(); // 123
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
class Person {
    constructor(name) {
        this.name = name;
    }
    display() {
        console.log(this.name);
    }
}

class Employee extends Person {
    constructor(name, code) {
        super(name);
        this.empCode = code;
    }
    show() {
        console.log(this.empCode);
    }
}
let emp = new Employee("John", 123);
emp.display();
emp.show();
```



## 枚举（Enums）

枚举用于定义命名常量。它允许你为常量值命名，使代码更具可读性和可靠性。

一个简单的枚举示例：

```typescript showLineNumbers
enum Direction {
  Up = 1,
  Down,
  Left,
  Right
}

console.log(Direction.Up);    // 1
console.log(Direction.Down);  // 2
console.log(Direction.Left);  // 3
console.log(Direction.Right); // 4
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
var Direction;
(function (Direction) {
    Direction[Direction["Up"] = 1] = "Up";
    Direction[Direction["Down"] = 2] = "Down";
    Direction[Direction["Left"] = 3] = "Left";
    Direction[Direction["Right"] = 4] = "Right";
})(Direction || (Direction = {}));
console.log(Direction.Up);
console.log(Direction.Down);
console.log(Direction.Left);
console.log(Direction.Right);
```



## 泛型（Generics）

泛型允许你创建可重用的组件、函数或类，这些组件可以处理多种类型的数据，而不是特定的类型。这使得开发者可以使用相同的函数或类来处理多种类型的数据。

一个简单的泛型示例：

```typescript showLineNumbers
function printArray(arr: T[]): void {
  for (let i = 0; i < arr.length; i++) {
    console.log(arr[i]);
  }
}

printArray([1, 2, 3]); // 数组
printArray(["a", "b", "c"]); // 字符串数组
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
function printArray(arr) {
    for (let i = 0; i < arr.length; i++) {
        console.log(arr[i]);
    }
}
printArray([1, 2, 3]);
printArray(["a", "b", "c"]);
```



## 模块（Modules）

TypeScript 支持 ES6 风格的模块系统，允许你将代码分割为多个文件并在需要时导入使用，有助于提升代码的组织性和可维护性。

```typescript showLineNumbers
// 在 math.ts 中
export function add(x: number, y: number): number {
  return x + y;
}

// 在 app.ts 中
import { add } from "./math";
console.log(add(10, 20));
```



## 命名空间（Namespaces）

命名空间用于将相关功能组织在一起，避免命名冲突（尤其是全局变量的污染）。虽然现在模块更为流行，但命名空间仍在某些场景下有其用武之地。

```typescript showLineNumbers
namespace MyNamespace {
  export class MyClass {
    sayHello() {
      console.log("Hello from namespace!");
    }
  }
}
```



## 支持第三方 JavaScript 库

你可以使用现有的 JavaScript 库，只需添加对应的类型定义文件（通常是 `.d.ts` 文件），TypeScript 就能理解这些库的类型信息。

例如：

```bash
npm install --save lodash
npm install --save-dev @types/lodash
```



## 小结

TypeScript 提供了一整套强大的语言特性，从静态类型、接口、类，到泛型和模块化开发，使得大型项目的开发更规范、代码更可维护。通过这些核心特性，你可以写出更健壮、可读性更强的代码，同时也能享受更强大的编辑器支持，极大提升开发效率。
