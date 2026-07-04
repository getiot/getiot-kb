---
sidebar_position: 9
---

# JavaScript 函数定义



在程序设计中，将代码组织成执行特定任务的函数，可以使代码变得更清晰，同时有利于代码复用。JavaScript 使用关键字 **function** 定义函数。



## 定义函数

在 JavaScript 中，使用 **function** 关键字后跟一个描述该函数用途的名称，在 `()` 中添加参数列表，以及在 `{}` 块中添加代码语句，就定义了一个函数。例如：

```javascript showLineNumbers
function myFunction () {
    console.log("Hello, World");
}
```

要执行函数中的代码，只需要调用该函数，例如：

```javascript showLineNumbers
> myFunction();
Hello, World
```



## 函数参数

下面我们定义一个带参数的函数，并将特定的值传递给函数。

```javascript showLineNumbers
function greeting (name, city) {
    console.log("Hello " + name + ". How is the weather in " + city + "?");
}
```

调用 greeting 函数时需要传入两个参数 name 和 city，例如：

```javascript showLineNumbers
> greeting("Rudy", "Qingdao");
Hello Rudy. How is the weather in Qingdao?
```



## 函数返回值

我们在 [JavaScript 数据类型](/js/javascript-data-types/) 提到，如果函数没有返回值时，默认返回 `undefined`。但通常情况下，函数需要返回一个值，以便于调用它的代码可以获取返回值。

在 JavaScript 中，我们可以在函数块中使用 **return** 关键字从函数返回值。例如：

```javascript showLineNumbers
function formatGreeting (name, city) {
    var retStr = "";
    retStr = "Hello " + name + ".";
    retStr = " How is the weather in " + city + "?";
    return retStr;
}
```

调用函数时，先接收返回值，再输出其内容：

```javascript showLineNumbers
var greeting = formatGreeting("Rudy", "Qingdao");
console.log(greeting);
```

