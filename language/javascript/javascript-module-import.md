---
sidebar_position: 26
---

# JavaScript 模块导入



在 JavaScript 中，从模块中导出的功能可以通过 **import** 关键字在另一个模块中访问。



## 基本语法

`import` 语句包括两部分 —— 要导入的标识符和标识符应当从哪个模块导入。语法如下：

```javascript showLineNumbers
import ( identifier1, identifier2 ) from "./example.js";
```

`import` 后面的大括号表示从给定模块导入的绑定（binding），关键字 from 表示从哪个模块导入给定的绑定，该模块由表示模块路径的字符串指定（被称作模块说明符）。浏览器使用的路径格式与传给 `<script>` 元素的相同，也就是说，必须把文件扩展名也加上。另一方面，Node.js 则遵循基于文件系统前缀区分本地文件和包的惯例。例如，example 是一个包，而 ./example.js 是一个本地文件。

当从模块中导入一个绑定时，它就好像使用 const 定义的一样。结果是你无法定义另一个同名变量（包括导入另一个同名绑定），也无法在 `import` 语句前使用标识符或改变绑定的值。



## 导入单个绑定

假设[前面的示例](/js/javascript-module-export/)在一个名为“example.js”模块中，我们可以导入并以多种方式使用这个模块中的绑定。

例如，只导入模块中的一个标识符：

```javascript showLineNumbers
// 只导入一个
import { sum } from "./example.js";

console.log(sum(1, 2));  // 3
sum = 1;                 // 抛出一个错误
```

尽管 example.js 导出的函数不止一个，但这个示例导入的却只有 `sum()` 函数。如果尝试给 sum 赋新值，结果是抛出一个错误，因为不能给导入的绑定重新赋值。



## 导入多个绑定

如果你想从示例模块导入多个绑定，则可以明确地将它们列出，例如：

```javascript showLineNumbers
// 导入多个
import { sum, multiply, magicNumber } from "./example.js";

console.log(sum(1, magicNumber));
console.log(multiply(1, 2));
```

这段代码从 example 模块中导入 3 个绑定（sum、multiply 和 magicNumber），之后就可以像在本地定义一样使用它们。



## 导入整个模块

特殊情况下，可以导入整个模块作为一个单一的对象。然后所有的导出都可以作为对象的属性使用。例如：

```javascript showLineNumbers
// 导入一切
import * as example from "./example.js";

console.log(example.sum(1, example.magicNumber));
console.log(example.multiply(1, 2));
```

这段代码从 example.js 中导出的所有绑定被加载到一个被称作 example 的对象中。指定的导出会作为 example 的属性被访问。这种导入格式被称作命名空间导入（`namespace import`）。因为 example.js 文件中不存在 example 对象，所以它作为 example.js 中所有导出成员的命名空间对象而被创建。



## 模块语法限制

与 export 一样，`import` 的一个重要的限制是，必须在其他语句和函数之外使用。

我们不能在一条语句中使用 `import`，只能在顶部使用它 。比如，下面这段代码会给出语法错误：

```javascript showLineNumbers
function tryImport() {
    import flag from "./example.js";  // 语法错误
}
```

在 JavaScript 中，`export` 和 `import` 关键字被设计成静态的，不能动态地导入或导出绑定。这样的好处之一是，像文本编辑器这样的工具可以轻松地识别模块中哪些信息是可用的。

