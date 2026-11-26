---
sidebar_position: 5
slug: /wio-terminal-bluetooth-web-api
---

# Wio Terminal 蓝牙 Web API



本文主要介绍如何使用 [Web Bluetooth API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Bluetooth_API) 和 Wio Terminal 的蓝牙功能交互。Web Bluetooth API 提供了在网络浏览器上与蓝牙设备交互的能力，类似于 [Physical Web](https://google.github.io/physical-web/)，帮助人们直接从网络走到设备并与之交互。



## Web Bluetooth 示例

以下示例演示了如何设置 Wio Terminal 并使用一个简单的 HTML 站点将 Web Bluetooth API 与 Wio Terminal 的蓝牙进行交互。



### Arduino 设置

请参照 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/) 和 [Wio Terminal 蓝牙教程](/wiot/wio-terminal-bluetooth/) 更新 RTL8720 固件并安装依赖库。

将下面示例代码复制到 Arduino IDE，编译并上传到 Wio Terminal：

```cpp showLineNumbers
#include <rpcBLEDevice.h>
#include <BLEServer.h>
#include <BLE2902.h>

bool _BLEClientConnected = false;
uint8_t level = 10;
 
#define BatteryService BLEUUID((uint16_t)0x180F) 
BLECharacteristic BatteryLevelCharacteristic(BLEUUID((uint16_t)0x2A19), BLECharacteristic::PROPERTY_READ | BLECharacteristic::PROPERTY_WRITE | BLECharacteristic::PROPERTY_NOTIFY);
 
class MyServerCallbacks : public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      _BLEClientConnected = true;
    };
 
    void onDisconnect(BLEServer* pServer) {
      _BLEClientConnected = false;
    }
};
 
/* ######## CALL back to receive data from Phone ######## */
#define CHARACTERISTIC_UUID_RX "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
 
class MyCallbacks: public BLECharacteristicCallbacks {
 
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();
      Serial.println(rxValue[0]);
 
      if (rxValue.length() > 0) {
        Serial.println("*********");
        Serial.print("Received Value: ");
 
        for (int i = 0; i < rxValue.length(); i++) {
          Serial.print(rxValue[i]);
        }
        Serial.println();
        Serial.println("*********");
      }
 
    }
};
 
/* ############################################################### */
void initBLE() {
  BLEDevice::init("BLE Battery");
  // Create the BLE Server
  BLEServer *pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
 
  // Create the BLE Service
  BLEService *pBattery = pServer->createService(BatteryService);
 
  pBattery->addCharacteristic(&BatteryLevelCharacteristic);
  BatteryLevelCharacteristic.addDescriptor(new BLE2902());
 
 
  /* ######## define callback ######## */
  BLECharacteristic *pWriteCharacteristic = pBattery->createCharacteristic(
                                         CHARACTERISTIC_UUID_RX,
                                         BLECharacteristic::PROPERTY_WRITE
                                       );
  pWriteCharacteristic->setAccessPermissions(GATT_PERM_READ | GATT_PERM_WRITE);
 
  pWriteCharacteristic->setCallbacks(new MyCallbacks());
  /* ############################################################### */
 
  pServer->getAdvertising()->addServiceUUID(BatteryService);
 
  pBattery->start();
  // Start advertising
  pServer->getAdvertising()->start();
}
 
void setup() {
  Serial.begin(115200);
//   while(!Serial);
  Serial.println("--- Wio Terminal BLE Battery Level Indicator ---");
  initBLE();
}
 
void loop() {
 
  BatteryLevelCharacteristic.setValue(&level, 1);
  BatteryLevelCharacteristic.notify();
  delay(3000);
 
  level++;
  Serial.print("Battery Level: ");
  Serial.println(int(level));
 
  if (int(level)==100)
    level=0;
}
```

上面的代码将 Wio Terminal 配置为蓝牙可发现名称 **`BLE Battery`** 并作为蓝牙服务器，建立一个 Battery BLE Service。这很重要，后面需要与 Web Bluetooth API 的 HTML 站点匹配。



### Web Bluetooth API HTML 网页

现在 Wio Terminal 已全部设置完毕，我们需要使用 Web Bluetooth API 编写一个 HTML 站点，以便它们可以交互。检查以下内容以供参考：

