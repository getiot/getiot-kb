---
sidebar_position: 12
slug: /wio-terminal-smart-garden
---

# Wio Terminal 智能花园



![](https://static.getiot.tech/wio-terminal-smart-garden.png#center)



## Demo 概述

这个 Demo 展示了如何借助 Wio Terminal 实现一个智能花园，测量土壤湿度、光照、温度和植物湿度，并将信息整齐地显示在 Wio Terminal 的 LCD 显示器上。同时，我们还可以通过内置的 WiFi 或蓝牙，将数据上报到云平台，提供数据存储和可视化功能。

**硬件材料**

- 1 x Wio Terminal
- 1 x [DHT11 温湿度传感器](https://www.seeedstudio.com/Grove-Temperature-Humidity-Sensor-DHT11.html)
- 1 x [土壤湿度传感器](https://www.seeedstudio.com/Grove-Moisture-Sensor.html)



## 安装依赖库

本示例 Demo 依赖 **LCD** 库和 **DHT** 库：

- `LCD` 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- `DHT` 库可以在 [GitHub 仓库](https://github.com/adafruit/DHT-sensor-library)下载，在 Arduino IDE 点击 *项目 > 加载库 > 添加 .ZIP 库…* 即可添加库。也可以打开 Arduino IDE 库管理器，直接搜索 “DHT sensor library” 安装。



## 完整代码

```cpp showLineNumbers
//Libraries 
#include "TFT_eSPI.h" //TFT LCD library 
#include "DHT.h" // DHT library 

//Definitions
#define DHTPIN 0 //Define signal pin of DHT sensor 
// #define DHTPIN PIN_WIRE_SCL //Use I2C port as Digital Port */
#define DHTTYPE DHT11 //Define DHT sensor type 

//Initializations
DHT dht(DHTPIN, DHTTYPE); //Initializing DHT sensor
TFT_eSPI tft; //Initializing TFT LCD
TFT_eSprite spr = TFT_eSprite(&tft); //Initializing buffer

//Soil Moisture Sensor definitions
int sensorPin = A1; //Define variable to store soil moisture sensor pin
int sensorValue = 0; //Define variable to store soil moisture sensor value

void setup() {
  Serial.begin(9600); //Start serial communication
  
  pinMode(WIO_LIGHT, INPUT); //Set light sensor pin as INPUT
  pinMode(WIO_BUZZER, OUTPUT); //Set buzzer pin as OUTPUT
  
  dht.begin(); //Start DHT sensor 
  tft.begin(); //Start TFT LCD
  tft.setRotation(3); //Set TFT LCD rotation
  spr.createSprite(TFT_HEIGHT,TFT_WIDTH); //Create buffer
}

void loop() {
  int t = dht.readTemperature(); //Assign variable to store temperature 
  int h = dht.readHumidity(); //Assign variable to store humidity 
  int light = analogRead(WIO_LIGHT); //Assign variable to store light sensor values

  //Setting the title header 
  spr.fillSprite(TFT_WHITE); //Fill background with white color
  spr.fillRect(0,0,320,50,TFT_DARKGREEN); //Rectangle fill with dark green 
  spr.setTextColor(TFT_WHITE); //Setting text color
  spr.setTextSize(3); //Setting text size 
  spr.drawString("Smart Garden",50,15); //Drawing a text string 

  spr.drawFastVLine(150,50,190,TFT_DARKGREEN); //Drawing verticle line
  spr.drawFastHLine(0,140,320,TFT_DARKGREEN); //Drawing horizontal line

  //Setting temperature
  spr.setTextColor(TFT_BLACK);
  spr.setTextSize(2);
  spr.drawString("Temperature",10,65);
  spr.setTextSize(3);
  spr.drawNumber(t,50,95); //Display temperature values 
  spr.drawString("C",90,95);

  //Setting humidity
  spr.setTextSize(2);
  spr.drawString("Humidity",25,160);
  spr.setTextSize(3);
  spr.drawNumber(h,30,190); //Display humidity values 
  spr.drawString("%RH",70,190);

  //Setting soil moisture
  sensorValue = analogRead(sensorPin); //Store sensor values 
  sensorValue = map(sensorValue,1023,400,0,100); //Map sensor values 
  spr.setTextSize(2);
  spr.drawString("Soil Moisture",160,65);
  spr.setTextSize(3);
  spr.drawNumber(sensorValue,200,95); //Display sensor values as percentage  
  spr.drawString("%",240,95);
  
  //Setting light 
  spr.setTextSize(2);
  spr.drawString("Light",200,160);
  spr.setTextSize(3);
  light = map(light,0,1023,0,100); //Map sensor values 
  spr.drawNumber(light,205,190); //Display sensor values as percentage  
  spr.drawString("%",245,190);

  //Condition for low soil moisture
  if(sensorValue < 50){
    spr.fillSprite(TFT_RED);
    spr.drawString("Time to water!",35,100);
    analogWrite(WIO_BUZZER, 150); //beep the buzzer
    delay(1000);
    analogWrite(WIO_BUZZER, 0); //Silence the buzzer
    delay(1000);
  }

  spr.pushSprite(0,0); //Push to LCD
  delay(50);
}
```

代码下载：[Smart_Garden](https://github.com/lakshanthad/Wio_Terminal_Classroom_Arduino/blob/main/Classroom%2012/Smart_Garden/Smart_Garden.ino)



