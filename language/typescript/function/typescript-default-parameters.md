---
sidebar_position: 4
slug: /typescript-default-parameters
---

# TypeScript - 默认参数

在 TypeScript 中，你可以为函数参数指定默认值。当调用函数时未提供参数值或参数值为 `undefined` 时，将使用这些默认值。这种方式能让你的代码更简洁，也更具可读性。



## 语法

你可以直接在函数定义中为参数指定默认值，语法如下：

```typescript
function functionName(param1: type, param2: type = defaultValue): returnType {
    // 函数体
}
```

在这个语法中，`functionName` 是函数名，`param1` 是必需参数，`param2` 是默认参数，`defaultValue` 是默认值。



## 示例

### 示例1：简单的默认参数

```typescript
function greet(name: string, age: number = 30): void {
    console.log(`Hi ${name}, your age is ${age}.`);
}
greet('John', 50);  // 输出：Hi John, your age is 50.
greet('John');      // 输出：Hi John, your age is 30.
```



### 示例2：默认参数在必需参数之后

默认参数必须放在必需参数之后。

```typescript
function sum(x: number, y: number = 10): number {
    return x + y;
}
console.log(sum(20, 30));  // 输出：50
console.log(sum(20));      // 输出：30
```

如果默认参数放在必需参数之前，调用函数时会报错。

```typescript
function sum(x: number = 10, y: number): number {
    return x + y;
}
console.log(sum(20, 30));  // 输出：50
console.log(sum(20));      // 报错：Expected 2 arguments, but got 1.
```



### 示例3：将函数作为默认参数值

```typescript
function getNum(): number {
    return 10;
}
function mul(a: number, b = getNum()): number {
    return a * b;
}
console.log(mul(20, 5));  // 输出：100
console.log(mul(20));     // 输出：200
```



## 默认参数与可选参数的区别

默认参数和可选参数都可以在调用函数时省略，但它们的行为有所不同。

### 示例1：默认参数

```typescript
function greet(name: string, age: number = 30): void {
    console.log(`Hi ${name}, your age is ${age}.`);
}
greet('John', 50);  // 输出：Hi John, your age is 50.
greet('John');      // 输出：Hi John, your age is 30.
```



### 示例2：可选参数

```typescript
function greet(name: string, age?: number): void {
    if (age) {
        console.log(`Hello ${name}, you are ${age} years old`);
    } else {
        console.log(`Hello ${name}`);
    }
}
greet('John', 50); // 输出：Hello John, you are 30 years old
greet('John');     // 输出：Hello John
```



### 默认参数与可选参数不能同时使用

```typescript
function greet(name: string, age?: number = 30): void {
    console.log(`Hi ${name}, your age is ${age}.`);
}
```

上述代码会报错：

```bash
Parameter cannot have question mark and initializer.
```



## 小结

默认参数是 TypeScript 中一个非常实用的特性，允许你在调用函数时省略某些参数。默认参数必须放在必需参数之后，并且不能与可选参数同时使用。通过为参数提供默认值，你可以减少函数调用时的重复代码，使代码更加简洁和易读。掌握默认参数的使用方法，可以帮助你编写更加灵活和高效的 TypeScript 代码。
