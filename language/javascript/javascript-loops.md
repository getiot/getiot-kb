---
sidebar_position: 7
---

# JavaScript 循环语句



循环是多次执行同一段代码的一种手段，在程序设计中非常常见。JavaScript 提供了 for 和 while 两大类循环执行语句。



## for 循环

和 C/C++ 一样，JavaScript 中的 for 循环使用一个把 3 个语句结合成一个执行块的 for 语句，将代码循环执行特定的次数。

```javascript showLineNumbers
for ( 赋值; 条件; 更新 ) {
    /* 要执行的代码块 */
}
```

for 语句中的 3 个语句：

- **赋值**：只在循环开始之前执行，用于初始化将在循环中使用的一些变量；
- **条件**：在循环的每次迭代之前计算该表达式的值，如果条件为真（true）则循环继续执行，否则结束循环；
- **更新**：在每次循环结束后更新一些变量，通常使用递增或递减的计数器。

示例：

```javascript showLineNumbers
for (var x=1; x<=3; x++) {
    for (var y=1; y<=3; y++) {
        console.log(x + "x" + y + " = " + (x*y));
    }
}
```

输出结果：

```bash
1x1 = 1
1x2 = 2
1x3 = 3
2x1 = 2
2x2 = 4
2x3 = 6
3x1 = 3
3x2 = 6
3x3 = 9
```



## for-in 循环

for-in 是另一种类型的 for 循环，可在能够被迭代的任何数据类型上执行，比如数组和对象。

示例：

```javascript showLineNumbers
var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
for (var idx in days) {
    console.log("It's " + days[idx]);
}
```

输出结果：

```bash
It's Mon
It's Tue
It's Wed
It's Thu
It's Fri
It's Sat
It's Sun
```



## while 循环

while 循环会测试条件表达式，如果为真（true）则循环继续执行，否则跳出循环。

```javascript showLineNumbers
while ( 条件 ) {
    /* 需要执行的代码 */
}
```

示例：

```javascript showLineNumbers
var i = 1;
while (i<5) {
    console.log("Iteration " + i);
    i++;
}
```

输出结果：

```bash
Iteration 1
Iteration 2
Iteration 3
Iteration 4
```



## do-while 循环

do-while 是另一种 while 循环形式，它能保证循环语句块中的代码至少被执行一次。

```javascript showLineNumbers
do { 
    /* 需要执行的代码 */
} while ( 条件 );
```

示例：

```javascript showLineNumbers
var i = 1;
do {
    console.log("Iteration " + i);
    i++;
} while (i<5);
```

输出结果：

```bash
Iteration 1
Iteration 2
Iteration 3
Iteration 4
```

