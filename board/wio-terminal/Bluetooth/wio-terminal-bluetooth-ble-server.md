---
sidebar_position: 3
slug: /wio-terminal-bluetooth-ble-server
---

# Wio Terminal 蓝牙 BLE 服务器



本示例将 Wio terminal 作为 BLE 服务器，连接其他 BLE 设备（可以是另一个 Wio Terminal），并通过蓝牙接收来自客户端的请求。



## 功能实现

首先，我们可以为该 BLE 设备设置一个名称，如下：

```cpp showLineNumbers
BLEDevice::init("Wio Terminal");
```

You need to define the UUID for the server device on the Wio terminal.

接着，我们需要定义该 BLE 服务器上的服务、特征、描述符等 UUID：

```cpp showLineNumbers
#define SERVICE_UUID        "180f"
#define CHARACTERISTIC_UUID "2a19"
#define DESCRIPTOR_UUID     "4545"
```

然后创建一个 BLE 服务器：

```cpp showLineNumbers
BLEServer *pServer = BLEDevice::createServer();
```

通过指定服务 UUID 创建 BLE 服务：

```cpp showLineNumbers
BLEService *pService = pServer->createService(SERVICE_UUID);
```

为 BLE 服务添加特征：

```cpp showLineNumbers
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(
                                         CHARACTERISTIC_UUID,
                                         BLECharacteristic::PROPERTY_READ |
                                         BLECharacteristic::PROPERTY_WRITE
                                       );
pCharacteristic->setValue("Hello World says Neil");
```

设置该特征的属性（可读、可写）：

```cpp showLineNumbers
  pCharacteristic->setAccessPermissions(GATT_PERM_READ | GATT_PERM_WRITE);
  BLEDescriptor *pDescriptor = pCharacteristic->createDescriptor(
                                         DESCRIPTOR_UUID,
                                          ATTRIB_FLAG_VOID | ATTRIB_FLAG_ASCII_Z,
                                         GATT_PERM_READ | GATT_PERM_WRITE,2
                                         );
```

启动 BLE 服务：

```cpp showLineNumbers
pService->start();
```

Advertising 允许设备广播信息。这意味着当移动设备收到蓝牙消息时，接收者可以选择接受或拒绝该消息。接收端需要积极表明它们是否希望接收这些广告信息。

```cpp showLineNumbers
BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
```



## BLE 通信示例

下面是一个简单的 BLE 测试，我们将 Wio Terminal 客户端与 Wio Terminal 服务器连接，当客户端找到服务器时，它们会连接，同时服务器会向客户端发送一条消息。

说明：

- 你需要有两台 Wio Terminal；
- 你需要创建 UUID 以提供给客户端连接使用；
- 你可以在 GitHub 上下载 [**Client**](https://github.com/Seeed-Studio/Seeed_Arduino_rpcBLE/tree/master/examples/BLE_client) 和 [**Server**](https://github.com/Seeed-Studio/Seeed_Arduino_rpcBLE/tree/master/examples/BLE_server) 代码；
- 编译并上传客户端程序到 Wio Terminal；
- 编译并上传服务器程序到另一台 Wio terminal。

当上传并运行服务器代码时，在连接客户端之前，你会在 Arduino IDE 监视器上看到它不断打印“unpaired”（未配对）。

![img](https://static.getiot.tech/wio-terminal-ble-server-1.png#center)

连接到客户端后，它将停止打印消息，客户端将从服务器打印消息。

![img](https://static.getiot.tech/wio-terminal-ble-client-1.png#center)



## 完整代码

```cpp showLineNumbers
#include <rpcBLEDevice.h>
#include <BLEServer.h>
 
#define SERVICE_UUID        "180f"
#define CHARACTERISTIC_UUID "2a19"
#define DESCRIPTOR_UUID     "4545"
 
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
  while(!Serial){};
  Serial.println("Starting BLE work!");
 
  BLEDevice::init("Long name 11");
  BLEServer *pServer = BLEDevice::createServer();
  BLEService *pService = pServer->createService(SERVICE_UUID);
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(
                                         CHARACTERISTIC_UUID,
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
  pCharacteristic->setValue("Hello World says Neil");
  pCharacteristic->setCallbacks(new MyCallbacks());
  pService->start();
 
  // BLEAdvertising *pAdvertising = pServer->getAdvertising();  // this still is working for backward compatibility
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
  Serial.println("Characteristic defined! Now you can read it in your phone!");
}
 
void loop() { 
  // put your main code here, to run repeatedly:
  Serial.println("1");
  delay(2000);
}
```




