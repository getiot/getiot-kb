---
sidebar_position: 1
slug: /wio-terminal-displaying-gyro
---

# Wio Terminal 显示陀螺仪



![](https://static.getiot.tech/wio-terminal-displaying-gyro.jpg#center)



## Demo 概述

这个 Demo 的功能是在 Wio Terminal 上以折线图的方式实时显示陀螺仪数据。Wio Terminal 内置了一个 3 轴加速度传感器，因此你不需要额外准备外设模块。除了在 LCD 上实时显示，我们还将传感器数据输出到串口，打开 Arduino IDE 的串口绘图器（Serial Plotter）同样可以看到折线图。

![](https://static.getiot.tech/wio-terminal-displaying-gyro-in-serial-plotter.png#center)

**重点难点**

- 如何将 3 轴加速度计的数据（X, Y, Z）显示在折线图中；
- 如何在 Wio Terminal 上实现实时数据的动态显示。



## 安装依赖库

本示例 Demo 依赖 **LCD** 库、 **Linechart** 库和 **LIS3DHTR** 库：

- `LCD` 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- `Linechart` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Linechart)下载，安装过程可参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)。
- `LIS3DHTR` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_LIS3DHTR)下载，安装过程可参考 [Wio Terminal 惯量传感器](/wiot/wio-terminal-imu/)。



## 功能实现

**初始化 LCD 和加速度计**

```cpp showLineNumbers
#include"LIS3DHTR.h" //include the accelerator library
#include"seeed_line_chart.h" //include the line chart library
TFT_eSPI tft;
LIS3DHTR<TwoWire>  lis;
 
#define max_size 50 //maximum size of data
doubles accelerator_readings[3];
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
 
    lis.begin(Wire1);
    lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ);
    lis.setFullScaleRange(LIS3DHTR_RANGE_2G);
 
    Serial.begin(115200);
}
```

**读取加速度计数据并存储在内存**

```cpp showLineNumbers
void loop() {
    spr.fillSprite(TFT_WHITE);
    float x_raw = lis.getAccelerationX();
    float y_raw = lis.getAccelerationY();
    float z_raw = lis.getAccelerationZ();
    ...
 
    if (accelerator_readings[0].size() == max_size) {
      for (uint8_t i = 0; i<3; i++){
        accelerator_readings[i].pop(); //this is used to remove the first read variable
      }
    }
 
    accelerator_readings[0].push(x_raw); //store x-axis readings
    accelerator_readings[1].push(y_raw); //store y-axis readings
    accelerator_readings[2].push(z_raw); //store z-axis readings
    ...
}
```

**设置折线图标题**（至于为什么这样设置，请参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)）

```cpp showLineNumbers
auto header =  text(0, 0)
            .value("Accelerator Readings")
            .align(center)
            .valign(vcenter)
            .width(tft.width())
            .thickness(2);
 
header.height(header.font_height() * 2);
header.draw(); //Header height is the twice the height of the font
```

**配置折线图数据**

我们要在一张图中画多条线，这里使用了 doubles 数组存储数据，那么可以把这个数组的项作为参数传递给 `content.value()` 函数，同时可以把颜色参数传递给 `.color()` 函数，这样颜色和数据项就会一一对应起来。

```cpp showLineNumbers
auto content = line_chart(20, header.height()); //(x,y) where the line graph begins
     content
            .height(tft.height() - header.height() * 1.5) //actual height of the line chart
            .width(tft.width() - content.x() * 2) //actual width of the line chart
            .based_on(-2.0) //Starting point of y-axis, must be a float
            .show_circle(false) //drawing a circle at each point, default is on.
            .value({accelerator_readings[0],accelerator_readings[1], accelerator_readings[2]}) //passing through the data to line graph
            .color(TFT_BLUE, TFT_RED, TFT_GREEN) //color for each line
            .draw();
```



## 完整代码

```cpp showLineNumbers
#include "LIS3DHTR.h"         // include the accelerator library
#include "seeed_line_chart.h" // include the line chart library

TFT_eSPI tft;
LIS3DHTR<TwoWire>  lis;

#define max_size 50 // maximum size of data

doubles accelerator_readings[3];
TFT_eSprite spr = TFT_eSprite(&tft); // Sprite

void setup() {
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT, TFT_WIDTH);

    lis.begin(Wire1);
    lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ);
    lis.setFullScaleRange(LIS3DHTR_RANGE_2G);

    Serial.begin(115200);
}

void loop() {
    spr.fillSprite(TFT_WHITE);
    float x_raw = lis.getAccelerationX();
    float y_raw = lis.getAccelerationY();
    float z_raw = lis.getAccelerationZ();
 
    //This is used to print out on Serial Plotter, check Serial Plotter!
    Serial.print(x_raw);
    Serial.print(",");
    Serial.print(y_raw);
    Serial.print(",");
    Serial.println(z_raw);
 
    if (accelerator_readings[0].size() == max_size) {
        for (uint8_t i = 0; i < 3; i++) {
            accelerator_readings[i].pop(); // this is used to remove the first read variable
        }
    }
    accelerator_readings[0].push(x_raw); // read variables and store in data
    accelerator_readings[1].push(y_raw);
    accelerator_readings[2].push(z_raw);
 
    // Settings for the line graph title
    auto header = text(0, 0).value("Accelerator Readings").align(center).valign(vcenter).width(tft.width()).thickness(2);
 
    header.height(header.font_height() * 2);
    header.draw(); // Header height is the twice the height of the font
 
    // Settings for the line graph
    auto content = line_chart(20, header.height());      // (x,y) where the line graph begins
    content.height(tft.height() - header.height() * 1.5) // actual height of the line chart
           .width(tft.width() - content.x() * 2)         // actual width of the line chart
           .based_on(-2.0)     // Starting point of y-axis, must be a float
           .show_circle(false) // drawing a cirle at each point, default is on.
           .value({accelerator_readings[0], accelerator_readings[1], accelerator_readings[2]}) // passing through the data to line graph
           .color(TFT_BLUE, TFT_RED, TFT_GREEN)
           .draw();
 
    spr.pushSprite(0, 0);
    delay(50);
}
```

