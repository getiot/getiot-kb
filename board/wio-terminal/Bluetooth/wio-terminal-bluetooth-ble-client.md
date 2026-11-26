---
sidebar_position: 2
slug: /wio-terminal-bluetooth-ble-client
---

# Wio Terminal 蓝牙 BLE 客户端



本示例将 Wio terminal 作为 BLE 客户端，扫描周围所有的 BLE 设备，并通过 BLE 将这些设备的名字和 MAC 地址显示出来。

注意事项：

- 确保已阅读 [Wio Terminal 蓝牙教程](/wiot/wio-terminal-bluetooth/)，并完成固件更新和 Arduino 依赖库的安装。
- 将示例代码中的服务器 UUID 和 MAC 地址替换成你的蓝牙设备。



## 功能实现

在代码中，我们需要放置你要连接该设备的服务 UUID 和特征 UUID。

提示：如果你不知道设备的 MAC 地址和 UUID，请打开 **nRF Connect** 应用程序，配置你的 GATT 服务并设置 UUID。

```cpp showLineNumbers
// The remote service we wish to connect to.
static BLEUUID serviceUUID(0x180F);
// The characteristic of the remote service we are interested in.
static BLEUUID    charUUID(0x2A19);
```

注意：代码的 UUID 是我们自己定义的，只是为了测试，通常商业产品的 UUID 格式和这里的不同，比如 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx。

在代码上更新要连接该设备的设备的 MAC 地址。

```cpp showLineNumbers
uint8_t bd_addr[6] = {0xd7, 0x01, 0x38, 0x20, 0x02, 0x4c}; // MAC address: 4c:02:20:38:01:d7
```

注意：蓝牙MAC地址被设计成唯一的并且可以追溯到芯片制造商，另外，你需要将 MAC 地址倒序排列再填写的数组中。

连接到远程 BLE 服务器（你的手机）。

```cpp showLineNumbers
pClient->connect(myDevice);
```

在远程 BLE 服务器中获取指定 UUID 服务的引用。

```cpp showLineNumbers
BLERemoteService* pRemoteService = pClient->getService(serviceUUID);
```

在远程 BLE 服务器的服务中获取指定 UUID 特性的引用。

```cpp showLineNumbers
pRemoteCharacteristic = pRemoteService->getCharacteristic(charUUID);
```



## 完整代码

