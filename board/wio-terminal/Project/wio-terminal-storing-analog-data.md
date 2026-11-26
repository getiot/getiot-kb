---
sidebar_position: 2
slug: /wio-terminal-storing-analog-data
---

# Wio Terminal 采集模拟数据

![](https://files.seeedstudio.com/wiki/Wio-Terminal/img/C0282.2019-11-28%2018_28_03.gif#center)

## Demo 概述

这个 Demo 的功能是在 Wio Terminal 上以折线图的方式实时显示光线传感器（Light Sensor）的数据。Wio Terminal 内置了一个光线传感器，因此你不需要额外准备外设模块。除了在 LCD 上实时显示，我们还将传感器数据输出到串口，打开 Arduino IDE 的串口绘图器（Serial Plotter）同样可以看到折线图。另外，为了更进一步，我们还将光线传感器的数据存储到 SD 卡中，在一个名为 `Readings.txt` 的文件。

**重点难点**

- 如何将光线传感器数据显示在 LCD 折线图中；
- 如何将光线传感器数据存储到 SD 卡中。



## 安装依赖库

本示例 Demo 依赖 **LCD** 库、 **Linechart** 库和 **FS** 库：

- `LCD` 库在安装 *Seeed SAMD Boards* 库时已经包含了，可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- `Linechart` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Linechart)下载，安装过程可参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)。
- `FS` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_FS)下载，安装过程可参考 [Wio Terminal 文件系统](/wiot/wio-terminal-file-system/)。



## 功能实现

**初始化 LCD 和 I/O 引脚**

Wio Terminal 内置光线传感器的引脚定义是 `WIO_LIGHT`，初始化代码如下。（可参考 [Wio Terminal 光线传感器](/wiot/wio-terminal-light-sensor/) 和 [Wio Terminal 文件系统](/wiot/wio-terminal-file-system/)）

```cpp showLineNumbers
#include <SPI.h>
#include <Seeed_FS.h>
#include "SD/Seeed_SD.h"
#include"seeed_line_chart.h" //include the library

File myFile;
TFT_eSPI tft;
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite 

#define max_size 30 //maximum size of data
doubles data; //Initilising a doubles type to store data
int brightness;

void setup() {
    Serial.begin(115200);
    if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI)) {
        Serial.println("initialization failed!");
        while(1);
    }
    pinMode(WIO_LIGHT, INPUT);
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
}
```

**读取光线传感器数据并存储到 SD 卡**

```cpp showLineNumbers
void loop() {
    spr.fillSprite(TFT_WHITE);
    brightness = analogRead(WIO_LIGHT); //Reading light sensor values
 
    if (data.size() == max_size) {
        data.pop();//this is used to remove the first read variable
    }
    data.push(brightness); //Storing light sensor values
    saveData(); //Saving data to SD card
    ...
}
```

**设置折线图标题**（至于为什么这样设置，请参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)）

```cpp showLineNumbers
//Settings for the line graph title
auto header =  text(0, 0)
            .value("Light Sensor Readings")
            .align(center)
            .valign(vcenter)
            .width(tft.width())
            .thickness(2);
 
header.height(header.font_height() * 2);
header.draw(); //Header height is the twice the height of the font
```

**配置折线图数据**

```cpp showLineNumbers
//Settings for the line graph
auto content = line_chart(20, header.height()); //(x,y) where the line graph begins
        content
            .height(tft.height() - header.height() * 1.5) //actual height of the line chart
            .width(tft.width() - content.x() * 2) //actual width of the line chart
            .based_on(0.0) //Starting point of y-axis, must be a float
            .show_circle(false) //drawing a cirle at each point, default is on.
            .value(data) //passing through the data to line graph
            .color(TFT_RED) //Setting the color for the line
            .draw();
 
spr.pushSprite(0, 0);
```

**将数据写到 SD 卡**（具体说明可参考 [Wio Terminal 文件系统](/wiot/wio-terminal-file-system/)）

```cpp showLineNumbers
void saveData(){
     myFile = SD.open("Readings.txt",FILE_APPEND);
     brightness = analogRead(WIO_LIGHT);
     Serial.println(brightness);
     myFile.println(brightness);
     myFile.close();
}
```



## 完整代码

```cpp showLineNumbers
#include <SPI.h>
#include <Seeed_FS.h>
#include "SD/Seeed_SD.h"
#include"seeed_line_chart.h" //include the library
 
File myFile;
TFT_eSPI tft;
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite 
 
#define max_size 30 //maximum size of data
doubles data; //Initilising a doubles type to store data
int brightness;

void setup() {
    Serial.begin(115200);
    if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI)) {
        Serial.println("initialization failed!");
        while(1);
    }
    pinMode(WIO_LIGHT, INPUT);
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
}
 
void loop() {
    spr.fillSprite(TFT_WHITE);
    brightness = analogRead(WIO_LIGHT);
 
    if (data.size() == max_size) {
        data.pop();//this is used to remove the first read variable
    }
    data.push(brightness); //read variables and store in data
    saveData();
 
    //Settings for the line graph title
    auto header =  text(0, 0)
                .value("Light Sensor Readings")
                .align(center)
                .valign(vcenter)
                .width(tft.width())
                .thickness(2);
 
    header.height(header.font_height() * 2);
    header.draw(); //Header height is the twice the height of the font
 
  //Settings for the line graph
    auto content = line_chart(20, header.height()); //(x,y) where the line graph begins
         content
                .height(tft.height() - header.height() * 1.5) //actual height of the line chart
                .width(tft.width() - content.x() * 2) //actual width of the line chart
                .based_on(0.0) //Starting point of y-axis, must be a float
                .show_circle(false) //drawing a cirle at each point, default is on.
                .value(data) //passing through the data to line graph
                .color(TFT_RED) //Setting the color for the line
                .draw();
 
    spr.pushSprite(0, 0);
}
 
void saveData(){
     myFile = SD.open("Readings.txt",FILE_APPEND);
     brightness = analogRead(WIO_LIGHT);
     Serial.println(brightness);
     myFile.println(brightness);
     myFile.close();
}
```

