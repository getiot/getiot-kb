---
sidebar_position: 16
---

# R 语言 - 向量



在 R 语言中，向量（vector）只是相同类型的项目列表。

要将项目列表组合成向量，请使用 `c()` 函数并用逗号分隔项目。



## 创建向量

在下面的示例中，我们创建了一个名为 **fruits** 的向量变量，它是一系列字符串的组合。

```R showLineNumbers
# Vector of strings
fruits <- c("banana", "apple", "orange")

# Print fruits
fruits
```

在下面示例中，我们创建了一个组合数值的向量：

```R showLineNumbers
# Vector of numerical values
numbers <- c(1, 2, 3)

# Print numbers
numbers
```

要创建一个包含序列中数值的向量，请使用 `:` 运算符：

```R showLineNumbers
# Vector with numerical values in a sequence
numbers <- 1:10

numbers
```

你还可以在序列中创建带小数的数值，但请注意，如果最后一个元素不属于该序列，则不会使用它：

```R showLineNumbers
# Vector with numerical decimals in a sequence
numbers1 <- 1.5:6.5
numbers1

# Vector with numerical decimals in a sequence where the last element is not used
numbers2 <- 1.5:6.3
numbers2
```

结果为

```R showLineNumbers
[1] 1.5 2.5 3.5 4.5 5.5 6.5
[1] 1.5 2.5 3.5 4.5 5.5
```

在下面的示例中，我们创建了一个逻辑值向量：

```R showLineNumbers
# Vector of logical values
log_values <- c(TRUE, FALSE, TRUE, FALSE)

log_values
```



## 向量长度

要找出一个向量有多少项，请使用 `length()` 函数：

```R showLineNumbers
fruits <- c("banana", "apple", "orange")

length(fruits)
```



## 向量排序

要按字母顺序或数字顺序对向量中的项目进行排序，请使用 `sort()` 函数：

```R showLineNumbers
fruits <- c("banana", "apple", "orange", "mango", "lemon")
numbers <- c(13, 3, 5, 7, 20, 2)

sort(fruits)  # Sort a string
sort(numbers) # Sort numbers
```



## 访问向量

你可以通过引用方括号 `[]` 内的索引号来访问向量项。其中，第一项的索引为 1，第二项的索引为 2，依此类推。

```R showLineNumbers
fruits <- c("banana", "apple", "orange")

# Access the first item (banana)
fruits[1]
```

你还可以通过使用 `c()` 函数引用不同的索引位置来访问多个元素：

```R showLineNumbers
fruits <- c("banana", "apple", "orange", "mango", "lemon")

# Access the first and third item (banana and orange)
fruits[c(1, 3)]
```

你还可以使用负索引号来访问除指定项目之外的所有项目：

```R showLineNumbers
fruits <- c("banana", "apple", "orange", "mango", "lemon")

# Access all items except for the first item
fruits[c(-1)]
```



## 修改向量项目

可以通过索引号更改向量中特定项目的值，例如：

```R showLineNumbers
fruits <- c("banana", "apple", "orange", "mango", "lemon")

# Change "banana" to "pear"
fruits[1] <- "pear"

# Print fruits
fruits
```



## 重复向量

要重复向量，请使用 `rep()` 函数：

**示例1：重复向量中的每个值**

```R showLineNumbers
repeat_each <- rep(c(1,2,3), each = 3)

repeat_each
```

结果为

```R showLineNumbers
[1] 1 1 1 2 2 2 3 3 3
```

**示例2：重复向量的序列**

```R showLineNumbers
repeat_times <- rep(c(1,2,3), times = 3)

repeat_times
```

结果为

```R showLineNumbers
[1] 1 2 3 1 2 3 1 2 3
```

**示例3：独立重复每个值**

```R showLineNumbers
repeat_indepent <- rep(c(1,2,3), times = c(5,2,1))

repeat_indepent
```

结果为

```R showLineNumbers
[1] 1 1 1 1 1 2 2 3
```



## 生成序列化向量

前面的一个示例中，我们向你展示了如何使用 `:` 运算符创建一个包含按序列排列的数值的向量。如下：

```R showLineNumbers
numbers <- 1:10

numbers
```

如果你想要在序列中进行更大或更小的间隔，可以使用 `seq()` 函数，例如：

```R showLineNumbers
numbers <- seq(from = 0, to = 100, by = 20)

numbers
```

**说明**：`seq()` 函数有三个参数，`from` 是序列的起点，`to` 是序列的终点，`by` 是序列的间隔。

