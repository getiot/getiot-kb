---
sidebar_position: 23
---

# R 语言 - 绘制折线图



## 折线图

折线图有一条线连接图中的所有点。

要创建一条线，可以使用 `plot()` 函数并添加值为 `"l"` 的 `type` 参数：

示例：

```R showLineNumbers
plot(1:10, type="l")
```

绘制结果：

![](https://static.getiot.tech/r_plot_draw_a_line.png#center)



## 线条颜色

线条颜色默认为黑色。如果想要更改颜色，请使用 `col` 参数。

示例：

```R showLineNumbers
plot(1:10, type="l", col="blue")
```

绘制结果：

![](https://static.getiot.tech/r_plot_draw_a_line_blue.png#center)



## 线条宽度

要更改线条的宽度，请使用“lwd”参数（默认为“1”，而“0.5”表示缩小 50%，“2”表示放大 100%）。

示例：

```R showLineNumbers
plot(1:10, type="l", col="blue", lwd=2)
```

绘制结果：

![](https://static.getiot.tech/r_plot_draw_a_line_blue2.png#center)



## 线条样式

默认情况下，该线是实线。使用值从 **0 到 6** 的 `lty` 参数来指定行格式。

例如：`lty=3` 将显示虚线而不是实线

```R showLineNumbers
plot(1:10, type="l", col="blue", lwd=5, lty=3)
```

绘制结果：

![](https://static.getiot.tech/r_plot_draw_a_line_blue3.png#center)

下面列出 `lty` 的可用参数值：

- `0` 删除该行（不显示）
- `1` 显示实线（solid line）
- `2` 显示虚线（dashed line）
- `3` 显示点虚线（dotted line）
- `4` 显示一条“点划线”（dot dashed line）
- `5` 显示一条“长虚线”（long dashed line）
- `6` 显示一条“双虚线”（two dashed line）



## 多线条

如果想要在图表中显示多条线，可以将 `plot()` 函数与 `lines()` 函数一起使用。

示例：

```R showLineNumbers
line1 <- c(1,2,3,4,5,10)
line2 <- c(2,5,7,8,9,10)

plot(line1, type = "l", col = "blue")
lines(line2, type="l", col = "red")
```

绘制结果：

![](https://static.getiot.tech/r_plot_draw_multiple_lines.png#center)

