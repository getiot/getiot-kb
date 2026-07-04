---
sidebar_position: 8
---

# JavaScript 变量作用域



在介绍 [JavaScript 数据类型](/js/javascript-data-types/) 的时候，我们都是使用 **`var`** 关键字来声明变量，但由于 JavaScript 存在提升（Hoisting）机制，var 声明的变量容易让人迷惑。因此，ECMAScript 6 的新语法增加了 **`let`** 和 **`const`** 关键字声明变量的用法。

在介绍 `let` 和 `const` 之前，我们还是先来看看 `var` 的作用域范围。



## JavaScript 局部变量

如果变量在函数内声明，那么这个变量就是局部作用域的变量。例如：

```javascript showLineNumbers
function myFunction() {
    var carName = "Tesla"; // 函数内可调用 carName 变量
}
```

局部变量 `carName` 只能在函数内部访问，在函数开始执行时创建，函数执行完后局部变量会自动销毁。



## JavaScript 全局变量

相反，在函数外定义的变量，即为全局变量。全局变量具有**全局作用域**，网页中所有脚本和函数均可使用。例如：

```javascript showLineNumbers
var carName = "Tesla";

/* 此处可使用 carName 变量 */

function myFunction()
{
    /* 函数内可使用 carName 变量 */
}
```



## var 变量提升机制

函数内可以定义与函数外同名的变量，而且会在函数作用域内覆盖，例如：

```javascript showLineNumbers
var carName = "Tesla";

function myFunction() {
    console.log(carName);
    var carName = "BMW";
    console.log(carName);
}
```

执行 `myFunction()` 的输出如下：

```javascript showLineNumbers
undefined
BMW
```

第一个输出之所以是 `undefined`，原因是代码在预编译阶段被 JavaScript 引擎修改这下面这样了。

```javascript showLineNumbers
var carName = "Tesla";

function myFunction() {
    var carName;
    console.log(carName);
    carName = "BMW";
    console.log(carName);
}
```

变量 `carName` 的声明被提升至函数顶部，而初始化操作依旧留在原处执行。因此第一个 `console.log()` 访问 `carName` 变量时，由于变量尚未初始化，所以其值为 `undefined`。

为了避免 var 变量提升机制带来的潜在问题，ECMAScript 6 引入了 **let** 变量。



## let 变量用法

let 声明的用法与 var 相同，但是由于 let 声明的局部变量不会被提升，因此可以将其作用域限制在当前代码块中。例如：

```javascript showLineNumbers
function getValue(condition) {
    if (condition) {
        let value = "blue";
        /* 代码块1 */
        return value;
    } else {
        /* 代码块2 */
        return null;
    }
}
```

如果使用 var 声明变量 value，由于提升机制，代码块1 和代码块2 都能够访问 value 变量。而使用 let 声明，则只能在代码块1 中访问 value。

我们再看前面的例子，如果使用 let 声明会怎么样？

```javascript showLineNumbers
var carName = "Tesla";

function myFunction() {
    console.log(carName);
    let carName = "BMW";
    console.log(carName);
}
```

调用 `myFunction()` 后会直接抛出异常：

```bash
Uncaught ReferenceError: Cannot access 'carName' before initialization
```



## const 常量用法

使用 const 声明的是常量，其值一旦被设定后就不可更改，因此每个 const 声明的常量必须进行初始化。例如：

```javascript showLineNumbers
const name = "Rudy";
const age; // 语法错误：常量未初始化
```

声明 `age` 时由于没有赋值，因此执行该语句时会抛出异常。

在使用上，const 和 let 声明的都是块级标识符，因此常量也只在当前代码块内有效，一旦执行到块外就会立即被销毁。同样，const 常量也不会被提升至作用域顶部。

不过，虽然 const 常量初始化后就不可更改，但如果 const 声明的是对象，那么不可更改的只是它的绑定关系，而对象的值是允许修改的。例如：

```javascript showLineNumbers
const person = {
    name: "Rudy"
};

// 可以修改对象属性的值
person.name = "Terry";

// 抛出语法错误
person = {
    name: "Terry"
};
```



## 使用建议

在推出 ECMAScript 6 标准之后，人们普遍认为应该默认使用 let 而不是 var。对很多 JavaScript 开发者而言，let 实际上与他们想要的 var 一样，直接替换符合逻辑。这种情况下，对于需要写保护的变量则要使用 const。

然而，当更多的开发者迁移到 ECMAScript 6 以后，默认使用 const 的做法更加普遍。只有确实需要修改变量的值时才使用 let，因为大部分变量的值在初始化后不应再改变，而预料外的变量值的改变是很多 bug 的源头。这一理念获得了很多人的支持，你也不妨试一试。

