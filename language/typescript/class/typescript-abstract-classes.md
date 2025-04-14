---
sidebar_position: 7
slug: /typescript-abstract-classes
---

# TypeScript - 抽象类

在面向对象编程中，有些类并不用于直接创建对象，而是用作其他类的基础结构。在 TypeScript 中，你可以使用 **抽象类（abstract class）** 来实现这样的设计。

抽象类是一种隐藏底层代码实现的方式，它向用户和部分开发者隐藏了复杂的实现细节，只展示方法所需的信息，而不是展示方法的完整复杂实现。简单来说，抽象类就像是一个**蓝图**，它定义了一组共同的属性和方法（包括抽象方法和具体实现的方法），供子类继承和扩展。



## 定义抽象类

在 TypeScript 中，使用 `abstract` 关键字定义一个抽象类。抽象类**不能被实例化**，它只能被继承。

```typescript showLineNumbers
abstract class Animal {
  abstract makeSound(): void;

  move(): void {
    console.log("Moving around...");
  }
}
```

在上面的例子中：

- `makeSound()` 是一个**抽象方法**，也就是说，它没有具体实现；
- `move()` 是一个普通方法，有自己的实现；
- 这个类本身是抽象的，不能用 `new Animal()` 直接创建对象。



## 抽象方法

抽象类可以包含普通方法和抽象方法。在抽象类中，你需要实现普通方法，而抽象方法只需要声明。抽象方法是没有函数体的方法，你只能在抽象类中声明它们，然后由子类去实现。

```typescript showLineNumbers
abstract class Animal {
  abstract makeSound(): void;
}
```



:::tip 注意

一旦类中声明了抽象方法，那么这个类也必须用 `abstract` 声明。

:::



## 子类继承并实现抽象类

你可以通过继承抽象类来使用它，但在子类中必须实现抽象类中的**所有抽象方法**。如果你不想在子类中实现抽象方法，你需要使用 `abstract` 关键字将子类也声明为抽象类。

```typescript showLineNumbers
abstract class Animal {
  abstract makeSound(): void;

  move(): void {
    console.log("Moving...");
  }
}

class Dog extends Animal {
  makeSound(): void {
    console.log("Woof!");
  }
}

let myDog = new Dog();
myDog.makeSound(); // 输出：Woof!
myDog.move();      // 输出：Moving...
```

在这个例子中：

- `Dog` 类继承了抽象类 `Animal`；
- 它实现了 `makeSound()` 方法；
- 同时继承了 `move()` 方法的实现。



## 抽象类不能被实例化

你不能直接创建一个抽象类的实例，否则会导致编译错误。

```typescript
let animal = new Animal(); // ❌ 编译错误：Cannot create an instance of an abstract class.
```



## 使用场景

你可以使用抽象类来定义一个通用的基础类型，然后根据需要让不同子类提供具体实现。这在大型应用中非常常见，例如：

- 不同类型的用户（Admin、Guest、Member）继承自一个通用的 User 类；
- 不同类型的图形（Circle、Rectangle）继承自一个通用的 Shape 类。



## 抽象类 vs 接口

|       特性       |        抽象类        |          接口          |
| :--------------: | :------------------: | :--------------------: |
| 是否可以包含实现 | ✅ 可以（非抽象方法） | ❌ 不可以（全部是定义） |
| 是否可以包含字段 |        ✅ 可以        |        ❌ 不可以        |
|      多继承      |  ❌ 不支持类的多继承  |  ✅ 支持多个接口的实现  |
|     使用场景     |  行为和状态共同定义  | 只定义行为（方法签名） |



## 小结

在 TypeScript 中，抽象类提供了一种结构化的方式，来定义通用的属性和行为，同时留出一些由子类自行实现的部分。通过使用抽象类，你可以让代码结构更清晰、职责更明确，尤其适合用于描述具备相似特性的对象集合。记住，抽象类不能被实例化，但它为你构建稳定、可扩展的代码体系提供了坚实的基础。
