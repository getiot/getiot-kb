---
sidebar_position: 3
slug: /typescript-access-modifiers
---

# TypeScript - 访问修饰符

在 TypeScript 中，你可以使用访问修饰符（Access Modifiers）来控制类成员（包括属性和方法）的可见性。访问修饰符是实现封装（Encapsulation）或数据隐藏的关键概念，它们决定了这些成员在哪些地方可以被访问或调用。

TypeScript 支持以下三种主要的访问修饰符：

- `public`（公共，默认）
- `private`（私有）
- `protected`（受保护）



## Public 访问修饰符

`public` 是默认的访问修饰符。使用 `public` 修饰的类成员可以在类的内部和外部任何地方访问。

示例：

```typescript
class Animal {
  public name: string;

  constructor(name: string) {
    this.name = name;
  }

  public move(distance: number): void {
    console.log(`${this.name} moved ${distance} meters.`);
  }
}

let dog = new Animal("Dog");
console.log(dog.name); // 访问 public 成员
dog.move(10);          // 调用 public 方法
```



## Private 访问修饰符

`private` 修饰符限制了类成员的访问范围，使其只能在定义它的类内部访问。

示例：

```typescript
class Person {
  private age: number;

  constructor(age: number) {
    this.age = age;
  }

  public getAge(): number {
    return this.age;
  }
}

let p = new Person(30);
console.log(p.getAge()); // 正确：通过 public 方法访问
// console.log(p.age);   // 错误：直接访问 private 成员会报错
```

在这个例子中，`age` 是私有成员，你必须通过公开的方法 `getAge()` 才能访问它。



## Protected 访问修饰符

`protected` 和 `private` 类似，不同之处在于：`protected` 成员不能在类的外部访问，但可以在派生类（子类）中访问。

示例：

```typescript
class Employee {
  protected name: string;

  constructor(name: string) {
    this.name = name;
  }
}

class Manager extends Employee {
  public getName(): string {
    return this.name; // 可以在子类中访问 protected 成员
  }
}

let mgr = new Manager("Alice");
console.log(mgr.getName()); // 正确
// console.log(mgr.name);   // 错误：在类的外部不能访问 protected 成员
```

你可以看到，子类 `Manager` 能够访问父类中用 `protected` 修饰的成员 `name`，但在类的外部不能直接访问。



## 小结

TypeScript 的访问修饰符为实现封装提供了强大的支持。通过 `public`、`private` 和 `protected` 修饰符，你可以精确控制类成员的访问权限，从而提高代码的安全性和可维护性。在实际开发中，合理使用访问修饰符可以帮助你更好地组织代码，避免不必要的副作用。掌握访问修饰符的使用，是成为 TypeScript 高级开发者的必经之路。
