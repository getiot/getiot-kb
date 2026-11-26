---
sidebar_position: 3
slug: /matplotlib-overview
draft: true
---

# Matplotlib 数据可视化

### Matplotlib 安装与概述

#### 安装

```
$ sudo pip3 install matplotlib
```



#### 初体验

```python
import matplotlib.pyplot as plt
import numpy as np

a = np.loadtxt('a.txt')
b = np.loadtxt('b.txt')

#np.savetxt('test.txt', a) # 保存文件

plt.scatter(a[:, 0], a[:, 1]) # 第一列作为横坐标，第二列作为纵坐标
plt.scatter(b[:, 0], b[:, 1])
plt.show()
```



#### 方法概览

| 方法        | 图表   | 说明                                                         |
| ----------- | ------ | ------------------------------------------------------------ |
| plt.scatter | 散点图 | 通常用于显示和比较数值，表示因变量随自变量而变化的大致趋势。 |
| plt.plot    | 折线图 | 非常适合于显示在相等时间间隔下数据的趋势。                   |
| plt.bar     | 柱状图 | 以长方形的长度为变量，用来比较两个或以上的数值，只有一个变量（可横可纵，可堆积）。 |
| plt.pie     | 饼状图 | 适合展示数据中各项大小和各项总和的比例。                     |
| plt.hist    | 直方图 | 直方图（Histogram）比柱状图更复杂，可以表达两个不同的变量。直方图又称为质量分布图，可以解析出数据的规则性、分布状态等。 |
| plt.boxplot | 箱线图 | 又称为箱形图、盒须图、盒式图，用于显示一组数据分散情况，反映原始数据分布的特征，常见于品质管理。 |
| plt.subplot | 子图   | 在一个画布中绘制多个图表，可设定布局                         |



---

### Matplotlib 绘制散点图

#### 示例1：参数调节

```python
import matplotlib.pyplot as plt
import numpy as np

# s设置大小，默认为20
# color设置颜色，可以是简写或十六进制值
# marker是形状
plt.scatter(3, 5, s=200, color='r', marker='+')
plt.scatter(4, 5, s=200, color='g', alpha=0.6, marker=',')
plt.scatter(5, 5, s=200, color='b', alpha=0.4, marker='*')
plt.scatter(6, 5, s=200, color='#ff0ff0', marker='D')
plt.scatter(7, 5, s=200, color='#00f0f0', marker='h')
plt.scatter(8, 5, s=200, color='#fff060', marker='.')
plt.show()
```

