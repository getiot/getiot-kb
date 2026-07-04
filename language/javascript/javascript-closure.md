---
sidebar_position: 28
---

# JavaScript 闭包



## 闭包的定义

一个函数和对其周围状态（lexical environment，词法环境）的引用捆绑在一起（或者说函数被引用包围），这样的组合就是**闭包**（**closure**）。也就是说，闭包让你可以在一个内层函数中访问到其外层函数的作用域。在 JavaScript 中，每当创建一个函数，闭包就会在函数创建的同时被创建出来。

Closure 被翻译为“闭包”，它是 [Theoritical computer science](https://en.wikipedia.org/wiki/Theoretical_computer_science) 里出的术语：不引用外部变量的 lambda 表达式是「封闭的」（Closed），那么把「开放的」表达式「封闭住」的东西，就是 Closure 了。



## 词法作用域

请看下面示例代码：

```javascript showLineNumbers
function init() {
    var name = "GetIoT";     // name 是一个被 init 函数创建的局部变量
    function displayName() { // displayName() 是内部函数（子函数），也是一个闭包
        console.log(name);   // 因为它使用了外层函数（父函数）中声明的变量 name
    }
    displayName();
}
init();
```

说明：`init()` 创建了一个局部变量 `name` 和一个名为 `displayName()` 的函数。`displayName()` 是定义在 `init()` 里的内部函数，并且仅在 `init()` 函数体内可用。请注意，`displayName()` 没有自己的局部变量。然而，因为它可以访问到外部函数的变量，所以 `displayName()` 可以使用父函数 `init()` 中声明的变量 `name` 。

实际上，**词法作用域**就是指 JavaScript 分析器如何在函数嵌套的情况下解析变量名。词法（lexical）一词指的是，词法作用域根据源代码中声明变量的位置来确定该变量在何处可用。比如，为了使嵌套函数可访问声明于它们外部作用域的变量，将代码封装在一处而实现上下文独立的闭合结构，这种词法环境（或称为“上下文”）就是所谓的“闭包”。



## 闭包示例

稍微修改上面的示例程序，使 `init` 函数返回它的内层函数 `displayName`，如下：

```javascript showLineNumbers
function init() {
    var name = "GetIoT";
    function displayName() {
        console.log(name);
    }
    return displayName;
}
var myFunc = init();
myFunc();
```

正常情况下，在函数内定义的变量为局部变量，只能在作用域内访问。在全局环境下应该是无法访问 `init` 函数作用域内的变量 `name`，更何况变量 `myFunc` 获取到的是 `displayName` 函数。但是利用闭包的特性，全局环境下的 `myFunc` 就能访问到 `init` 函数作用域内的变量 `name`。实际上，此时的 `name` 既不是局部的（Local），也不是全局的（Global），而是闭包（Closure）。

简单来说，**闭包就是指有权访问另一个函数作用域中变量的函数。**



## 浏览器调试

还是前面的例子，我们稍作修改，在 Chrome 浏览器中运行它。

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>闭包 Demo</title>
</head>
<body>
    <h1>闭包 Demo</h1>
    <script>
        debugger
        function makeFunc() {
            var name = "GetIoT";
            function displayName() {
                alert(name);
            }
            return displayName;
        }

        var myFunc = makeFunc();
        myFunc();
    </script>
</body>
</html>
```

在 JS 脚本的开头添加了 `debugger` 语句，开启调试功能，单步运行到 `myFunc()` 函数调用时，可以看到 Scope 作用域中有一项 **Closure (makeFunc)**，其中包含一个 `name` 变量。

![JavaScript 闭包示例调试](https://static.getiot.tech/javascript-closure-debugger.png#center)


