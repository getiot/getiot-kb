---
sidebar_position: 6
slug: /wio-terminal-bluetooth-ibeacon
---

# Wio Terminal 蓝牙 iBeacon



蓝牙信标 Beacon 是基于低功耗蓝牙广播协议，工作状态下，Beacon 会连续周期性地向周围环境进行广播，广播内容包括 MAC 地址、信号强度 RSSI 值、UUID 和数据包内容等，一旦手机用户进入蓝牙信标的信号覆盖范围内，就可以形成手机端的自动应答机制，无需用户多余的手动操作，即可以实现信息接收功能。

本文主要介绍 BLE iBeacon 功能在 Wio Terminal 上的使用。

![](https://static.getiot.tech/wio-terminal-bluetooth-beacon.png#center)



## 概述

Wio Terminal 是一款强大的物联网设备，内置支持经典蓝牙和蓝牙低功耗（BLE），经典蓝牙用于蓝牙音频模块、文件或大码流数据传输；BLE 则用于电池优化应用，比如蓝牙信标、健身手环、近距离广告等。所以我们可以根据用户的需要连接一些特定的功能模块，然后作为特定场合的信标。

前面 [Wio Terminal 蓝牙教程](/wiot/wio-terminal-bluetooth/) 已经介绍了蓝牙 BLE 的 Client 模式和 Server 模式。接下来，我们将使用 Wio Terminal 构建一个 BLE iBeacon，并通过智能手机来呈现 iBeacon 信息。

**准备硬件**

- 一台 Wio Terminal
- 一根 Type-C 连接线
- 一个 Wio Terminal 底盘电池（可选）

**准备软件**

- Arduino IDE 桌面开发工具
- nRF Connect 手机应用程序（App 的使用可参考 [Wio Terminal 蓝牙教程](/wiot/wio-terminal-bluetooth/)）
- 参照 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/) 和 [Wio Terminal 蓝牙教程](/wiot/wio-terminal-bluetooth/) 更新 RTL8720 固件并安装依赖库



## iBeacon 测试

下面是一个扫描 Wio-Terminal iBeacon 设备并显示信息的简单测试，目的是为了确保可以检测到 Wio-Terminal iBeacon 设备，正常的话，你将会看到 iBeacon 的特定图标。

### Wio-Terminal iBeacon 代码

将下面代码复制到 Arduino IDE，编译并上传到 Wio-Terminal。

```cpp showLineNumbers
#include "sys/time.h"
#include "rpcBLEDevice.h"
#include "BLEBeacon.h"
 
BLEAdvertising *pAdvertising;
//struct timeval now;
 
#define BEACON_UUID           "8ec76ea3-6668-48da-9866-75be8bc86f4d" // UUID 1 
 
void setBeacon() {
 
  BLEBeacon oBeacon = BLEBeacon();
  oBeacon.setManufacturerId(0x4C00); // fake Apple 0x004C LSB (ENDIAN_CHANGE_U16!)
  oBeacon.setProximityUUID(BLEUUID(BEACON_UUID));
  oBeacon.setMajor(0x007B);
  oBeacon.setMinor(0x01C8);
  BLEAdvertisementData oAdvertisementData = BLEAdvertisementData();
  BLEAdvertisementData oScanResponseData = BLEAdvertisementData();
 
  oAdvertisementData.setFlags(0x04); // BR_EDR_NOT_SUPPORTED 0x04
 
  std::string strServiceData = "";
 
  strServiceData += (char)26;     // Len
  strServiceData += (char)0xFF;   // Type
  strServiceData += oBeacon.getData(); 
  oAdvertisementData.addData(strServiceData);
 
  pAdvertising->setAdvertisementData(oAdvertisementData);
  pAdvertising->setScanResponseData(oScanResponseData);
  pAdvertising->setAdvertisementType(GAP_ADTYPE_ADV_NONCONN_IND);
 
}
 
void setup() {
 
 
  Serial.begin(115200);
  while(!Serial){};
 
  // Create the BLE Device
  BLEDevice::init("");
 
  // Create the BLE Server
  // BLEServer *pServer = BLEDevice::createServer(); // <-- no longer required to instantiate BLEServer, less flash and ram usage
 
  pAdvertising = BLEDevice::getAdvertising();
 
  setBeacon();
   // Start advertising
  pAdvertising->start();
  Serial.println("Advertizing started...");
  delay(100);
  Serial.printf("in deep sleep\n");
}
 
void loop() {
    delay(1000);
}
```



### nRF connect 应用程序

打开 **nRF Connect** 应用程序，点击右上角的 **SCAN** 按钮开始扫描，你将会看到一个 iBeacon 设备（Wio Terminal），并且可以看 MAC 地址、RSSI（dBm）和连接延迟时间（ms）等信息。

<img src="https://static.getiot.tech/wio-terminal-bluetooth-ibeacon-nrf-app.jpg" alt="Wio Terminal iBeacon on nRF connect" width="320" />

提示：在此测试中，由于设备未命名，因此显示 N/A。



### iBeacon 简单讲解

