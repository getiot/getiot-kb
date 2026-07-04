---
sidebar_position: 25
---

# JavaScript 模块导出



在 JavaScript 中，**模块**是自动运行在严格模式下且没有办法退出运行的代码。

JS 脚本需要导入模块才能使用模块提供的功能，但在模块顶部定义的变量不会自动添加到全局共享作用域，这些变量仅在模块的顶级作用域中存在。因此，模块必须主动导出一些外部代码可以访问的元素，如变量和函数。当然，模块里面也可以导入其他模块。



## 模块导出示例

在 JavaScript 中，可以使用 `export` 关键字将一部分已发布的代码暴露给其他模块。请看下面示例：

```javascript showLineNumbers
// 导出数据
export var color = "blue";
export let name = "Rudy";
export const magicNumber = 12;

// 导出函数
export function sum(num1, num2) {
    return num1 + num2;
}

// 导出类
export class Rectangle {
    constructor(length, width) {
        this.length = length;
        this.width = width;
    }
}

// 这个函数是模块私有的
function subtract(num1, num2) {
    return num1 - num2;
}

// 定义一个函数
function multiply(num1, num2) {
    return num1 * num2;
}

// 之后再将它导出
export multiply;
```

在这个示例中，我们将 `export` 放在变量、函数或类声明的前面，以将它们从模块导出。此外，我们也可以先定义函数，后续再统一导出。可以看到，除了 `export` 关键字以外，模块中的每一个声明都与脚本中的声明一模一样。



## 模块语法限制

`export` 的一个重要的限制是，必须在其他语句和函数之外使用。

比如，在 if 语句中使用 `export` 会给出一个语法错误：

```javascript showLineNumbers
if (flag) {
    export flag;  // 语法错误
}
```

在 JavaScript 中，不能有条件导出或以任何方式动态导出。模块语法存在的一个原因是要让 JavaScript 引擎静态地确定哪些可以导出。因此，只能在模块顶部使用 `export`。

