---
sidebar_position: 5
slug: /wio-terminal-grove-gps-sensor
---

# Wio Terminal GPS 卫星定位



本文介绍如何将 GPS 传感器接入 Wio-Terminal，由于 GPS 传感器输出的是 NMEA 格式数据，因此我们需要实时获取 NMEA GPS 数据，并使用 TinyGPSPlus 库将其解析为可读信息，然后再打印到 Arduino IDE 的串口监视器上。



## 安装依赖库

首先需要为 Wio Terminal 安装 GPS 库 `TinyGPSPlus`。

1、在 `TinyGPSPlus` 的 [GitHub 仓库](https://github.com/mikalhart/TinyGPSPlus) 下载 zip 包。

2、然后将 `TinyGPSPlus` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库...*，然后选择刚刚下载的 TinyGPSPlus.zip 文件。



## 示例代码

将 Grove GPS 传感器连接到 Wio Terminal 的 Grove I2C 引脚（左下方），上传代码并查看结果。

```cpp showLineNumbers
#include <TinyGPS++.h>
#include <wiring_private.h>
 
static const uint32_t GPSBaud = 9600;
 
// The TinyGPS++ object
TinyGPSPlus gps;
 
// The serial connection to the GPS device - Left side Grove connector.
// Left side Grove connector shares pins with I2C1 of 40 pin connector.
static Uart Serial3(&sercom3, PIN_WIRE_SCL, PIN_WIRE_SDA, SERCOM_RX_PAD_1, UART_TX_PAD_0);
 
void setup()
{
  Serial.begin(115200);
 
  Serial3.begin(GPSBaud);
  pinPeripheral(PIN_WIRE_SCL, PIO_SERCOM_ALT);
  pinPeripheral(PIN_WIRE_SCL, PIO_SERCOM_ALT);
}
 
void loop()
{
  // This sketch displays information every time a new sentence is correctly encoded.
  while (Serial3.available() > 0)
    if (gps.encode(Serial3.read()))
      displayInfo();
 
  if (millis() > 5000 && gps.charsProcessed() < 10)
  {
    Serial.println(F("No GPS detected: check wiring."));
    while(true);
  }
}
 
void displayInfo()
{
  Serial.print(F("Location: ")); 
  if (gps.location.isValid())
  {
    Serial.print(gps.location.lat(), 6);
    Serial.print(F(","));
    Serial.print(gps.location.lng(), 6);
  }
  else
  {
    Serial.print(F("INVALID"));
  }
 
  Serial.print(F("  Date/Time: "));
  if (gps.date.isValid())
  {
    Serial.print(gps.date.month());
    Serial.print(F("/"));
    Serial.print(gps.date.day());
    Serial.print(F("/"));
    Serial.print(gps.date.year());
  }
  else
  {
    Serial.print(F("INVALID"));
  }
 
  Serial.print(F(" "));
  if (gps.time.isValid())
  {
    if (gps.time.hour() < 10) Serial.print(F("0"));
    Serial.print(gps.time.hour());
    Serial.print(F(":"));
    if (gps.time.minute() < 10) Serial.print(F("0"));
    Serial.print(gps.time.minute());
    Serial.print(F(":"));
    if (gps.time.second() < 10) Serial.print(F("0"));
    Serial.print(gps.time.second());
    Serial.print(F("."));
    if (gps.time.centisecond() < 10) Serial.print(F("0"));
    Serial.print(gps.time.centisecond());
  }
  else
  {
    Serial.print(F("INVALID"));
  }
 
  Serial.println();
}
 
void SERCOM3_0_Handler()
{
  Serial3.IrqHandler();
}
void SERCOM3_1_Handler()
{
  Serial3.IrqHandler();
}
void SERCOM3_2_Handler()
{
  Serial3.IrqHandler();
}
void SERCOM3_3_Handler()
{
  Serial3.IrqHandler();
}
```


