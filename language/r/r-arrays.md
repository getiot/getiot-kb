---
sidebar_position: 19
---

# R 语言 - 数组

本节介绍 R 语言中数组的概念和用法。与[矩阵](/r/r-matrices/)相比，数组可以有两个以上的维度。



## 创建数组

我们可以使用 `array()` 函数创建一个数组，并使用 `dim` 参数指定维度：

```R showLineNumbers
# An array with one dimension with values ranging from 1 to 24
thisarray <- c(1:24)
```

在上面的示例中，我们创建了一个值为 1 到 24 的数组。

```bash
> thisarray
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
```

将其转换为多维数组（通过参数 `dim=c(4,3,2)` 指定数组的维数）

```R showLineNumbers
# An array with more than one dimension
multiarray <- array(thisarray, dim = c(4, 3, 2))
```

其中，括号中的第一个和第二个数字指定行数和列数，括号中的最后一个数字指定了我们想要的维数。结果为：

```R showLineNumbers
> multiarray
, , 1

     [,1] [,2] [,3]
[1,]    1    5    9
[2,]    2    6   10
[3,]    3    7   11
[4,]    4    8   12

, , 2

     [,1] [,2] [,3]
[1,]   13   17   21
[2,]   14   18   22
[3,]   15   19   23
[4,]   16   20   24
```

**注意**：数组只能有一种数据类型。



## 访问数组项

你可以通过引用索引位置来访问数组元素，使用 `[]` 括号从数组中访问所需的元素：

```R showLineNumbers
thisarray <- c(1:24)
multiarray <- array(thisarray, dim = c(4, 3, 2))

multiarray[2, 3, 2]
```

语法如下：

```R showLineNumbers
array[row position, column position, matrix level]
```

你还可以使用 `c()` 函数从数组中的矩阵访问整行或整列：

```R showLineNumbers
thisarray <- c(1:24)

# Access all the items from the first row from matrix one
multiarray <- array(thisarray, dim = c(4, 3, 2))
multiarray[c(1),,1]

# Access all the items from the first column from matrix one
multiarray <- array(thisarray, dim = c(4, 3, 2))
multiarray[,c(1),1]
```

其中，`c()` 前的逗号表示我们要访问该列，`c()` 之后的逗号表示我们要访问该行。



## 检查数组项是否存在

要查明数组中是否存在指定项，请使用 `%in%` 运算符：

例如：检查数组中是否存在值“2”

```R showLineNumbers
thisarray <- c(1:24)
multiarray <- array(thisarray, dim = c(4, 3, 2))

2 %in% multiarray
```



## 行数和列数

使用 `dim()` 函数获取数组中的行数和列数：

```R showLineNumbers
thisarray <- c(1:24)
multiarray <- array(thisarray, dim = c(4, 3, 2))

dim(multiarray)
```



## 数组长度

使用 `length()` 函数查找数组的维度：

```R showLineNumbers
thisarray <- c(1:24)
multiarray <- array(thisarray, dim = c(4, 3, 2))

length(multiarray)
```



## 遍历数组

我们可以使用 `for` 循环来遍历数组项，例如：

```R showLineNumbers
thisarray <- c(1:24)
multiarray <- array(thisarray, dim = c(4, 3, 2))

for(x in multiarray){
  print(x)
}
```

