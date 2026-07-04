---
sidebar_position: 14
---

# R 语言 - 函数



- 函数是一段代码，只有在被调用时才会运行。
- 你可以将称为参数的数据传递到函数中。
- 函数可以返回数据作为结果。



## 创建函数

在 R 语言中，使用 `function()` 关键字创建函数。例如：

```R showLineNumbers
my_function <- function() { # create a function with the name my_function
  print("Hello World!")
}
```



## 调用函数

要调用函数，请使用函数名称后跟括号，例如 **my_function()**：

```R showLineNumbers
my_function <- function() {
  print("Hello World!")
}

my_function() # call the function named my_function
```



## 函数参数

信息可以作为参数传递给函数。

参数在函数名称后的括号内指定。你可以根据需要添加任意数量的参数，只需用逗号分隔它们即可。

以下示例具有一个带一个参数（fname）的函数。调用函数时，我们传递一个名字，在函数内部使用它来打印全名：

```R showLineNumbers
my_function <- function(fname) {
  paste(fname, "Griffin")
}

my_function("Peter")
my_function("Lois")
my_function("Stewie")
```



## 参数个数

默认情况下，必须使用正确数量的参数调用函数。这意味着如果你的函数需要 2 个参数，则必须传递 2 个参数调用该函数，不能多也不能少。

例如：下面函数需要 2 个参数：

```R showLineNumbers
my_function <- function(fname, lname) {
  paste(fname, lname)
}

my_function("Peter", "Griffin")
```

如果你尝试使用 1 个或 3 个参数调用该函数，那么你将收到错误消息。

```R showLineNumbers
my_function <- function(fname, lname) {
  paste(fname, lname)
}

my_function("Peter")
```



## 默认参数

以下示例显示如何使用默认参数值。

如果我们调用不带参数的函数，它会使用默认值：

```R showLineNumbers
my_function <- function(country = "China") {
  paste("I am from", country)
}

my_function("Sweden")
my_function("India")
my_function() # will get the default value, which is China
my_function("USA")
```



## 返回值

如果想让函数返回结果，请使用 `return()` 函数。例如：

```R showLineNumbers
my_function <- function(x) {
  return (5 * x)
}

print(my_function(3))
print(my_function(5))
print(my_function(9))
```

上面代码的输出将是：

```R showLineNumbers
[1] 15
[1] 25
[1] 45
```



## 嵌套函数

有两种创建嵌套函数的方法：

- 在另一个函数中调用一个函数。
- 在函数中编写函数。

**示例1：在一个函数中调用另一个函数**

```R showLineNumbers
Nested_function <- function(x, y) {
  a <- x + y
  return(a)
}

Nested_function(Nested_function(2,2), Nested_function(3,3))
```

第一个输入 `Nested_function(2,2)` 是主函数的“x”，第二个输入 `Nested_function(3,3)` 是主函数的“y”。因此输出为 (2+2) + (3+3) = **10**。

**示例2：在函数中写一个函数**

```R showLineNumbers
Outer_func <- function(x) {
  Inner_func <- function(y) {
    a <- x + y
    return(a)
  }
  return (Inner_func)
}
output <- Outer_func(3) # To call the Outer_func
output(5)
```

你不能直接调用 `Inner_func`，因为该函数已定义（嵌套）在 `Outer_func` 内部。我们需要先调用 `Outer_func` 才能间接地调用 `Inner_func`。

我们需要创建一个名为 output 的新变量并为其赋值，此处为 3。然后我们使用所需的“y”值打印输出，在本例中为 5。

因此输出为 **8** (3 + 5)。



## 递归

R 还接受函数递归，这意味着定义的函数可以调用自身。

递归（Recursion）是一个常见的数学和编程概念，简单来说就是一个函数调用它自己。这意味着你可以循环遍历数据以获得结果。

开发人员应该非常小心递归，因为很容易编写一个永不终止的函数，或者一个使用过多内存或处理器能力的函数。但是，如果编写正确，递归可以成为一种非常有效且数学上优雅的编程方法。

在下面示例中，`tri_recursion()` 是我们定义为调用自身（“递归”）的函数。我们使用 `k` 变量作为数据，每次递归时它都会递减 (`-1`)。 当条件不大于 0 时（即为 0 时），递归结束。

示例：

```R showLineNumbers
tri_recursion <- function(k) {
  if (k > 0) {
    result <- k + tri_recursion(k - 1)
    print(result)
  } else {
    result = 0
    return(result)
  }
}
tri_recursion(6)
```

对于新手来说，可能需要一些时间才能弄清楚它究竟是如何工作的，不过最好的学习方法是测试和修改它。
