---
sidebar_position: 3
slug: /typescript-modules
---

# TypeScript - 模块

在 TypeScript 中，**模块**（Module）是将相关代码组织在一起的一种机制，方便你进行封装、复用和维护。每个模块都有自己的作用域，默认情况下模块中的内容是私有的，只有通过 `export` 导出的成员才能在其他模块中访问。

从 ES6 开始，JavaScript 原生就支持模块，而 TypeScript 也基于这一标准进行了扩展与支持。



## 什么是模块？

模块可以是一个文件，也可以是多个文件的组合。你可以把模块理解为“独立作用域中的一组变量、函数、类或接口”，它们不会污染全局命名空间。在 TypeScript 中，模块通过 `export` 暴露变量、函数或类，通过 `import` 引入其他模块中导出的成员。

在现代前端与全栈开发中，**模块化** 已经成为构建大型系统的核心方式，而 TypeScript 的模块系统正是连接这一理念的重要桥梁。模块的引入具有非常重要的意义，包括：

- **增强代码组织性与可维护性**：模块让你可以将功能划分为独立的文件，每个文件专注于某个领域（如用户管理、订单处理等），大大提升了代码的**可读性**与**可维护性**。
- **促进代码复用与共享**：模块的导入导出机制，让你能像搭积木一样重用代码。不仅是项目内部的代码复用，也让第三方库（比如 `lodash`、`axios`）以模块形式集成变得简单自然。
- **与 JavaScript 标准接轨**：TypeScript 的模块语法完全兼容 ES6 标准模块 (`import` / `export`)，这意味着你可以无缝地将 TS 代码与现代 JavaScript 一起打包、运行在浏览器或 Node.js 中。
- **支持构建大型应用的工程化需求**：对于企业级项目或大型团队，模块系统是代码分工、解耦和测试的基础。
- **生态工具链的基石**：许多流行框架（如 React、Vue、NestJS、Next.js 等）和构建工具（Webpack、Rollup、Vite）都依赖模块系统进行依赖管理与打包优化。

总之，TypeScript 模块不仅是语法上的组织方式，更是现代前端工程化的核心支柱，连接了**可维护性、类型安全、工具链集成**与**标准化**开发的每一个环节。

![](https://static.getiot.tech/module-icon_processed.png#center-200)



## 内部模块和外部模块

模块主要分为两种类型：内部模块和外部模块。

**内部模块**是 TypeScript 早期版本中用于逻辑分组代码的方式，它允许你将类、接口、函数等组织成一个单元，并可以导出到其他模块中。在最新版本的 TypeScript 中，内部模块已经被命名空间（Namespaces）所取代，因此建议使用命名空间而不是内部模块。关于命名空间的使用方法，可以参考 [上一节](/ts/typescript-namespaces/) 的内容。

**外部模块**用于在多个 JavaScript 文件之间指定和加载依赖关系。传统的 JavaScript 文件依赖管理是通过浏览器的 `<script>` 标签实现的，但这种方式是线性的，无法异步加载模块。TypeScript 提供了更好的解决方案，允许你在客户端（如浏览器）和服务器端（如 Node.js）环境中异步加载模块。

- **客户端模块加载器**：在浏览器环境中，常用的模块加载器是 **RequireJS**，它实现了 AMD（Asynchronous Module Definition）规范。AMD 允许你异步加载模块，即使它们之间存在依赖关系。
- **服务器端模块加载器**：在 Node.js 环境中，模块加载是通过 **CommonJS** 规范实现的，使用 `require` 和 `module.exports` 来导出和导入模块。
- **定义和使用外部模块**：在 TypeScript 中，你可以使用 `export` 和 `import` 关键字来定义和使用外部模块。



## 模块使用示例

### 如何导出模块？

你可以使用 `export` 关键字导出一个或多个变量、函数、类或接口：

```typescript showLineNumbers title="Calculator.ts"
// file: Calculator.ts
export function add(x: number, y: number): number {
  return x + y;
}

export function subtract(x: number, y: number): number {
  return x - y;
}
```

你还可以使用 `export` 声明整个模块的默认导出（`export default`）：

```typescript showLineNumbers title="Logger.ts"
// file: Logger.ts
export default function log(message: string): void {
  console.log("Log message:", message);
}
```



### 如何导入模块？

在其他文件中使用 `import` 引入模块成员：

```typescript showLineNumbers title="App.ts"
// file: App.ts
import { add, subtract } from "./Calculator";

console.log(add(10, 5));      // 输出: 15
console.log(subtract(10, 5)); // 输出: 5
```

对于默认导出，你可以自定义导入的变量名：

```typescript showLineNumbers title=""
import log from "./Logger";

log("模块已加载"); // 输出: Log message: 模块已加载
```



### 编译 TypeScript 模块

要编译使用模块的 TypeScript 代码，你需要设置 `tsconfig.json` 文件中的 `module` 选项，例如：

```json showLineNumbers title="tsconfig.json"
{
  "compilerOptions": {
    "module": "ES6",
    "target": "ES5"
  }
}
```

设置好以后，直接执行 `tsc` 命令即可编译所有 .ts 文件。

或者你也可以使用命令行参数来指定模块类型：

```bash
tsc --module ES6 App.ts
```

:::tip

TypeScript 支持的模块类型包括：`CommonJS`、`ES6`、`AMD`、`System` 等，具体选择取决于你的运行环境（如 Node.js 或浏览器）和打包工具（如 Webpack、Rollup）。

:::



## 模块 vs 命名空间

虽然命名空间（namespace）和模块在概念上都可以组织代码，但它们之间有一些重要区别：

| 特性         | 命名空间（namespace）              | 模块（module）               |
| ------------ | ---------------------------------- | ---------------------------- |
| 语法         | 使用 `namespace` 关键字            | 使用 `export/import`         |
| 编译后作用域 | 全局（通常在浏览器中）             | 独立文件作用域               |
| 依赖管理     | 手动引入（使用 `/// <reference>`） | 自动依赖管理（基于文件路径） |
| 使用场景     | 小型项目、浏览器脚本               | 现代项目、使用打包工具的项目 |

如果你在开发现代应用（尤其是使用打包器如 Webpack），推荐你使用模块而不是命名空间。

:::tip

TypeScript 既支持命名空间，也支持 ES6 模块语法。不过在现代项目中，**模块更推荐**，因为它们与 JavaScript 的标准一致，适合现代前端/后端开发流程。

命名空间适合较小或不使用模块打包工具的项目，例如早期的浏览器脚本或简单页面。

:::



## 小结

模块是 TypeScript 中管理和组织代码的重要机制。通过使用 `export` 和 `import`，你可以在多个文件中安全地共享和复用代码。与传统命名空间相比，模块提供了更清晰的结构、更强的封装性，并且与现代 JavaScript 生态（如 ES6、Node.js、Webpack 等）更兼容。掌握模块的使用，是你迈向大型项目开发的重要一步。
