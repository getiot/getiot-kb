---
sidebar_position: 10
---

# R 语言 - 布尔值



在编程中，我们经常需要知道表达式是 **true** 还是 **false**。

你可以计算 R 中的任何表达式，并获得两个答案之一，“真”或“假”。

当你比较两个值时，R 解释器会计算表达式的逻辑值并返回答案：

```R showLineNumbers
10 > 9    # TRUE because 10 is greater than 9
10 == 9   # FALSE because 10 is not equal to 9
10 < 9    # FALSE because 10 is greater than 9
```

你也可以通过变量来比较：

```R showLineNumbers
a <- 10
b <- 9

a > b
```

更多的，我们通常会在 `if` 语句中使用逻辑表达式，关于这部分可以参考《[R 语言判断语句](/r/r-decision/)》。

```R showLineNumbers
a <- 200
b <- 33

if (b > a) {
  print ("b is greater than a")
} else {
  print("b is not greater than a")
}
```

