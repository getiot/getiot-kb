---
sidebar_position: 24
---

# R 语言 - 绘制散点图



## 散点图

我们在《[R 语言 – 绘图](/r/r-graph-plot/)》中了解到，`plot()` 函数可用来绘制数字之间的对比图。

散点图（scatter plot）是一种用于显示两个数值变量之间关系的图，并为每个观察绘制一个点。

它需要两个相同长度的向量，一个用于 x 轴（水平），一个用于 y 轴（垂直）。

示例1：

```R showLineNumbers
x <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y <- c(99,86,87,88,111,103,87,94,78,77,85,86)

plot(x, y)
```

绘制结果：

![](https://static.getiot.tech/r_scatterplot.png#center)

上述散点图其实显示的是 12 辆汽车经过的结果。对于第一次看到图表的人来说，这可能不太清楚，所以让我们添加一个标题和不同的标签来更好地描述散点图。

```R showLineNumbers
x <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y <- c(99,86,87,88,111,103,87,94,78,77,85,86)

plot(x, y, main="Observation of Cars", xlab="Car age", ylab="Car speed")
```

绘制结果：

![](https://static.getiot.tech/r_scatterplot_observation_of_cars.png#center)

其中，**x 轴** 显示汽车的年龄，**y 轴** 显示汽车通过时的速度。

现在，你能否观察结果之间有什么关系吗？

是的，好像越新的车开的越快，不过也有可能是巧合，毕竟我们只记录了 12 辆车。



## 比较图

在上面的示例中，汽车速度和年龄之间似乎存在关系，但如果我们也绘制另一天的观察结果呢？ 散点图会告诉我们其他信息吗？

要将绘图与另一个绘图进行比较，请使用 `points()` 函数。

示例：在同一个画布上绘制两个图

```R showLineNumbers
# day one, the age and speed of 12 cars:
x1 <- c(5,7,8,7,2,2,9,4,11,12,9,6)
y1 <- c(99,86,87,88,111,103,87,94,78,77,85,86)

# day two, the age and speed of 15 cars:
x2 <- c(2,2,8,1,15,8,12,9,7,3,11,4,7,14,12)
y2 <- c(100,105,84,105,90,99,90,95,94,100,79,112,91,80,85)

plot(x1, y1, main="Observation of Cars", xlab="Car age", ylab="Car speed", col="red", cex=2)
points(x2, y2, col="blue", cex=2)
```

绘制结果：

![](https://static.getiot.tech/r_scatterplot_observation_of_cars2.png#center)

**注意**：为了能够看到比较的差异，我们这里为绘图分配了不同的颜色（通过使用 `col` 参数）。红色代表第 1 天的值，而蓝色代表第 2 天的值。请注意，我们还添加了 `cex` 参数以增加点的大小。

**观察结论**：通过比较这两个图，我认为可以肯定地说它们都给了我们相同的结论 —— 汽车越新，开得越快。

