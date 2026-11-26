---
sidebar_position: 6
slug: /wio-terminal-lcd-line-charts
---

# Wio Terminal LCD 折线图



本文主要介绍如何在 Wio Terminal 上绘制折线图（或称“曲线图”）。这是一种很酷的数据显示方法，你甚至可以把传感器采集过来的数据用这种方式展示，这样就可以像专业绘图仪（比如心电图）一样在屏幕上可视化读数。

当然，本文介绍的库也非常灵活，学习完之后，你便可以根据自己的需要进行更改。

![](https://files.seeedstudio.com/wiki/Wio-Terminal/img/C0277.2019-11-27%2018_19_05.gif#center)



## 安装依赖库

首先需要为 Wio Terminal 安装 2D 图形库 `Seeed_Arduino_Linechart`。

1、在 `Seeed_Arduino_Linechart` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Linechart) 下载 zip 包。

2、然后将 `Seeed_Arduino_Linechart` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库...*，然后选择刚刚下载的 Seeed_Arduino_Linechart.zip 文件。



## 显示折线图

**1、为绘制折线图进行初始化**

首先，定义要存储数据点的最大值，并使用双精度浮点类型来存储数据，以及使用 TFT Sprite 函数创建缓冲区。

```cpp showLineNumbers
#define max_size 50 // maximum size of data
doubles data;       // Initilising a doubles type to store data
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite
```

**2、初始化 LCD 屏幕**

```cpp showLineNumbers
void setup() {
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT, TFT_WIDTH);
}
```

**3、将变量加载到数据**

使用 `data.push(variable)` 将变量（即传感器读数）存储在数据中，如果达到预定义的最大数量，它会删除第一个变量，以此类推，循环下去。

```cpp showLineNumbers
    spr.fillSprite(TFT_WHITE);
    if (data.size() == max_size) {
        data.pop(); // this is used to remove the first read variable
    }
    data.push(0.01 * random(1, 10)); // read variables and store in data
```

**4、初始化折线图标题的设置**

我们还可以为折线图设置一个标题，通常来说这是必须的。首先，初始化一个 `text(x, y)` 结构体，其中 `(x, y)` 是标题的起始坐标，具体看下面代码。在这个例子中，`header` 是这个结构的名称，你可以使用 `header.value("test")` 这样的方式来更改标题的相关设置。

```cpp showLineNumbers
    //Settings for the line graph title
    auto header =   text(0, 0)           //starting coordinates of title
                .value("test")      //actual title of the line graph
                .align(center)      //horizontal alignment of title
                .valign(vcenter)    //vertical alignment of title
                .width(tft.width()) //width of the title
                .thickness(3);      //thickness of the font
 
    header.height(header.font_height() * 2); //the height of title is the twice the height of the font
    header.draw(); 
```

为了帮助理解这个示例代码，请参考下面的标题配置示意图。

![](https://static.getiot.tech/Seeed_Arduino_Linechart_title.png#center)

**5、在 LCD 屏幕上初始化折线图和绘图的设置**

接着还有一些用于配置折线图所需显示的设置。

初始化一个 `line_chart(x, y)` 结构体，其中 `(x, y)` 是折线图的起始坐标。 并配置设置如下。在这个例子中，`content` 是这个结构的名称，你可以通过 `content.based_on(0.0)` 等方式来改变折线图的设置。

```cpp showLineNumbers
  //Settings for the line graph
    auto content = line_chart(20, header.height()); //(x,y) where the line graph begins
         content
                .height(tft.height() - header.height() * 1.5) //actual height of the line chart
                .width(tft.width() - content.x() * 2) //actual width of the line chart
                .based_on(0.0) //Starting point of y-axis, must be a float
                .show_circle(false) //drawing a cirle at each point, default is on.
                .value(data) //passing through the data to line graph
                .color(TFT_PURPLE) //Setting the color for the line
                .draw();
 
    spr.pushSprite(0, 0);
    delay(50);
```

为了帮助理解这个示例代码，请参考下面的折线图配置示意图。

![](https://static.getiot.tech/Seeed_Arduino_Linechart_linegraph.png#center)

## 完整示例代码

```cpp showLineNumbers
#include"seeed_line_chart.h" // include the library
TFT_eSPI tft;
 
#define max_size 50 // maximum size of data
doubles data;       // Initilising a doubles type to store data
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite 
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
}

void loop() {
    spr.fillSprite(TFT_WHITE);
    if (data.size() == max_size) {
        data.pop(); // this is used to remove the first read variable
    }
    data.push(0.01 * random(1, 10)); // read variables and store in data
 
    // Settings for the line graph title
    auto header =  text(0, 0)
                .value("GetIoT")
                .align(center)
                .valign(vcenter)
                .width(tft.width())
                .thickness(3);
 
    header.height(header.font_height() * 2);
    header.draw(); // Header height is the twice the height of the font
 
  //Settings for the line graph
    auto content = line_chart(20, header.height()); // (x,y) where the line graph begins
         content
                .height(tft.height() - header.height() * 1.5) // actual height of the line chart
                .width(tft.width() - content.x() * 2)         // actual width of the line chart
                .based_on(0.0)                                // Starting point of y-axis, must be a float
                .show_circle(false)                           // drawing a cirle at each point, default is on.
                .value(data)                                  // passing through the data to line graph
                .color(TFT_PURPLE)                            // Setting the color for the line
                .draw();
 
    spr.pushSprite(0, 0);
    delay(50);
}
```



