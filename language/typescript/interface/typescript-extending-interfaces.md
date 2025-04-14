---
sidebar_position: 2
slug: /typescript-extending-interfaces
---

# TypeScript - 扩展接口

在 TypeScript 中，**接口**（Interface） 用于定义对象的结构。而当你希望一个接口能从另一个接口那里“继承”属性时，就可以使用 **扩展接口**（Extending Interfaces） 的特性。

简单来说，这就像类的继承机制一样：你可以基于已有接口创建一个更复杂的新接口，而不用重复定义相同的属性。



## 语法

使用 `extends` 关键字可以扩展一个或多个接口。语法如下：

```typescript
interface NewInterface extends ExistingInterface {
    // 新的属性和方法
}

interface NewInterface extends Interface1, Interface2, ... {
    // 新的属性和方法
}
```



## 单接口扩展

你可以通过扩展单个接口来实现单接口继承。例如，我们有一个 `Shape` 接口，它定义了一个 `color` 属性。我们可以创建一个新的接口 `ColoredShape`，它继承自 `Shape` 并添加一个新的 `name` 属性。

**示例**：

```typescript
interface Shape {
    color: string;
}

interface ColoredShape extends Shape {
    name: string;
}

const square: ColoredShape = {
    color: "red",
    name: "Square",
};

console.log(square.color); // 输出：red
console.log(square.name);  // 输出：Square
```

编译后的 JavaScript 代码：

```javascript
var square = {
    color: "red",
    name: "Square"
};
console.log(square.color);
console.log(square.name);
```



## 多接口扩展

TypeScript 允许你扩展多个接口，从而创建一个结合了所有扩展接口属性和方法的新接口。这使得我们可以实现多重接口继承。

**示例**：

在下面的例子中，我们定义了 `Printable` 和 `Scanable` 接口，每个接口都有自己的方法。然后，我们创建了 `MultifunctionalDevice` 接口，它继承了 `Printable` 和 `Scanable` 接口，并添加了一个新的 `copy()` 方法。我们通过一个类 `Printer` 实现了 `MultifunctionalDevice` 接口，并提供了所有方法的实现。

```typescript
interface Printable {
    print(): void;
}

interface Scanable {
    scan(): void;
}

interface MultifunctionalDevice extends Printable, Scanable {
    copy(): void;
}

class Printer implements MultifunctionalDevice {
    print() {
        console.log("Printing...");
    }

    scan() {
        console.log("Scanning...");
    }

    copy() {
        console.log("Copying...");
    }
}

const printer = new Printer();
printer.print(); // 输出：Printing...
printer.scan();  // 输出：Scanning...
printer.copy();  // 输出：Copying...
```

编译后的 JavaScript 代码：

```javascript
var Printer = (function () {
    function Printer() {
    }
    Printer.prototype.print = function () {
        console.log("Printing...");
    };
    Printer.prototype.scan = function () {
        console.log("Scanning...");
    };
    Printer.prototype.copy = function () {
        console.log("Copying...");
    };
    return Printer;
}());

var printer = new Printer();
printer.print();
printer.scan();
printer.copy();
```



## 扩展现有接口

你可能经常会遇到需要在不直接修改原始接口的情况下，为现有接口添加额外属性或方法的情况。通过扩展接口，你可以轻松实现这一点。

**示例**：

在这个例子中，我们有一个现有的 `User` 接口，它有一个 `name` 属性。我们通过扩展 `User` 接口创建了一个 `EnhancedUser` 接口，它添加了一个 `age` 属性和一个 `greet()` 方法。通过扩展接口，我们定义了一个 `user` 对象，它包含了来自两个接口的属性和方法。

```typescript
interface User {
    name: string;
}

interface EnhancedUser extends User {
    age: number;
    greet(): void;
}

const user: EnhancedUser = {
    name: "John Wick",
    age: 25,
    greet() {
        console.log(`Hello, my name is ${this.name} and I'm ${this.age} years old.`);
    }
};

user.greet(); // 输出：Hello, my name is John Wick and I'm 25 years old.
```

编译后的 JavaScript 代码：

```javascript
var user = {
    name: "John Wick",
    age: 25,
    greet: function () {
        console.log("Hello, my name is ".concat(this.name, " and I'm ").concat(this.age, " years old."));
    }
};

user.greet();
```



## 创建复合接口

扩展接口在创建复合接口时也非常有用，这些复合接口可以从多个来源组合属性和方法。这在与提供接口的外部库或模块一起工作时特别有用。

**示例**：

在这个例子中，我们有四个接口：`Product`、`DiscountedProduct`、`ProductWithReviews` 和 `FeaturedProduct`。每个接口都继承了一个或多个现有接口，允许我们创建一个包含多个来源属性和方法的复合接口。我们定义了一个类型为 `FeaturedProduct` 的 `product` 对象，它包含了所有扩展接口中定义的属性。

```typescript
interface Product {
    name: string;
    price: number;
}

interface DiscountedProduct extends Product {
    discount: number;
}

interface ProductWithReviews extends Product {
    reviews: string[];
}

interface FeaturedProduct extends DiscountedProduct, ProductWithReviews {
    featured: boolean;
}

const product: FeaturedProduct = {
    name: "Smartphone",
    price: 599,
    discount: 50,
    reviews: ["Great product!", "Highly recommended."],
    featured: true
};

console.log(product.featured); // 输出：true
console.log(product.reviews);  // 输出：[ 'Great product!', 'Highly recommended.' ]
```

编译后的 JavaScript 代码：

```javascript
var product = {
    name: "Smartphone",
    price: 599,
    discount: 50,
    reviews: ["Great product!", "Highly recommended."],
    featured: true
};

console.log(product.featured);
console.log(product.reviews);
```



## 重写属性和方法

在扩展接口时，你也可以重写从基接口继承的属性和方法。这允许你修改或为特定接口提供不同的属性或方法实现。

**示例**：

在下面的例子中，我们有一个 `Animal` 接口，它有一个 `name` 属性和一个 `makeSound()` 方法。我们通过扩展 `Animal` 接口创建了一个 `Dog` 接口，并在 `Dog` 接口中重写了 `makeSound()` 方法，为狗提供了特定的实现。

```typescript
interface Animal {
    name: string;
    makeSound(): void;
}

interface Dog extends Animal {
    makeSound(): void;
}

const dog: Dog = {
    name: "Buddy",
    makeSound() {
        console.log("Woof woof!");
    }
};

dog.makeSound(); // 输出：Woof woof!
```

编译后的 JavaScript 代码：

```javascript
var dog = {
    name: "Buddy",
    makeSound: function () {
        console.log("Woof woof!");
    }
};

dog.makeSound();
```



## 小结

TypeScript 的接口扩展功能为创建灵活、可维护的类型定义提供了强大的支持。通过扩展接口，你可以轻松地复用现有接口的属性和方法，同时添加新的功能。这种机制不仅有助于保持代码的整洁，还能提高代码的可读性和可维护性。在实际开发中，接口扩展特别适合处理复杂对象的类型定义，特别是在需要继承多个接口属性和方法的场景中。掌握接口扩展，可以让你的 TypeScript 代码更加模块化和专业。
