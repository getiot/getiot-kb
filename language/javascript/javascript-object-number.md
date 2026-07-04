---
sidebar_position: 16
---

# JavaScript Number 对象



JavaScript 只有一种数字类型 `number`，这种类型包含整数值和小数值。但实际上，目前 JavaScript 并没有真正的整数。也就是说，一个“整数”其实只是一个没有小数部分的小数值。

和大多数现代计算机脚本语言一样，JavaScript 的 `number` 类型的实现基于“IEEE 754”标准，通常被称为“浮点”。JavaScript 明确地使用了这个标准的“双精度”（也就是“64位二进制”）格式。



## 创建 Number 对象

在 JavaScript 中，我们可以直接给变量赋值一个数字，例如：

```javascript showLineNumbers
var x = 123;
```

这里的 `x` 就是一个原始类型的数值，它本身没有属性和方法。不过，我们还是可以调用 Number 对象的属性和方法，这是因为在 JavaScript 中，原始类型可以向包装对象“借用”。比如，`toFixed()` 实际上是在 Number 对象原型（prototype）中声明的方法。

```javascript showLineNumbers
x.toFixed === Number.prototype.toFixed   // true
```

**Number** 对象是数值对应的包装对象，可以作为构造函数使用，也可以作为工具函数使用。

作为构造函数时，它用于生成值为数值的对象。例如：

```javascript showLineNumbers
var n = new Number(1);  // 创建一个值为 1 的对象
typeof n                // 类型为 "object"
```

作为工具函数时，它可以将任何类型的值转为数值。例如：

```javascript showLineNumbers
Number(true);    // 返回数字 1
Number(false);   // 返回数字 0
Number("123");   // 返回数字 123
```



## 对象属性

Number 对象拥有以下一些属性：

- `Number.POSITIVE_INFINITY`：正的无限，指向 `Infinity`。
- `Number.NEGATIVE_INFINITY`：负的无限，指向 `-Infinity`。
- `Number.NaN`：表示非数值，指向 `NaN`。
- `Number.MAX_VALUE`：表示最大的正数，相应的，最小的负数为 `-Number.MAX_VALUE`。
- `Number.MIN_VALUE`：表示最小的正数（即最接近 0 的正数，在 64 位浮点数体系中为 `5e-324`），相应的，最接近0的负数为 `-Number.MIN_VALUE`。
- `Number.MAX_SAFE_INTEGER`：表示能够精确表示的最大整数，即 `9007199254740991`。
- `Number.MIN_SAFE_INTEGER`：表示能够精确表示的最小整数，即 `-9007199254740991`。



## 对象方法

Number 对象拥有以下一些方法：

- `toString`：用来将一个数值转为字符串形式。可以接受一个参数，表示输出的进制。
- `toExponential`：用于将一个数转为科学计数法形式。参数表示小数点后有效数字的位数，范围为 0 到 20，超出这个范围，会抛出一个 RangeError。
- `toPrecision`：将一个数转为指定位数的有效数字。参数为有效数字的位数，范围是1到21，超出这个范围会抛出RangeError错误。
- `toFixed`：用于将一个数转为指定位数的小数，返回这个小数对应的字符串。参数为指定的小数位数，有效范围为 0 到 20，超出这个范围将抛出 RangeError 错误。

使用示例：

```javascript showLineNumbers
(10).toString()   // "10"
(10).toString(2)  // "1010"
(10).toString(8)  // "12"
(10).toString(16) // "a"

(1234).toExponential()  // "1.234e+3"
(1234).toExponential(1) // "1.2e+3"
(1234).toExponential(2) // "1.23e+3"

(12.35).toPrecision(3)  // "12.3"
(12.25).toPrecision(3)  // "12.3"
(12.15).toPrecision(3)  // "12.2"
(12.45).toPrecision(3)  // "12.4"

(10).toFixed(2)         // "10.00"
(10.005).toFixed(2)     // "10.01"
```



## 自定义方法

与其他对象一样，`Number.prototype` 对象上面可以自定义方法，被 `Number` 的实例继承。

```javascript showLineNumbers
Number.prototype.add = function (x) {
    return this + x;
};
```

上面代码为 `Number` 对象实例定义了一个 `add` 方法。

在数值上调用某个方法，数值会自动转为 `Number` 的实例对象，所以就得到了下面的结果。

```javascript showLineNumbers
8['add'](2)  // 10
```

上面代码中，调用方法之所以写成 `8['add']`，而不是 `8.add`，是因为数值后面的点，会被解释为小数点，而不是点运算符。将数值放在圆括号中，就可以使用点运算符调用方法了。

```javascript showLineNumbers
(8).add(2)   // 10
```

由于 add 方法返回的还是数值，所以可以链式运算。

```javascript showLineNumbers
Number.prototype.subtract = function (x) {
    return this - x;
};

(8).add(2).subtract(4)  // 6
```

上面代码在 `Number` 对象的实例上部署了 `subtract` 方法，它可以与 `add` 方法链式调用。

我们还可以部署更复杂的方法。

```javascript showLineNumbers
Number.prototype.iterate = function () {
    var result = [];
    for (var i = 0; i <= this; i++) {
        result.push(i);
    }
    return result;
};

(8).iterate()
// [0, 1, 2, 3, 4, 5, 6, 7, 8]
```

上面代码在 `Number` 对象的原型上部署了 `iterate` 方法，可以将一个数值自动遍历为一个数组。

需要注意的是，数值的自定义方法，只能定义在它的原型对象 `Number.prototype` 上面，数值本身是无法自定义属性的。

```javascript showLineNumbers
var n = 1;
n.x = 1;
n.x  // undefined
```

例如，上面代码中的 `n` 是一个原始类型的数值。直接在它上面新增一个属性 x，不会报错，但毫无作用，总是返回 `undefined`。这是因为一旦被调用属性，n 就自动转为 Number 的实例对象，调用结束后，该对象自动销毁。所以，下一次调用 n 的属性时，实际取到的是另一个对象，属性 x 当然就读不出来。


