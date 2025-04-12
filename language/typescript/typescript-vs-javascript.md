---
sidebar_position: 4
slug: /typescript-vs-javascript
---

# TypeScript 与 JavaScript 的比较



## TypeScript 与 JavaScript 的区别

|     特性     |          TypeScript          |        JavaScript        |
| :----------: | :--------------------------: | :----------------------: |
| **类型系统** |    静态类型（编译时检查）    |  动态类型（运行时检查）  |
| **面向对象** |      支持类、接口、继承      |        基于原型链        |
|   **编译**   | 需编译为 JavaScript 才能运行 |         直接运行         |
| **错误检查** |     编写阶段提示类型错误     |  运行时才能发现类型错误  |
| **工具支持** |     完善的 IDE 智能提示      | 依赖插件或较弱的类型推断 |

举个例子，JavaScript 允许以下代码：

```typescript
function add(a, b) { return a + b; }
add("1", 2); // 输出 "12"（可能非预期）
```

而 TypeScript 会通过类型注解阻止这种错误：

```typescript
function add(a: number, b: number): number {
    return a + b;
}
add("1", 2); // 编译时报错！
```

