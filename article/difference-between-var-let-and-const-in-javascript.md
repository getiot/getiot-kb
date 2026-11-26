---
sidebar_position: 11
slug: /difference-between-var-let-and-const-in-javascript
---

# JavaScript 中 var、let、const 的区别



在 JavaScript 中，关键字 var、let、const 有什么区别？这是一道经典面试题。



## 六个方面

下面，我们从 6 个方面来回答 var、let、const 之间的区别。

### 1、是否存在变量提升

变量提升，即变量可以在声明之前使用。`var` 声明的变量存在变量提升，全局作用域下是 `window` 属性。

```javascript showLineNumbers
function A() {
    console.log(a);
    var a = 10;
}
```

调用 `A()` 函数时，输出 `undefined`。这是因为 JavaScript 预处理器将变量 a 的声明提升到函数体的开头了，相当于：

```javascript showLineNumbers
function A() {
    var a;
    console.log(a);
    a = 10;
}
```

而 `let` 和 `const` 声明的变量则不会被提升。

```javascript showLineNumbers
function B() {
    console.log(b);
    let b = 10;
}

function C() {
    console.log(c);
    const c = 10;
}
```

调用 `B()` 和 `C()` 函数时，都会直接抛出 Uncaught ReferenceError 错误。



### 2、变量能否重复声明

`var` 能重复声明，例如：

```javascript showLineNumbers
var a = 10;
var a = 20;
console.log(a); // 输出 20
```

`let` 和 `const` 不能重复声明，例如：

```javascript showLineNumbers
let b = 10;
let b = 20;    // 报错 Uncaught SyntaxError

const c = 10;
const c = 20;  // 报错 Uncaught SyntaxError
```



### 3、变量值能否修改

`var` 和 `let` 声明的值可以修改，例如：

```javascript showLineNumbers
var a = 10;
a = 20;
let b = 10;
b = 20;
```

而 `const` 声明的是常量，不能修改。例如：

```javascript showLineNumbers
const c = 10;
c = 20;  // 报错 Uncaught TypeError: Assignment to constant variable.
```

但如果 const 声明的是引用类型，对象中的属性值是可以修改。例如：

```javascript showLineNumbers
const d = {val:10};
d.val = 20;
```



### 4、是否必须设置初始值

`var` 和 `let` 声明时可以不用设置初始值。例如：

```javascript showLineNumbers
var a, let b;
a = 10;
b = 20;
```

但 `const` 声明时必须设置初始值，不能使用 `null` 占位。例如：

```javascript showLineNumbers
const c;  // 报错 Uncaught SyntaxError: Missing initializer in const declaration
```



### 5、是否存在块级作用域

如果声明的变量只在该块级作用域内有效，则称该变量存在块级作用域。

`var` 没有块级作用域，例如：

```javascript showLineNumbers
for (var i=0; i<3; i++) {
    console.log(i);
}
console.log(i);  // 输出 3

if (true) {
    var a = 10;
}
console.log(a);  // 输出 10
```

`let` 和 `const` 有块级作用域，例如：

```javascript showLineNumbers
for (let i=0; i<3; i++) {
    console.log(i);
}
console.log(i);  // 报错

if (true) {
    let b = 10;
}
console.log(b);  // 报错

if (true) {
    const c = 10;
}
console.log(c);  // 报错
```



### 6、是否存在暂时性死区

`var` 不存在暂时性死区，例如：

```javascript showLineNumbers
var a = 10;
if (true) {
    console.log(a);  // 输出 10
    var a = 20;
}
```

`let` 和 `const` 存在暂时性死区，例如：

```javascript showLineNumbers
var a = 10;
if (true) {
    console.log(a);
    let a = 20;  // 报错 Uncaught ReferenceError: Cannot access 'a' before initialization
}

if (true) {
    console.log(a);
    const a = 20;  // 报错 Uncaught ReferenceError: Cannot access 'a' before initialization
}
```



## 总结

| 区别               | var  | let  | const |
| ------------------ | ---- | ---- | ----- |
| 是否存在变量提升   | 是   | 否   | 否    |
| 是否能重复声明     | 是   | 否   | 否    |
| 变量值能否修改     | 能   | 能   | 否    |
| 是否必须设置初始值 | 否   | 否   | 是    |
| 是否存在块级作用域 | 否   | 是   | 是    |
| 是否存在暂时性死区 | 否   | 是   | 是    |

