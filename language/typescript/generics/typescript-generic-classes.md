---
sidebar_position: 4
slug: /typescript-generic-classes
---

# TypeScript - 泛型类

在 TypeScript 中，**泛型类**是一种能够处理多种数据类型的类结构。通过在类名后添加泛型参数（例如 `<T>`），你可以创建灵活且可复用的类，既不牺牲类型安全，也无需为每种类型编写重复代码。

泛型类在数据结构（如队列、栈、列表等）中非常有用。下面就带你一步步了解它的用法。



## 语法

定义泛型类的语法如下：

```typescript
class ClassName<T, U> {
    // 类体
}
let obj = new ClassName.DataType1.DataType2();
```

- `ClassName` 是类的名称。
- `<T, U>` 是类型参数，你可以根据需要指定多个类型参数。
- 在创建类的实例时，需要在类名后使用尖括号 `< >` 指定类型参数。

你可以像这样定义一个使用泛型的类：

```typescript
class GenericNumber<T> {
    zeroValue: T;
    add: (x: T, y: T) => T;
}
```

这个类声明了一个泛型类型参数 `T`，你可以用它来替代类中的具体类型。也就是说，不论是 `number`、`string` 还是其他类型，只要在使用时指定，类就可以根据需要灵活工作。



## 示例

### 示例 1：基本用法

在这个例子中，我们定义了名为 `Box` 的泛型类，其采用类型参数 `T`。在类中，我们定义了类型 `T` 的 `val` 变量，以及初始化 `val` 变量值的构造函数。

之后，我们分别定义了名为 `get()` 和 `set()` 的 getter 和 setter 来获取和设置 `val` 变量的值。

最后，我们定义了 `Box` 类的 box1 和 box2 对象，它们分别以数字和字符串作为类型参数。

```typescript showLineNumbers
class Box<T> {
    val: T;

    constructor(value: T) {
        this.val = value;
    }

    get(): T {
        return this.val;
    }

    set(value: T): void {
        this.val = value;
    }
}

let box1 = new Box<number>(10);
console.log(box1.get()); // 输出：10

let box2 = new Box<string>("Hello");
console.log(box2.get()); // 输出：Hello
```



### 示例 2：栈的实现

下面示例将演示如何通过泛型类实现栈的功能。首先定义一个参数类型为 `T` 的 Stack 类，它有一个私有变量 `st`，其类型是 `T` 类型的数组。然后在构造函数中初始化 `st` 数组，并实现几个方法。

- `push()` 方法以 `T` 类型的元素作为参数，并将其插入 `st` 数组中。
- `pop()` 方法从 `st` 数组中删除最后一个元素并返回它。
- `peek()` 方法返回数组中的最后一个元素。
- `isEmpty()` 方法根据数组是否为空返回布尔值。
- `size()` 方法返回 `st` 数组的大小。

最后，我们尝试用数字类型定义了 Stack 类的对象，并使用 Stack 类的方法执行各种操作。

```typescript showLineNumbers
class Stack<T> {
    private st: T[] = [];

    constructor(initialContents?: T[]) {
        if (initialContents) {
            this.st = initialContents;
        }
    }

    push(item: T): void {
        this.st.push(item);
    }

    pop(): T | undefined {
        return this.st.pop();
    }

    peek(): T | undefined {
        return this.st[this.st.length - 1];
    }

    isEmpty(): boolean {
        return this.st.length === 0;
    }

    size(): number {
        return this.st.length;
    }
}

const numberStack = new Stack<number>();
numberStack.push(1);
numberStack.push(2);
numberStack.push(3);

console.log(numberStack.peek());    // 输出：3
console.log(numberStack.pop());     // 输出：3
console.log(numberStack.peek());    // 输出：2
console.log(numberStack.isEmpty()); // 输出：false
console.log(numberStack.size());    // 输出：2
```



## 使用泛型类实现泛型接口

在 TypeScript 中，泛型类也可以实现泛型接口。因此，你可以使用单个泛型接口来实现多个泛型类，从而实现代码的复用。使用泛型类实现泛型接口的基本语法如下：

```typescript
class class_name<T> implements interface_name<T> {
    // Class body
}
```

- `class class_name<T>` 定义了通用类；
- `implements` 是使用类实现接口的关键字；
- `interface_name<T>` 是一个通用接口。

### 示例 3：实现泛型接口

下面示例定义了一个名为 `dataBase` 的通用接口，它声明了 `findById()` 和 `save()` 方法。同时还定义了一个名为 `memorydataBase` 的通用类，并使用 `dataBase` 接口实现它。在这个类中，定义了私有变量 `items`，它将数值存储为键，即 `T` 类型的值。并实现了 `DataBase` 接口中声明的两个方法。

- `findById()` 方法从映射中按键访问值并返回它。
- `save()` 方法将键值对存储在 `items` 映射中。

最后，我们创建了 `MemorydataBase` 类的对象，并使用此方法执行各种操作。

```typescript showLineNumbers
interface DataBase<T> {
    findById(id: number): T | undefined;
    save(item: T): void;
}

class MemoryDataBase<T> implements DataBase<T> {
    private items = new Map<number, T>();

    findById(id: number): T | undefined {
        return this.items.get(id);
    }

    save(item: T): void {
        const id = this.items.size + 1;
        this.items.set(id, item);
    }
}

const repo = new MemoryDataBase<string>();
repo.save("Hello");
console.log(repo.findById(1)); // 输出：Hello
```



## 为什么使用泛型类？

如果你有一些逻辑结构是“类型无关”的，比如实现一个容器、缓冲区、队列等，就非常适合使用泛型类。泛型让你只写一遍逻辑，却能作用于多种类型，而且还能保持类型检查和自动补全的好处。



## 小结

TypeScript 的泛型类让你可以编写适用于各种类型的可复用代码。通过在类中使用泛型参数，你不再需要重复为不同类型编写几乎相同的类。无论是处理数字、字符串还是更复杂的对象，泛型类都可以让你的代码更简洁、更灵活，同时保持类型安全，是你深入 TypeScript 泛型世界的重要一环。
