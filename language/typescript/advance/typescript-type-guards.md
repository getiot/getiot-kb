---
sidebar_position: 2
slug: /typescript-type-guards
---

# TypeScript - 类型保护

在 TypeScript 中，类型保护（Type Guards）是一种用于确定变量类型的机制。它们通常在条件块或函数块中使用，通过返回布尔值或变量类型来帮助 TypeScript 编译器推断变量在特定上下文中的类型。类型保护可以确保参数的类型符合预期，从而提高代码的安全性和可维护性。



## 内置类型保护

TypeScript 提供了几个内置的类型保护操作符：

### typeof 类型保护

`typeof` 操作符用于获取变量的类型。它返回的值可以是 `number`、`string`、`boolean`、`object`、`bigint`、`symbol`、`function` 或 `undefined`。

示例代码：

```typescript
function add(x: number | string, y: number | string): number | string {
   if (typeof x === "number" && typeof y === "number") {
      return x + y; // 数值相加
   } else {
      return x.toString() + y.toString(); // 字符串拼接
   }
}

console.log(add(10, 20));
console.log(add("Hello, ", "World"));
```

输出结果：

```bash
30
Hello, World
```

在这个例子中，`typeof` 用于检查传入参数的实际类型，从而决定是执行加法还是字符串拼接。



### in 类型保护

`in` 操作符用于检查对象是否包含特定属性。它返回一个布尔值，指示属性是否存在于对象中。

示例代码：

```typescript
let obj1: { id: number; name: string } = { id: 1, name: 'GetIoT' };
let obj2: { name: string; roll: number } = { name: 'XYZ', roll: 12 };
let obj3: { id: number; marks: { english: number; math: number } } = {
    id: 101,
    marks: {
        math: 90,
        english: 80,
    },
};

console.log('Is name in obj1? => ' + ('name' in obj1));
console.log('Is id in obj2? => ' + ('id' in obj2));
console.log('Is marks in obj3? => ' + ('marks' in obj3));
console.log('Is math in obj3.marks? => ' + ('math' in obj3.marks));
```

输出结果：

```
Is name in obj1? => true
Is id in obj2? => false
Is marks in obj3? => true
Is math in obj3.marks? => true
```



### instanceof 类型保护

`instanceof` 操作符用于确定一个值是否是特定构造函数或类的实例。

示例代码：

```typescript
class Parent {
    id: number;
    constructor(id: number) {
        this.id = id;
    }
}

class Child extends Parent {
    name: string;
    constructor(id: number, name: string) {
        super(id);
        this.name = name;
    }
}

let child = new Child(101, 'ABC');

console.log('child instanceof Child => ' + (child instanceof Child));
console.log('child instanceof Parent => ' + (child instanceof Parent));
```

输出结果：

```
child instanceof Child => true
child instanceof Parent => true
```



## 小结

TypeScript 的类型保护为确保变量类型正确提供了强大的支持。通过 `typeof`、`in` 和 `instanceof` 操作符，你可以轻松地在代码中进行类型检查和推断，从而提高代码的安全性和可维护性。掌握类型保护的使用，可以帮助你编写更加健壮和专业的 TypeScript 代码。
