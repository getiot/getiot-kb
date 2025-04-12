---
sidebar_position: 6
slug: /typescript-variables
---

# TypeScript 变量定义

在 TypeScript 中，变量是用来存储数据的容器。你可以使用 `var`、`let` 或 `const` 来声明变量，但它们的行为略有不同。本节将带你了解如何在 TypeScript 中声明变量、作用域的区别、变量类型、类型断言、类型推断等内容。



## 变量的命名规则

变量是程序中用于存储值的命名内存空间。在 TypeScript 中，变量必须遵循 JavaScript 的命名规则：

- 变量名可以包含字母和数字。
- 不能包含空格和特殊字符（下划线 `_` 和美元符号 `$` 除外）。
- 不能以数字开头。



## 变量的声明方式

TypeScript 是强类型语言，你可以在声明变量时指定类型。TypeScript 中声明变量的语法是在变量名后加冒号 `:`，然后指定其类型。以下是四种声明变量的方式：

1. **同时声明类型和值**

   ```typescript
   // 格式
   var [identifier] : [type-annotation] = value ;
   
   // 示例
   var name: string = "Mary";
   ```

2. **声明类型但不赋值**（此时变量默认值为 `undefined`）

   ```typescript
   // 格式
   var [identifier] : [type-annotation] ;
   
   // 示例
   var name: string;
   ```

3. **赋值但不声明类型**（类型将根据赋值推断）

   ```typescript
   // 格式
   var [identifier] = value ;
   
   // 示例
   var name = "Mary";
   ```

4. **既不赋值也不声明类型**（此时变量类型为 `any`，默认值为 `undefined`）

   ```typescript
   // 格式
   var [identifier] ;
   
   // 示例
   var name;
   ```



### 示例：TypeScript 中的变量

```typescript showLineNumbers
var name: string = "John";
var score1: number = 50;
var score2: number = 42.50;
var sum = score1 + score2;

console.log("name: " + name);
console.log("first score: " + score1);
console.log("second score: " + score2);
console.log("sum of the scores: " + sum);
```

编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
var name = "John";
var score1 = 50;
var score2 = 42.50;
var sum = score1 + score2;

console.log("name" + name);
console.log("first score: " + score1);
console.log("second score: " + score2);
console.log("sum of the scores: " + sum);
```

输出结果为：

```bash
name: John
first score: 50
second score: 42.50
sum of the scores: 92.50
```

如果尝试给变量赋不符合其类型定义的值，TypeScript 编译器会报错。例如：

```typescript
var num: number = "hello"; // 会报编译错误
```



## 类型断言

TypeScript 允许将变量从一种类型转换为另一种类型，这个过程称为类型断言（Type Assertion）。语法是将目标类型放在 `< >` 符号中，并放在变量或表达式前面。

```typescript showLineNumbers
var str = '1';
var str2: number = <number> <any> str; // 将 str 断言为 number 类型
console.log(typeof(str2));
```

代码解释：

1. **`<number>`** 是类型断言的目标类型，表示你希望将变量 `str` 断言为 `number` 类型。
2. **`<any>`**：`any` 是 TypeScript 中的一种特殊类型，表示变量可以是任何类型。通过先将变量断言为 `any`，可以绕过 TypeScript 的类型检查，然后再将其断言为目标类型。

这段代码编译后生成的 JavaScript 代码如下：

```javascript showLineNumbers
"use strict";
var str = '1';
var str2 = str; // str 被断言为 number 类型
console.log(typeof (str2));
```

输出结果为：

```bash
string
```

类型断言是编译时的构造，不会在运行时提供支持。



## 类型推断

TypeScript 支持类型推断（Inferred Typing），即在不指定类型的情况下，编译器会根据初始赋值推断变量类型。

```typescript showLineNumbers
var num = 2; // 类型被推断为 number
console.log("value of num: " + num);

num = "12"; // 会报编译错误
console.log(num);
```

输出错误：

```bash
error TS2322: Type 'string' is not assignable to type 'number'.
```



## 变量作用域

TypeScript 中变量的作用域（Scope）决定了变量在程序中的可访问性：

- **全局作用域**：在程序构造之外声明，可在代码任何位置访问
- **类作用域**：在类中但方法外声明，可通过类实例访问
- **局部作用域**：在方法、循环等构造内声明，仅在声明的位置可访问

示例：

```typescript showLineNumbers
var global_num = 12; // 全局变量

class Numbers {
   num_val = 13;     // 类变量
   static sval = 10; // 静态变量

   storeNum(): void {
      var local_num = 14; // 局部变量
   }
}

console.log("Global num: " + global_num);
console.log(Numbers.sval); // 访问静态变量
var obj = new Numbers();
console.log("Global num: " + obj.num_val);
```

编译后的 JavaScript 代码：

```javascript showLineNumbers
var global_num = 12;
var Numbers = (function () {
   function Numbers() {
      this.num_val = 13;
   }
   Numbers.prototype.storeNum = function () {
      var local_num = 14;
   };
   Numbers.sval = 10;
   return Numbers;
}());

console.log("Global num: " + global_num);
console.log(Numbers.sval);
var obj = new Numbers();
console.log("Global num: " + obj.num_val);
```

输出结果：

```bash
Global num: 12
10
Global num: 13
```

如果尝试在方法外访问局部变量，会报编译错误：

```bash
error TS2095: Could not find symbol 'local_num'.
```



## 小结

本文介绍了 TypeScript 中变量的使用方法，包括变量的声明方式、类型断言、类型推断以及作用域规则。通过 TypeScript 的类型系统，你可以在编译时捕获类型错误，提高代码的健壮性。类型推断功能让你在享受类型安全的同时，保持代码的简洁性。理解变量的作用域规则，能帮助你更好地组织代码结构，避免变量污染和命名冲突。掌握这些基础知识，将为你后续学习更复杂的 TypeScript 概念打下坚实基础。

