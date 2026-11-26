---
sidebar_position: 2
slug: /wio-terminal-wifi
---

# Wio Terminal 无线 WiFi 配置



本文主要介绍 Wio Terminal 的 WiFi 功能，并演示如何使用 SeeedStudio 的 Arduino 库来配置 WiFi 工作模式和建立无线连接。

Wio Terminal 配备的无线网卡是 Realtek RTL8720，在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。

我们知道，WiFi 有两种工作模式：AP 模式和 STA 模式。

- AP（Access Point）也就是无线接入点，是一个无线网络的创建者，是网络的中心节点。一般家庭或办公室使用的无线路由器就一个 AP。
- STA（Station）也就是站点，每一个连接到无线网络中的终端（如笔记本电脑、PDA 及其它可以联网的用户设备）都可称为一个站点。

本文会分别介绍 STA 和 AP 模式的使用情况。



## 配置为 STA 模式

Wio Terminal 的 Wi-Fi 配置依赖 rpcWiFi 库，所以需要在 Arduino 中添加 `rpcWifi.h` 头文件，然后就可以通过下面代码将无线网卡配置为 STA 模式。

```cpp showLineNumbers
WiFi.mode(WIFI_STA);
```



### 扫描 Wi-Fi 网络

下面示例将 Wio Terminal 配置为 Wi-Fi STA 模式，然后扫描所有可用的 WiFi 接入网络，并将其打印到串口监视器。

```cpp showLineNumbers
#include "rpcWiFi.h"
 
void setup() {
    Serial.begin(115200);
    while(!Serial); // Wait for Serial to be ready
    delay(1000);
 
    // Set WiFi to station mode and disconnect from an AP if it was previously connected
    WiFi.mode(WIFI_STA);
    WiFi.disconnect();
    delay(100);
 
    Serial.println("Setup done");
}
 
void loop() {
    Serial.println("scan start");
 
    // WiFi.scanNetworks will return the number of networks found
    int n = WiFi.scanNetworks();
    Serial.println("scan done");
    if (n == 0) {
        Serial.println("no networks found");
    } else {
        Serial.print(n);
        Serial.println(" networks found");
        for (int i = 0; i < n; ++i) {
            // Print SSID and RSSI for each network found
            Serial.print(i + 1);
            Serial.print(": ");
            Serial.print(WiFi.SSID(i));
            Serial.print(" (");
            Serial.print(WiFi.RSSI(i));
            Serial.print(")");
            Serial.println((WiFi.encryptionType(i) == WIFI_AUTH_OPEN) ? " " : "*");
            delay(10);
        }
    }
    Serial.println("");
 
    // Wait a bit before scanning again
    delay(5000);
}
```



### 连接 Wi-Fi 网络

下面示例将 Wio Terminal 连接到指定的 WiFi 网络。（需要将 `ssid` 和 `password` 修改为你的 WiFi 网络）

```cpp showLineNumbers
#include "rpcWiFi.h"

const char* ssid = "yourNetworkName";
const char* password =  "yourNetworkPassword";

void setup() {
    Serial.begin(115200);
    while(!Serial); // Wait for Serial to be ready
 
    // Set WiFi to station mode and disconnect from an AP if it was previously connected
    WiFi.mode(WIFI_STA);
    WiFi.disconnect();
 
    Serial.println("Connecting to WiFi..");
    WiFi.begin(ssid, password);
 
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.println("Connecting to WiFi..");
        WiFi.begin(ssid, password);
    }
    Serial.println("Connected to the WiFi network");
    Serial.print("IP Address: ");
    Serial.println (WiFi.localIP()); // prints out the device's IP address
    }
 
void loop() {
 
}
```



### Wi-Fi 多连接示例

有时候我们需要配置多个 WiFi 连接信息，以便设备自动扫描并连接最佳的 WiFi 网络。在 Wio Terminal 中，我们可以使用 `WiFiMulti` 类来达到这个目的。

```cpp showLineNumbers
wifiMulti.addAP("ssid", "password");
```

只需要将多个 AP（WiFi 接入点）添加到列表中，`wifiMulti.run()` 将尝试连接到信号最好的 WiFi。

**注意**：记得根据你的网络情况修改 `SSID` 和 `Password` 参数。

```cpp showLineNumbers
#include "rpcWiFi.h"
#include <WiFiMulti.h>

WiFiMulti wifiMulti;

void setup() {
    Serial.begin(115200);
    while(!Serial); // Wait for Serial to be ready
    delay(1000);
 
    wifiMulti.addAP("ssid_from_AP_1", "your_password_for_AP_1");
    wifiMulti.addAP("ssid_from_AP_2", "your_password_for_AP_2");
    wifiMulti.addAP("ssid_from_AP_3", "your_password_for_AP_3");
 
    Serial.println("Connecting Wifi...");
    if (wifiMulti.run() == WL_CONNECTED) {
        Serial.println("");
        Serial.println("WiFi connected");
        Serial.println("IP address: ");
        Serial.println(WiFi.localIP());
    }
}

void loop() {
    if (wifiMulti.run() != WL_CONNECTED) {
        Serial.println("WiFi not connected!");
        delay(1000);
    }
}
```



