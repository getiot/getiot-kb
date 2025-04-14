---
sidebar_position: 1
slug: /typescript-triple-slash-directives
---

# TypeScript - 三斜线指令

在 TypeScript 中，**三斜线指令**（Triple-Slash Directives） 是一种特殊的单行注释，它以 `///` 开头，主要用于指示编译器在编译期间如何处理某些文件之间的依赖关系。

三斜线指令在文件的**顶部**使用，并且只能在注释语句之前出现。它们通常用于引用其他文件或声明文件，对于大型项目中模块或类型定义的组织管理非常有用。

```typescript
/// <reference path="..." />
```



## 可用的三斜线指令类型

TypeScript 支持以下几种三斜线指令：

| 指令                            | 描述                                                         |
| ------------------------------- | ------------------------------------------------------------ |
| `/// <reference path="..." />`  | 引用另一个 TypeScript 文件，使当前文件能访问其声明内容。     |
| `/// <reference types="..." />` | 引用一个类型声明包（一般用于 `@types` 目录下的包）。         |
| `/// <reference lib="..." />`   | 引用一个内建库（例如 `es2015`、`dom` 等），相当于 `tsconfig.json` 中的 `lib`。 |
| `/// <amd-module />`            | 用于为模块提供一个自定义名称（主要用于 AMD 模块格式）。      |
| `/// <amd-dependency />`        | 引用一个 AMD 依赖。已不推荐使用。                            |



## 示例：`<reference path>`

这是最常用的一种三斜线指令，用于引用另一个文件的类型声明或代码内容。

**file1.ts** 文件：

```typescript showLineNumbers
export class Student {
    name: string;
    constructor(name: string) {
        this.name = name;
    }
    display(): void {
        console.log("学生姓名: " + this.name);
    }
}
```

**file2.ts** 文件：

```typescript showLineNumbers
/// <reference path="file1.ts" />

let s = new Student("小明");
s.display();
```

你需要同时编译两个文件：

```bash
tsc --outFile output.js file1.ts file2.ts
```

或者使用一个包含所有文件的 `tsconfig.json` 配置项目。



## 示例：`<reference types>`

当你使用第三方库（如 jQuery、Node.js）时，可以通过这个指令显式引用类型声明包。

```typescript showLineNumbers
/// <reference types="node" />
```

这告诉 TypeScript 去加载 `@types/node` 中的类型定义。如果你没有使用 `tsconfig.json` 文件，这种指令很有帮助。



## 示例：`<reference lib>`

你可以使用 `<reference lib>` 显式引用 TypeScript 的标准库（比如 DOM、ES2015 等）。

```typescript showLineNumbers
/// <reference lib="dom" />
/// <reference lib="es2015.iterable" />
```

这适用于某些环境中没有默认启用全部标准库时的补充。



## 示例：`<amd-module>`

这个指令用于为模块设置一个名字，适用于 AMD 模块系统。（了解即可）

```typescript showLineNumbers
/// <amd-module name="myModuleName" />
```

一般你不会经常使用这个指令，除非你在使用 AMD 相关的构建工具，比如 RequireJS。



## 示例：`<amd-dependency>`

```typescript showLineNumbers
/// <amd-dependency path="jquery" name="$" />
```

这会在生成的 JavaScript 中注入一个 AMD 的依赖项。现代项目推荐使用模块导入（`import`）来代替这种方式。（已不推荐使用该方式，了解即可）



## 注意事项

- 三斜线指令**必须放在文件顶部**，在任何代码或 import 语句之前。
- 如果你使用了模块系统（如 `import/export`），推荐使用模块导入语法而不是 `<reference path>`。
- 对于类型引用，尽可能使用 `tsconfig.json` 中的 `types` 字段来统一配置，而不是在每个文件中使用三斜线指令。



## 小结

三斜线指令是 TypeScript 提供的一种特殊语法，用于在编译时引用其他文件、类型声明包或标准库。它们主要用于非模块化代码结构中，或在过渡期项目中显式控制依赖关系。现代 TypeScript 项目中建议使用模块导入和 `tsconfig.json` 进行统一管理，但了解三斜线指令依然对你调试旧项目或非模块文件非常有帮助。

