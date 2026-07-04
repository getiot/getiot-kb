---
sidebar_position: 13
---

# R 语言 - 循环语句



在 R 语言中，有两种循环语句：

- `while` 循环语句
- `for` 循环语句

只要达到指定的条件，循环就可以执行一段代码。

由于循环可以节省时间、减少错误并使代码更具可读性，因此在程序设计中使用非常广泛。



## While 循环

使用 while 循环，只要条件为真，我们就可以执行一组语句。

例如，只要 `i` 小于 6，就打印 `i` 的值：

```R showLineNumbers
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
}
```

在上面的示例中，循环将继续生成 1 到 5 之间的数字。循环将在 6 处停止，因为 6 < 6 为 FALSE。

在 `while` 循环中，你需要提前准备好相关变量，例如在本例中我们需要定义一个索引变量 `i`，我们将其设置为 1。

**注意**：记得增加 i，否则循环将永远持续下去。



### Break 语句

使用 break 语句，即使 while 条件为真，我们也可以停止循环。

例如：如果 `i` 等于 4，则退出循环

```R showLineNumbers
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}
```

循环将在 3 处停止，因为我们选择在 `i` 等于 4 (`i == 4`) 时使用 `break` 语句结束循环。



### Next 语句

使用 `next` 语句，我们可以在不终止循环的情况下跳过迭代。

例如：跳过 `i` 等于 3 的情况

```R showLineNumbers
i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
}
```

当循环经过值 3 时，会跳过它继续循环。



## For 循环

在 R 语言中，`for` 循环用于迭代序列，写法比 `while` 循环更为简洁。

```R showLineNumbers
for (x in 1:10) {
  print(x)
}
```

这不太像其他编程语言中的 `for` 关键字，而更像是其他面向对象编程语言中的迭代器方法。

使用 for 循环，我们可以执行一组语句，对向量（vector）、数组（array）、列表（list）等中的每个项目执行一次。

这里简单列举两个示例，你可以在后面的《[R 语言 - 列表](/r/r-lists/)》和《[R 语言 - 向量](/r/r-vectors/)》等章节中学习更多相关内容。

示例1：打印列表中的每一项

```R showLineNumbers
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  print(x)
}
```

示例2：打印骰子的数值

```R showLineNumbers
dice <- c(1, 2, 3, 4, 5, 6)

for (x in dice) {
  print(x)
}
```

提示：`for` 循环不需要像`while` 循环那样预先设置索引变量。



### Break 语句

使用 break 语句，我们可以在循环遍历所有项目之前停止循环。

例如：在“樱桃”处停止循环

```R showLineNumbers
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  if (x == "cherry") {
    break
  }
  print(x)
}
```

循环将在“cherry”处停止，因为我们选择了在 x 等于“cherry”时使用 break 语句来结束循环 (`x == "cherry"`)。



### Next 语句

使用 `next` 语句，我们可以在不终止循环的情况下跳过迭代。

例如：跳过“香蕉”

```R showLineNumbers
fruits <- list("apple", "banana", "cherry")

for (x in fruits) {
  if (x == "banana") {
    next
  }
  print(x)
}
```

当循环经过“banana”时，会跳过它继续循环。
