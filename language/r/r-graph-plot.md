---
sidebar_position: 22
---

# R 语言 - 绘图



## 绘制点

`plot()` 函数用于在图表中绘制点（标记）。

该函数采用参数来指定图中的点。

- 参数 1 指定 **x 轴** 上的点。
- 参数 2 指定 **y 轴** 上的点。

最简单的是，你可以使用 `plot()` 函数绘制两个数字的对比图。

示例1：在图中的位置 (1, 3) 处绘制一个点

```R showLineNumbers
plot(1, 3)
```

绘制结果：

![](https://static.getiot.tech/r_plot_simple.png#center)



## 绘制多点

如果想要绘制多个点，可以使用[向量](/r/r-vectors/)。

例如：在位置 (1, 3) 和位置 (8, 10) 上绘制两个点

```R showLineNumbers
plot(c(1, 8), c(3, 10))
```

你可以通过这种方式绘制任意多的点，只要确保两个轴上的点数相同即可。

例如：绘制五个点

```R showLineNumbers
plot(c(1, 2, 3, 4, 5), c(3, 7, 8, 9, 12))
```

绘制结果：

![](https://static.getiot.tech/r_plot_multiple_points.png#center)

为了更好地组织多个值，建议使用变量将它们保存起来，例如：

```R showLineNumbers
x <- c(1, 2, 3, 4, 5)
y <- c(3, 7, 8, 9, 12)

plot(x, y)
```



## 点序列

如果要在 **x 轴** 和 **y 轴** 上按序列绘制点，可以使用 `:` 运算符。

示例：

```R showLineNumbers
plot(1:10)
```

绘制结果：

![](https://static.getiot.tech/r_plot_sequences_of_points.png#center)



## 绘制线条

`plot()` 函数还可以采用值为 `l` 的 `type` 参数来绘制一条线来连接图中的所有点。

示例：

```R showLineNumbers
plot(1:10, type="l")
```

绘制结果：

![](https://static.getiot.tech/r_plot_draw_a_line.png#center)



## 绘图标签

`plot()` 函数还接受其他参数，例如 `main`、`xlab` 和 `ylab`，如果你想使用主标题和 x 轴和 y 轴的不同标签自定义图形。

示例：

```R showLineNumbers
plot(1:10, main="My Graph", xlab="The x-axis", ylab="The y axis")
```

绘制结果：

![](https://static.getiot.tech/r_plot_labels.png#center)



## 图形外观

你可以使用许多其他参数来更改点的外观。

### 颜色

使用 `col="*color*"` 为点添加颜色。

示例：

```R showLineNumbers
plot(1:10, col="red")
```

绘制结果：

![](https://static.getiot.tech/r_plot_appearance_color.png#center)



### 大小

使用 `cex=*number*` 改变点的大小（`1` 是默认值，而 `0.5` 表示小 50%，而 `2` 表示大 100%）。

示例：

```R showLineNumbers
plot(1:10, cex=2)
```

绘制结果：

![](https://static.getiot.tech/r_plot_appearance_size.png#center)



### 形状

使用 `pch` 和 0 到 25 之间的值来更改点形状格式。

示例：

```R showLineNumbers
plot(1:10, pch=25, cex=2)
```

绘制结果：

![](https://static.getiot.tech/r_plot_appearance_shape.png#center)

`pch` 参数的取值范围为 0 到 25，这意味着我们最多可以选择 26 种不同类型的点形状，下图列出了所有形状。

![](https://static.getiot.tech/r_plot_pch2.png#center)


