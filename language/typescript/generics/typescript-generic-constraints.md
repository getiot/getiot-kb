---
sidebar_position: 2
slug: /typescript-generic-constraints
---

# TypeScript - 泛型约束

在 TypeScript 中，**泛型**（Generic）可以让你编写通用且可复用的函数或类。但有时候你可能希望限制传入泛型的类型，以确保它们符合某些结构，这时候就需要用到 **泛型约束**（Generic Constraints）。

如果你在没有设置泛型约束的情况下访问泛型对象的某个属性，TypeScript 编译器会报错，因为它无法确定该属性是否真的存在。



## 问题示例

在深入学习泛型约束之前，我们先通过一个示例来理解何时需要使用泛型约束。

**示例 1：合并对象**

```typescript showLineNumbers
function merge<T, U>(obj1: T, obj2: U) {
    return { ...obj1, ...obj2 };
}

const mergedObj = merge({ name: 'Sam' }, { age: 30 });
console.log(mergedObj); // 输出：{ name: 'Sam', age: 30 }
```

如果我们将第二个参数改为布尔值，代码将无法正确执行：

```typescript showLineNumbers
const mergedObj = merge({ name: 'Sam' }, true);
console.log(mergedObj); // 输出：{ name: 'Sam' }
```

为了确保泛型参数仅接受特定类型的数据，我们可以使用泛型约束。



## 泛型约束的工作原理

泛型约束允许你限制泛型参数，使其仅接受特定类型的数据。语法如下：

```typescript
function merge<T extends object>(obj1: T) {
    // 函数体
}
```

- `T` 是泛型类型。
- `extends` 是关键字。
- `object` 是数据类型。

**示例：限制泛型参数为对象**

```typescript showLineNumbers
function merge<T extends object, U extends object>(obj1: T, obj2: U) {
    return { ...obj1, ...obj2 };
}

const mergedObj = merge({ name: 'Sam' }, true);
// 错误：'boolean' 类型的参数不能分配给 'object' 类型的参数。
```



## 使用接口扩展泛型约束

请看下面示例，在这个示例中：

- 我们定义了包含姓名、年龄和电子邮件属性的“Person”接口。
- 接下来，我们定义了包含“empCode”和“empDept”属性的“Employee”接口。
- merge() 函数包含两个 Person 类型的泛型参数 T 和 Employee 类型的泛型参数 U。
- 在 merge() 函数中，我们合并两个对象。
- 之后，我们分别定义了两个类型为 Person 和 Employee 的对象。
- 接下来，我们通过传递对象作为参数来调用 merge() 函数，并且代码运行时没有任何错误。

```typescript showLineNumbers
interface Person {
    name: string;
    age: number;
    email: string;
}

interface Employee {
    empCode: number;
    empDept: string;
}

function merge<T extends Person, U extends Employee>(obj1: T, obj2: U) {
    return { ...obj1, ...obj2 };
}

const person: Person = { name: 'John', age: 30, email: 'abc@gmail.com' };
const employee: Employee = { empCode: 1001, empDept: 'IT' };

const mergedObj = merge(person, employee);
console.log(mergedObj);
```

输出结果：

```bash
{
  name: 'John',
  age: 30,
  email: 'abc@gmail.com',
  empCode: 1001,
  empDept: 'IT'
}
```



## 在泛型约束中使用类型参数

TypeScript 还允许你定义一个类型参数，该参数受同一函数中另一个参数的约束。

在下面示例代码中，类型“U”扩展了第一个参数中接收的对象的键。因此，它将接受 obj 对象的键作为参数，以避免函数体中出现错误。接下来，我们通过传递“obj”对象作为参数来调用 getValue() 函数。它在输出中打印键值。

```typescript showLineNumbers
function getValue<T extends object, U extends keyof T>(obj: T, key: U) {
    return obj[key];
}

const obj = {
    name: 'Sam',
    age: 34
};

const name1 = getValue(obj, 'name');
console.log(name1); // 输出：Sam
```

输出结果：

```bash
Sam
```



## 小结

泛型约束是 TypeScript 泛型系统中的一项关键能力，它让你可以在享受泛型带来的灵活性的同时，也能保证类型安全。通过使用 `extends`、接口或内置类型工具（如 `keyof`），你可以精准地限制泛型的使用范围，避免出现类型不明确的问题。当你构建复杂系统或复用组件时，掌握泛型约束会为你带来更强大的类型表达能力。

