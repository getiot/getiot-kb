---
sidebar_position: 1
slug: /typescript-classes
---

# TypeScript - 类（Class）

在 TypeScript 中，类（Classes）是实现面向对象编程的核心概念之一。类是一种蓝图，用于创建具有特定属性和方法的对象。TypeScript 的类基于 ES6 标准，提供了更简洁和直观的语法来定义类。

如果你接触过面向对象语言（如 Java、C++ 或 C#），TypeScript 的类语法对你来说会非常熟悉。如果你是 JavaScript 开发者，TypeScript 提供的类功能则会更加严谨、强类型化。



## 创建类

使用 `class` 关键字来声明一个类。类的定义可以包括字段、构造函数和方法。

**示例**：

```typescript showLineNumbers
class Car {
    // 字段
    engine: string;

    // 构造函数
    constructor(engine: string) {
        this.engine = engine;
    }

    // 方法
    disp(): void {
        console.log("Engine is: " + this.engine);
    }
}

// 创建对象
const obj = new Car("XXSY1");

// 访问字段
console.log("Reading attribute value Engine as: " + obj.engine);

// 调用方法
obj.disp();
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var Car = (function () {
    function Car(engine) {
        this.engine = engine;
    }
    Car.prototype.disp = function () {
        console.log("Engine is: " + this.engine);
    };
    return Car;
}());

var obj = new Car("XXSY1");
console.log("Reading attribute value Engine as: " + obj.engine);
obj.disp();
```

输出结果：

```bash
Reading attribute value Engine as: XXSY1
Engine is: XXSY1
```



## 类的继承

TypeScript 支持继承，允许你从现有类创建新类。子类继承父类的所有公共属性和方法。

**示例**：

```typescript showLineNumbers
class Shape {
    area: number;

    constructor(a: number) {
        this.area = a;
    }
}

class Circle extends Shape {
    disp(): void {
        console.log("Area of the circle: " + this.area);
    }
}

const obj = new Circle(223);
obj.disp();
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var Shape = (function () {
    function Shape(a) {
        this.area = a;
    }
    return Shape;
}());

var Circle = (function (_super) {
    __extends(Circle, _super);
    function Circle() {
        _super.apply(this, arguments);
    }
    Circle.prototype.disp = function () {
        console.log("Area of the circle: " + this.area);
    };
    return Circle;
}(Shape));

var obj = new Circle(223);
obj.disp();
```

输出结果：

```bash
Area of the circle: 223
```



## 方法重写

子类可以重写父类的方法，以提供特定的实现。

**示例**：

```typescript showLineNumbers
class PrinterClass {
    doPrint(): void {
        console.log("doPrint() from Parent called");
    }
}

class StringPrinter extends PrinterClass {
    doPrint(): void {
        super.doPrint();
        console.log("doPrint() is printing a string");
    }
}

const obj = new StringPrinter();
obj.doPrint();
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var PrinterClass = (function () {
    function PrinterClass() {
    }
    PrinterClass.prototype.doPrint = function () {
        console.log("doPrint() from Parent called");
    };
    return PrinterClass;
}());

var StringPrinter = (function (_super) {
    __extends(StringPrinter, _super);
    function StringPrinter() {
        _super.apply(this, arguments);
    }
    StringPrinter.prototype.doPrint = function () {
        _super.prototype.doPrint.call(this);
        console.log("doPrint() is printing a string");
    };
    return StringPrinter;
}(PrinterClass));

var obj = new StringPrinter();
obj.doPrint();
```

输出结果：

```bash
doPrint() from Parent called
doPrint() is printing a string
```



## 静态成员

使用 `static` 关键字可以定义类的静态成员。静态成员属于类本身，而不是类的实例。

**示例**：

```typescript showLineNumbers
class StaticMem {
    static num: number;

    static disp(): void {
        console.log("The value of num is " + StaticMem.num);
    }
}

StaticMem.num = 12;
StaticMem.disp();
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var StaticMem = (function () {
    function StaticMem() {
    }
    StaticMem.disp = function () {
        console.log("The value of num is " + StaticMem.num);
    };
    return StaticMem;
}());

StaticMem.num = 12;
StaticMem.disp();
```

输出结果：

```bash
The value of num is 12
```



## instanceof 运算符

`instanceof` 运算符用于检查对象是否属于特定类型。

**示例**：

```typescript showLineNumbers
class Person { }

const obj = new Person();
const isPerson = obj instanceof Person;
console.log("obj is an instance of Person: " + isPerson);
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var Person = (function () {
    function Person() {
    }
    return Person;
}());

var obj = new Person();
var isPerson = obj instanceof Person;
console.log("obj is an instance of Person: " + isPerson);
```

输出结果：

```bash
obj is an instance of Person: true
```



## 数据隐藏

TypeScript 提供了访问修饰符来控制类成员的可见性。

**示例**：

```typescript showLineNumbers
class Encapsulate {
    str: string = "hello";
    private str2: string = "world";
}

const obj = new Encapsulate();
console.log(obj.str); // 可访问
// console.log(obj.str2); // 编译错误：str2 是私有的
```



## 类与接口

类可以实现接口，以确保类包含接口中定义的属性和方法。

**示例**：

```typescript showLineNumbers
interface ILoan {
    interest: number;
}

class AgriLoan implements ILoan {
    interest: number;
    rebate: number;

    constructor(interest: number, rebate: number) {
        this.interest = interest;
        this.rebate = rebate;
    }
}

const obj = new AgriLoan(10, 1);
console.log("Interest is: " + obj.interest + " Rebate is: " + obj.rebate);
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var AgriLoan = (function () {
    function AgriLoan(interest, rebate) {
        this.interest = interest;
        this.rebate = rebate;
    }
    return AgriLoan;
}());

var obj = new AgriLoan(10, 1);
console.log("Interest is: " + obj.interest + " Rebate is: " + obj.rebate);
```

输出结果：

```bash
Interest is: 10 Rebate is: 1
```



## 小结

TypeScript 的类功能为面向对象编程提供了强大的支持。通过类，你可以定义具有特定属性和方法的对象蓝图。类支持继承、方法重写、静态成员、数据隐藏和接口实现等功能。掌握类的使用，可以让你的 TypeScript 代码更加结构化、模块化和专业。无论是简单的对象模型还是复杂的继承体系，类都能帮助你更好地组织代码。
