---
sidebar_position: 2
slug: /typescript-environment-setup
---

# TypeScript 环境搭建

TypeScript 代码需要通过编译器（tsc）转换为 JavaScript 才能在浏览器或 Node.js 中运行。搭建环境的核心目标是安装 TypeScript 编译器并配置开发工具，让代码编写、编译和调试更高效。

## 安装

### 安装 Node.js 与 npm

TypeScript 依赖 Node.js 的包管理工具 npm 进行安装和管理。（具体步骤可参考 [Node.js 安装](/nodejs/nodejs-installation)）
1. **下载 Node.js**：访问 [Node.js 官网](https://nodejs.org/) ，选择 LTS（长期支持版）安装包下载。  
2. **验证安装**：安装完成后，在终端输入以下命令，确保版本号正常显示：
```bash
node -v  # 示例输出：v20.17.0
npm -v   # 示例输出：11.2.0
```

### 安装 TypeScript 编译器

通过 Node.js 的包管理器（npm）全局安装 TypeScript 编译器（tsc）：

```bash
npm install -g typescript
```

安装完成后，检查版本：

```bash
tsc -v  # 示例输出：Version 5.8.3
```

:::warning 注意

若在 Windows 系统下执行 `tsc` 命令报错（如“禁止运行脚本”），需以管理员身份运行 PowerShell，执行 `Set-ExecutionPolicy RemoteSigned` 并输入 `Y` 确认。

:::



## 开发工具

[VS Code](/vscode) 是 TypeScript 官方推荐的编辑器，它内置了对 TypeScript 的支持，可提供智能提示和调试支持。安装 VS Code 编辑器后可通过快捷键 `Ctrl+Shift+B` 自动将 `.ts` 文件编译为 `.js`。

推荐插件：

- **TypeScript 支持**：内置无需额外安装。
- **TSLint**：代码规范检查（需全局安装 `npm install -g tslint`）。
- **Auto Compile**：自动编译 TypeScript 文件。



## 编写第一个程序

打开 VS Code 编辑器，创建 `hello.ts` 文件，输入如下代码：

```typescript showLineNumbers
function sayHello(name: string): void {
    console.log(`Hello, ${name}!`);
}
sayHello("TypeScript");
```

打开终端命令行，依次执行如下命令，将 `hello.ts` 编译成 `hello.js` 程序并运行。

```bash
tsc hello.ts    # 生成 hello.js
node hello.js   # 执行程序
```

输出结果：

```bash
Hello, TypeScript!
```



## 第一个 TypeScript 项目

在实际开发中，你通常需要创建一个 TypeScript 项目工程，而不是一个单独的 ts 文件。下面我们将学习如何创建并编译一个 TypeScript 项目。

首先创建一个目录：

```bash
mkdir my-ts-project
cd my-ts-project
```

执行 tsc 初始化命令生成配置文件：

```bash
tsc --init
```

这个命令会生成一个 `tsconfig.json` 文件，该配置文件提供了许多编译选项。你可以尝试修改配置，例如：

```json showLineNumbers title="tsconfig.json"
{
  "compilerOptions": {
    "target": "es5",       // 编译为兼容旧浏览器的 ES5 代码
    "module": "commonjs",  // 使用 CommonJS 模块规范
    "outDir": "./dist",    // 输出目录
    "rootDir": "./src",    // 源代码目录
    "sourceMap": true      // 生成调试用的 .map 文件
  },
  "exclude": ["node_modules"]
}
```

接下来，创建 `src` 目录，并在 `src` 目录下创建源代码文件 `index.ts`。输入如下代码：

```typescript showLineNumbers title="src/index.ts"
function greet(name: string): void {
  console.log(`Hello, ${name}!`);
}
greet("TypeScript");
```

执行 `tsc` 命令，将编译所有 .ts 文件，并输出到 dist 目录。

```bash
tsc  # 编译所有 .ts 文件，输出到 dist 目录
```

现在，你可以通过 Node.js 运行编译后的 JavaScript：

```bash
node dist/index.js  # 输出：Hello, TypeScript!
```



:::tip 推荐

在 VS Code 编辑器中，按下快捷键 `Ctrl+Shift+B`，选择 `tsc: 监视模式`，代码保存后将自动编译。

另外，你可以安装 `ts-node` 软件包，直接运行 .ts 文件，无需手动编译：

```bash
npm install -g ts-node
ts-node src/index.ts
```

:::



## 小结

本文介绍了 TypeScript 开发环境的基本概念和安装步骤，并通过实际操作带你编写并运行了第一个 TypeScript 程序。通过完成直接创建 `hello.ts` 文件和通过 `tsc` 初始化 TypeScript 项目两个示例，相信你已经完成本地开发环境的搭建，并掌握 TypeScript 程序的运行方法。接下来，我们将学习 TypeScript 的基本语法。