- 下载 [`webbluetooth.html`](https://github.com/ansonhe97/WioTerminal-WebBluetooth/blob/main/webbluetooth.html) 文件；
- 使用最新的 Google Chrome 或 Microsoft Edge 浏览器（它们支持 Web Bluetooth APIs）打开 `webbluetooth.html`；
- 按 **`F12`** 打开 Console 控制台；
- 点击网页上的 **Connect with BLE device** 按钮，你应该会看到 `BLE Battery`（Wio Terminal）出现在连接窗口中。 点击 **Connect**。
- 点击 **Start** 按钮开始接收来自 Wio Terminal 的电池电量数据。

Web Bluetooth API 网页控制台： 

![](https://static.getiot.tech/wio-terminal-bluetooth-web-1.png#center)

Arduino 串口监视器：

![](https://static.getiot.tech/wio-terminal-bluetooth-web-2.png#center)

看，现在 Wio Terminal 正在与使用 Web Bluetooth API 的站点交互！这个功能使得 BLE 更加有趣，你可以通过 Web 浏览器传输信息！



## 可视化传感器数据

下面这个示例介绍如何使用 Web Bluetooth API 在网页上以可视化的方式显示 Wio Terminal 的加速度传感器数据。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-Web-Bluetooth/exmaple.gif#center)



### Arduino 设置

请参照 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/) 和 [Wio Terminal 蓝牙教程](/wiot/wio-terminal-bluetooth/) 更新 RTL8720 固件并安装依赖库。

下载 [WebBluetooth-Accelerator.ino](https://github.com/Seeed-Studio/Seeed_Arduino_Sketchbook/blob/master/examples/WioTerminal_WebBluetooth/WioTerminal_WebBluetooth.ino)，或直接将下面示例代码复制到 Arduino IDE。

```cpp showLineNumbers
#include <rpcBLEDevice.h>
#include <BLEServer.h>
#include <LIS3DHTR.h>
 
#define accelerometerService "19b10000-e8f2-537e-4f6c-d104768a1214"
#define firstCharacteristic  "19b10010-e8f2-537e-4f6c-d104768a1214"
#define DESCRIPTOR_UUID      "19b10010"
 
LIS3DHTR<TwoWire> lis;
 
bool deviceConnected = false;
bool oldDeviceConnected = false;
 
BLEServer *pServer = NULL;
BLECharacteristic * pCharacteristic;
 
class MyServerCallbacks: public BLEServerCallbacks {
    void onConnect(BLEServer* pServer) {
      Serial.println("MyServerCallbacks onConnect ");
      deviceConnected = true;
    };
 
    void onDisconnect(BLEServer* pServer) {
      deviceConnected = false;
    }
};
 
class MyCallbacks: public BLECharacteristicCallbacks {
    void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rxValue = pCharacteristic->getValue();
 
      if (rxValue.length() > 0) {
        Serial.println("*********");
        Serial.print("Received Value: ");
        for (int i = 0; i < rxValue.length(); i++)
          Serial.print(rxValue[i]);
 
        Serial.println();
        Serial.println("*********");
      }
    }
};
 
void setup() {
  Serial.begin(115200);
//  while(!Serial){};
 
  lis.begin(Wire1);
  if (!lis) {
    Serial.println("Accelerater Error!");
    while(1);
  }
  lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); //Data output rate
  lis.setFullScaleRange(LIS3DHTR_RANGE_2G); //Scale range set to 2g
  Serial.println("Accelerater Initialised!");
 
  Serial.println("Starting BLE work!");
 
  BLEDevice::init("Accelerometer");
  pServer = BLEDevice::createServer();
  pServer->setCallbacks(new MyServerCallbacks());
 
  BLEService *pService = pServer->createService(accelerometerService);
  pCharacteristic = pService->createCharacteristic(
                                         firstCharacteristic,
                                         BLECharacteristic::PROPERTY_READ |
                                         BLECharacteristic::PROPERTY_WRITE
                                       );
  pCharacteristic->setAccessPermissions(GATT_PERM_READ | GATT_PERM_WRITE);
  BLEDescriptor *pDescriptor = pCharacteristic->createDescriptor(
                                         DESCRIPTOR_UUID,
                                          ATTRIB_FLAG_VOID | ATTRIB_FLAG_ASCII_Z,
                                         GATT_PERM_READ | GATT_PERM_WRITE,
                                         2
                                         );
  pCharacteristic->setCallbacks(new MyCallbacks());
  pService->start();
 
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(accelerometerService);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
  Serial.println("Characteristic defined! Now you can read it in your phone!");
}
 
void loop() { 
  if (deviceConnected) {
    updateAcceleration();
  }
      // disconnecting
    if (!deviceConnected && oldDeviceConnected) {
        delay(500); // give the bluetooth stack the chance to get things ready
        pServer->startAdvertising(); // restart advertising
        Serial.println("start advertising");
        oldDeviceConnected = deviceConnected;
    }
    // connecting
    if (deviceConnected && !oldDeviceConnected) {
    // do stuff here on connecting
        oldDeviceConnected = deviceConnected;
    }
}
 
void updateAcceleration() {
  float x_values, y_values, z_values;
  x_values = lis.getAccelerationX();
  y_values = lis.getAccelerationY();
  z_values = lis.getAccelerationZ();
 
  String accelerometerData = String(x_values)+"|"+String(y_values)+"|"+String(z_values);
  Serial.println(accelerometerData);
  pCharacteristic->setValue(accelerometerData.c_str());
  pCharacteristic->notify();
  delay(20);
}
```



### Web Bluetooth API HTML 网页

- 使用最新的 Google Chrome 或 Microsoft Edge 浏览器打开 **[Web Bluetooth Accelerometer Plotter For Wio Terminal](https://seeed-studio.github.io/Seeed_Arduino_Sketchbook/)** 网页。对应的 HTML 代码在[这里](https://github.com/Seeed-Studio/Seeed_Arduino_Sketchbook/blob/web-bluetooth/docs/index.html)。
- 连接名为 “Accelerator” 的设备（Wio Terminal），然后你就可以看到网页上动态显示加速度传感器的数据。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-Web-Bluetooth/web-acc.gif#center)

学会这个技能，你就可以使用 Wio Terminal 编写 Web 蓝牙交互网站啦！



## 资源链接

- [Web Bluetooth APIs Specs](https://developer.mozilla.org/en-US/docs/Web/API/Web_Bluetooth_API)
- [Web Bluetooth APIs Examples](https://googlechrome.github.io/samples/web-bluetooth/index.html)
- [Implementation Bugs](https://crbug.com/?q=component:Blink>Bluetooth)
- [Web Bluetooth Spec](https://webbluetoothcg.github.io/web-bluetooth)

