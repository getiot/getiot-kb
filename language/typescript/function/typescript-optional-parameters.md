---
sidebar_position: 3
slug: /typescript-optional-parameters
---

# TypeScript - 可选参数

在 TypeScript 中，可选参数允许你在调用函数时省略某些参数。当你不需要为函数传递所有参数时，可选参数非常有用。可选参数通过在参数名后添加问号（`?`）来标记。



## 语法

以下是定义带有可选参数的函数的语法：

```typescript
function functionName(para1: type1, para2?: type2): returnType {
    // 函数体
}
```

在这个语法中，`functionName` 是函数名，`para1` 是必需参数，`para2` 是可选参数。



## 示例

### 示例1：使用可选参数

以下示例中，函数 `sum` 接受三个参数：`x`、`y` 和 `z`。其中，`x` 和 `y` 是必需参数，`z` 是可选参数。

```typescript
function sum(x: number, y: number, z?: number): number {
    if (z !== undefined) {
        return x + y + z;
    } else {
        return x + y;
    }
}
console.log(sum(2, 3));    // 输出：5
console.log(sum(2, 3, 5)); // 输出：10
```



### 示例2：使用类型守卫检查可选参数

在以下示例中，我们使用类型守卫 `typeof age === 'number'` 来检查 `age` 是否有值。

```typescript
function greet(name: string, age?: number): void {
    if (typeof age === 'number') {
        console.log(`You are ${age} years old.`);
    }
}
greet('Rudy', 30); // 输出：You are 30 years old.
```



### 示例3：可选参数必须是最后一个参数

可选参数必须放在必需参数之后。

```typescript
function add(x: number, y?: number): number {
    return x + (y || 0);
}
console.log(add(2, 3)); // 输出：5
console.log(add(2));    // 输出：2
```



### 示例4：可选参数不能有默认值

可选参数不能同时具有默认值。如果你需要为参数提供默认值，可以使用默认参数。

```typescript
function greet(name: string, age: number = 30): void {
    console.log(`Hello, ${name}!`);
    console.log(`You are ${age} years old.`);
}
greet('Rudy'); // 输出：Hello, Rudy! You are 30 years old.
```



## 小结

可选参数是 TypeScript 中一个非常实用的特性，允许你在调用函数时省略某些参数。通过在参数名后添加问号（`?`），你可以标记一个参数为可选。可选参数必须放在必需参数之后，并且不能同时具有默认值。掌握可选参数的使用方法，可以帮助你编写更加灵活和易用的函数。
