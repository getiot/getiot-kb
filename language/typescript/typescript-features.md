---
sidebar_position: 5
slug: /typescript-features
draft: true
---

# TypeScript 核心特性



### 静态类型

通过类型注解（如 `let age: number = 25`）定义变量类型，支持原始类型（`boolean`、`string`）、联合类型（`string | number`）、泛型等。

### 类与接口

```typescript showLineNumbers
interface Person {
    name: string;
    age: number;
}

class Student implements Person {
    constructor(public name: string, public age: number) {}
}
```

接口定义对象结构，类则支持面向对象编程（如继承、封装）。

### 模块化

通过 `import` 和 `export` 管理代码模块，避免全局污染：

```typescript showLineNumbers
// math.ts
export function sum(a: number, b: number): number {
    return a + b;
}

// app.ts
import { sum } from './math';
console.log(sum(1, 2)); // 输出 3
```

### 类型推断与断言

TypeScript 能自动推断变量类型（如 `let str = "hello"` 推断为 `string`），也可用类型断言手动指定类型：

```typescript showLineNumbers
let value: any = "123";
let num: number = (value as string).length; // 断言为 string 类型
```
