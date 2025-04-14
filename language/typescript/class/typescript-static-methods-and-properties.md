---
sidebar_position: 6
slug: /typescript-static-methods-and-properties
---

# TypeScript - 静态方法与属性

在 TypeScript 中，**静态成员**（static members）是属于类本身的，而不是某个类的实例。你可以把它们理解为“**类级别**”的变量和方法，它们不需要实例化类就可以被访问。你可以使用关键字 `static` 在类中定义静态属性和静态方法。



## 静态属性（Static Properties）

静态属性由类本身而不是其实例拥有。要定义静态属性，你只需在属性前加上 `static` 关键字。

示例：

```typescript
class Circle {
  static pi: number = 3.14;
}

console.log(Circle.pi); // 输出：3.14
```



:::warning

你不能通过类的实例来访问静态属性。例如 `new Circle().pi` 是错误的。

```typescript
// ❌ 错误：不能通过实例访问静态属性
let c = new Circle();
console.log(c.pi); // 编译错误
```

:::



## 静态方法（Static Methods）

与静态属性类似，**静态方法也属于类本身**。它们不能访问类的实例属性，但可以访问其他静态成员。

示例：

```typescript
class Circle {
  static pi: number = 3.14;

  static calculateArea(radius: number): number {
    return this.pi * radius * radius;
  }
}

console.log(Circle.calculateArea(5)); // 输出：78.5
```

在这个例子中，你通过类名 `Circle` 直接调用静态方法 `calculateArea`，并计算了一个半径为 5 的圆的面积。



## 类与实例成员的对比

|    特性     | 静态成员（static） |       实例成员       |
| :---------: | :----------------: | :------------------: |
|  所属对象   |    类（Class）     | 类的实例（Instance） |
| 是否可继承  |         是         |          是          |
|  访问方式   | `ClassName.member` |   `object.member`    |
| 使用 `this` |     引用类本身     |     引用当前实例     |



## 静态成员的继承

静态属性和方法也会被子类继承。这意味着你可以在子类中直接使用父类的静态成员，或者根据需要进行重写。

```typescript
class Shape {
  static category: string = "2D";
}

class Rectangle extends Shape {}

console.log(Rectangle.category); // 输出：2D
```



## 静态块（Static Blocks）

从 TypeScript 4.4 开始，你还可以使用 `static { }` 语法定义**静态初始化块**。这是在类定义时执行的代码块，常用于对多个静态成员做复杂初始化。

```typescript
class Config {
  static dbHost: string;
  static dbPort: number;

  static {
    this.dbHost = "localhost";
    this.dbPort = 5432;
  }
}
```



## 小结

在 TypeScript 中，静态方法与属性属于类本身，而不是其实例。你可以通过 `static` 关键字轻松地定义它们，并使用 `ClassName.member` 的形式访问。静态成员可以继承，也可以用于封装一些与实例无关的通用逻辑。掌握它们可以让你的代码结构更加清晰，也能提高复用性。

如果你需要封装“工具类”或存放全局配置信息，静态成员会非常有用。在实际开发中，你可以尝试将一些与状态无关的函数提取为静态方法，提升代码质量。
