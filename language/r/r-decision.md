---
sidebar_position: 12
---

# R 语言 - 判断语句



在 R 语言中，支持数学中常见的逻辑条件，包括：

| 运算符 | 描述     | 示例     |
| :----- | :------- | :------- |
| `==`   | 等于     | `x == y` |
| `!=`   | 不等于   | `x != y` |
| `>`    | 大于     | `x > y`  |
| `<`    | 小于     | `x < y`  |
| `>=`   | 大于等于 | `x >= y` |
| `<=`   | 小于等于 | `x <= y` |

这些条件可以以多种方式使用，最常见的是在“if 语句”和循环语句中使用。



## If 语句

If 语句用 `if` 关键字编写，用于指定在条件为 `TRUE` 时要执行的代码块，例如：

```R showLineNumbers
a <- 33
b <- 200

if (b > a) {
  print("b is greater than a")
}
```

在这个例子中我们使用了两个变量 a 和 b，它们被用作 if 语句的一部分来测试 b 是否大于 a。因为 a 是 33，b 是 200，我们知道 200 大于 33，所以我们在屏幕上打印 "b is greater than a"。

提示：在 R 中，使用花括号 `{ }` 来定义代码中的范围。



## Else If 语句

`else if` 关键字是 R 表达“如果前面的条件不成立，则尝试这个条件”的方式，例如：

```R showLineNumbers
a <- 33
b <- 33

if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print ("a and b are equal")
}
```

在此示例中，由于 “a” 等于 “b”，因此第一个条件不为真，但 `else if` 条件为真，因此我们在屏幕上打印 "a and b are equal"。

提示：你可以在 R 中使用任意多的 else if 语句。



## If Else 语句

else 关键字用于捕获任何未被前面条件捕获的内容，例如：

```R showLineNumbers
a <- 200
b <- 33

if (b > a) {
  print("b is greater than a")
} else if (a == b) {
  print("a and b are equal")
} else {
  print("a is greater than b")
}
```

在这个例子中，a 大于 b，所以第一个条件不成立，else if 条件也不成立，所以我们转到 else 条件并在屏幕上打印 "a is greater than b"。

你也可以在不使用 else if 的情况下使用 else，例如：

```R showLineNumbers
a <- 200
b <- 33

if (b > a) {
  print("b is greater than a")
} else {
  print("b is not greater than a")
}
```



## 嵌套 If 语句

你还可以在 `if` 语句中包含 `if` 语句，这称为 **嵌套** `if` 语句。

```R showLineNumbers
x <- 41

if (x > 10) {
  print("Above ten")
  if (x > 20) {
    print("and also above 20!")
  } else {
    print("but not above 20.")
  }
} else {
  print("below 10.")
}
```



## 逻辑与（AND）

`&` 符号（and）是逻辑运算符，用于组合条件语句。

例如：测试 a 是否大于 b，以及 c 是否大于 a

```R showLineNumbers
a <- 200
b <- 33
c <- 500

if (a > b & c > a) {
  print("Both conditions are true")
}
```



## 逻辑或（OR）

`|` 符号（或）是逻辑运算符，用于组合条件语句。

例如：测试 a 是否大于 b，或者 c 是否大于 a：

```R showLineNumbers
a <- 200
b <- 33
c <- 500

if (a > b | a > c) {
  print("At least one of the conditions is true")
}
```


