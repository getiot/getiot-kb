---
sidebar_position: 29
---

# JavaScript 原型链与继承



## 概述

JavaScript 所有对象都可以从原型对象上继承属性和方法。每个构造函数都有一个原型对象，原型对象包括一个指向构造函数的指针。而实例中包含一个指向原型对象的内部指针。即构造函数的原型对象 `prototype` 等于实例对象的 `__proto__`。

假设构造函数的原型对象等于另一个构造函数的实例对象，那么实例对象的 `__proto__` 就拥有另一个构造函数的属性和方法。而所有函数的顶层都是 Object 函数。所以另一个构造函数的实例对象又拥有 Object 函数原型对象的属性和方法，以此构成一个链条就叫作**原型链**。实例对象可以拥有原型对象上的属性和方法就叫作**继承**。



## 示例

```javascript showLineNumbers
function fn () {
    this.name = "rudy";
}

function fn1 () {
    this.age = 18;
}

fn.prototype = new fn1();
let x = new fn();
console.log(x.name);  // 输出 rudy
console.log(x.age);   // 输出 18，age 属性是继承自构造函数 fn1 的原型对象
```

对比实例对象和原型对象：

```javascript showLineNumbers
// x是fn的实例对象，所以实例对象的内部指针指向构造函数的原型对象
console.log(x.__proto__ === fn.prototype);  // true

// fn的原型对象等于fn1的实例对象，所以原型对象的指针指向fn1的原型对象
console.log(fn.prototype.__proto__ === fn1.prototype); // true

// 原型对象的指针指向顶层函数Object的原型对象
console.log(fn1.prototype.__proto__ === Object.prototype); // true
```

综上，最后 fn 的实例对象 x 的指针指向顶层函数 Object 的原型对象，因此 x 既拥有自身构造函数 fn 上的属性和方法，也拥有 fn1 构造函数的属性和方法以及 Object 构造函数的属性和方法，即：

```javascript showLineNumbers
console.log(x.__proto__.__proto__.__proto__ === Object.prototype); // true
```

我们可以使用 `instanceof` 操作符来判断一个对象是否是构造函数的实例对象。

```javascript showLineNumbers
console.log(x instanceof fn);
console.log(x instanceof fn1);
console.log(fn instanceof Object);
console.log(fn1 instanceof Object);

let arr = new Array();
console.log(arr instanceof Array);
console.log(arr instanceof Object);
```