这个 demo 介绍了 Wio-Terminal 在一些特定场合的使用方法，比如 Wio-Terminal iBeacon 可以通过广告网关信息来引导人们，如下图，有 door-1，door-2 ... 等， 1号门里面有产品 A 和说明书。我们可以在每个门口安装 Wio-Terminal 来投放广告信息，并在屏幕上显示介绍信息。

![img](https://static.getiot.tech/wio-terminal-bluetooth-ibeacon-door.png#center)

打开 nRF connect 应用程序，我们会在列表中看到 “wio” iBeacon 设备，然后点击设备，会显示设备的 UUID、RSSI 和制造商数据。点击 Manufacturer data（制造商数据），将显示 3 个选项，分别是 Manufacturer data (Bluetooth Core 4.1)、Manufacturer data 和 Text (UTF-8)。点击 Text (UTF-8)，制造商数据将转换为普通数据。可以看到，在 Text (UTF-8) 条目中显示了网关信息，A 在 1号门，B 在2号门，这样人们就会知道 A 和 B 在哪里。

![Wio Terminal iBeacon on nRF connect](https://static.getiot.tech/wio-terminal-bluetooth-ibeacon-screenshot.png#center)

这样的应用场景有很多，比如在博物馆，当人们进入某个门后，会看到关于 A 或 B 的更多细节，如历史或其他取决于使用场合的文字介绍。

![Wio Terminal Beacon Application](https://static.getiot.tech/wio-terminal-bluetooth-ibeacon-show.png#center-400)



## 示例代码

下面是一个 BLE iBeacon 的完整示例，编译并上传到 Wio-Terminal 看看效果吧。

```cpp showLineNumbers
#include "sys/time.h"
#include "BLEDevice.h"
#include "BLEBeacon.h"
 
#include <TFT_eSPI.h> // Hardware-specific library
#include <SPI.h>
TFT_eSPI tft = TFT_eSPI();       // Invoke custom library
TFT_eSprite spr = TFT_eSprite(&tft);  // Sprite
LIS3DHTR<TwoWire> lis;
BLEAdvertising *pAdvertising;
 
#define BEACON_UUID           "8ec76ea3-6668-48da-9866-75be8bc86f4d" // UUID 1 128-Bit 
#define SERVICE_UUID           0x1801
#define SERVICE_UUID1          0x1802
#define SERVICE_UUID2          0x1803
 
void setBeacon() {
  BLEBeacon oBeacon = BLEBeacon();
  oBeacon.setManufacturerId(0x4C00); // fake Apple 0x004C LSB (ENDIAN_CHANGE_U16!)
  oBeacon.setProximityUUID(BLEUUID(BEACON_UUID));
  oBeacon.setMajor(0x007B);
  oBeacon.setMinor(0x01C8);
  BLEAdvertisementData oAdvertisementData = BLEAdvertisementData();
  BLEAdvertisementData oScanResponseData = BLEAdvertisementData();
 
  oAdvertisementData.setFlags(0x04); // BR_EDR_NOT_SUPPORTED 0x04
  std::string strServiceData = "";
  strServiceData += (char)26;     // Len
  strServiceData += (char)0xFF;   // Type
  strServiceData += oBeacon.getData();
  oAdvertisementData.addData(strServiceData);
 
  union cracked_float_t {
    float f;
    uint32_t l;
    word w[sizeof(float) / sizeof(word)];
    byte b[sizeof(float)];
  };
 
  oScanResponseData.setName("wio");
 
  oScanResponseData.setManufacturerData("oxA-door-1");   // Ibeacon information(MAX:31 byte) 
  oScanResponseData.setManufacturerData("oxB-door-2");
 
  pAdvertising->setAdvertisementData(oAdvertisementData);
  pAdvertising->setScanResponseData(oScanResponseData);
  pAdvertising->setAdvertisementType(GAP_ADTYPE_ADV_SCAN_IND);
 
 
  spr.fillSprite(TFT_BLACK);
  spr.createSprite(240, 160);
  spr.fillSprite(TFT_BLACK);
  spr.setTextColor(TFT_WHITE, TFT_BLACK);
  spr.setFreeFont(&FreeSansBoldOblique12pt7b);
 
  spr.drawString("what is A", 20 , 10);                // product introduction
  spr.drawString("The A history: .....", 20 , 35);      
 
  spr.drawString("what is B", 20 , 110);
  spr.drawString("The B history: .....", 20 , 135);
 
 
  spr.pushSprite(0, 0);
}
 
  void setup() {
 
    tft.begin();
    tft.init();
    tft.setRotation(3);
    tft.fillScreen(TFT_BLACK);
    Serial.begin(115200);
 
    // Create the BLE Device
    BLEDevice::init("");
    lis.begin(Wire1);
    if (!lis) {
      Serial.println("ERROR");
      while (1);
    }
    lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); //Data output rate
    lis.setFullScaleRange(LIS3DHTR_RANGE_2G); //Scale range set to 2g
 
 
    pAdvertising = BLEDevice::getAdvertising();
 
 
 
    Serial.println("Advertizing started...");
    delay(100);
  }
 
  void loop() {
    setBeacon();
    // Start advertising
    pAdvertising->start();
    delay(5000);
    pAdvertising->stop();
    delay(1000);
  }
```

