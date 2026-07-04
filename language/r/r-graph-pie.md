---
sidebar_position: 25
---

# R 语言 - 绘制饼图



## 饼图

饼图（Pie Chart）是数据的圆形视图。在 R 语言中，使用 `pie()` 函数绘制饼图。

示例：

```R showLineNumbers
# Create a vector of pies
x <- c(10,20,30,40)

# Display the pie chart
pie(x)
```

绘制结果：

![](https://static.getiot.tech/r_pie.png#center)

可以看到，饼图为向量中的每个值绘制一个饼图（在本例中为 10、20、30、40）。

默认情况下，第一个饼图的绘制从 x 轴开始并**逆时针**移动。

**注意**：每个饼图的大小是通过使用以下公式将值与所有其他值进行比较来确定的。

值除以所有值的总和：`x/sum(x)`



## 起始角

你可以使用 `init.angle` 参数更改饼图的起始角度。

`init.angle` 的值是用角度定义的，默认角度为 0。

示例：以 90 度开始绘制饼图

```R showLineNumbers
# Create a vector of pies
x <- c(10,20,30,40)

# Display the pie chart and start the first pie at 90 degrees
pie(x, init.angle = 90)
```

绘制结果：

![](https://static.getiot.tech/r_pie2.png#center)



## 标签和标题

使用 `label` 参数向饼图添加标签，使用 `main` 参数添加标题。

示例：

```R showLineNumbers
# Create a vector of pies
x <- c(10,20,30,40)

# Create a vector of labels
mylabel <- c("Apples", "Bananas", "Cherries", "Dates")

# Display the pie chart with labels
pie(x, label = mylabel, main = "Fruits")
```

绘制结果：

![](https://static.getiot.tech/r_pie3.png#center)



## 颜色

你可以使用 `col` 参数为每个饼图添加颜色。

示例：

```R showLineNumbers
# Create a vector of colors
colors <- c("blue", "yellow", "green", "red")

# Display the pie chart with colors
pie(x, label = mylabel, main = "Fruits", col = colors)
```

绘制结果：

![](https://static.getiot.tech/r_pie4.png#center)



## 图例

如果想为每个饼图添加图例说明，可以使用 `legend()` 函数。

示例：

```R showLineNumbers
# Create a vector of labels
mylabel <- c("Apples", "Bananas", "Cherries", "Dates")

# Create a vector of colors
colors <- c("blue", "yellow", "green", "red")

# Display the pie chart with colors
pie(x, label = mylabel, main = "Fruits", col = colors)

# Display the explanation box
legend("bottomright", mylabel, fill = colors)
```

绘制结果：

![](https://static.getiot.tech/r_pie5.png#center)

图例可以位置可以设置为以下值：`bottomright`, `bottom`, `bottomleft`, `left`, `topleft`, `top`, `topright`, `right`, `center`。

