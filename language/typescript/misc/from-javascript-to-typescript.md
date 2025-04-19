---
sidebar_position: 13
slug: /from-javascript-to-typescript
---

# 从 JavaScript 到 TypeScript 迁移

如果你已经熟悉 JavaScript，并且想要利用 TypeScript 带来的静态类型、类型检查和更好的开发体验，那么迁移就是一个很自然的选择。本文介绍将现有的 JavaScript 代码迁移到 TypeScript 的基本步骤，在不打破现有功能的前提下，逐步引入类型安全。



## 为什么从 JavaScript 迁移到 TypeScript？

- **类型安全**：TypeScript 的核心特性之一是静态类型检查，这有助于在开发早期捕获错误。
- **提高代码质量**：TypeScript 可以在开发过程中提前发现错误，节省时间和成本。
- **高级特性**：TypeScript 支持接口、类、模块等 JavaScript 不支持的特性。
- **可扩展性**：使用 TypeScript 更容易管理和扩展大型代码库。



## 迁移步骤

### 第一步：设置环境

如果你尚未安装 TypeScript，可以在终端中执行以下命令进行安装：

```bash
npm install -g typescript
```

参考《[TypeScript 环境搭建](/ts/typescript-environment-setup/)》。



### 第二步：添加 `tsconfig.json` 文件

为了更好地管理 TypeScript 项目，你需要在项目的根目录下创建一个 `tsconfig.json` 文件，这是 TypeScript 项目的核心配置文件。

下面是一个基本配置示例：

```json
{
    "compileOnSave": true,
    "compilerOptions": {
        "target": "es6",
        "lib": ["es6", "dom"],
        "module": "commonjs"
    },
    "include": ["src/**/*"]
}
```



### 第三步：转换 JavaScript 文件为 TypeScript

接下来，你可以将 `.js` 文件重命名为 `.ts`（如果文件包含 JSX，则重命名为 `.tsx`）。重命名后，TypeScript 编译器将识别这些文件并进行编译。

举个例子：

```bash
mv app.js app.ts
```

此时，TypeScript 编译器就会开始对该文件进行类型检查。但由于我们还没添加类型注解，所以初期不会有太多报错。



### 第四步：添加类型注解

一旦你的文件已经是 `.ts`，你就可以开始为函数、变量、参数等添加类型注解了。

以一个简单的 JavaScript 函数为例：

```javascript
function add(a, b) {
    return a + b;
}
```

将其转换为 TypeScript：

```typescript
function add(a: number, b: number): number {
    return a + b;
}
```



### 第五步：解决错误并安装外部库

转换代码后，可能需要解决类型错误。如果你使用了第三方库，例如 jQuery、Lodash 等，TypeScript 需要知道这些库的类型定义。你可以通过 `DefinitelyTyped` 项目提供的 `@types` 包来获取这些类型定义。

你可以使用 NPM 安装这些库的类型定义，例如：

```bash
npm install --save-dev @types/jquery @types/lodash
```

这样你就可以在代码中直接使用 jQuery、Lodash 的类型定义了。



### 第六步：编译 TypeScript 代码

解决所有错误后，你就可以在终端中执行以下命令来编译 TypeScript 代码：

```bash
npx tsc filename
```

将 `filename` 替换为实际的 TypeScript 文件名。编译后将生成一个同名的 JavaScript 文件，该文件可以直接在浏览器中使用或通过 Node.js 执行。



## 小结

将 JavaScript 项目迁移到 TypeScript 是一个渐进式的过程。你可以从重命名文件开始，逐步添加类型注解和类型检查机制，并借助社区提供的类型定义文件完善项目结构。通过这种方式，你不仅保留了 JavaScript 的灵活性，还能享受到类型系统带来的更高可靠性和开发效率。只要一步步来，这个过程其实没你想象的那么复杂。

