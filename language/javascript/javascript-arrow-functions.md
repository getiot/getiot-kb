---
sidebar_position: 11
---

# JavaScript 箭头函数



在 ECMAScript 6 中，箭头函数是其中最有趣的新增特性。顾名思义，箭头函数是一种使用箭头（`=>`）定义函数的新语法，但是它与传统的 JavaScript 函数有些许不同，主要体现在以下几方面：

- 没有 this、super、arguments 和 new.target 绑定
- 不能通过 new 关键字调用
- 没有原型
- 不可以改变 this 的绑定
- 不支持 arguments 对象
- 不支持重复的命名参数



## 箭头函数语法

箭头函数的语法多变，根据实际的使用场景有多种形式。所有变种都由函数参数、箭头、函数体组成，根据使用的需求，参数和函数体可以分别采取多种不同的形式。

### 形式一

举个例子，在下面这段代码中，箭头函数采用了单一参数，并且只是简单地返回了参数的值：

```javascript showLineNumbers
let reflect = value => value;

// 实际上相当于：

let reflect = function(value) {
    return value;
};
```

当箭头函数只有一个参数时，可以直接写参数名，箭头紧随其后，箭头右侧的表达式被求值后便立即返回。即使没有显式的返回语句，这个箭头函数也可以返回传入的第一个参数，不需要更多的语法铺垫。

### 形式二

如果要传入两个或两个以上的参数，要在参数的两侧添加一对小括号，例如：

```javascript showLineNumbers
let sum = (num1, num2) => num1 + num2;

// 实际上相当于：

let sum = function(num1, num2) {
    return num1 + num2;
};
```

这里的 `sum()` 函数接受两个参数，将它们简单相加后返回最终结果，它与 `reflect()` 函数唯一的不同是它的参数被包裹在小括号中，并且用逗号进行分隔（类似传统函数）。

### 形式三

如果函数没有参数，也要在声明的时候写一组没有内容的小括号，例如：

```javascript showLineNumbers
let getName = () => "GetIoT.tech";

// 实际上相当于：

let getName = function() {
    return "GetIoT.tech";
};
```

### 形式四

如果想要为函数编写由多个表达式组成的更传统的函数体，那么需要用花括号包裹函数体，并显式地定义一个返回值，例如这个版本的 `sum()` 函数：

```javascript showLineNumbers
let sum = (num1, num2) => {
    return num1 + num2;
};

// 实际上相当于：

let sum = function(num1, num2) {
    return num1 + num2;
};
```

除了 arguments 对象不可用以外，某种程度上你可以将花括号里的代码视作传统的函数体定义。

### 形式五

如果想创建一个空函数，需要写一对没有内容的花括号，例如：

```javascript showLineNumbers
let doNothing = () => {};

// 实际上相当于：

let doNothing = function() {};
```

### 形式六

如果想让箭头函数向外返回一个对象字面量，那么需要将该字面量包裹在小括号里。例如：

```javascript showLineNumbers
let getTempItem = id => ({ id: id, name: "Temp"});

// 实际上相当于：

let getTempItem = function(id) {
    return {
        id: id,
        name: "Temp"
    };
};
```

将对象字面量包裹在小括号中是为了将其与函数体区分开来。



## 箭头函数和数组

箭头函数的语法简洁，非常适用于数组处理。假设有一个数组 values，如下：

```javascript showLineNumbers
var values = [1, 2, 4, 5, 3, 7, 9, -2];
```

现在，你想给 values 数组排序，通常需要写一个自定义的比较器：

```javascript showLineNumbers
var result = values.sort(function(a, b) {
    return a - b;
});
```

如果使用箭头函数，则可以简化为：

```javascript showLineNumbers
var result = values.sort((a, b) => a - b);
```

诸如 `sort()`、`map()` 和 `reduce()` 等可以接受回调函数的数组方法，都可以通过箭头函数语法简化编码过程并减少代码量。

