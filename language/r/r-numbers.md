---
sidebar_position: 7
---

# R 语言 - 数字



在 R 语言中，有三种数字类型：

- `numeric`
- `integer`
- `complex`

当你为它们赋值时，就会创建数字类型的变量，例如：

```R showLineNumbers
x <- 10.5   # numeric
y <- 10L    # integer
z <- 1i     # complex
```



## Numeric

`numeric` 数据类型是 R 中最常见的类型，包含任何带或不带小数点的数字，例如：10.5、55、787。

```R showLineNumbers
x <- 10.5
y <- 55

# Print values of x and y
x
y

# Print the class name of x and y
class(x)
class(y)
```



## Integer

`integer` 是整数类型，表示没有小数的数字数据。如果你确定一个数字变量永远不会包含小数，那么可以将其定义为整数类型。要创建“整数”变量，只需要在整数值后使用字母 `L`，例如：

```R showLineNumbers
x <- 1000L
y <- 55L

# Print values of x and y
x
y

# Print the class name of x and y
class(x)
class(y)
```



## Complex

`complex` 是复数类型，"`i`" 表示复数的虚部：

```R showLineNumbers
x <- 3+5i
y <- 5i

# Print values of x and y
x
y

# Print the class name of x and y
class(x)
class(y)
```



## 类型转换

你可以使用以下函数从一种类型转换为另一种类型：

- `as.numeric()`
- `as.integer()`
- `as.complex()`

示例：[type-conversion.R](https://github.com/getiot/r-courses/blob/main/03_DataTypes/type-conversion.R)

```R showLineNumbers
x <- 1L # integer
y <- 2 # numeric

# convert from integer to numeric:
a <- as.numeric(x)

# convert from numeric to integer:
b <- as.integer(y)

# print values of x and y
x
y

# print the class name of a and b
class(a)
class(b)
```

