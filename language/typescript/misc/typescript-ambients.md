---
sidebar_position: 4
slug: /typescript-ambients
---

# TypeScript - 外部声明

在构建 TypeScript 项目时，你可能会使用到一些用 JavaScript 编写的第三方库。为了在 TypeScript 中正确地使用这些库，并享受类型检查和智能提示的优势，你需要为这些库提供类型信息。这就是 **外部声明**（Ambient Declarations） 的用途。

外部声明使用 `declare` 关键字来描述外部代码库的类型信息。这些声明不会被编译成 JavaScript 代码，它们仅存在于编译阶段，帮助 TypeScript 编译器进行类型检查。



## 什么是外部声明

外部声明是指在 TypeScript 中为已经存在于其他地方的变量、函数、类或模块提供类型信息。通过使用 `declare` 关键字，你可以告诉 TypeScript 编译器这些实体的类型，而无需提供具体的实现。

以下是一个使用 `declare` 关键字声明全局函数的示例：

```typescript
declare function fetch(url: string): Promise<Response>;
```

在这个例子中，我们声明了一个名为 `fetch` 的全局函数，它接受一个字符串类型的参数 `url`，并返回一个 `Promise<Response>` 类型的对象。



## 外部模块声明

对于外部模块，TypeScript 提供了模块声明的语法，可以为整个模块定义类型。

假设你有一个名为 `math-lib` 的 JavaScript 模块，提供了一个 `add` 函数。你可以为它创建一个类型声明文件 `math-lib.d.ts`，内容如下：

```typescript showLineNumbers title="math-lib.d.ts"
declare module 'math-lib' {
    export function add(a: number, b: number): number;
}
```

然后，在你的 TypeScript 文件中，你可以像这样使用该模块：

```typescript showLineNumbers
import { add } from 'math-lib';

console.log(add(2, 3)); // 输出: 5
```

通过这种方式，TypeScript 能够识别 `math-lib` 模块，并为其提供类型检查和智能提示。



## 使用外部声明

要在 TypeScript 项目中使用外部声明，你需要创建一个以 `.d.ts` 为后缀的声明文件，并在其中使用 `declare` 关键字来描述外部实体的类型。

假设你有一个名为 `utils.js` 的 JavaScript 文件，内容如下：

```javascript showLineNumbers title="utils.js"
function greet(name) {
    return 'Hello, ' + name;
}
```

你可以为它创建一个名为 `utils.d.ts` 的声明文件，内容如下：

```typescript showLineNumbers title="utils.d.ts"
declare function greet(name: string): string;
```

然后，在你的 TypeScript 文件中，你可以直接使用 `greet` 函数，TypeScript 编译器会根据声明文件提供类型检查和智能提示。



## 全局外部声明

有时候，你可能需要为全局变量或函数提供类型声明。这种情况下，你可以在声明文件中直接使用 `declare` 关键字，而不需要模块声明。

假设你在 HTML 文件中引入了一个全局变量 `VERSION`，你可以为它创建一个声明文件 `globals.d.ts`，内容如下：

```typescript showLineNumbers title="globals.d.ts"
declare const VERSION: string;
```

这样，TypeScript 编译器就会识别 `VERSION` 变量，并为其提供类型检查。



## 使用 DefinitelyTyped

[DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) 是一个由社区维护的 TypeScript 类型声明仓库，包含了大量流行 JavaScript 库的类型声明。你可以使用 `npm` 安装这些声明文件。

以安装 jQuery 的类型声明为例：

```bash
npm install --save-dev @types/jquery
```

安装完成后，TypeScript 编译器会自动识别 jQuery 的类型声明，你可以在项目中直接使用 jQuery，享受类型检查和智能提示的优势。



## 外部声明的最佳实践

- **使用社区提供的声明文件**：优先使用 DefinitelyTyped 提供的类型声明，避免重复造轮子。
- **为自定义库编写声明文件**：如果你使用的库没有现成的类型声明，可以自己编写 `.d.ts` 文件，为其提供类型信息。
- **保持声明文件的更新**：当外部库的 API 发生变化时，及时更新对应的声明文件，确保类型信息的准确性。



## 小结

通过本节的学习，你了解了 TypeScript 中的外部声明（Ambient Declarations）的概念和使用方法。外部声明允许你为已有的 JavaScript 代码提供类型信息，使得在 TypeScript 项目中使用这些代码时，能够享受类型检查和智能提示的优势。

掌握外部声明的使用，将有助于你更好地集成第三方库，提高代码的可维护性和可靠性。