```cpp showLineNumbers
/**
 * A BLE client example that is rich in capabilities.
 * There is a lot new capabilities implemented.
 * author unknown
 * updated by chegewara
 */
 
#include "rpcBLEDevice.h"
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
 
// The remote service we wish to connect to.
static BLEUUID serviceUUID(0x180F);
// The characteristic of the remote service we are interested in.
static BLEUUID    charUUID(0x2A19);
 
static boolean doConnect = false;
static boolean connected = false;
static boolean doScan = false;
static BLERemoteCharacteristic* pRemoteCharacteristic;
static BLEAdvertisedDevice* myDevice;
uint8_t bd_addr[6] = {0xd7, 0x01, 0x38, 0x20, 0x02, 0x4c};
BLEAddress BattServer(bd_addr);
 
static void notifyCallback(
  BLERemoteCharacteristic* pBLERemoteCharacteristic,
  uint8_t* pData,
  size_t length,
  bool isNotify) {
    Serial.print("Notify callback for characteristic ");
    Serial.print(pBLERemoteCharacteristic->getUUID().toString().c_str());
    Serial.print(" of data length ");
    Serial.println(length);
    Serial.print("data: ");
    Serial.print(*(uint8_t *)pData);
}
 
class MyClientCallback : public BLEClientCallbacks {
  void onConnect(BLEClient* pclient) {
  }
 
  void onDisconnect(BLEClient* pclient) {
    connected = false;
    Serial.println("onDisconnect");
  }
};

bool connectToServer() {
    Serial.print("Forming a connection to ");
    Serial.println(myDevice->getAddress().toString().c_str());
 
    BLEClient*  pClient  = BLEDevice::createClient();
    Serial.println(" - Created client");
 
    pClient->setClientCallbacks(new MyClientCallback());
 
 
    // Connect to the remove BLE Server.
    pClient->connect(myDevice);  // if you pass BLEAdvertisedDevice instead of address, it will be recognized type of peer device address (public or private)
    Serial.println(" - Connected to server");
 
    // Obtain a reference to the service we are after in the remote BLE server.
    BLERemoteService* pRemoteService = pClient->getService(serviceUUID);
    Serial.println(serviceUUID.toString().c_str());
    if (pRemoteService == nullptr) {
      Serial.print("Failed to find our service UUID: ");
      Serial.println(serviceUUID.toString().c_str());
      pClient->disconnect();
      return false;
    }
    Serial.println(" - Found our service");
 
    // Obtain a reference to the characteristic in the service of the remote BLE server.
    pRemoteCharacteristic = pRemoteService->getCharacteristic(charUUID);
    if (pRemoteCharacteristic == nullptr) {
      Serial.print("Failed to find our characteristic UUID: ");
      Serial.println(charUUID.toString().c_str());
      pClient->disconnect();
      return false;
    }
    Serial.println(" - Found our characteristic");
 
    // Read the value of the characteristic.
    if(pRemoteCharacteristic->canRead()) {
      Serial.println(" -  can  read  start");
      std::string value = pRemoteCharacteristic->readValue();
      Serial.print("The characteristic value was: ");
      Serial.println(value.c_str());
    }
 
    if(pRemoteCharacteristic->canNotify())
      pRemoteCharacteristic->registerForNotify(notifyCallback);
 
    connected = true;
    return true;
}

/**
 * Scan for BLE servers and find the first one that advertises the service we are looking for.
 */
class MyAdvertisedDeviceCallbacks: public BLEAdvertisedDeviceCallbacks {
 /**
   * Called for each advertising BLE server.
   */
  void onResult(BLEAdvertisedDevice advertisedDevice) {
    Serial.print("BLE Advertised Device found: ");
    Serial.println(advertisedDevice.toString().c_str());
 
    // We have found a device, let us now see if it contains the service we are looking for.
    if (memcmp(advertisedDevice.getAddress().getNative(),BattServer.getNative(), 6) == 0) {
      Serial.print("BATT Device found: ");
      Serial.println(advertisedDevice.toString().c_str());
      BLEDevice::getScan()->stop();
      Serial.println("new BLEAdvertisedDevice");
      myDevice = new BLEAdvertisedDevice(advertisedDevice);
      Serial.println("new BLEAdvertisedDevice done");
      doConnect = true;
      doScan = true;    
  } // onResult
  }
}; // MyAdvertisedDeviceCallbacks

void setup() {
  Serial.begin(115200);
  while(!Serial){};
  delay(2000);
  Serial.println("Starting Arduino BLE Client application...");
  BLEDevice::init("");
 
  // Retrieve a Scanner and set the callback we want to use to be informed when we
  // have detected a new device.  Specify that we want active scanning and start the
  // scan to run for 5 seconds.
  BLEScan* pBLEScan = BLEDevice::getScan();
  pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks());
  pBLEScan->setInterval(1349);
  pBLEScan->setWindow(449);
  pBLEScan->setActiveScan(true);
  pBLEScan->start(5, false);
} // End of setup.
 
 
// This is the Arduino main loop function.
void loop() {
 
  // If the flag "doConnect" is true then we have scanned for and found the desired
  // BLE Server with which we wish to connect.  Now we connect to it.  Once we are 
  // connected we set the connected flag to be true.
  if (doConnect == true) {
    if (connectToServer()) {
      Serial.println("We are now connected to the BLE Server.");
    } else {
      Serial.println("We have failed to connect to the server; there is nothin more we will do.");
    }
    doConnect = false;
  }
  Serial.printf(".");
  delay(1000);
} // End of loop
```



## 运行结果

下面是客户端的运行结果，无需连接任何设备，Wio Terminal 扫描 BLE 设备并显示设备。

![](https://static.getiot.tech/wio-terminal-BLE-device-print.png#center)

