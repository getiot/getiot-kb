---
sidebar_position: 2
slug: /typescript-namespaces
---

# TypeScript - 命名空间

在 TypeScript 中，**命名空间**（Namespaces）是一种逻辑分组相关代码的方式。它帮助你避免全局命名空间的污染，特别是在使用多个文件时，可以防止变量和接口的命名冲突。你可以把它想象成 JavaScript 中的模块（在 ES6 之前），用于将变量、函数、类等封装到一个逻辑单元中。

在你写大型项目时，命名空间能帮助你保持代码结构清晰，防止全局作用域被污染。



## 定义命名空间

你可以使用 `namespace` 关键字来定义一个命名空间，基本语法如下：

```typescript
namespace SomeNamespace {
    export interface ISomeInterface {}
    export class SomeClass {}
}
```

- `SomeNamespace` 是命名空间的名称。
- `export` 关键字用于标记需要在命名空间外部访问的类或接口。



## 访问命名空间中的类或接口

在另一个命名空间中访问类或接口时，可以使用以下语法：

```typescript
SomeNamespace.SomeClass;
```

如果命名空间定义在单独的 TypeScript 文件中，则需要使用[三斜线指令](/ts/typescript-triple-slash-directives)来引用该文件。

```typescript
/// <reference path="SomeFileName.ts" />
```



## 示例 1：基本用法

### 文件名：IShape.ts

```typescript showLineNumbers title="IShape.ts"
namespace Drawing {
    export interface IShape {
        draw(): void;
    }
}
```

### 文件名：Circle.ts

```typescript showLineNumbers title="Circle.ts"
/// <reference path="IShape.ts" />
namespace Drawing {
    export class Circle implements IShape {
        public draw(): void {
            console.log("Circle is drawn");
        }
    }
}
```

### 文件名：Triangle.ts

```typescript showLineNumbers title="Triangle.ts"
/// <reference path="IShape.ts" />
namespace Drawing {
    export class Triangle implements IShape {
        public draw(): void {
            console.log("Triangle is drawn");
        }
    }
}
```

### 文件名：TestShape.ts

```typescript showLineNumbers title="TestShape.ts"
/// <reference path="IShape.ts" />
/// <reference path="Circle.ts" />
/// <reference path="Triangle.ts" />

function drawAllShapes(shape: Drawing.IShape): void {
    shape.draw();
}

drawAllShapes(new Drawing.Circle());
drawAllShapes(new Drawing.Triangle());
```

编译并运行：

```bash
tsc --out app.js TestShape.ts
node app.js
```

输出结果：

```bash
Circle is drawn
Triangle is drawn
```



## 示例 2：嵌套命名空间

你可以在一个命名空间内部定义另一个命名空间。

```typescript
namespace Namespace1 {
    export namespace Namespace2 {
        export class ClassName {}
    }
}
```

访问嵌套命名空间的成员时，可以使用点运算符：

```typescript
Namespace1.Namespace2.ClassName;
```

请看下面示例：

### 文件名：Invoice.ts

```typescript showLineNumbers title="Invoice.ts"
namespace TutorialPoint {
    export namespace InvoiceApp {
        export class Invoice {
            public calculateDiscount(price: number): number {
                return price * 0.40;
            }
        }
    }
}
```

### 文件名：InvoiceTest.ts

```typescript showLineNumbers title="InvoiceTest.ts"
/// <reference path="Invoice.ts" />
var invoice = new TutorialPoint.InvoiceApp.Invoice();
console.log(invoice.calculateDiscount(500));
```

编译并运行：

```bash
tsc --out app.js InvoiceTest.ts
node app.js
```

输出结果：

```bash
200
```



## 小结

命名空间是一种老派但仍然有用的组织代码方式，尤其适用于不打包的 TypeScript 项目。通过将相关的函数、类和接口封装到命名空间中，你可以有效避免命名冲突，并让代码更具可读性。不过在现代开发中，你通常会使用模块（`import/export`）来替代命名空间。如果你在维护老项目或者正在学习基础语法，理解命名空间依然非常重要。
