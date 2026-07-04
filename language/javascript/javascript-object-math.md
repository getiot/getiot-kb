---
sidebar_position: 19
---

# JavaScript Math 对象



JavaScript 内置对象 Math 提供了一系列数学常数和数学方法。值得注意的是，Math 对象不是构造函数，不能生成实例，所有的属性和方法都必须在 Math 对象上调用。



## 算术值

JavaScript 提供 8 种可被 Math 对象访问的算术值，即 Math 的属性。

```javascript showLineNumbers
Math.E        // 自然常数
Math.PI       // 圆周率
Math.SQRT2    // 2 的算术平方根
Math.SQRT1_2  // 1/2 的平方根
Math.LN2      // 2 的自然对数
Math.LN10     // 10 的自然对数
Math.LOG2E    // 以 2 为底数，e 的对数
Math.LOG10E   // 以 10 为底数，e 的对数
```



## 算术方法

Math 对象提供以下一些数学方法。

- `Math.abs()`：绝对值
- `Math.ceil()`：向上取整
- `Math.floor()`：向下取整
- `Math.max()`：最大值
- `Math.min()`：最小值
- `Math.pow()`：指数运算
- `Math.sqrt()`：平方根
- `Math.log()`：自然对数
- `Math.exp()`：e 的指数
- `Math.round()`：四舍五入
- `Math.random()`：随机数



## 使用示例

```javascript showLineNumbers
// 计算 x 的绝对值
var x = -1.23;
Math.abs(x);

// 获取最大值和最小值
Math.max(2, -1, 5); // 5
Math.min(2, -1, 5); // -1

// 向下取整，返回小于参数的最大整数
Math.floor(3.2);    // 3
Math.floor(-3.2);   // -4

// 四舍五入，相当于 Math.floor(x + 0.5)
Math.round(0.1);    // 0
Math.round(0.5);    // 1
Math.round(0.6);    // 1

// 求 2 的二次幂
Math.pow(2, 2);     // 4
// 求 2 的三次幂
Math.pow(2, 3);     // 8

// 计算圆的面积
var radius = 20;
var area = Math.PI * Math.pow(radius, 2);
```

