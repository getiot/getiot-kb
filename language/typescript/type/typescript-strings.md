---
sidebar_position: 5
sidebar_label: TypeScript - 字符串
slug: /typescript-strings
---

# TypeScript - Strings 字符串

在 TypeScript 中，字符串（`string`）用于表示一系列字符。字符串是 TypeScript 中的基本数据类型之一，用于存储文本数据。与 JavaScript 类似，TypeScript 也支持字符串原始类型和字符串对象（`String`）。



## 创建字符串

你可以通过以下两种方式创建字符串。

**1、使用单引号、双引号或反引号创建字符串原始类型：**

```typescript
let str1: string = 'a string primitive';
let str2: string = "another string";
let str3: string = `yet another string`;
```

**2、使用 `String()` 构造函数创建字符串对象：**

```typescript
const str = new String('example@getiot.tech');
console.log(str);
console.log(typeof str);
```

输出结果：

```bash
example@getiot.tech
object
```

:::tip

`string` 是原始类型，而 `String` 是包装对象。建议优先使用 `string`，因为 `String` 对象在某些情况下可能会导致意外行为。

:::



## 字符串属性

以下是字符串对象的一些常用属性：

| 属性名   | 描述             |
| -------- | ---------------- |
| `length` | 返回字符串的长度 |



## 字符串方法

以下是字符串对象的一些常用方法：

| 方法名                          | 描述                                       |
| ------------------------------- | ------------------------------------------ |
| `charAt(index)`                 | 返回指定索引处的字符                       |
| `charCodeAt(index)`             | 返回指定索引处字符的 Unicode 值            |
| `concat(str1, str2, ..., strN)` | 连接两个或多个字符串                       |
| `indexOf(searchValue)`          | 返回指定值在字符串中首次出现的索引         |
| `lastIndexOf(searchValue)`      | 返回指定值在字符串中最后一次出现的索引     |
| `localeCompare(compareString)`  | 比较两个字符串并返回比较结果               |
| `match(regexp)`                 | 在字符串中匹配正则表达式                   |
| `replace(regexp, newSubStr)`    | 替换与正则表达式匹配的子字符串             |
| `search(regexp)`                | 在字符串中搜索正则表达式匹配               |
| `slice(start, end)`             | 提取字符串的一部分并返回新字符串           |
| `split(separator)`              | 将字符串分割成子字符串数组                 |
| `substr(start, length)`         | 返回字符串中从指定位置开始的指定数量的字符 |
| `substring(start, end)`         | 返回字符串中两个指定索引之间的字符         |
| `toLocaleLowerCase()`           | 将字符串转换为小写，考虑当前区域设置       |
| `toLocaleUpperCase()`           | 将字符串转换为大写，考虑当前区域设置       |
| `toLowerCase()`                 | 将字符串转换为小写                         |
| `toString()`                    | 返回字符串的字符串表示                     |
| `toUpperCase()`                 | 将字符串转换为大写                         |
| `valueOf()`                     | 返回字符串的原始值                         |



## 示例

### 示例 1：创建字符串原始类型

```typescript
let str1: string = 'a string primitive';
console.log(str1);
let str2: string = "another string";
console.log(str2);
let str3: string = `yet another string`;
console.log(str3);
```

输出结果：

```bash
a string primitive
another string
yet another string
```

### 示例 2：连接字符串

使用 `+` 运算符连接两个字符串：

```typescript
let str1: string = "Hello ";
let str2: string = "World!";
let str3: string = str1 + str2;
console.log(str3);
```

输出结果：

```bash
Hello World!
```

### 示例 3：访问字符串元素

通过索引访问字符串中的字符：

```typescript
let message: string = "Hello World!";
console.log("Character at index 1 is => " + message[1]);
console.log("Character at index 6 is => " + message[6]);
```

输出结果：

```bash
Character at index 1 is => e
Character at index 6 is => W
```

### 示例 4：字符串 vs. 字符串对象

尝试将字符串对象赋值给字符串原始类型变量会报错：

```typescript
let str: string;
str = new String('GetIoT');
```

报错信息：

```bash
Type 'String' is not assignable to type 'string'.
  'string' is a primitive, but 'String' is a wrapper object. Prefer using 'string' when possible.
```



## 小结

TypeScript 的 `string` 类型用于表示文本数据，支持单引号、双引号和反引号创建字符串原始类型。虽然可以使用 `String` 构造函数创建字符串对象，但建议优先使用原始类型 `string`，以避免潜在的意外行为。字符串提供了丰富的属性和方法，用于处理和格式化文本数据。掌握这些基本概念，可以帮助你更高效地在 TypeScript 中处理字符串类型的数据。
