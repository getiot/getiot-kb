---
sidebar_position: 29
---

# R 语言 - 最大和最小值



在上一章中，我们介绍了 **mtcars** 数据集，下面我们将继续使用该数据集进行统计分析。

我们在《[R 语言 – 数学函数](/r/r-math/)》中了解到 R 的一些内置的数学函数。例如，`min()` 和 `max()` 函数可用于查找集合中的最小值或最大值。



## 最大值和最小值

示例：找出变量 `hp`（horsepower，马力）的最大值和最小值。

```R showLineNumbers
Data_Cars <- mtcars

max(Data_Cars$hp)
min(Data_Cars$hp)
```

输出结果：

```R showLineNumbers
[1] 335
[1] 52
```

现在我们知道集合中最大的马力值是 **335**，最小的是 **52**。

我们可以查看数据集并尝试从中找出这两个值属于哪辆车。

```R showLineNumbers
                     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

观察上表，好像马力值最大的是玛莎拉蒂宝来（Maserati Bora），最低的是本田思域（Honda Civic）。

不过你可能和我一样看得有点头疼，让我们试试通过 R 来找出它们，这应该要容易得多（也更安全）。

例如，我们可以使用 `which.max()` 和 `which.min()` 函数来查找表中最大值和最小值的索引位置。

```R showLineNumbers
Data_Cars <- mtcars

which.max(Data_Cars$hp)
which.min(Data_Cars$hp)
```

输出结果：

```R showLineNumbers
[1] 31
[1] 19
```

不过这样还不够直观，我们可以将 `which.max()` 和 `which.min()` 与 `rownames()` 函数结合起来，以获取具有最大和最小马力的汽车的名称。

```R showLineNumbers
Data_Cars <- mtcars

rownames(Data_Cars)[which.max(Data_Cars$hp)]
rownames(Data_Cars)[which.min(Data_Cars$hp)]
```

输出结果：

```R showLineNumbers
[1] "Maserati Bora"
[1] "Honda Civic"
```

现在我们可以肯定地知道：**玛莎拉蒂宝来**是马力最大的车，**本田思域**是马力最小的车。



## 异常值

最大值和最小值的另一个用法是用于检测**异常值**（outliers）。异常值也称为“离群值”，是与其余观察值不同的数据点。

例如，在 **mtcars** 数据集中出现下面数据则可能是异常值：

- 如果汽车的最大前进档是 11
- 如果汽车的最小马力为 0
- 如果汽车的最大重量为 50 000 磅
