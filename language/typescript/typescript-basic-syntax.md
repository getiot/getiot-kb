---
sidebar_position: 3
slug: /typescript-basic-syntax
draft: true
---

# TypeScript 基本语法



## 变量声明与类型注解

TypeScript 的变量声明语法与 JavaScript 相似，但增加了**类型注解**（Type Annotations），用于显式指定变量类型。例如：

```typescript
let isDone: boolean = false;  // 布尔类型
let count: number = 42;       // 数字类型
let name: string = "Alice";   // 字符串类型
```

如果尝试为变量赋予错误类型的值（如 `count = "42"`），编译器会直接报错。TypeScript 也支持类型推断，若未显式声明类型，会根据初始值自动推断类型。



