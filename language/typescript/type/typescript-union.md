---
sidebar_position: 12
slug: /typescript-union
---

# TypeScript - Union 联合类型

在 TypeScript 中，**联合类型（Union Type）** 允许你为一个变量指定多个可能的类型。这意味着一个变量可以在不同场景中接受多种类型的值，从而提供更大的灵活性。联合类型通过竖线（`|`）将多个类型组合在一起。



## 语法

你可以使用竖线（`|`）将多个类型连接起来，表示这个变量可以是其中任意一种类型。

联合类型的语法如下：

```typescript
Type1 | Type2 | Type3
```

例如：

```typescript
let value: number | string | boolean;
```

在上面的例子中，我们定义了一个名为 `value` 的变量，它可以是数字、字符串或布尔值。



## 定义联合类型变量

你可以定义一个联合类型的变量，该变量可以存储多种类型的值。

**示例：联合类型变量**

```typescript showLineNumbers
var val: string | number;

val = 12;
console.log("numeric value of val: " + val);

val = "This is a string";
console.log("string value of val: " + val);
```

输出结果：

```bash
numeric value of val: 12
string value of val: This is a string
```



## 联合类型与函数参数

你可以定义一个函数，使其参数为联合类型。这样，调用函数时可以传递联合类型中的任何一种类型的参数。

**示例：联合类型函数参数**

```typescript showLineNumbers
function disp(name: string | string[]) {
    if (typeof name === "string") {
        console.log(name);
    } else {
        for (let i = 0; i < name.length; i++) {
            console.log(name[i]);
        }
    }
}

disp("mark");
console.log("Printing names array....");
disp(["Mark", "Tom", "Mary", "John"]);
```

输出结果：

```bash
mark
Printing names array....
Mark
Tom
Mary
John
```



## 联合类型与数组

联合类型也可以应用于数组，表示数组可以存储多种类型的值。

**示例：联合类型数组**

```typescript showLineNumbers
var arr: number[] | string[];
var i: number;

arr = [1, 2, 4];
console.log("**numeric array**");

for (i = 0; i < arr.length; i++) {
    console.log(arr[i]);
}

arr = ["Mumbai", "Pune", "Delhi"];
console.log("**string array**");

for (i = 0; i < arr.length; i++) {
    console.log(arr[i]);
}
```

输出结果：

```bash
**numeric array**
1
2
4
**string array**
Mumbai
Pune
Delhi
```



## 小结

联合类型在 TypeScript 中是一种非常灵活的类型，允许你定义一个值可以是多种类型中的一种。通过联合类型，你可以更灵活地处理不同的数据类型，同时保持代码的类型安全性。在实际开发中，联合类型常用于函数参数、变量和数组等场景，帮助你编写更灵活、更安全的代码。
