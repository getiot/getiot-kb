---
sidebar_position: 5
slug: /typescript-inheritance
---

# TypeScript - 继承

在 TypeScript 中，**继承**（Inheritance）是一种从已有类派生出新类的机制。它能让你重用已有类中的属性和方法，同时还能在子类中添加或重写特定的行为。使用 `extends` 关键字，你可以让一个类继承另一个类。继承能提升代码的可维护性和复用性，是面向对象编程的核心之一。



## 单类继承

单类继承是指一个类继承另一个类的属性和方法。子类可以访问父类的所有公共属性和方法。

示例：

```typescript showLineNumbers
class Shape {
  Area: number;

  constructor(a: number) {
    this.Area = a;
  }
}

class Circle extends Shape {
  display(): void {
    console.log("圆的面积: " + this.Area);
  }
}

let obj = new Circle(223);
obj.display();  // 输出: 圆的面积: 223
```

在这个例子中：

- `Circle` 类继承自 `Shape` 类；
- `Circle` 拥有了 `Shape` 的属性 `Area`；
- 同时 `Circle` 添加了自己的方法 `display()`。

你可以看到，通过继承，子类不仅可以访问父类的成员，还可以在其基础上添加自己的功能。



## super 关键字

`super` 关键字用于调用父类的构造函数或方法。

示例：

```typescript showLineNumbers
class Person {
    name: string;
    constructor(name: string) {
        this.name = name;
    }
    display(): void {
        console.log(this.name);
    }
}

class Employee extends Person {
    empCode: number;
    constructor(name: string, code: number) {
        super(name); // 调用父类的构造函数
        this.empCode = code;
    }
    show(): void {
        super.display(); // 调用父类方法
        console.log("子类的 show() 方法");
    }
}

let emp = new Employee("Alice", 123);
emp.show();
```

这里使用了 `super` 来调用父类的 `display()` 方法，然后在子类中添加了更多的逻辑。这种方式很常见，特别是在你想要保留父类逻辑的同时再添加扩展行为时。



## 方法重写

方法重写（Method Overriding）允许子类重新定义父类的方法，以实现不同的功能。

示例：

```typescript showLineNumbers
class Animal {
    move() {
        console.log("Animal is moving");
    }
}

class Dog extends Animal {
    move() {
        console.log("Dog is moving");
    }
}

let dog = new Dog();
dog.move(); // 输出：Dog is moving
```

子类 `Dog` 的 `move()` 方法覆盖了父类 `Animal` 的 `move()` 方法。

:::tip

你只需要在子类中重新定义该方法即可。TypeScript 会自动识别你是在重写，而不是重载。

:::



## 多级继承

多级继承允许一个类继承另一个类，而这个类本身也继承了其他类。

示例：

```typescript showLineNumbers
class Animal {
    move() {
        console.log('This animal moves');
    }
}

class Bird extends Animal {
    fly() {
        console.log('This bird flies');
    }
}

class Parrot extends Bird {
    speak() {
        console.log('The parrot speaks');
    }
}

let P1 = new Parrot();
P1.speak(); // 输出：The parrot speaks
P1.fly();   // 输出：This bird flies
P1.move();  // 输出：This animal moves
```

在这个例子中，子类 `Parrot` 继承了 `Bird` 类，`Bird` 又继承了 `Animal` 类。因此 `Parrot` 类对象同时拥有 `speak()`、`fly()` 和 `move()` 方法。

:::info 注意

在 TypeScript 中，**类（class）不支持多重继承**，也就是说，一个子类**不能**同时继承多个父类。这一点和大多数面向对象语言（如 Java、C#）是一致的。

虽然不能通过继承实现多重继承，但你可以使用 [**mixin（混入）**](/ts/typescript-mixins/) 模式来“模拟”多个父类的效果。TypeScript 支持使用函数将多个类的功能“混入”到一个目标类中。

:::



## 小结

TypeScript 的继承功能为面向对象编程提供了强大的支持。通过继承，你可以重用代码，提高代码的可读性和可维护性。单类继承、多级继承、`super` 关键字和方法重写等功能，帮助你在实际开发中灵活地组织和扩展代码。掌握继承的使用，是成为 TypeScript 高级开发者的必经之路。

