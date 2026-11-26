---
sidebar_position: 2
slug: /wio-terminal-grove-tds-sensor
---

# Wio Terminal TDS 传感器



本文介绍如何将 TDS 传感器接入 Wio-Terminal，并将 TDS 传感器数据实时显示在 Wio-Terminal 的 LCD 显示屏上。



## TDS 传感器

TDS 是 Total Dissolved Solids 的缩写，即溶解性固体总量，用于表示水中溶解性物质的浓度，单位为毫克/升（mg/L）。是检测纯净水、蒸馏水、RO 膜（反渗透膜）净水器出水水质的一个重要指标。

本文示例中使用的 Grove 接口 TDS 传感器，采用模拟信号输出，输出电压范围在 0 ~ 2.3V，模块输入电压支持 5V/3.3V。

![](https://static.getiot.tech/Grove-TDS-Sensor-connect.jpg#center)



## 安装依赖库

本示例依赖 **LCD** 库和 **Linechart** 库：

- LCD 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- Linechart 库则可在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Linechart)下载，安装过程可参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)。



## 示例代码

将 Grove TDS 传感器连接到 Wio Terminal 的数字 Grove D/A 引脚，上传代码并查看结果。

```cpp showLineNumbers
#include"seeed_line_chart.h" //include the library
TFT_eSPI tft;
 
#define max_size 50 //maximum size of data
doubles data; //Initilising a doubles type to store data
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite 
 
#define sensorPin A0 //Analog pin
 
int sensorValue = 0;
float tdsValue = 0;
float Voltage = 0;
 
void setup() {
    pinMode(sensorPin, INPUT);
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
}
 
void loop() {
    spr.fillSprite(TFT_WHITE);
 
    sensorValue = analogRead(sensorPin);
    Voltage = sensorValue*5/1024.0; //Convert analog reading to Voltage
    tdsValue=(133.42*Voltage*Voltage*Voltage - 255.86*Voltage*Voltage + 857.39*Voltage)*0.5; //Convert voltage value to TDS value
 
    if (data.size() == max_size) {
        data.pop();//this is used to remove the first read variable
    }
    data.push(tdsValue); //read variables and store in data
 
    //Settings for the line graph title
    auto header =  text(0, 0)
                .value("TDS Reading")
                .align(center)
                .valign(vcenter)
                .width(tft.width())
                .thickness(3);
 
    header.height(header.font_height() * 2);
    header.draw(); //Header height is the twice the height of the font
 
  //Settings for the line graph
    auto content = line_chart(20, header.height()); //(x,y) where the line graph begins
         content
                .height(tft.height() - header.height() * 1.5) //actual height of the line chart
                .width(tft.width() - content.x() * 2) //actual width of the line chart
                .based_on(0.0) //Starting point of y-axis, must be a float
                .show_circle(true) //drawing a cirle at each point, default is on.
                .value(data) //passing through the data to line graph
                .color(TFT_RED) //Setting the color for the line
                .draw();
 
    spr.pushSprite(0, 0);
    delay(50);
}
```



