---
sidebar_position: 26
---

# R 语言 - 绘制条形图



## 条形图

条形图（Bar Charts）使用矩形条来可视化数据。条形图可以水平或垂直显示，条形的高度或长度与其代表的值成比例。

在 R 语言中，使用 `barplot()` 函数绘制垂直条形图。

示例：

```R showLineNumbers
# x-axis values
x <- c("A", "B", "C", "D")

# y-axis values
y <- c(2, 4, 6, 8)

barplot(y, names.arg = x)
```

绘制结果：

![](https://static.getiot.tech/r_bar.png#center)

说明：

- `x` 变量表示 x 轴 (A,B,C,D) 中的值
- `y` 变量表示 y 轴 (2,4,6,8) 中的值
- 然后我们使用 `barplot()` 函数创建值的条形图
- `names.arg` 定义 x 轴上每个观察值的名称



## 设置颜色

可以使用 `col` 参数更改条形图的颜色。

示例：

```R showLineNumbers
x <- c("A", "B", "C", "D")
y <- c(2, 4, 6, 8)

barplot(y, names.arg = x, col = "orange")
```

绘制结果：

![](https://static.getiot.tech/r_bar2.png#center)



## 设置密度

要更改条形纹理（bar texture），可以使用 `density` 参数。

示例：

```R showLineNumbers
x <- c("A", "B", "C", "D")
y <- c(2, 4, 6, 8)

barplot(y, names.arg = x, density = 10)
```

绘制结果：

![](https://static.getiot.tech/r_bar3.png#center)



## 设置宽度

使用 `width` 参数更改条形的宽度。

示例：

```R showLineNumbers
x <- c("A", "B", "C", "D")
y <- c(2, 4, 6, 8)

barplot(y, names.arg = x, width = c(1,2,3,4))
```

绘制结果：

![](https://static.getiot.tech/r_bar4.png#center)



## 水平条形

如果你希望条形图水平显示而不是垂直显示，可以使用 `horiz=TRUE`。

示例：

```R showLineNumbers
x <- c("A", "B", "C", "D")
y <- c(2, 4, 6, 8)

barplot(y, names.arg = x, horiz = TRUE)
```

绘制结果：

![](https://static.getiot.tech/r_bar5.png#center)