![](https://static.getiot.tech/matplotlib-scatter-01.png)

#### 示例2：列表

```python
x = [1, 2, 3, 4]
y = [2, 3, 4, 8]
plt.scatter(x, y, s=[20, 40, 80, 300], color=['r', 'g', 'b', 'y'])
plt.show()
```

![](https://static.getiot.tech/matplotlib-scatter-02.png)

#### 示例3：随机数

```python
x1 = np.random.randint(1, 10, size=(10, 2))
x2 = np.random.randint(1, 10, size=(10, 2))
plt.scatter(x1[:, 0], x1[:, 1], color='r')
plt.scatter(x2[:, 0], x2[:, 1], color='g')
plt.show()
```

![](https://static.getiot.tech/matplotlib-scatter-03.png)

#### 示例4：男女身高

```python
X = np.loadtxt('X_height.txt')
y = np.concatenate([np.zeros(18), np.ones(18)]) 
plt.scatter(X[y==0, 0], X[y==0, 1], color='r', marker='_')
plt.scatter(X[y==1, 0], X[y==1, 1], color='g', marker='_')
plt.show()
```

![](https://static.getiot.tech/matplotlib-scatter-04.png)



---

### Matplotlib 绘制折线图

#### 示例1：参数调节

```python
import matplotlib.pyplot as plt
import numpy as np

x = np.arange(10)

np.random.seed(1)
y = np.random.random(size=10)
plt.plot(x, y)
plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-01.png)

```python
# linestyle指定样式，'--'为虚线，':'为点，'-.'为点划线，默认为'-'
plt.plot(x, y, color='r', linestyle='--', marker='o')
plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-03.png)

还可以像这样简写：

```python
plt.plot(x, y, 'r--*')
plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-04.png)



#### 示例2：三角函数

显示正弦函数

```python
x = np.linspace(0, 10, 101)
y = np.sin(x)
plt.plot(x, y)
plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-05.png)

把余弦函数也显示出来

```python
y2 = np.cos(x)
plt.plot(x, y)
plt.plot(x, y2)
plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-06.png)

增加图例、标题和描述信息

```python
plt.plot(x, y, label='sin(x)')
plt.plot(x, y2, label='cos(x)')
plt.legend()

plt.xlabel('x axis')
plt.ylabel('y value')

plt.title('My demo')

plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-07.png)

Matplotlib 会自动选择取值范围，我们也可以自己指定

```python
plt.plot(x, y, label='sin(x)')
plt.plot(x, y2, label='cos(x)')
plt.legend()

# 自定义取值范围
plt.axis([-5, 15, -2, 2])

plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-08.png)

也可以缩小

```python
# 自定义取值范围
plt.axis([5, 10, 0, 1.2])

plt.show()
```

![](https://static.getiot.tech/matplotlib-line-chart-09.png)



---

### Matplotlib 绘制柱状图

#### 示例1：季度图

```python
import matplotlib.pyplot as plt

x = ['Q1', 'Q2', 'Q3', 'Q4']
y = [10, 30, 20, 60]

# 可以指定颜色和宽度
rect = plt.bar(x, y, color='g', width=0.5)

# 添加数值
for ind, item in enumerate(rect):
    _x = item.get_x() + 0.2
    _y = item.get_height() + 1
    plt.text(_x, _y, y[ind])

# 指定y轴范围
plt.ylim(0, 70)

# 显示网格
plt.grid(True) 
plt.show()
```

![](https://static.getiot.tech/matplotlib-bar-chart-01.png)





---

### Matplotlib 绘制饼状图

#### 示例1：季度图

```python
import matplotlib.pyplot as plt

x = ['Q1', 'Q2', 'Q3', 'Q4']
y = [10, 30, 20, 60]
c = ['#FFA488', '#FFFF77', '#77FFCC', '#9999FF']

# plt.axes(aspect=1) # 正圆，已失效

# 添加标签，修改颜色，增加百分比
plt.pie(y, labels=x, colors=c, autopct='%.2f%%')
plt.show()
```

![](https://static.getiot.tech/matplotlib-pie-chart-01.png)

```python
# 分离
plt.pie(y, labels=x, colors=c, autopct='%.2f%%', explode=[0.1, 0, 0, 0])
plt.show()
```

![](https://static.getiot.tech/matplotlib-pie-chart-02.png)

```python
# 阴影
plt.pie(y, labels=x, colors=c, autopct='%.2f%%', explode=[0.1, 0, 0, 0], shadow=True)
plt.show()
```

![](https://static.getiot.tech/matplotlib-pie-chart-03.png)



---

### Matplotlib 绘制直方图

原型

```python
plt.hist(x, 
         bins=None, 
         range=None, 
         density=None, 
         weights=None, 
         cumulative=False, 
         bottom=None, 
         histtype='bar', 
         align='mid', 
         orientation='vertical', 
         rwidth=None, 
         log=False, 
         color=None, 
         label=None, 
         stacked=False, 
         normed=None, *, 
         data=None, 
         **kwargs
        )
```

文档描述

```python
Plot a histogram.

Compute and draw the histogram of *x*. The return value is a
tuple (*n*, *bins*, *patches*) or ([*n0*, *n1*, ...], *bins*,
[*patches0*, *patches1*,...]) if the input contains multiple
data.

Multiple data can be provided via *x* as a list of datasets
of potentially different length ([*x0*, *x1*, ...]), or as
a 2-D ndarray in which each column is a dataset.  Note that
the ndarray form is transposed relative to the list form.

Masked arrays are not supported at present.
```

参数

```python
x : (n,) array or sequence of (n,) arrays
    Input values, this takes either a single array or a sequence of
    arrays which are not required to be of the same length.

bins : int or sequence or str, optional
    If an integer is given, ``bins + 1`` bin edges are calculated and
    returned, consistent with `numpy.histogram`.

    If `bins` is a sequence, gives bin edges, including left edge of
    first bin and right edge of last bin.  In this case, `bins` is
    returned unmodified.

    All but the last (righthand-most) bin is half-open.  In other
    words, if `bins` is::

        [1, 2, 3, 4]

    then the first bin is ``[1, 2)`` (including 1, but excluding 2) and
    the second ``[2, 3)``.  The last bin, however, is ``[3, 4]``, which
    *includes* 4.

    Unequally spaced bins are supported if *bins* is a sequence.

    With Numpy 1.11 or newer, you can alternatively provide a string
    describing a binning strategy, such as 'auto', 'sturges', 'fd',
    'doane', 'scott', 'rice', 'sturges' or 'sqrt', see
    `numpy.histogram`.

    The default is taken from :rc:`hist.bins`.

range : tuple or None, optional
    The lower and upper range of the bins. Lower and upper outliers
    are ignored. If not provided, *range* is ``(x.min(), x.max())``.
    Range has no effect if *bins* is a sequence.

    If *bins* is a sequence or *range* is specified, autoscaling
    is based on the specified bin range instead of the
    range of x.

    Default is ``None``

density : bool, optional
    If ``True``, the first element of the return tuple will
    be the counts normalized to form a probability density, i.e.,
    the area (or integral) under the histogram will sum to 1.
    This is achieved by dividing the count by the number of
    observations times the bin width and not dividing by the total
    number of observations. If *stacked* is also ``True``, the sum of
    the histograms is normalized to 1.

    Default is ``None`` for both *normed* and *density*. If either is
    set, then that value will be used. If neither are set, then the
    args will be treated as ``False``.

    If both *density* and *normed* are set an error is raised.

weights : (n, ) array_like or None, optional
    An array of weights, of the same shape as *x*.  Each value in *x*
    only contributes its associated weight towards the bin count
    (instead of 1).  If *normed* or *density* is ``True``,
    the weights are normalized, so that the integral of the density
    over the range remains 1.

    Default is ``None``

cumulative : bool, optional
    If ``True``, then a histogram is computed where each bin gives the
    counts in that bin plus all bins for smaller values. The last bin
    gives the total number of datapoints. If *normed* or *density*
    is also ``True`` then the histogram is normalized such that the
    last bin equals 1. If *cumulative* evaluates to less than 0
    (e.g., -1), the direction of accumulation is reversed.
    In this case, if *normed* and/or *density* is also ``True``, then
    the histogram is normalized such that the first bin equals 1.

    Default is ``False``

bottom : array_like, scalar, or None
    Location of the bottom baseline of each bin.  If a scalar,
    the base line for each bin is shifted by the same amount.
    If an array, each bin is shifted independently and the length
    of bottom must match the number of bins.  If None, defaults to 0.

    Default is ``None``

histtype : {'bar', 'barstacked', 'step',  'stepfilled'}, optional
    The type of histogram to draw.

    - 'bar' is a traditional bar-type histogram.  If multiple data
      are given the bars are arranged side by side.

    - 'barstacked' is a bar-type histogram where multiple
      data are stacked on top of each other.

    - 'step' generates a lineplot that is by default
      unfilled.

    - 'stepfilled' generates a lineplot that is by default
      filled.

    Default is 'bar'

align : {'left', 'mid', 'right'}, optional
    Controls how the histogram is plotted.

        - 'left': bars are centered on the left bin edges.

        - 'mid': bars are centered between the bin edges.

        - 'right': bars are centered on the right bin edges.

    Default is 'mid'

orientation : {'horizontal', 'vertical'}, optional
    If 'horizontal', `~matplotlib.pyplot.barh` will be used for
    bar-type histograms and the *bottom* kwarg will be the left edges.

rwidth : scalar or None, optional
    The relative width of the bars as a fraction of the bin width.  If
    ``None``, automatically compute the width.

    Ignored if *histtype* is 'step' or 'stepfilled'.

    Default is ``None``

log : bool, optional
    If ``True``, the histogram axis will be set to a log scale. If
    *log* is ``True`` and *x* is a 1D array, empty bins will be
    filtered out and only the non-empty ``(n, bins, patches)``
    will be returned.

    Default is ``False``

color : color or array_like of colors or None, optional
    Color spec or sequence of color specs, one per dataset.  Default
    (``None``) uses the standard line color sequence.

    Default is ``None``

label : str or None, optional
    String, or sequence of strings to match multiple datasets.  Bar
    charts yield multiple patches per dataset, but only the first gets
    the label, so that the legend command will work as expected.

    default is ``None``

stacked : bool, optional
    If ``True``, multiple data are stacked on top of each other If
    ``False`` multiple data are arranged side by side if histtype is
    'bar' or on top of each other if histtype is 'step'

    Default is ``False``

normed : bool, optional
    Deprecated; use the density keyword argument instead.


Other Parameters
----------------
**kwargs : `~matplotlib.patches.Patch` properties
```

返回值

```python
Returns
-------
n : array or list of arrays
    The values of the histogram bins. See *normed* or *density*
    and *weights* for a description of the possible semantics.
    If input *x* is an array, then this is an array of length
    *nbins*. If input is a sequence of arrays
    ``[data1, data2,..]``, then this is a list of arrays with
    the values of the histograms for each of the arrays in the
    same order.

bins : array
    The edges of the bins. Length nbins + 1 (nbins left edges and right
    edge of last bin).  Always a single array even when multiple data
    sets are passed in.

patches : list or list of lists
    Silent list of individual patches used to create the histogram
    or list of such list if multiple input datasets.
```

其他

```python
See also
--------
hist2d : 2D histograms

Notes
-----
.. [Notes section required for data comment. See #10189.]

.. note::
    In addition to the above described arguments, this function can take a
    **data** keyword argument. If such a **data** argument is given, the
    following arguments are replaced by **data[<arg>]**:

    * All arguments with the following names: 'weights', 'x'.

    Objects passed as **data** must support item access (``data[<arg>]``) and
    membership test (``<arg> in data``).
File:      /usr/local/lib/python3.5/dist-packages/matplotlib/pyplot.py
Type:      function
```



#### 示例1：员工工资

```python
import matplotlib.pyplot as plt
import numpy as np

np.random.seed(100)

# 均值为9000，标准差为3000的300个随机数
data = np.random.normal(9000, 3000, size=300)
data = data[data>=4000]

plt.hist(data, color='r', rwidth=0.8, alpha=0.6)
plt.show()
```

![](https://static.getiot.tech/matplotlib-histogram-01.png)

最常用的参数其实是 **bins**！增加条形数量

```python
plt.hist(data, bins=20, color='r', rwidth=0.8, alpha=0.6)
plt.show()
```

![](https://static.getiot.tech/matplotlib-histogram-02.png)



---

### Matplotlib 绘制箱线图

#### 搞懂箱线图

> 箱形图是 John Wilder Tukey 的一项重大发明。Tukey 先生1915年出生于美国麻省的新贝德福德。他22岁的时候在布朗大学获得了硕士学位，之后又在普林斯顿大学拿到了化学博士。有趣的是，他并没有直接开始让他青史留名的统计学工作，而是在二战期间进入了火控研究室，在那里，大量武器相关的研究最终都转而需要先解决统计学问题。从此，Tukey 改变了自己的人生方向，一代统计学大师即将出现。



![](https://static.getiot.tech/John_Wilder_Tukey.jpeg)



箱形图最大的优点就是不受异常值的影响，可以以一种相对稳定的方式描述数据的离散分布情况。默念两遍，**箱形图不受异常值的影响**，这很重要。

为了更形象的说明，我们先画个图，看图说话。以下Python代码在Anaconda的Jupyter中实现：

```python
%matplotlib inline
import matplotlib
from matplotlib import pyplot as plt

matplotlib.use('qt4agg')
matplotlib.rcParams['font.sans-serif'] = ['SimHei']
matplotlib.rcParams['font.family']='sans-serif'

sample =[1,6,2,7,4,2,3,3,8,25,30]
plt.boxplot(sample)
plt.title('箱型图')
```

![](https://static.getiot.tech/matplotlib-boxplot-00.png)

中间是个矩形块，可以把它想象成一个盒子。盒子里面有一条线，外面有两个形似 T 的东西。哦，最外面还有两个空心的圆圈，这个可不是所有的箱形图都会有。接下来一一解释这些玩意儿。

在上面的箱型图中，看到了两个圆圈，这两个圆圈就代表2个异常值。 箱形图最重要的用途就是识别异常值。数据清洗中，作用很大哦。



#### 箱线图五要素

有一件重要的点，要交代一下，不然可能要被大多数人给忽略掉了。画箱型图，需要计算分位数，若你拿到的这组数据不是顺序排列的，首先要对数据进行排序。

- **中位数**
  - 中位数，即二分之一分位数。
  - 将数据从小到大进行排序，若数据的个数 n 是奇数，则中位数所在的位置即为 (n+1)/2 的位置。若数据的个数 n 是偶数，则中位数为第 n/2、第 n/2+1 两个数的算数平均值。
- **下四分位数Q1**
  - 四分之一分位数位于箱型图的下方，所以也叫“下四分位数”。
  - 强调一下，四分位数的求法，是将序列平均分成四份。具体的计算目前有 (n+1)/4 与 (n-1)/4 两种，一般使用 (n+1)/4，即四分之一分位数即第 (n+1)/4 个数，当然这个结果可能是个分数。结果是分数时，具体的计算后文再讲。
- **上四分位数Q3**
  - 四分之三分位数位于箱型图的上方，所以也叫“上四分位数”。
  - 强调一下，四分位数的求法，是将序列平均分成四份。具体的计算目前有 (n+1)/4\*3 与 (n-1)/4\*3 两种，一般使用 (n+1)/4\*3，即四分之三分位数即第 (n+1)/4\*3 个数。
- **内限**（上边界 & 下边界）
  - 目前我们文章中看到的这两个 T 形的盒须就是内限。
  - 上面的 T 形线段所延伸到的极远处，是 Q3+1.5IQR（其中，IQR=Q3-Q1）与剔除异常值后的极大值两者取最小。
  - 下面的 T 形线段所延伸到的极远处，是 Q1-1.5IQR 与剔除异常值后的极小值两者取最大。



![](https://static.getiot.tech/boxplot-five-elements.bmp)



#### 示例1：1到9

```python
import matplotlib.pyplot as plt
import numpy as np

data = np.arange(1, 10)

# 箱线图包含的信息量还是比较大的，不仅能分析出数据平均水平的差异，
# 还能够反映数据间的离散程度、异常值、分布差异等等
plt.boxplot(data)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-01.png)

解释：

- 从1到9，中位数是5
- 上四分位数（Q~3~）是7
- 下四分位数（Q~1~）是3
- IQR = Q~3~ - Q~1~= 7 - 3 = 4
- 上边缘 = Q~3~ + 1.5IQR = 7 + 1.5*4 = 13（13大于最大值9，所以选取9 ？）
- 下边缘 = Q~1~ - 1.5IQR = 3 - 1.5*4 = -3 （-3小于最小值1，所以选取1 ？）



#### 示例2：正态分布

```python
import matplotlib.pyplot as plt
import numpy as np

np.random.seed(100)
# 创建100个正态分布随机数
data = np.random.normal(size=100)

plt.hist(data)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-02.png)

```python
# 添加异常数据
data = np.concatenate([data, [4, 7, 8, 9, -4]])
plt.boxplot(data)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-03.png)

