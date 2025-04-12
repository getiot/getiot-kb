---
sidebar_position: 7
slug: /typescript-let-const
---

# TypeScript 关键字 let 和 const

在 TypeScript 中，`let` 和 `const` 是用于声明变量的现代关键字，它们是 ES6（也叫 ES2015）引入的新特性，用来替代传统的 `var` 关键字。相较于 `var`，它们在作用域、安全性和代码可读性上都有明显优势。本节将带你深入了解 `let` 和 `const` 的用法和区别。

:::tip

- `var`：具有函数作用域（function scope）；
- `let`：具有块级作用域（block scope）；
- `const`：用于声明常量，一旦赋值就不能再更改。

:::



## 使用 let 声明变量

在 TypeScript 中使用 `let` 关键字声明变量的语法如下：

```typescript
let var_name: var_type = value;
```

- `let` 是关键字。
- `var_name` 是变量名的有效标识符。
- `var_type` 是变量的类型。
- `value` 是要存储在变量中的值。

### 示例

在 TypeScript 中声明变量：

```typescript showLineNumbers
let car_name: string = "Brezza";
let car_price: number = 1000000;
console.log(car_name);
console.log(car_price);
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
let car_name = "Brezza";
let car_price = 1000000;
console.log(car_name);
console.log(car_price);
```

输出结果为：

```bash
Brezza
1000000
```

### 变量作用域

使用 `let` 声明的变量具有块级作用域。这意味着你不能在块外部访问变量，这与使用 `var` 声明的变量不同。

在下面的代码中，`bool` 变量的值为 `true`，因此 `if` 语句的代码块将始终执行。在 `if` 块中声明的 `result` 变量只能在该块内访问。如果尝试在块外部访问它，TypeScript 编译器将抛出错误。

```typescript showLineNumbers
let bool: boolean = true;
if (bool) {
    let result: number = 10;
    console.log(result); // 只能在该块内访问
}
// console.log(result); 不能在块外部访问变量
```

### 不能重新声明 let 变量

不能重新声明使用 `let` 关键字声明的变量。

在下面的代码中，如果你尝试重新声明相同的变量，TypeScript 编译器将抛出错误。

```typescript showLineNumbers
let animal: string = "cat";
// let animal: string = "dog"; // 错误：不能重新声明块级作用域变量 'animal'

console.log(animal); // 输出：cat
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
let animal = "cat";
// let animal: string = "dog"; // 错误：不能重新声明块级作用域变量 'animal'
console.log(animal); // 输出：cat
```

输出结果为：

```bash
cat
```

### 不同块中的同名变量

使用 `let` 关键字声明的变量具有块级作用域。因此，如果同名变量在不同的块中声明，它们被视为不同的变量。

在下面的代码中，我们在 `if` 和 `else` 块中都声明了 `num` 变量，并分别初始化为不同的值。

```typescript showLineNumbers
let bool: boolean = false;
// 如果布尔值为 true，变量 num 将为 1，否则为 2
if (bool) {
    let num: number = 1;
    console.log(num);
} else {
    let num: number = 2;
    console.log(num);
}
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
let bool = false;
// 如果布尔值为 true，变量 num 将为 1，否则为 2
if (bool) {
    let num = 1;
    console.log(num);
}
else {
    let num = 2;
    console.log(num);
}
```

输出结果为：

```bash
2
```



## 使用 const 声明变量

`const` 关键字的语法与 `var` 和 `let` 类似，用于声明常量变量。但是，`const` 变量定义后就不能再更改它们，因此需要在定义时进行初始化。

### 示例

在 TypeScript 中声明常量变量：

```typescript showLineNumbers
const lang: string = 'TypeScript';
const PI: number = 3.14;
console.log(`Language: ${lang}`);
console.log(`Value of PI: ${PI}`);
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
const lang = 'TypeScript';
const PI = 3.14;
console.log(`Language: ${lang}`);
console.log(`Value of PI: ${PI}`);
```

输出结果为：

```bash
Language: TypeScript
Value of PI: 3.14
```

### 不能重新声明或修改 const 变量

使用 `const` 声明的变量具有与 `let` 声明的变量相同的作用域和重新声明规则。在下面的代码中，如果你尝试在相同作用域中重新声明 `const` 变量或在声明后更改其值，将抛出错误。

```typescript showLineNumbers
if (true) {
    const PI: number = 3.14;
    console.log(PI);
    // const PI: number = 3.14; // 错误：不能重新声明块级作用域变量 'PI'
    // PI = 3.15; // 错误：不能分配给 'PI'，因为它是一个常量
}
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
if (true) {
    const PI = 3.14;
    console.log(PI);
    // const PI: number = 3.14; // 错误：不能重新声明块级作用域变量 'PI'
    // PI = 3.15; // 错误：不能分配给 'PI'，因为它是一个常量
}
```

输出结果为：

```bash
3.14
```



## var、let 和 const 对比

**表：关键字 var、let 和 const 对比**

| 特性           | var               | let  | const       |
| -------------- | ----------------- | ---- | ----------- |
| 是否可重新赋值 | ✔️                 | ✔️    | ❌（不可变） |
| 是否可重新声明 | ✔️（在同一作用域） | ❌    | ❌           |
| 是否块级作用域 | ❌（函数作用域）   | ✔️    | ✔️           |

推荐你在日常开发中优先使用 `let` 和 `const`，避免使用 `var`，因为块级作用域更容易维护和理解。



## 小结

在 TypeScript 中，使用 `let` 和 `const` 声明变量提供了更好的作用域控制和代码安全性。`let` 声明的变量具有块级作用域，不能重新声明，但可以在声明后重新赋值。`const` 声明的变量也具有块级作用域，不能重新声明或重新赋值，必须在声明时初始化。使用 `let` 和 `const` 可以避免 `var` 声明的一些常见问题，如变量提升和作用域污染，因此在现代 TypeScript 和 JavaScript 开发中，建议优先使用 `let` 和 `const`。

