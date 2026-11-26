---
sidebar_position: 4
slug: /wio-terminal-grove-temp-sensor
---

# Wio Terminal 温度传感器



本文介绍如何将 Grove 温度传感器接入 Wio-Terminal，实时采集温度数据并显示在 Wio-Terminal 的 LCD 显示屏上。

![](https://static.getiot.tech/wio-terminal-temp-sensor.png#center)



## 温度传感器

本文示例中使用的 Grove 温度传感器采用热敏电阻（LM35）检测环境温度。热敏电阻的电阻会随着环境温度的降低而增加，我们正是利用这个特性来计算环境温度。该传感器的检测范围为 -40 ~ 125ºC，精度为 ±1.5ºC。

因此，我们使用 Wio Terminal 的模拟输入引脚即可获取温度数据。



## 安装依赖库

本示例依赖 **LCD** 库和 **Linechart** 库：

- LCD 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- Linechart 库则可在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Linechart)下载，安装过程可参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)。



## 示例代码

将 Grove 温度传感器连接到 Wio Terminal 的数字 Grove D/A 引脚，上传代码并查看结果。

```cpp showLineNumbers
#include"seeed_line_chart.h" //include the library
#include <math.h>
 
TFT_eSPI tft;
 
#define max_size 50 //maximum size of data
doubles data; //Initilising a doubles type to store data
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite 
 
const int B = 4275;               // B value of the thermistor
const int R0 = 100000;            // R0 = 100k
const int pinTempSensor = A0;     // Grove - Temperature Sensor connect to A0
 
void setup() {
    pinMode(pinTempSensor, INPUT);
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
}
 
void loop() {
    spr.fillSprite(TFT_DARKCYAN);
 
    int a = analogRead(pinTempSensor);
    float R = 1023.0/a-1.0;
    R = R0*R;
 
    float temperature = 1.0/(log(R/R0)/B+1/298.15)-273.15; // convert to temperature via datasheet
 
    if (data.size() == max_size) {
        data.pop();//this is used to remove the first read variable
    }
    data.push(temperature); //read variables and store in data
 
    //Settings for the line graph title
    auto header =  text(0, 0)
                .value("Temperature Reading")
                .align(center)
                .color(TFT_WHITE)
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
                .show_circle(true) //drawing a cirle at each point, default is on.
                .y_role_color(TFT_WHITE)
                .x_role_color(TFT_WHITE)
                .value(data) //passing through the data to line graph
                .color(TFT_RED) //Setting the color for the line
                .draw();
 
    spr.pushSprite(0, 0);
    delay(50);
}
```



