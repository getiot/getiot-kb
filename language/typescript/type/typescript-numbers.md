---
sidebar_position: 4
sidebar_label: TypeScript - 数字
slug: /typescript-numbers
---

# TypeScript - Number 数字类型

在 TypeScript 中，`number` 类型用于表示所有的数字值，包括整数和浮点数。TypeScript 的 `number` 类型与 JavaScript 相同，都是基于 IEEE 754 标准的双精度 64 位浮点数。



## 声明数字变量

你可以使用 `let` 或 `const` 关键字来声明一个 `number` 类型的变量：

```typescript
let num1: number = 10;
const num2: number = 20.5;
```

如果你在声明变量时赋予了初始值，TypeScript 会自动推断其类型为 `number`，因此可以省略类型注解：

```typescript
let num3 = 30; // 推断为 number 类型
```

你也可以为数字变量赋浮点数、二进制、八进制和十六进制值：

```typescript
let decNum: number = 10.6;     // 浮点数
let binNum: number = 0b101001; // 二进制
let octNum: number = 0o45;     // 八进制
let hexNum: number = 0x80fd;   // 十六进制
```

TypeScript 支持多种数字字面量的表示方式：

- **十进制（Decimal）**：标准的数字表示方式，如 `42`。
- **十六进制（Hexadecimal）**：以 `0x` 或 `0X` 开头，如 `0x2A`。
- **八进制（Octal）**：以 `0o` 或 `0O` 开头，如 `0o52`。
- **二进制（Binary）**：以 `0b` 或 `0B` 开头，如 `0b101010`。



## 创建数字对象

你可以使用 `Number()` 构造函数创建数字对象：

```typescript
const count = new Number(10);
console.log(count);
console.log(typeof count);
```

输出结果：

```bash
[Number: 10]
Object
```

注意：`Number` 是一个包装对象，而 `number` 是原始类型。建议优先使用 `number`，因为 `Number` 对象在某些情况下可能会导致意外行为。



## 数字对象的属性

以下是 `Number` 对象的一些常用属性：

| 属性名              | 描述                                                         |
| ------------------- | ------------------------------------------------------------ |
| `MAX_VALUE`         | JavaScript 中数字可以拥有的最大值（约 `1.7976931348623157e+308`） |
| `MIN_VALUE`         | JavaScript 中数字可以拥有的最小值（约 `5e-324`）             |
| `NaN`               | 表示不是一个数字的值                                         |
| `NEGATIVE_INFINITY` | 表示负无穷大                                                 |
| `POSITIVE_INFINITY` | 表示正无穷大                                                 |
| `prototype`         | 允许为 `Number` 对象添加属性和方法                           |

### 示例：数字对象的属性

```typescript
console.log("TypeScript Number Properties: ");
console.log("Maximum value that a number variable can hold: " + Number.MAX_VALUE);
console.log("The least value that a number variable can hold: " + Number.MIN_VALUE);
console.log("Value of Negative Infinity: " + Number.NEGATIVE_INFINITY);
console.log("Value of Positive Infinity: " + Number.POSITIVE_INFINITY);
```

输出结果：

```bash
TypeScript Number Properties:
Maximum value that a number variable can hold: 1.7976931348623157e+308
The least value that a number variable can hold: 5e-324
Value of Negative Infinity: -Infinity
Value of Positive Infinity: Infinity
```

### 示例：`NaN`

```typescript
let month = 0;
if (month <= 0 || month > 12) {
    month = Number.NaN;
    console.log("Month is " + month);
} else {
    console.log("Value Accepted..");
}
```

输出结果：

```bash
Month is NaN
```



## 数字对象的方法

以下是 `Number` 对象的一些常用方法：

| 方法名             | 描述                               |
| ------------------ | ---------------------------------- |
| `toExponential()`  | 将数字转换为指数表示法             |
| `toFixed()`        | 将数字格式化为指定小数位数的字符串 |
| `toLocaleString()` | 根据本地设置返回数字的字符串表示   |
| `toPrecision()`    | 定义数字的总有效位数               |
| `toString()`       | 返回数字的字符串表示               |
| `valueOf()`        | 返回数字的原始值                   |

### 示例：`toFixed()` 方法

```typescript
let num: number = 123.456;
console.log(num.toFixed(2)); // 输出：123.46
```

### 示例：`toString()` 方法

```typescript
let num: number = 123;
console.log(num.toString(2)); // 输出：1111011（二进制表示）
```



## Number 类型的特殊值

TypeScript 的 `number` 类型还包括一些特殊值：

- **`NaN`**：表示“不是一个数字”（Not-a-Number）。
- **`Infinity`**：表示正无穷大。
- **`-Infinity`**：表示负无穷大。

示例：

```typescript
let notANumber: number = NaN;
let positiveInfinity: number = Infinity;
let negativeInfinity: number = -Infinity;
```

你可以使用 `isNaN()` 函数来检查一个值是否为 NaN：

```typescript
let result: number = 0 / 0;
console.log(isNaN(result)); // 输出: true
```



## 小结

TypeScript 的 `number` 类型用于表示数值，支持十进制、二进制、八进制和十六进制。你可以使用 `Number` 构造函数创建数字对象，但建议优先使用原始类型 `number`。`Number` 对象提供了多种属性和方法，用于处理和格式化数字。掌握这些基本概念，可以帮助你更高效地在 TypeScript 中处理数字类型的数据。
