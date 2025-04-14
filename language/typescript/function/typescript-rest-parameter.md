---
sidebar_position: 7
slug: /typescript-rest-parameter
---

# TypeScript - 剩余参数

在 TypeScript 中，有时候你可能不知道一个函数会接收多少个参数。这时候，**剩余参数**（Rest Parameter）就派上用场了。它允许你使用 **一个参数变量** 来接收多个参数。



## 剩余参数语法

剩余参数的语法是使用三个点（`...`）后跟参数名。在函数声明中，你需要为剩余参数指定数组类型。

```typescript
function funcName(...rest: type[]): returnType {
   // 函数体
}
```

- **`funcName`**：函数的名称。
- **`...rest`**：将多个参数收集到名为 rest 的数组中。
- **`type[]`**：指定参数的类型。

一个函数可以同时包含普通参数和剩余参数，但剩余参数必须是参数列表中的最后一个参数。

```typescript
function funcName(param1: type, ...rest: type[]) {}  // 正确
function funcName(...rest: type[], param1: type) {}  // 错误：剩余参数必须是最后一个参数
```

一个函数定义中只能有一个剩余参数。

```typescript
function funcName(...rest1: type[], ...rest2: number[]) {}  // 错误：只能有一个剩余参数
```

函数表达式同样可以使用剩余参数。

```typescript
let getSum = function(...rest: number[]) {
   // 函数体
}
```



## 示例

### 示例 1：可变长度参数列表

使用剩余参数，你可以用不同数量的参数调用函数。剩余参数会将这些参数存储为数组元素。

```typescript showLineNumbers
function sum(...nums: number[]) {
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }
    return totalSum;
}
console.log(sum(10, 20, 30, 40)); // 输出 100
console.log(sum(10, 20));         // 输出 30
console.log(sum());               // 输出 0
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function sum(...nums) {
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }
    return totalSum;
}
console.log(sum(10, 20, 30, 40));
console.log(sum(10, 20));
console.log(sum());
```



### 示例 2：获取参数长度

你可以使用数组的 length 属性来获取参数的数量。

```typescript showLineNumbers
function getLen(...theArgs: number[]) {
  console.log(theArgs.length);
}
getLen();         // 输出 0
getLen(5);        // 输出 1
getLen(5, 6, 7);  // 输出 3
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function getLen(...theArgs) {
    console.log(theArgs.length);
}
getLen();
getLen(5);
getLen(5, 6, 7);
```



## 剩余参数与展开运算符

剩余参数和展开运算符都使用三个点（`...`），但它们的功能不同。

- **剩余参数**：用于将多个参数收集到一个数组中。
- **展开运算符**：用于将数组元素展开为单独的元素。



### 示例 1：数组作为展开参数

```typescript showLineNumbers
const arr1: number[] = [10, 20, 30];
const arr2: number[] = [40, 50, 60];

arr1.push(...arr2);
console.log(arr1); // 输出 [10, 20, 30, 40, 50, 60]
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
const arr1 = [10, 20, 30];
const arr2 = [40, 50, 60];

arr1.push(...arr2);
console.log(arr1);
```



### 示例 2：查找最大/最小值

```typescript showLineNumbers
function getMax(...args: number[]) { // 这里 ...args 作为剩余参数
    return Math.max(...args); // 这里 ... 作为展开运算符
}

console.log(getMax(10, 20, 30, 40)); // 输出 40
console.log(getMax(10, 20, 30));     // 输出 30
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function getMax(...args) {
    return Math.max(...args); // 这里 ... 作为展开运算符
}

console.log(getMax(10, 20, 30, 40));
console.log(getMax(10, 20, 30));
```



### 示例 3：传递剩余参数

```typescript showLineNumbers
function multiply(a: number, b: number, c: number): number {
    return a * b * c;
}

let numbers: [number, number, number];
numbers = [2, 3, 4];
console.log(multiply(...numbers)); // 输出 24
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
function multiply(a, b, c) {
    return a * b * c;
}

let numbers;
numbers = [2, 3, 4];
console.log(multiply(...numbers));
```



## 小结

TypeScript 的剩余参数功能允许函数接收可变数量的参数，并将它们存储为一个数组。这在处理不确定数量的参数时非常有用。剩余参数必须是参数列表中的最后一个参数，且一个函数只能有一个剩余参数。剩余参数和展开运算符都使用三个点（`...`），但它们的功能不同：剩余参数用于收集参数，而展开运算符用于展开数组元素。通过本文的示例，你应该能够理解如何在实际项目中使用剩余参数来简化代码。
