---
sidebar_position: 12
slug: /typescript-tsconfig-json
---

# TypeScript - tsconfig.json 文件

**tsconfig.json** 是 TypeScript 项目中的配置文件，用于指定编译选项。这些编译器选项用于编译 TypeScript 代码并将其转换为 JavaScript 代码。此外，它还允许开发人员指定更多配置，以便在项目中使用。tsconfig.json 文件通常位于项目的根目录，并以 JSON 格式存储。



## tsconfig.json 文件的基本结构

tsconfig.json 文件主要包含以下 5 个属性：

- **`compileOnSave`**：指定是否在保存代码时自动编译项目，默认为 `false`。
- **`compilerOptions`**：用于设置 TypeScript 编译器的选项，如目标 ECMAScript 版本、模块系统等。
- **`files`**：指定要包含在编译过程中的文件列表。
- **`include`**：使用通配符指定要包含在编译中的文件。
- **`exclude`**：使用通配符指定要排除在编译之外的文件。

tsconfig.json 文件中的所有属性都是可选的，如果你没有设置这些属性，那么编译器将使用默认设置。

下面是 `tsconfig.json` 文件的基本结构：

```json showLineNumbers
{
    "compileOnSave": true,
    "compilerOptions": {
        "target": "es6",
        "lib": [
            "es6",
            "dom"
        ],
        "module": "commonjs"
    },
    "files": [
        "app.ts",
        "base.ts"
    ],
    "include": [
        "src/**/*"
    ],
    "exclude": [
        "node_modules",
        "src/**/*.calc.ts"
    ]
}
```



## compileOnSave 选项

**`compileOnSave`** 属性用于指定在保存代码时是否立即编译项目代码。其默认值为 `false`。如果该属性为 `false`，那么意味着你需要手动编译代码。

```json showLineNumbers
{
    "compileOnSave": boolean_value
}
```



## compilerOptions 选项

**`compilerOptions`** 选项是 tsconfig.json 文件中非常重要的属性。它用于指定 TypeScript 编译器的编译设置。例如，如果你想在编译 TypeScript 代码时使用特定版本的 JavaScript 或模块，可以修改 `CompilerOptions` 属性。

以下是 `compilerOptions` 中常用的选项：

| 选项                | 描述                                                         |
| ------------------- | ------------------------------------------------------------ |
| `target`            | 指定输出 JavaScript 文件的 ECMAScript 版本，如 `es6`。       |
| `lib`               | 指定要包含的库文件，如 `es6` 和 `dom`。                      |
| `module`            | 指定模块系统，如 `commonjs`。                                |
| `esModuleInterop`   | 实现与非 ES 模块兼容导入的兼容性，允许从没有默认导出的模块进行默认导入。 |
| `resolveJsonModule` | 允许将 .json 文件作为项目中的模块导入。                      |
| `listFiles`         | 打印出编译的一部分文件列表。                                 |
| `strict`            | 启用所有严格的类型检查选项。                                 |
| `strictNullChecks`  | 对代码执行严格的空检查，助于防止空或未定义的访问错误。       |
| `outDir`            | 指定编译后输出目录。                                         |
| `outFile`           | 输出到单个文件。注意：如果指定了 `outFile`，则 `outDir` 将被忽略。 |
| `rootDir`           | 指定输入文件的根目录。                                       |
| `sourceRoot`        | 指定编译器应查找的源代码的位置，而不是默认位置。             |
| `sourceMap`         | 是否生成 `.map` 文件，方便调试。                             |
| `esModuleInterop`   | 允许默认导入非 ES 模块。                                     |
| `allowJs`           | 允许 JavaScript 文件与 TypeScript 文件一起编译。适用于混合使用 JS 和 TS 的项目。 |

以下是使用 tsconfig.json 文件中的 `compilerOptions` 的常用配置：

```json showLineNumbers
{    
    "compilerOptions": {
        "target": "es6",
        "lib": [
            "es6",
            "dom"
        ],
        "module": "commonjs"
    }
}
```



## files 选项

**`files`** 属性接受要包含在编译过程中的文件列表作为值。如果文件位于根目录中，你可以直接添加文件名；如果要包含在编译过程中，你可以为每个文件添加相对或绝对文件路径。例如：

```json showLineNumbers
"files": [
    "app.ts",
    "base.ts"
]
```



## include 选项

**`include`** 属性允许开发人员使用通配符查询添加用于编译的 TypeScript 文件列表。如果你想添加编译中的所有文件，你可以使用以下通配符查询。

```json showLineNumbers
"include": [
    "src/**/*"
]
```



## exclude 选项

**`exclude`** 属性与 `include` 属性相反。它允许开发人员使用通配符指定要排除在编译之外的文件。例如：

```json showLineNumbers
"exclude": [
    "node_modules",
    "src/**/*.calc.ts"
]
```



## 小结

对于 TypeScript 开发人员来说，了解如何管理 `tsconfig.json` 文件非常重要。通过合理配置 `compilerOptions`、`include`、`exclude` 和其他字段，你可以构建更高效、更可靠的 TypeScript 项目结构。掌握 `tsconfig.json` 的使用，不仅可以帮助你更好地控制构建过程，还能让团队协作更加顺畅。
