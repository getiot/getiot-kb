---
sidebar_position: 18
---

# R 语言 - 矩阵

矩阵是具有列和行的二维数据集。其中，列是数据的垂直表示，而行是数据的水平表示。

在 R 语言中，矩阵是其中元素以二维矩形布局排列的对象，其本质上仍是[向量](/r/r-vectors/)。因此，所有能对向量进行的操作，对矩阵都适用，对向量的限制，对矩阵也都适用，比如要求所有元素必须是同一类型。



## 创建矩阵

矩阵可通过使用 `matrix()` 函数来创建，参数 `nrow` 和 `ncol` 可用于指定矩阵的行数和列数。

```R showLineNumbers
# Create a matrix
thismatrix <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)

# Print the matrix
thismatrix
```

**注意**：请记住 `c()` 函数用于将子项连接在一起。

除了使用数字，你还可以创建一个带有字符串的矩阵，例如：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

thismatrix
```

结果为

```bash
> thismatrix
     [,1]     [,2]    
[1,] "apple"  "cherry"
[2,] "banana" "orange"
```



## 访问矩阵项

你可以使用 `[]` 括号访问这些项目。括号中的第一个数字“1”指定行位置，而第二个数字“2”指定列位置：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

thismatrix[1, 2]
```

如果你在括号中的数字后指定一个逗号，则可以访问整行：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

thismatrix[2,]
```

如果你在括号中的数字前指定一个逗号，则可以访问整列：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

thismatrix[,2]
```



### 访问多行

可以结合 `c()` 函数访问多行数据。例如访问第 1 和第 2 行：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

thismatrix[c(1,2),]
```



### 访问多列

可以结合 `c()` 函数访问多行数据。例如访问第 1 和第 2 列：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

thismatrix[, c(1,2)]
```



## 添加行和列

使用 `cbind()` 函数在矩阵中添加额外的列：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

newmatrix <- cbind(thismatrix, c("strawberry", "blueberry", "raspberry"))

# Print the new matrix
newmatrix
```

**注意**：新列中的单元格必须与现有矩阵的长度相同。

使用 `rbind()` 函数在矩阵中添加额外的行：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)

newmatrix <- rbind(thismatrix, c("strawberry", "blueberry", "raspberry"))

# Print the new matrix
newmatrix
```

**注意**：新行中的单元格必须与现有矩阵的长度相同。



## 删除行和列

使用 `c()` 函数删除矩阵中的行和列：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange", "mango", "pineapple"), nrow = 3, ncol =2)

#Remove the first row and the first column
thismatrix <- thismatrix[-c(1), -c(1)]

thismatrix
```



## 检查矩阵项是否存在

要查明指定项是否存在于矩阵中，请使用 `%in%` 运算符：

例如：检查矩阵中是否存在“apple”

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

"apple" %in% thismatrix
```



## 行数和列数

使用 `dim()` 函数可以获取矩阵中的行数和列数：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

dim(thismatrix)
```



## 矩阵大小

使用 `length()` 函数计算矩阵的维数（Dimension）：

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

length(thismatrix)
```

矩阵中的总单元格等于行数乘以列数。

在上面的示例中：矩阵的维数 = 2*2 = **4**。



## 遍历矩阵

你可以使用 `for` 循环遍历矩阵。循环将从第一行开始，向右移动。

示例：遍历矩阵项并打印它们

```R showLineNumbers
thismatrix <- matrix(c("apple", "banana", "cherry", "orange"), nrow = 2, ncol = 2)

for (rows in 1:nrow(thismatrix)) {
  for (columns in 1:ncol(thismatrix)) {
    print(thismatrix[rows, columns])
  }
}
```



## 合并矩阵

你可以使用 `rbind()` 或 `cbind()` 函数将两个或多个矩阵组合在一起，例如：

```R showLineNumbers
# Combine matrices
Matrix1 <- matrix(c("apple", "banana", "cherry", "grape"), nrow = 2, ncol = 2)
Matrix2 <- matrix(c("orange", "mango", "pineapple", "watermelon"), nrow = 2, ncol = 2)

# Adding it as a rows
Matrix_Combined <- rbind(Matrix1, Matrix2)
Matrix_Combined

# Adding it as a columns
Matrix_Combined <- cbind(Matrix1, Matrix2)
Matrix_Combined
```