## 配置为 AP 模式（Web Server）

下面介绍如何将 Wio Terminal 配置为 AP 模式，并启动一个简单的 Web Server。

首先，配置为 AP 模式需要依赖 `rpcWiFi.h`、`WiFiClient.h` 和 `WifiAP.h` 三个头文件。然后使用 `WiFiServer` 创建服务器对象，参数 80 表示端口号。

```cpp showLineNumbers
WiFiServer server(80);
```

使用 `ssid` 和 `password` 参数初始化 AP：

```cpp showLineNumbers
WiFi.softAP(ssid, password);
```

启动 Web Server：

```cpp showLineNumbers
server.begin();
```

下面是完整的示例代码，在本示例中，首先将 Wio Terminal 配置为一个简单的 Web 服务器，并允许你（比如手机）连接到其 AP 网络并根据 HTTP 上的响应控制硬件。

```cpp showLineNumbers
/*
    WiFiAccessPoint.ino creates a WiFi access point and provides a web server on it.
 
    Steps:
    1. Connect to the access point "yourAp"
    2. Point your web browser to http://<This-AP-IP>/H to turn the LED on or http://<This-AP-IP>/L to turn it off
       (<This-AP-IP> should be replaced with the IP got in terminal/SerialPort, see Note 1)
     OR
     Run raw TCP "GET /H" and "GET /L" on PuTTY terminal with IP address (see Note 1) and 80 as port
 
    Created for arduino-esp32 on 04 July, 2018
    by Elochukwu Ifediora (fedy0)
*/

#include <rpcWiFi.h>
#include <WiFiClient.h>
#include <WiFiAP.h>

#define LED_BUILTIN 2   // Set the GPIO pin where you connected your test LED
                        // or comment this line out if your dev board has a built-in LED

// Set these to your desired credentials.
const char* ssid = "yourAP";
const char* password = "yourPassword";

WiFiServer server(80);

void setup() {
    pinMode(LED_BUILTIN, OUTPUT);
 
    Serial.begin(115200);
    while(!Serial); // Wait for Serial to be ready
    delay(1000);
    Serial.println();
    Serial.println("Configuring access point...");
 
    // You can remove the password parameter if you want the AP to be open.
    WiFi.softAP(ssid, password);
    IPAddress myIP = WiFi.softAPIP();
    /*
     * Note 1
     * Record this IP, will used by Client (such as Web Browser)
     */
    Serial.print("AP IP address: ");
    Serial.println(myIP);
    server.begin();
 
    Serial.println("Server started");
}
 
void loop() {
    WiFiClient client = server.available();   // listen for incoming clients
 
    if (client) {                             // if you get a client,
        Serial.println("New Client.");           // print a message out the serial port
        String currentLine = "";                // make a String to hold incoming data from the client
        while (client.connected()) {            // loop while the client's connected
            if (client.available()) {             // if there's bytes to read from the client,
                char c = client.read();             // read a byte, then
                Serial.write(c);                    // print it out the serial monitor
                if (c == '\n') {                    // if the byte is a newline character
 
                    // if the current line is blank, you got two newline characters in a row.
                    // that's the end of the client HTTP request, so send a response:
                    if (currentLine.length() == 0) {
                        // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
                        // and a content-type so the client knows what's coming, then a blank line:
                        client.println("HTTP/1.1 200 OK");
                        client.println("Content-type:text/html");
                        client.println();
 
                        // the content of the HTTP response follows the header:
                        client.print("Click <a href=\"/H\">here</a> to turn ON the LED.<br/>");
                        client.print("Click <a href=\"/L\">here</a> to turn OFF the LED.<br/>");
 
                        // The HTTP response ends with another blank line:
                        client.println();
                        // break out of the while loop:
                        break;
                    } else {    // if you got a newline, then clear currentLine:
                        currentLine = "";
                    }
                } else if (c != '\r') {  // if you got anything else but a carriage return character,
                    currentLine += c;      // add it to the end of the currentLine
                }
 
                // Check to see if the client request was "GET /H" or "GET /L":
                if (currentLine.endsWith("GET /H")) {
                    digitalWrite(LED_BUILTIN, HIGH);               // GET /H turns the LED on
                }
                if (currentLine.endsWith("GET /L")) {
                    digitalWrite(LED_BUILTIN, LOW);                // GET /L turns the LED off
                }
            }
        }
        // close the connection:
        client.stop();
        Serial.println("Client Disconnected.");
    }
}
```

将代码编译上传到 Wio Terminal，打开手机 WiFi 设置界面，可以看到一个名为 “Wio-Terminal” 的 WiFi 接入点，输入密码即可连接。

![](https://static.getiot.tech/wio-terminal-wifi-ap.jpg#center-300)