```python
# 调节内限范围，whis 参数默认为 1.5
plt.boxplot(data, whis=3)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-04.png)

```python
# 显示均值，向上箭头表示当前均值高于中位数
plt.boxplot(data, showmeans=True)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-05.png)

```python
# 显示均值线
plt.boxplot(data, showmeans=True, meanline=True)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-06.png)

```python
# 不显示箱子
plt.boxplot(data, showbox=False)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-07.png)

```python
# 调节箱子宽度
plt.boxplot(data, widths=0.8)
plt.show()
```

![](https://static.getiot.tech/matplotlib-boxplot-08.png)



---

### Matplotlib 绘制子图

#### 切分子图

将一个图片分上下两部分绘制

```python
import matplotlib.pyplot as plt

# 两行一列
plt.subplot(2, 1, 1)
plt.subplot(2, 1, 2)
plt.show()
```

![](https://static.getiot.tech/matplotlib-subplot-01.png)

```python
# 三行一列
plt.subplot(3, 1, 1)
plt.subplot(3, 1, 2)
plt.subplot(3, 1, 3)
plt.show()
```

![](https://static.getiot.tech/matplotlib-subplot-02.png)

```python
# 一行两列
plt.subplot(1, 2, 1)
plt.subplot(1, 2, 2)
plt.show()
```

![](https://static.getiot.tech/matplotlib-subplot-03.png)

```python
# 两行两列
plt.subplot(2, 2, 1)
plt.subplot(2, 2, 2)
plt.subplot(2, 2, 3)
plt.subplot(2, 2, 4)
plt.show()
```

![](https://static.getiot.tech/matplotlib-subplot-04.png)

```python
# 两行两列，第二行独占一列
plt.subplot(2, 2, 1)
plt.subplot(2, 2, 2)
plt.subplot(2, 1, 2)
plt.show()
```

![](https://static.getiot.tech/matplotlib-subplot-05.png)



#### 绘制图形

```python
import matplotlib.pyplot as plt
import numpy as np

# 第一个
plt.subplot(2, 2, 1)

x = np.random.random(10)
y = np.random.random(10)
plt.scatter(x, y)
plt.title('tag1')

# 第二个
plt.subplot(2, 2, 2)

x = np.arange(10)
y = x ** 2
plt.plot(x, y)
plt.title('tag2')

# 第三个
plt.subplot(2, 1, 2)

np.random.seed(100)
data = np.random.normal(size=100)
plt.hist(data, rwidth=0.8, bins=20)
plt.title('tag3')

plt.show()
```

![](https://static.getiot.tech/matplotlib-subplot-06.png)



---

### 支持中文显示

Ubuntu 16.04

思源宋体（Source Han Serif）

[https://github.com/adobe-fonts/source-han-serif/tree/release/SubsetOTF/CN](https://github.com/adobe-fonts/source-han-serif/tree/release/SubsetOTF/CN)

#### 设置标准黑体字体

(1) 查找 matplotlib 配置文件位置：

```python
import matplotlib
print(matplotlib.matplotlib_fname())

# /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/matplotlibrc
```

(2) 修改 matplotlibrc 文件，找到 font.family 和 font.sans-serif 两项，并修改如下：

```ini
font.family         : sans-serif
font.sans-serif     : SimHei, DejaVu Sans, Bitstream Vera Sans, Computer Modern Sans Serif, Lucida Grande, Verdana, Geneva, Lu    cid, Arial, Helvetica, Avant Garde, sans-serif
```

(3) 将准备好的 simhei.ttf 字体文件复制到 /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/fonts/ttf/ 和 /usr/share/fonts/truetype/ 目录。

(4)删除缓存文件 ~/.cache/matplotlib/fontlist-v300.json



使用

```python
import matplotlib.pyplot as plt

plt.rc('font', **{'family':"SimHei"})
```





---

### Pandas 绘制图表

#### 示例1：城市月平均工资

数据 data-2017.txt

```
排名 城市 月均工资
1 北京 9240
2 上海 8962
3 深圳 8315
4 广州 7409
5 杭州 7330
6 宁波 7152
7 佛山 7017
8 东莞 6998
9 厦门 6886
10 苏州 6719
11 南京 6680
12 重庆 6584
13 福州 6522
14 贵阳 6437
15 成都 6402
16 武汉 6331
17 南昌 6235
18 昆明 6230
19 南宁 6197
20 郑州 6191
21 长沙 6186
22 天津 6178
23 合肥 6173
24 大连 6144
25 无锡 6095
26 济南 6067
27 青岛 6057
28 石家庄 5886
29 西安 5872
30 沈阳 5842
31 太原 5841
32 烟台 5765
33 哈尔滨 5659
34 长春 5332
```

Pandas 导入数据

```python
import pandas as pd
import matplotlib.pyplot as plt

plt.rc('font', **{'family':"SimHei"})

data = pd.read_table('data-2017.txt', sep=' ')
data.head()
```

![](https://static.getiot.tech/pandas-plot-monthly-salary-01.png)

```python
# 绘制月均工资折线图
data['月均工资'].plot()
plt.show()
```

![](https://static.getiot.tech/pandas-chart-01.png)



```python
# 设置城市编号为索引
data = data.set_index('城市')
data.head()
```

![](https://static.getiot.tech/pandas-plot-monthly-salary-02.png)

```python
# 绘制月均工资top10城市的柱状图
data['月均工资'][:10].plot(kind='bar')
plt.show()
```

![](https://static.getiot.tech/pandas-chart-02.png)

```python
# 箱线图
data[['月均工资']].boxplot()
plt.show()
```

![](https://static.getiot.tech/pandas-chart-03.png)

```python
# 直方图
data[['月均工资']].hist()
plt.show()
```

![](https://static.getiot.tech/pandas-chart-04.png)



#### 示例2：多维数据

```python
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

data = pd.DataFrame(np.random.rand(10, 4), columns=list('ABCD'))
```

data 数据如下

![](https://static.getiot.tech/pandas-chart-05.png)

柱状图展示数据

```python
data.plot(kind='bar')
plt.show()
```

![](https://static.getiot.tech/pandas-chart-06.png)

横向柱状图

```python
data.plot(kind='barh')
plt.show()
```

![](https://static.getiot.tech/pandas-chart-07.png)

使用堆叠方式

```python
data.plot(kind='barh', stacked=True)
plt.show()
```

![](https://static.getiot.tech/pandas-chart-08.png)



#### 图片保存

支持格式：eps, pdf, pgf, png, ps, raw, rgba, svg, svgz

```python
data.plot(kind='barh', stacked=True)
plt.savefig('test.png')  # 保存为png格式
plt.savefig('test.pdf')  # 保存为pdf格式
```

在当前目录下可以看到相应的文件：

![](https://static.getiot.tech/matplotlib-savefig.png)
