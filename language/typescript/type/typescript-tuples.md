---
sidebar_position: 8
sidebar_label: TypeScript - 元组
slug: /typescript-tuples
---

# TypeScript - Tuple 元组

元组（Tuple）是 TypeScript 中一种特殊的数据类型，用于表示一个固定长度的数组，其中每个位置上的元素都有特定的类型。元组允许你在数组中存储不同类型的值，同时保持类型安全。



## 语法

你可以使用以下语法声明和初始化一个元组：

```typescript
const tupleName: [type1, type2, type3, ..., typeN] = [value1, value2, value3, ..., valueN];
```

示例：

```typescript
const myTuple: [number, string] = [10, "Hello"];
```

你也可以先声明元组类型，再进行初始化：

```typescript
let myTuple: [number, string];
myTuple = [10, "Hello"];
```



## 访问元组中的值

元组中的值可以通过索引访问，索引从 0 开始：

```typescript
const myTuple: [number, string] = [10, "Hello"];
console.log(myTuple[0]); // 输出：10
console.log(myTuple[1]); // 输出：Hello
```



## 空元组

你也可以声明一个空元组，然后在稍后初始化：

```typescript
let tup: [number, string] = [];
tup[0] = 12;
tup[1] = "Hello";
console.log(tup[0]); // 输出：12
console.log(tup[1]); // 输出：Hello
```



## 元组操作

元组支持多种操作，例如添加新元素、删除元素等。

示例：

```typescript
let myTuple: [number, string, string, string];
myTuple = [10, "Hello", "World", "TypeScript"];
console.log("添加前元素数量：" + myTuple.length);

myTuple.push(12);
console.log("添加后元素数量：" + myTuple.length);

console.log("删除前元素数量：" + myTuple.length);
console.log(myTuple.pop() + " 已从元组中删除");
console.log("删除后元素数量：" + myTuple.length);
```

输出结果：

```bash
添加前元素数量：4
添加后元素数量：5
删除前元素数量：5
12 已从元组中删除
删除后元素数量：4
```



## 更新元组

元组是可变的，你可以更新元组中的元素值：

```typescript
let myTuple: [number, string, string, string];
myTuple = [10, "Hello", "World", "TypeScript"];
console.log("索引 0 处的值：" + myTuple[0]);

myTuple[0] = 121;
console.log("索引 0 处的值已更新为：" + myTuple[0]);
```

输出结果：

```bash
索引 0 处的值：10
索引 0 处的值已更新为：121
```



## 元组解构

你可以通过解构的方式将元组中的值分配给单独的变量：

```typescript
const a: [number, string] = [10, "hello"];
const [b, c] = a;
console.log(b); // 输出：10
console.log(c); // 输出：hello
```



## 函数参数中的元组类型

你可以定义一个函数，使其接受元组类型的参数：

```typescript
function processData(data: [string, number]): void {
    const [name, age] = data;
    console.log(`姓名：${name}，年龄：${age}`);
}
let data: [string, number] = ["John", 32];
processData(data);
```

输出结果：

```bash
姓名：John，年龄：32
```



## 小结

TypeScript 的元组类型允许你在数组中存储不同类型的值，同时保持类型安全。你可以通过索引访问和更新元组中的元素，还可以使用多种方法操作元组。元组的解构功能让你可以方便地将元组中的值分配给单独的变量。在需要固定结构的数组时，元组是一个非常有用的数据类型。
