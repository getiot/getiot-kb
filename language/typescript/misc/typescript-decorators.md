---
sidebar_position: 5
slug: /typescript-decorators
---

# TypeScript - 装饰器

在 TypeScript 中，装饰器（Decorator）是一种特殊的声明形式，可以附加到类声明、方法、访问器、属性或参数上。它们允许你在不修改原始源代码的情况下，独立地修改类的行为。这使得装饰器成为面向对象编程中的强大工具，有助于编写更清晰、组织良好的代码，并遵循 DRY（Don't Repeat Yourself）原则。

装饰器通过在类声明、属性、方法或参数前添加特殊语法（`@decorator`）来实现。



## 启用装饰器

要使用装饰器，你需要在 `tsconfig.json` 文件中启用 `experimentalDecorators` 选项：

```json showLineNumbers title="tsconfig.json"
{
    "compilerOptions": {
        "target": "ES5",
        "experimentalDecorators": true
    }
}
```

或者在编译时使用命令行参数指定启用装饰器，例如：

```bash
tsc --target ES5 --experimentalDecorators
```



## 装饰器语法

装饰器的基本语法如下：

```typescript
@DecoratorName
```

其中，`DecoratorName` 是一个函数名，前缀为 `@` 符号。该表达式在运行时会被解析为 `DecoratorName` 函数被调用。



## 装饰器工厂

当你需要自定义装饰器函数如何应用于声明时，可以使用装饰器工厂（Decorator Factories）。装饰器工厂是一个返回装饰器函数的函数，允许你动态地定制装饰器的行为。

以下是装饰器工厂的语法：

```typescript showLineNumbers
function decoratorName(args: string) {
    // 装饰器工厂返回一个函数表达式
    return function (target) {
        // 这是在运行时会被评估的装饰器
    };
}
```

在上面的语法中，`args` 是传递给装饰函数的参数，`target` 是类的原型。



## 装饰器组合

你可以为同一个声明使用多个装饰器，它们可以写在同一行或不同行。

```typescript showLineNumbers
@f @g x
```

或

```typescript showLineNumbers
@f
@g
x
```

在上面的语法中，`f` 和 `g` 装饰器与单个声明 `x` 一起使用。



## 示例

### 示例 1：方法装饰器

Student 类中定义了 `sayHello()` 和 `printrollNo()` 方法。现在，如果我们想在函数执行开始和结束时记录日志怎么办？按照传统方法，你需要在每个函数的开始和结束时添加日志。

如果我们想重用记录函数执行的逻辑，而又不想编写重复的代码，该怎么办？这时，装饰器就派上用场了！

在这个示例中，我们定义了 `printExecution` 装饰器。然后在 Student 类成员方法 `sayHello()` 和 `printrollNo()` 前面增加 `@printExecution` 声明即可。

```typescript showLineNumbers
function printExecution(method: any, _context: any) {
    return function (value: any, ...args: any[]) {
        console.log("start:", method.name);
        const result = method.call(value, ...args);
        console.log("end:", method.name);
        return result;
    }
}

class Student {
    constructor(private name: string, private rollNo: number) {}

    @printExecution
    sayHello() {
        console.log(`Hello, my name is ${this.name}.`);
    }

    @printExecution
    printrollNo() {
        console.log(`My RollNo is ${this.rollNo}.`);
    }
}

const user = new Student("John", 20);
user.sayHello();
user.printrollNo();
```

输出结果：

```bash
start: sayHello
Hello, my name is John.
end: sayHello
start: printrollNo
My RollNo is 20.
end: printrollNo
```



### 示例 2：类装饰器

```typescript showLineNumbers
function LogClass(target: Function) {
    console.log(`${target.name} is instantiated`);
}

@LogClass
class MyClass {
    constructor() { console.log("MyClass instance created"); }
}

const myClassInstance = new MyClass();
```

输出结果：

```bash
MyClass instance created
MyClass is instantiated
```



### 示例 3：属性装饰器

```typescript showLineNumbers
function LogProperty(target: any, propertyKey: string) {
    console.log(`Property declared: ${propertyKey}`);
}

class Person {
    @LogProperty
    name: string;

    @LogProperty
    age: number;

    constructor(name: string, age: number) {
        this.name = name;
        this.age = age;
    }
}

let person = new Person('Jay', 23);
```

输出结果：

```bash
Property declared: name
Property declared: age
```



## 小结

TypeScript 的装饰器为扩展和修改类及其成员提供了强大的工具。通过装饰器，你可以轻松地实现日志记录、性能监控、属性验证等功能，而无需修改原始代码。掌握装饰器的使用，你可以利用装饰器来编写更清晰、可维护的代码。



