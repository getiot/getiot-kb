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

请看下面示例：

```typescript
class Person {
    public name: string = "";
    public greet(): void {
        console.log(`Hello, my name is ${this.name}!`);
    }
}

const person = new Person();
person.name = "John";
person.greet();   // 输出：Hello, my name is John!
```

编译后的 JavaScript 代码：

```javascript
class Person {
    constructor() {
        this.name = "";
    }
    greet() {
        console.log(`Hello, my name is ${this.name}!`);
    }
}

const person = new Person();
person.name = "John";
person.greet();
```



## Private 访问修饰符

`private` 修饰符限制了类成员的访问范围，使其只能在定义它的类内部访问。

请看下面示例：

```typescript
class BankAccount {
    private balance: number;
    constructor(initialBalance: number) {
        this.balance = initialBalance;
    }
    private calculateInterest(): number {
        const interestRate = 0.05;
        return this.balance * interestRate;
    }
}

// 创建 BankAccount 类的实例
const account = new BankAccount(1000);

// 尝试访问私有成员
console.log(account.balance);             // 编译错误：'balance' 是私有的
console.log(account.calculateInterest()); // 编译错误：'calculateInterest' 是私有的
```

编译后的 JavaScript 代码：

```javascript
class BankAccount {
    constructor(initialBalance) {
        this.balance = initialBalance;
    }
    calculateInterest() {
        const interestRate = 0.05;
        return this.balance * interestRate;
    }
}

// 创建 BankAccount 类的实例
const account = new BankAccount(1000);

// 尝试访问私有成员
console.log(account.balance);
console.log(account.calculateInterest());
```

运行时会抛出错误，因为尝试访问了私有成员。



## Protected 访问修饰符

`protected` 修饰符允许类成员在定义它的类及其子类中访问。

请看下面示例：

```typescript
class Animal {
    protected name: string;
    constructor(name: string) {
        this.name = name;
    }
    protected makeSound(): void {
        console.log("The animal makes a sound");
    }
}

class Dog extends Animal {
    public bark(): void {
        console.log(`${this.name} barks!`);
    }
}

// 创建 Dog 类的实例
const dog = new Dog("Buddy");
dog.bark(); // 输出：Buddy barks!
```

编译后的 JavaScript 代码：

```javascript
class Animal {
    constructor(name) {
        this.name = name;
    }
    makeSound() {
        console.log("The animal makes a sound");
    }
}
class Dog extends Animal {
    bark() {
        console.log(`${this.name} barks!`);
    }
}

// 创建 Dog 类的实例
const dog = new Dog("Buddy");
dog.bark();
```



## 小结

TypeScript 的访问修饰符为实现封装提供了强大的支持。通过 `public`、`private` 和 `protected` 修饰符，你可以精确控制类成员的访问权限，从而提高代码的安全性和可维护性。在实际开发中，合理使用访问修饰符可以帮助你更好地组织代码，避免不必要的副作用。掌握访问修饰符的使用，是成为 TypeScript 高级开发者的必经之路。
