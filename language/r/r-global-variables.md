---
sidebar_position: 15
---

# R 语言 - 全局变量



## 什么是全局变量

在函数外部创建的变量称为 **全局** 变量。

每个人都可以使用全局变量，无论是在函数内部还是外部。

示例：在函数外部创建一个全局变量并在函数内部使用它

```R showLineNumbers
txt <- "awesome"
my_function <- function() {
  paste("R is", txt)
}

my_function()
```

如果在函数内部创建同名变量，这个变量将是局部变量，只能在函数内部使用。具有相同名称的全局变量将保持原样，即仍然是具有原始值的全局变量。

示例：在函数内部创建一个与全局变量同名的变量

```R showLineNumbers
txt <- "global variable"
my_function <- function() {
  txt = "fantastic"
  paste("R is", txt)
}

my_function()

txt # print txt
```

如果你尝试打印 `txt`，它将返回“**global variable**”，因为我们在函数外部打印 `txt`。



## 全局赋值运算符

通常，当你在函数内部创建变量时，该变量是局部变量，并且只能在该函数内部使用。

想要在函数内创建全局变量，可以使用**全局赋值**运算符 `<<-`。

示例：如果使用赋值运算符 `<<-`，则变量属于全局作用域

```R showLineNumbers
my_function <- function() {
  txt <<- "fantastic"
  paste("R is", txt)
}

my_function()

print(txt)
```

此外，如果要更改函数内的全局变量，请使用 **global** 赋值运算符（`<<-`）。例如：

```R showLineNumbers
txt <- "awesome"
my_function <- function() {
  txt <<- "fantastic"
  paste("R is", txt)
}

my_function()

paste("R is", txt)
```


