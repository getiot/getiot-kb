---
sidebar_position: 6
sidebar_label: TypeScript - 布尔值
slug: /typescript-boolean
---

# TypeScript - Boolean 布尔类型

在 TypeScript 中，布尔类型（`boolean`）用于表示逻辑值 `true` 或 `false`。布尔值通常用于控制程序的执行流程。TypeScript 支持布尔原始类型和布尔对象。



## 声明布尔变量

你可以使用以下语法声明一个布尔类型的变量：

```typescript
let varName: boolean = true;
```

示例：

```typescript
let isPresent: boolean = true;
console.log(isPresent); // 输出：true
```



## 创建布尔对象

你可以使用 `Boolean()` 构造函数创建布尔对象：

```typescript
const isTrue = new Boolean(true);
console.log(isTrue);
console.log(typeof isTrue);
```

输出结果：

```bash
[Boolean: true]
object
```

:::tip

`boolean` 是原始类型，而 `Boolean` 是包装对象。建议优先使用 `boolean`，因为它更轻量且性能更高。

:::



## 真值和假值

在 TypeScript 中，假值（falsy values）是指在布尔上下文中被评估为 `false` 的值。以下六种值是假值：

- `false`
- `0`（零）
- 空字符串（`""`）
- `null`
- `undefined`
- `NaN`

所有其他值都是真值（truthy values）。



## 将非布尔值转换为布尔值

你可以使用 `Boolean()` 函数或双感叹号（`!!`）运算符将非布尔值转换为布尔值。

**示例：使用 `Boolean()` 函数**

```typescript
const myBoolean1 = Boolean(10);
console.log(myBoolean1); // 输出：true

const myBoolean2 = Boolean("");
console.log(myBoolean2); // 输出：false
```

**示例：使用双感叹号（`!!`）运算符**

```typescript
const myBoolean1 = !!10;
console.log(myBoolean1); // 输出：true

const myBoolean2 = !!"";
console.log(myBoolean2); // 输出：false
```



## 布尔运算

TypeScript 支持三种逻辑运算符：逻辑与（`&&`）、逻辑或（`||`）和逻辑非（`!`）。

### 逻辑与（`&&`）

```typescript
let x: boolean = true;
let y: boolean = false;
let result: boolean = x && y;
console.log(result); // 输出：false
```

### 逻辑或（`||`）

```typescript
let x: boolean = true;
let y: boolean = false;
let result: boolean = x || y;
console.log(result); // 输出：true
```

### 逻辑非（`!`）

```typescript
let isPresent: boolean = false;
let isAbsent: boolean = !isPresent;
console.log(isAbsent); // 输出：true
```



## 条件表达式与布尔值

### 使用 `if` 语句

```typescript
let age: number = 25;
let isAdult: boolean = age >= 18;
if (isAdult) {
    console.log('You are an adult.');
} else {
    console.log('You are not an adult.');
}
```

输出结果：

```bash
You are an adult.
```

### 使用条件表达式（三元运算符）

```typescript
let score: number = 80;
let isPassing: boolean = score >= 70;
let result: string = isPassing ? 'Pass' : 'Fail';
console.log(result); // 输出：Pass
```



## 布尔对象的属性和方法

boolean 变量具有以下常用属性：

| 属性名        | 描述                         |
| ------------- | ---------------------------- |
| `constructor` | 返回创建布尔对象的函数引用   |
| `prototype`   | 允许为布尔对象添加属性和方法 |

boolean 变量具有以下常用方法：

| 方法名       | 描述                             |
| ------------ | -------------------------------- |
| `toSource()` | 返回包含布尔对象源代码的字符串   |
| `toString()` | 返回字符串 `"true"` 或 `"false"` |
| `valueOf()`  | 返回布尔对象的原始值             |



## 小结

TypeScript 的 `boolean` 类型用于表示逻辑值 `true` 或 `false`，是控制程序流程的重要数据类型。你可以使用 `Boolean()` 函数或双感叹号（`!!`）运算符将非布尔值转换为布尔值。掌握布尔运算（如逻辑与、逻辑或和逻辑非）和条件表达式的使用，可以帮助你更高效地编写控制逻辑。建议优先使用原始类型 `boolean`，而不是包装对象 `Boolean`，以提高代码的性能和可读性。
