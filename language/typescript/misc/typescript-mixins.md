---
sidebar_position: 9
slug: /typescript-mixins
---

# TypeScript - Mixins 混入模式

在 TypeScript 中，Mixin（混入）是一种设计模式，允许你将多个类的功能组合到一个类中，从而实现代码的复用和模块化。由于 TypeScript 不支持多重继承，mixin 提供了一种灵活的方式来扩展类的功能。它允许你在一个类中重用多个类的方法和属性，从而实现多重继承的效果。



## 为什么需要混入模式？

TypeScript 是一种面向对象的编程语言，包含类，它们是对象的蓝图。在 TypeScript 中，类的定义如下所示。

```typescript
class MathOps {
    // defining a method
    add(a: number, b: number): void {
        console.log('sum is: ', a + b);
    }
}
```

现在，假设我们有多个像上面那样的类，它们包含不同的操作。

如果你想重用这两个类，并想通过扩展这两个类来创建第三个类，该怎么办？例如，如果你尝试用 `MathOps` 和 `BitwiseOps` 类扩展 `allOps` 类，TypeScript 会报错，因为 TypeScript 不允许多重继承。

```typescript
class allOps extends MathOps, BitwiseOps {
    // Executable code
}
```

为了解决上述问题，就需要用到 TypeScript 中的 mixins 混入模式。它通过组合多个类的特性，提供了一种更简洁和灵活的解决方案。

混入模式的核心思想是通过函数将一个类的属性和方法复制到另一个类中。这通常涉及到对类原型的操作，以确保混入的类能够正确地继承和扩展功能。



## 示例：实现 Mixin 辅助函数

### 定义混入辅助函数

```typescript showLineNumbers
// 定义一个辅助函数，用于将多个类的属性和方法复制到一个目标类
function applyMixins(derivedCtor: any, baseCtors: any[]) {
    // 遍历所有基类
    baseCtors.forEach(baseCtor => {
        // 获取基类原型上的所有属性名
        Object.getOwnPropertyNames(baseCtor.prototype).forEach(name => {
            // 将基类原型上的属性和方法复制到目标类的原型上
            derivedCtor.prototype[name] = baseCtor.prototype[name];
        });
    });
}
```

在这个示例中，我们采用了直接赋值的方式复制了类的属性。不过这种方式只复制了属性的值，而没有复制其他特性，如 `get`、`set`、`configurable` 和 `enumerable` 等。这种方法在大多数情况下有效，但对于需要复制特殊属性（如 `get` 和 `set`）的场景，可能会导致行为不一致。

为了解决这个问题，你可以使用 `Object.getOwnPropertyDescriptor` 和 `Object.defineProperty` 函数，确保复制的属性在目标类中具有与源类中完全相同的行为，包括访问修饰符、可枚举性等。

```typescript showLineNumbers {4}
function applyMixins(derivedCtor: any, baseCtors: any[]) {
    baseCtors.forEach(baseCtor => {
        Object.getOwnPropertyNames(baseCtor.prototype).forEach(name => {
            Object.defineProperty(derivedCtor.prototype, name, Object.getOwnPropertyDescriptor(baseCtors.prototype, name));
        });
    });
}
```



### 创建混入类

```typescript showLineNumbers
// 定义一个游泳类，包含游泳相关的方法
class Swimmer {
    StartSwim() {
        console.log('Starting the swimming session...');
    }
    EndSwim() {
        console.log('Completed the swimming session.');
    }
}

// 定义一个骑行类，包含骑行相关的方法
class Cyclist {
    StartCycle() {
        console.log('Starting the cycling session...');
    }
    EndCycle() {
        console.log('Completed the cycling session.');
    }
}

// 定义一个双项运动员类
class Biathlete {}

// 使用接口合并多个类的类型定义
interface Biathlete extends Swimmer, Cyclist {}

// 使用辅助函数将 Swimmer 和 Cyclist 的方法和属性混入到 Biathlete 类中
applyMixins(Biathlete, [Swimmer, Cyclist]);
```

关键说明：

- **`Biathlete` 类**是一个空类，用于接收混入的属性和方法。
- **接口合并**：通过 `interface Biathlete extends Swimmer, Cyclist {}`，告诉 TypeScript 编译器 `Biathlete` 类应该包含 `Swimmer` 和 `Cyclist` 的所有方法和属性。
- **混入操作**：通过 `applyMixins(Biathlete, [Swimmer, Cyclist])` 将 `Swimmer` 和 `Cyclist` 的方法和属性复制到 `Biathlete` 类中。



### 调用混入类对象

现在，你可以创建一个 Biathlete 类的实例，并调用混入的方法。

```typescript showLineNumbers
// 创建 Biathlete 类的实例
const athlete = new Biathlete();

// 调用混入的方法
athlete.StartSwim();
athlete.EndSwim();
athlete.StartCycle();
athlete.EndCycle();
```

输出结果：

```bash
Starting the swimming session...
Completed the swimming session.
Starting the cycling session...
Completed the cycling session.
```



## 小结

通过本章的学习，你了解了 TypeScript 中的 Mixins 混入模式及其实现方式。它提供了一种灵活的方式来组合多个类的功能，弥补了 TypeScript 不支持多重继承的限制。掌握 Mixins 混入模式，将有助于你编写更加模块化和可维护的代码。
