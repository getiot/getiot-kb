---
sidebar_position: 7
slug: /wio-terminal-lcd-histogram
---

# Wio Terminal LCD 柱状图



本文主要介绍如何在 Wio Terminal 上绘制柱状图（或称“直方图”）。类似于 [折线图](/wiot/wio-terminal-lcd-line-charts/)，这也是一种很酷的数据显示方法，可以帮你用很直观的可视化方式展示来自传感器的数据。

同样，本文介绍的库也非常灵活，学习完之后，你便可以根据自己的需要进行更改。

![](https://files.seeedstudio.com/wiki/Wio-Terminal/img/20200114131505.png#center)



## 安装依赖库

首先需要为 Wio Terminal 安装 2D 图形库 `Seeed_Arduino_Histogram`。

1、在 `Seeed_Arduino_Histogram` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Histogram) 下载 zip 包。

2、然后将 `Seeed_Arduino_Histogram` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库...*，然后选择刚刚下载的 Seeed_Arduino_Histogram.zip 文件。



## 显示柱状图

**1、初始化，为绘制直方图做准备**

初始化代码如下：

```cpp showLineNumbers
#include <TFT_eSPI.h> // Hardware-specific library
#include <SPI.h>
#include "Histogram.h"
 
TFT_Histogram histogram = TFT_Histogram(); // Initializing Histogram
TFT_eSPI tft = TFT_eSPI(); // Initializing TFT
 
void setup(void) {
  tft.init();
  histogram.initHistogram(&tft);
  ...
}
```

**2、在直方图中创建列**

创建方式如下：

```cpp showLineNumbers
void formHistogram(String label,int NO,double Histogram_value,int Histogram_WIDTH,uint32_t colour);
```

其中 `label` 是其列下的列名，`NO` 是直方图列的编号标签，`Histogram_value` 是直方图列的值，`Histogram_WIDTH` 是直方图列的宽度，`colour` 是直方图列颜色（柱子填充颜色）。

**3、显示直方图**

显示方式如下：

```cpp showLineNumbers
void showHistogram();
```

**4、改变直方图数值**

更改现有条目的值的方式：

```cpp showLineNumbers
void changeParam(uint8_t NO, String lable, float Histogram_value, uint32_t colour);
```

where `NO` refers back to the number tag of the histogram column(which column to change).

其中，参数 `NO` 表示直方图列的数字标签（即要更改的那一列）。

**5、删除列**

从直方图中删除一列的方式：

```cpp showLineNumbers
void deleteCylinder(uint8_t NO);
```

其中，参数 `NO` 表示直方图列的数字标签（即要删除的那一列）。

**6、将折线图添加到直方图**

添加折线图的方式：

```cpp showLineNumbers
void lineChart(uint32_t colour);
```

其中 `color` 表示折线图的颜色。

**7、隐藏直方图的坐标轴**

```cpp showLineNumbers
void notShowAxis();
```

**8、其他实用功能**

Seeed_Arduino_Histogram 直方图库还提供了其他一些实用功能，这里就不一一介绍了，大家可以参考 `Histogram.h` 文件。此外，它还提供了示例集，你可以在 examples 目录找到完整的测试代码。



## 完整示例代码

```cpp showLineNumbers
#include <TFT_eSPI.h> // Hardware-specific library
#include <SPI.h>
#include"Histogram.h" // include histogram library
 
TFT_Histogram histogram=TFT_Histogram(); // Initializing tft and histogram
TFT_eSPI tft = TFT_eSPI();

void setup() {
    tft.init();
    histogram.initHistogram(&tft);
    histogram.formHistogram("a",1,50.55,40,TFT_RED);  // Column 1
    histogram.formHistogram("b",2,20,40,TFT_BLACK);   // Column 2
    histogram.formHistogram("c",3,100,50,TFT_GREEN);  // Column 3
    histogram.formHistogram("d",4,53,50,TFT_BLUE);    // Column 4
    histogram.formHistogram("e",5,133,30,TFT_YELLOW); // Column 5
    histogram.formHistogram("f",6,53,50,TFT_ORANGE);  // Column 6
    histogram.formHistogram("g",7,80,50,TFT_PINK);    // Column 7
 
    histogram.showHistogram(); // show histogram
    delay(3000);
 
    histogram.changeParam(6,"F",55,TFT_PINK); // change column 6
    histogram.deleteCylinder(7);              // delete colum 7
    histogram.lineChart(TFT_BLACK);
 
    delay(2000);
    histogram.notShowAxis(); // hiding the axis of histogram
}

void loop() {}
```

