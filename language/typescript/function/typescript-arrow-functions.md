---
sidebar_position: 9
slug: /typescript-arrow-functions
---

# TypeScript - 箭头函数

**箭头函数**（Arrow Functions）是 TypeScript 中一种简洁的匿名函数定义方式，它在 ES6（ECMAScript 2015）中被引入。箭头函数不仅语法更短，而且在处理 `this` 关键字时表现得更加直观和一致。

如果你在使用匿名函数或回调函数时感到代码冗长或者 `this` 总是不如你预期工作，那么箭头函数会是一个很好的替代方案。



## 语法

箭头函数使用“箭头”（`=>`）来分隔函数参数和函数体。基本语法如下：

```typescript
(param1, param2, ..., paramN) => { statement }
```

箭头函数包含三个部分：

1. **参数**：函数可以有零个或多个参数。
2. **箭头符号（=>）**：用于分隔参数和函数体。
3. **语句**：函数的执行逻辑。



## 示例

### 示例 1：单语句箭头函数

当箭头函数只有一个语句时，可以省略大括号和 `return` 关键字。

```typescript
const add = (x: number, y: number): number => x + y;
console.log(add(20, 30)); // 输出 50
```

编译后的 JavaScript 代码：

```javascript
const add = (x, y) => x + y;
console.log(add(20, 30));
```



### 示例 2：多语句箭头函数

当箭头函数包含多个语句时，需要用大括号包裹，并显式使用 `return` 返回值。

```typescript
const multiply = (x: number, y: number): number => {
    let res: number = x * y;
    return res;
};
console.log(multiply(5, 6)); // 输出 30
```

编译后的 JavaScript 代码：

```javascript
const multiply = (x, y) => {
    let res = x * y;
    return res;
};
console.log(multiply(5, 6));
```



### 示例 3：无参数箭头函数

箭头函数可以没有参数。

```typescript
const greet = () => { return "Hello World!"; };
console.log(greet()); // 输出 Hello World!
```

编译后的 JavaScript 代码：

```javascript
const greet = () => { return "Hello World!"; };
console.log(greet());
```



### 示例 4：单参数箭头函数

箭头函数可以有一个参数。

```typescript
const add = (x: number): number => { return x + 10; };
console.log(add(5)); // 输出 15
```

编译后的 JavaScript 代码：

```javascript
const add = (x) => { return x + 10; };
console.log(add(5));
```



### 示例 5：多参数箭头函数

箭头函数可以有多个参数。

```typescript
const add = (a: number, b: number, c: number): number => {
    let sum: number = a + b + c;
    return sum;
};
console.log(add(10, 30, 45)); // 输出 85
```

编译后的 JavaScript 代码：

```javascript
const add = (a, b, c) => {
    let sum = a + b + c;
    return sum;
};
console.log(add(10, 30, 45));
```



### 示例 6：默认参数

箭头函数支持默认参数。

```typescript
const mul = (a = 10, b = 15): number => a * b;
console.log("mul(5, 8) = " + mul(5, 8)); // 输出 40
console.log("mul(6) = " + mul(6));       // 输出 90
console.log("mul() = " + mul());         // 输出 150
```

编译后的 JavaScript 代码：

```javascript
const mul = (a = 10, b = 15) => a * b;
console.log("mul(5, 8) = " + mul(5, 8));
console.log("mul(6) = " + mul(6));
console.log("mul() = " + mul());
```



## 应用场景

### 场景 1：作为回调函数

箭头函数非常适合用作回调函数，例如在数组方法（如 `map`、`filter`、`reduce`）中。

```typescript
const numbers = [1, 2, 3, 4, 5];
const squaredNumbers = numbers.map(x => x * x);
console.log(`Original array: ${numbers}`);       // 输出 Original array: 1,2,3,4,5
console.log(`Squared array: ${squaredNumbers}`); // 输出 Squared array: 1,4,9,16,25
```

编译后的 JavaScript 代码：

```javascript
const numbers = [1, 2, 3, 4, 5];
const squaredNumbers = numbers.map(x => x * x);
console.log(`Original array: ${numbers}`);
console.log(`Squared array: ${squaredNumbers}`);
```



### 场景 2：类中的箭头函数

箭头函数可以用作类的方法或对象的属性。

```typescript
class Calculator {
    add = (x: number, y: number, z: number): number => x + y + z;
}
const obj = new Calculator();
console.log(`The result is: ${obj.add(4, 3, 2)}`); // 输出 The result is: 9
```

编译后的 JavaScript 代码：

```javascript
class Calculator {
    constructor() {
        this.add = (x, y, z) => x + y + z;
    }
}
const obj = new Calculator();
console.log(`The result is: ${obj.add(4, 3, 2)}`);
```



### 场景 3：高阶函数

箭头函数非常适合定义高阶函数（接受函数作为参数或返回函数的函数）。

```typescript
const applyOp = (
    x: number,
    y: number,
    operation: (a: number, b: number) => number
) => {
    return operation(x, y);
};
console.log(applyOp(10, 20, (a, b) => a + b)); // 输出 30
console.log(applyOp(10, 20, (a, b) => a * b)); // 输出 200
```

编译后的 JavaScript 代码：

```javascript
const applyOp = (x, y, operation) => {
    return operation(x, y);
};
console.log(applyOp(10, 20, (a, b) => a + b));
console.log(applyOp(10, 20, (a, b) => a * b));
```



## 小结

TypeScript 的箭头函数提供了一种简洁的匿名函数定义方式，特别适合处理回调函数或简单的函数表达式。箭头函数的语法简洁，支持默认参数和多参数，并且在数组方法和高阶函数中非常实用。通过本文的示例，你应该能够理解如何在实际项目中使用箭头函数来简化代码。箭头函数不仅提高了代码的可读性，还减少了样板代码，使你的 TypeScript 代码更加现代化和专业。
