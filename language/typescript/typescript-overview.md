---
sidebar_position: 1
slug: /typescript-intro
---

# TypeScript 简介

作为一名软件工程师，你可能会发现，随着 JavaScript 代码的不断增长，代码的可维护性和可重用性变得越来越困难。JavaScript 在企业级应用中也缺乏对象导向、强类型检查和编译时错误检查等特性。TypeScript 的出现正是为了弥补这些不足。

![TypeScript 之父 Anders Hejlsberg（安德斯·海尔斯伯格）](https://static.getiot.tech/TypeScript-Hejlsberg_processed.webp#center)



## 什么是 TypeScript？

TypeScript 是由微软开发的开源编程语言，它是 JavaScript 的**超集**（所有 JavaScript 代码都可以直接在 TypeScript 中运行），通过添加**静态类型系统**、类、接口等特性，帮助开发者构建更健壮的大型应用。TypeScript 代码最终会被编译为标准的 JavaScript，因此可以在任何支持 JavaScript 的环境中运行。

举个例子，以下是一个 TypeScript 函数：

```typescript showLineNumbers
function greet(name: string): string {
    return `Hello, ${name}!`;
}

let user = "Rudy";
console.log(greeter(user));
```

这里通过 `: string` 指定了参数和返回值的类型，如果调用时传入非字符串参数，编译器会直接报错——这种特性让你在写代码时就能发现潜在问题，而不是等到运行时。



## 为什么选择 TypeScript？

1. **更早发现错误**

   JavaScript 是动态类型语言，错误通常在运行时暴露（比如变量类型错误）。而 TypeScript 的静态类型检查会在编译阶段标记问题，比如函数参数类型不匹配、未定义变量等，显著减少调试时间。

2. **更好的开发体验**

   TypeScript 提供智能代码提示和自动补全功能。例如，当你定义一个接口后，编辑器会提示对象必须包含哪些属性，避免拼写错误或遗漏字段。

3. **支持现代语法**

   TypeScript 支持 ES6+ 的语法（如箭头函数、解构赋值），并能编译为兼容旧浏览器的 JavaScript。此外，它还扩展了类、泛型、装饰器等高级特性，适合复杂项目。

4. **生态兼容性**

   TypeScript 与主流前端框架（如 Angular、React、Vue）深度集成，且社区提供了大量类型定义文件（`*.d.ts`），让你能安全地使用第三方库。



## TypeScript 的特点

- **TypeScript 就是 JavaScript**

  TypeScript 从 JavaScript 开始，也以 JavaScript 结束。TypeScript 采用 JavaScript 的基本构建块，因此你只需要了解 JavaScript 就可以使用 TypeScript。所有 TypeScript 代码都会转换为其 JavaScript 等效代码以便执行。

- **TypeScript 支持其他 JS 库**

  编译后的 TypeScript 可以被任何 JavaScript 代码使用。TypeScript 生成的 JavaScript 可以重用所有现有的 JavaScript 框架、工具和库。

- **JavaScript 是 TypeScript**

  这意味着任何有效的 **.js** 文件可以重命名为 **.ts** 并与其他 TypeScript 文件一起编译。

- **TypeScript 是可移植的**

  TypeScript 可以在浏览器、设备和操作系统之间移植。它可以在 JavaScript 运行的任何环境中运行。与其他语言不同，TypeScript 不需要专用的虚拟机或特定的运行时环境来执行。



## 未来动向

微软正在将 TypeScript 编译器迁移到 Go 语言（代号“Corsa”），预计 2025 年发布原生版本（TypeScript 7.0），编译速度可提升 10 倍，内存占用减少 50%，进一步提升大型项目的开发体验

