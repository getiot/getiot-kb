---
sidebar_position: 6
slug: /wio-terminal-microphone
---

# Wio Terminal 麦克风



Wio Terminal 内置了一个麦克风（Microphone），可作为音频输入接口。我们可以利用这个麦克风来检测周围的声音并做出相应的响应。

**提示**：麦克风位于 Wio Terminal 正面的左下角。本文只是简单地通过模拟输入获取麦克风信号，后续可以关注 SeeedStudio 专门制作的麦克风库。



## 电路原理图

![](https://static.getiot.tech/wio-terminal-SCH-Microphone.png#center)



## 引脚定义

在 `variant.h` 中定义了麦克风的信号引脚 `WIO_MIC`，另一种风格是 `MIC_INPUT`。

```cpp showLineNumbers
/*
 * MIC_INPUT
 */
#define MIC_INPUT (39ul)
#define WIO_MIC (39ul)
```



## 示例代码

下面示例代码简单地读取麦克风信号，并打印到串口监视器。

```cpp showLineNumbers
void setup() {
  pinMode(WIO_MIC, INPUT);
  Serial.begin(115200);
}
 
void loop() {
  int val = analogRead(WIO_MIC);
  Serial.println(val);
  delay(200);
}
```



## 带 LCD 显示示例

本示例依赖 **LCD** 库和 **Linechart** 库：

- LCD 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- Linechart 库则可在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_Linechart)下载，安装过程可参考 [Wio Terminal LCD 折线图](/wiot/wio-terminal-lcd-line-charts/)。

下面是完整示例代码：

```cpp showLineNumbers
#include"seeed_line_chart.h" //include the library
#include <math.h>
 
TFT_eSPI tft;
 
#define max_size 50 //maximum size of data
doubles data; //Initilising a doubles type to store data
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite 
 
void setup() {
    pinMode(WIO_MIC, INPUT);
 
    tft.begin();
    tft.setRotation(3);
    spr.createSprite(TFT_HEIGHT,TFT_WIDTH);
}
 
void loop() {
    spr.fillSprite(TFT_DARKGREY);
 
    int val = analogRead(WIO_MIC);
 
    if (data.size() == max_size) {
        data.pop();//this is used to remove the first read variable
    }
    data.push(val); //read variables and store in data
 
    //Settings for the line graph title
    auto header =  text(0, 0)
                .value("Microphone Reading")
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

