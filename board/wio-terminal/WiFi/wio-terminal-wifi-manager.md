---
sidebar_position: 11
slug: /wio-terminal-wifi-manager
---

# Wio Terminal WiFi 管理器



没错，我们已经将著名的 WiFi Manager 移植到 Wio Terminal 平台，以便你可以使用手机或其他设备为你的 Wio Terminal 配置 Wi-Fi 设置！



## 安装依赖

首先需要为 Wio Terminal 安装 **Seeed_Arduino_rpcWiFiManager** 库。

1、在 `Seeed_Arduino_rpcWiFiManager` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_rpcWiFiManager) 下载 zip 包。

2、然后将 `Seeed_Arduino_rpcWiFiManager` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Seeed_Arduino_rpcWiFiManager.zip 文件。



## 自动连接 WiFi

下面是 WiFi 自动连接的示例，你可以使用该示例为 Wio Terminal 设置 WiFi 设置。

如果 Wio Terminal 之前连接过 WiFi，它将自动连接到同一网络。如果它无法连接到任何 WiFi，它将进入 AP 模式并发出 WiFi。使用你的手机连接到此 WiFi 并输入 WiFi 设置。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <DNSServer.h>
#include <WebServer.h>
#include <WiFiManager.h>
 
void setup() {
    Serial.begin(115200);
    while(!Serial); // wait till Serial is opened
 
    WiFiManager wifiManager;
    // Uncomment the resetSettings() will wipe out the saved settings
    //wifiManager.resetSettings();
 
    //Fetches ssid and pass from RTL8720 and tries to connect
    //if it does not connect it starts an access point with the specified name
    //here  "AutoConnectAP"
    //and goes into a blocking loop awaiting configuration
    wifiManager.autoConnect("AutoConnectAP");
    //or use this for auto generated name ESP + ChipID
    //wifiManager.autoConnect();
 
    //if you get here you have connected to the WiFi
    Serial.println("connected...yeey :)");
    Serial.println(WiFi.localIP());
}
 
void loop() {
    // put your main code here, to run repeatedly:
}
```

如果之前连接过 WiFi，WiFiManager 将自动连接到该 WiFi 网络。

![WiFiManager 自动连接](https://static.getiot.tech/wio-terminal-wifi-manager.png#center)

如果无法连接到任何 WiFi，Wio Terminal 将进入 AP 模式并发出 WiFi，此时通过手机连接到此 WiFi 并为其配置 WiFi 设置。

![WiFiManager 自动连接](https://files.seeedstudio.com/wiki/Wio-Terminal-Advanced-Wi-Fi/wifimanager.gif#center)
