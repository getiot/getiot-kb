---
sidebar_position: 3
---

# JavaScript 数据类型



JavaScript 数据类型分为基本数据类型和引用数据类型。

其中，基本数据类型有 6 种：字符串（String）、数值（Number）、布尔（Boolean）、空（null）、未定义（undefined）、Symbol（ES6 语法新增）。

另外，有 3 种引用类型：对象（Object）、数组（Array）、函数（Function）。

由于 JavaScript 是一种无类型的语言，因此在 JS 脚本中不需要指定一个变量的数据类型，解释器会自动推算出某个变量的正确数据类型。此外，还可以将不同类型的值赋给一种类型的变量。例如下面代码先定义了一个字符串变量，然后再将一个整数类型的值赋给它。

```javascript showLineNumbers
var id = "1101";
id = 1101;
```



## 基本数据类型

### 字符串（String）

String 类型将字符数据存储为一个字符串，字符数据可以用单引号或双引号来指定。所有包含在引号中的数据将被赋值给字符串变量。

示例：

```javascript showLineNumbers
var myString = "GetIoT";
var anotherString = "GetIoT.tech";
```



### 数值（Number）

Number 类型将数据存储为一个数值，数字可以带小数点，也可以不带。


示例：

```javascript showLineNumbers
var myInteger = 1;
var cost = 7.25;
```



### 布尔（Boolean）

Boolean 类型存储一个位（Bit），其值要么是 true（真），要么是 false（假）。布尔值通常用于标志，例如在代码开始处把一个布尔变量设置为 false，然后在完成时检查它以观察代码是否执行到一个特定的位置。


示例：

```javascript showLineNumbers
var yes = true;
var no = false;
```



### 空（null）

有时候，变量中没有存储任何值，比如当我们不再需要某个变量时，可以将这个变量设置为 `null`。


示例：

```javascript showLineNumbers
var newVar = null;
```

使用 `null` 比赋值为 0 或空字符串（`""`）更好，因为它们可能是变量的有效值。



### 未定义（undefined）

`undefined` 的含义与用法都和 `null` 差不多，这与 JavaScript 的历史有关。

在 JavaScript 的最初版本中是这样区分的：`null` 是一个表示"无"的对象，转为数值时为 0；`undefined` 是一个表示"无"的原始值，转为数值时为 `NaN`。

示例：

```javascript showLineNumbers
var newVar = undefined;
```

下面是 `null` 和 `undefined` 在使用上的一些细微差别。

- `null` 表示“没有对象”，即此处不应该有值。典型用法是：
  1. 作为函数的参数，表示该函数的参数不是对象；
  2. 作为对象原型链的终点。
- `undefined` 表示“缺少值”，即此处应该有一个值，但还没有定义。典型用法是：
  1. 声明了变量，但没有赋值时，其值为 `undefined`；
  2. 调用函数时，应该提供的参数没有提供，该参数等于 `undefined`；
  3. 对象没有赋值的属性，该属性的值为 `undefined`；
  4. 函数没有返回值时，默认返回 `undefined`。



### Symbol 类型

ES6 引入了一种新的原始数据类型 Symbol，表示独一无二的值。Symbol 值通过 Symbol 函数生成。这就是说，对象的属性名现在可以有两种类型，一种是原来就有的字符串，另一种就是新增的 Symbol 类型。凡是属性名属于 Symbol 类型，就都是独一无二的，可以保证不会与其他属性名产生冲突。

示例：

```javascript showLineNumbers
let s = Symbol();
console.log(typeof s);  // 输出 symbol
```



## 引用数据类型

### 对象（Object）

JavaScript 对象由花括号包裹，在括号内部，对象的属性以名称和值对的形式 `(name:value)` 来定义，简称**键值对**。


示例：

```javascript showLineNumbers
var obj = {"name":"Rudy", "occupation":"Hacker", "age", "Unknown"};
```

使用对象时，可以通过 `object.property` 语法访问对象中的值与函数。例如：

```javascript showLineNumbers
var name = obj.name;
```

### 数组（Array）

一个带索引的数组是一组独立的不同的数据项，这些数据项全部在一个单独的变量名中存储。在数组中的条目可以使用 `array[index]` 的方式来访问，第一个元素的索引为 0。


示例：

```javascript showLineNumbers
var arr = ["one", "two", "three"];
var first = arr[0];
```

### 函数（Function）

将在后面章节介绍，参考 [JavaScript 函数定义](/js/javascript-function-definition/)。


