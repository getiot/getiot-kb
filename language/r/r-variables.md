---
sidebar_position: 5
---

# R 语言变量



## 创建变量

变量是存储数据值的容器。在 R 语言中，没有用于声明变量的命令，变量是在你第一次为其赋值时创建的。

要为变量赋值，请使用 `<-` 符号。要输出（或打印）变量值，只需键入变量名，例如：

```R showLineNumbers
name <- "Rudy"
age <- 30

name   # output "Rudy"
age    # output 30
```

在上面示例中，`name` 和 `age` 是变量名，而 `"Rudy"` 和 `30` 则是变量的值。

在其他编程语言中，通常使用 `=` 作为赋值运算符。在 R 中，我们可以同时使用 `=` 和 `<-` 作为赋值运算符。

不过，在大多数情况下，`<-` 是首选，因为 `=` 运算符在 R 的某些上下文中可能被禁止。



## 打印/输出变量

与许多其他编程语言相比，在 R 中，你不必使用函数来打印/输出变量。只需要键入变量的名称即可，例如：

```R showLineNumbers
name <- "Rudy Lo"

name # auto-print the value of the name variable
```

但是，R 语言中也提供了 `print()` 函数。如果你熟悉其他编程语言，例如 [Python](/python/python-intro/)，这可能会很有用，因为它经常使用 `print()` 函数来打印变量内容。

```R showLineNumbers
name <- "Rudy Lo"

print(name) # print the value of the name variable
```

有时候，你必须使用 `print()` 函数来输出代码，例如在使用 `for` 循环时（后面的章节会介绍）：

```R showLineNumbers
for (x in 1:10) {
  print(x)
}
```

**结论**：是否使用 `print()` 函数输出代码完全由你决定。但是，当你的代码位于 R 表达式内时（例如在上例中的大括号“{}”内），如果要输出结果，就要使用 `print()` 函数。



## 连接元素

在 R 中，你可以使用 `paste()` 函数连接两个或多个元素。为了组合文本和变量，R 使用逗号（`,`）：

```R showLineNumbers
text <- "awesome"

paste("R is", text)
```

你还可以使用 `,` 将一个变量添加到另一个变量：

```R showLineNumbers
text1 <- "R is"
text2 <- "awesome"

paste(text1, text2)
```

对于数字变量，可以使用 `+` 字符作为数学运算符工作：

```R showLineNumbers
num1 <- 5
num2 <- 10

num1 + num2
```

但是如果你试图组合一个字符串（文本）和一个数字，R 会给你一个错误：

```R showLineNumbers
num <- 5
text <- "Some text"

num + text
```



## 多变量赋值

R 允许你在一行中为多个变量分配相同的值：

```R showLineNumbers
# Assign the same value to multiple variables in one line
var1 <- var2 <- var3 <- "Orange"

# Print variable values
var1
var2
var3
```



## 变量命名

变量可以有一个短名称（如 x 和 y）或更具描述性的名称（age、carname、total_volume）。R 变量的规则是：

- 变量名必须以字母开头，可以是字母、数字、句点（`.`）和下划线（`_`）。如果它以句点（`.`）开头，则后面不能跟数字。
- 变量名不能以数字或下划线（`_`）开头。
- 变量名区分大小写（age、Age 和 AGE 是三个不同的变量）
- 保留字不能用作变量（TRUE、FALSE、NULL、if...）

下面是变量命名的合法示例：

```R showLineNumbers
# Legal variable names:
myvar <- "Rudy"
my_var <- "Rudy"
myVar <- "Rudy"
MYVAR <- "Rudy"
myvar2 <- "Rudy"
.myvar <- "Rudy"
```

下面是变量命名不合法的示例：

```R showLineNumbers
# Illegal variable names:
2myvar <- "Rudy"
my-var <- "Rudy"
my var <- "Rudy"
_my_var <- "Rudy"
my_v@ar <- "Rudy"
TRUE <- "Rudy"
```

