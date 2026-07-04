---
sidebar_position: 8
---

# R 语言 - 数学函数



## 数学运算

在 R 语言中，你可以使用数学运算符对数字进行常见的数学运算。

例如，运算符 `+` 用于两个数字相加：

```R showLineNumbers
10 + 5
```

运算符 `-` 用于两个数字相减：

```R showLineNumbers
10 - 5
```

你可以在 [R 语言运算符](/r/r-operators/) 学习更多运算符的使用。



## 内置数学函数

在 R 语言中，内置了很多数学函数，可帮助你方便地对数字执行数学计算。

例如，`min()` 和 `max()` 函数可用于查找集合中的最小或者最大的数字：

```R showLineNumbers
> max(5, 10, 15)
[1] 15

> min(5, 10, 15)
[1] 5
```



## sqrt()

`sqrt()` 函数返回数字的平方根：

```R showLineNumbers
> sqrt(16)
[1] 4
```



## abs()

`abs()` 函数返回数字的绝对（正）值：

```R showLineNumbers
> abs(-4.7)
[1] 4.7
```



## ceiling() and floor()

`ceiling()` 函数将数字向上舍入到最接近的整数，而 `floor()` 函数将数字向下舍入到最接近的整数，并返回结果：

```R showLineNumbers
> ceiling(1.4)
[1] 2

> floor(1.4)
[1] 1
```



## log()

`log()` 函数用于求对数，默认以自然常数 e 为底：

```R showLineNumbers
> e <- exp(1) # 变量e为自然常数
> log(e)
[1] 1
```

通过设置 base 参数，可以改变对数底的大小，例如 10：

```R showLineNumbers
> log(100, base=10)
[1] 2
```

