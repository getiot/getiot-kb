---
sidebar_position: 9
slug: /wio-terminal-webserver
---

# Wio Terminal Web 服务器



![Wio Terminal Web 服务器](https://static.getiot.tech/wio-terminal-webserver.png#center)



本文主要介绍 **WebServer** 库的使用，这意味着你可以将 Wio Terminal 变成一台 Web 服务器，让同一个局域网中的其他计算机运行浏览器访问该服务器，甚至可以实现从网页控制 Wio Terminal 上的硬件、读取传感器数据等等。



## 简单的 HelloServer 示例

下面是在 Wio Terminal 上设置一个 Web 服务器的简单示例。

提示：将下面代码中的 `ssid` 和 `password` 替换成你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <WiFiClient.h>
#include <WebServer.h>
 
const char *ssid = "yourNetwork";
const char *password = "yourPassword";
 
WebServer server(80);
 
const int led = 13;
 
void handleRoot() {
  digitalWrite(led, 1);
  server.send(200, "text/plain", "hello from Wio Terminal!");
  digitalWrite(led, 0);
}
 
void handleNotFound() {
  digitalWrite(led, 1);
  String message = "File Not Found\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  for (uint8_t i = 0; i < server.args(); i++) {
    message += " " + server.argName(i) + ": " + server.arg(i) + "\n";
  }
  server.send(404, "text/plain", message);
  digitalWrite(led, 0);
}
 
void setup(void) {
  pinMode(led, OUTPUT);
  digitalWrite(led, 0);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
 
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
 
  server.on("/", handleRoot);
 
  server.on("/inline", []() {
    server.send(200, "text/plain", "this works as well");
  });
 
  server.onNotFound(handleNotFound);
 
  server.begin();
  Serial.println("HTTP server started");
}
 
void loop(void) {
  server.handleClient();
}
```

使用同一网络的计算机，打开浏览器输入 Wio Terminal 的 IP 地址，即可访问该 Web 服务器。

![](https://static.getiot.tech/wio-terminal-helloServer.png#center)



## 身份验证 Web 服务器

下面这个示例设置了一个需要身份验证（Authentication）过程的 Web 服务器，这是出于安全目的的常见功能，在某些情况下非常有用。

提示：将下面代码中的 `ssid` 和 `password` 替换成你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <WebServer.h>
 
const char *ssid = "yourNetwork";
const char *password = "yourPassword";
 
WebServer server(80);
 
const char* www_username = "admin";
const char* www_password = "password";
 
void setup() {
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  if (WiFi.waitForConnectResult() != WL_CONNECTED) {
    Serial.println("WiFi Connect Failed! Rebooting...");
    delay(1000);
    NVIC_SystemReset(); // Reset Wio Terminal
  }
 
  server.on("/", []() {
    if (!server.authenticate(www_username, www_password)) {
      return server.requestAuthentication();
    }
    server.send(200, "text/plain", "Login OK");
  });
  server.begin();
 
  Serial.print("Open http://");
  Serial.print(WiFi.localIP());
  Serial.println("/ in your browser to see it working");
}
 
void loop() {
  server.handleClient();
}
```

使用同一网络的计算机，打开浏览器输入 Wio Terminal 的 IP 地址，然后输入预设的用户名和密码登录。

![Wio Terminal 身份验证 Web 服务器](https://files.seeedstudio.com/wiki/Wio-Terminal-Advanced-Wi-Fi/auth.gif#center)

