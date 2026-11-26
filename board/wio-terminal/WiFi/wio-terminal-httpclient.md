---
sidebar_position: 8
slug: /wio-terminal-httpclient
---

# Wio Terminal HTTP 客户端



在 Wio Terminal 使用 WiFi 进行网络通信，除了直接使用 **rpcWiFi** 库，还可以使用一些更高级的库，比如 **HTTPClient**、**DNSServer** 和 **WebServer** 库。学会这些库的使用之后，你就可以轻而易举地开发物联网项目啦！

本文先来介绍 **HTTPClient** 库的使用，在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。

**HTTPClient** 库用于发送 **HTTP GET**、**POST** 和 **PUT** 请求到 Web 服务器，这里直接通过一些示例来介绍它们的具体用法。



## HTTP GET 示例

下面是使用 HTTPClient 进行简单 HTTP 连接并将响应打印回串口监视器的示例。

提示：将下面代码中的 `ssid` 和 `password` 替换成你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include [HTTPClient.h](HTTPClient.h)
 
const char* ssid = "yourNetwork";
const char* password =  "yourPassword";
 
void setup() {
 
  Serial.begin(115200);
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) { //Check for the connection
    delay(500);
    Serial.println("Connecting..");
  }
  Serial.print("Connected to the WiFi network with IP: ");
  Serial.println(WiFi.localIP());
}
 
void loop() {
    // wait for WiFi connection
    if((WiFi.status() == WL_CONNECTED)) {
        HTTPClient http;
        Serial.print("[HTTP] begin...\n");
        // configure traged server and url
        http.begin("http://www.example.com/index.html"); //HTTP
        Serial.print("[HTTP] GET...\n");
        // start connection and send HTTP header
        int httpCode = http.GET();
        // httpCode will be negative on error
        if(httpCode > 0) {
            // HTTP header has been send and Server response header has been handled
            Serial.printf("[HTTP] GET... code: %d\n", httpCode);
            // file found at server
            if(httpCode == HTTP_CODE_OK) {
                String payload = http.getString();
                Serial.println(payload);
            }
        } else {
            Serial.printf("[HTTP] GET... failed, error: %s\n", http.errorToString(httpCode).c_str());
        }
        http.end();
    }
    delay(5000);
}
```

编译并上传到 Wio Terminal，运行结果如下：

![](https://static.getiot.tech/wio-terminal-httpclient-http-get.png#center)



## HTTPs GET 示例

下面是使用 HTTPClient 进行简单 HTTPs 连接的示例，你可以参照这个示例向其他网站发送 HTTPs GET 请求以获取所需的数据。

要获取网站的根 CA 证书，你可以在终端（Linux Bash Shell）中运行以下命令：

```bash
openssl s_client -showcerts -verify 5 -connect www.example.com:443 < /dev/null
```

提示：用目标网站的 URL 替换 `www.example.com`。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include [HTTPClient.h](HTTPClient.h)
#include <WiFiClientSecure.h>
 
const char* ssid = "yourNetwork";
const char* password =  "yourPassword";
 
const char* test_root_ca = \
                            "-----BEGIN CERTIFICATE-----\n"
                            "MIIESjCCAzKgAwIBAgINAeO0mqGNiqmBJWlQuDANBgkqhkiG9w0BAQsFADBMMSAw\n"
                            "HgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMjETMBEGA1UEChMKR2xvYmFs\n"
                            "U2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNzA2MTUwMDAwNDJaFw0yMTEy\n"
                            "MTUwMDAwNDJaMEIxCzAJBgNVBAYTAlVTMR4wHAYDVQQKExVHb29nbGUgVHJ1c3Qg\n"
                            "U2VydmljZXMxEzARBgNVBAMTCkdUUyBDQSAxTzEwggEiMA0GCSqGSIb3DQEBAQUA\n"
                            "A4IBDwAwggEKAoIBAQDQGM9F1IvN05zkQO9+tN1pIRvJzzyOTHW5DzEZhD2ePCnv\n"
                            "UA0Qk28FgICfKqC9EksC4T2fWBYk/jCfC3R3VZMdS/dN4ZKCEPZRrAzDsiKUDzRr\n"
                            "mBBJ5wudgzndIMYcLe/RGGFl5yODIKgjEv/SJH/UL+dEaltN11BmsK+eQmMF++Ac\n"
                            "xGNhr59qM/9il71I2dN8FGfcddwuaej4bXhp0LcQBbjxMcI7JP0aM3T4I+DsaxmK\n"
                            "FsbjzaTNC9uzpFlgOIg7rR25xoynUxv8vNmkq7zdPGHXkxWY7oG9j+JkRyBABk7X\n"
                            "rJfoucBZEqFJJSPk7XA0LKW0Y3z5oz2D0c1tJKwHAgMBAAGjggEzMIIBLzAOBgNV\n"
                            "HQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMBIGA1Ud\n"
                            "EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFJjR+G4Q68+b7GCfGJAboOt9Cf0rMB8G\n"
                            "A1UdIwQYMBaAFJviB1dnHB7AagbeWbSaLd/cGYYuMDUGCCsGAQUFBwEBBCkwJzAl\n"
                            "BggrBgEFBQcwAYYZaHR0cDovL29jc3AucGtpLmdvb2cvZ3NyMjAyBgNVHR8EKzAp\n"
                            "MCegJaAjhiFodHRwOi8vY3JsLnBraS5nb29nL2dzcjIvZ3NyMi5jcmwwPwYDVR0g\n"
                            "BDgwNjA0BgZngQwBAgIwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly9wa2kuZ29vZy9y\n"
                            "ZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEAGoA+Nnn78y6pRjd9XlQWNa7H\n"
                            "TgiZ/r3RNGkmUmYHPQq6Scti9PEajvwRT2iWTHQr02fesqOqBY2ETUwgZQ+lltoN\n"
                            "FvhsO9tvBCOIazpswWC9aJ9xju4tWDQH8NVU6YZZ/XteDSGU9YzJqPjY8q3MDxrz\n"
                            "mqepBCf5o8mw/wJ4a2G6xzUr6Fb6T8McDO22PLRL6u3M4Tzs3A2M1j6bykJYi8wW\n"
                            "IRdAvKLWZu/axBVbzYmqmwkm5zLSDW5nIAJbELCQCZwMH56t2Dvqofxs6BBcCFIZ\n"
                            "USpxu6x6td0V7SvJCCosirSmIatj/9dSSVDQibet8q/7UK4v4ZUN80atnZz1yg==\n"
                            "-----END CERTIFICATE-----\n";

WiFiClientSecure client;
 
void setup() 
{
  Serial.begin(115200);
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) { //Check for the connection
    delay(500);
    Serial.println("Connecting..");
  }
  Serial.print("Connected to the WiFi network with IP: ");
  Serial.println(WiFi.localIP());
  client.setCACert(test_root_ca);
}

void loop() 
{
  if(&client) {
    {
      // Add a scoping block for HTTPClient https to make sure it is destroyed before WiFiClientSecure *client is 
      HTTPClient https;
      Serial.print("[HTTPS] begin...\n");
      if (https.begin(client, "https://www.google.com/index.html")) {  // HTTPS
        Serial.print("[HTTPS] GET...\n");
        // start connection and send HTTP header
        int httpCode = https.GET();
        // httpCode will be negative on error
        if (httpCode > 0) {
          // HTTP header has been send and Server response header has been handled
          Serial.printf("[HTTPS] GET... code: %d\n", httpCode);
          // file found at server
          if (httpCode == HTTP_CODE_OK || httpCode == HTTP_CODE_MOVED_PERMANENTLY) {
            String payload = https.getString();
            Serial.println(payload);
          }
        } else {
          Serial.printf("[HTTPS] GET... failed, error: %s\n", https.errorToString(httpCode).c_str());
        }
        https.end();
      } else {
        Serial.printf("[HTTPS] Unable to connect\n");
      }
      // End extra scoping block
    }
  } else {
    Serial.println("Unable to create client");
  }
  Serial.println();
  Serial.println("Waiting 10s before the next round...");
  delay(10000);
}
```



## HTTP POST 示例

下面是使用 HTTPClient 从 Wio Terminal 向 Web 服务器发送 **HTTP POST 请求** 的示例。在这个演示中，我们使用 Python 在我们的 PC 上设置一个简单的 Web 服务器，它可以接收和响应 HTTP 请求。

### Python Server 代码

首先，我们需要使用 `pip` 安装 **bottle** 库，命令如下：（你的机器可能需要改成 `pip3`）

```bash
pip install bottle
```

安装成功后，复制下面一段代码并保存为 **`simple-server.py`** 文件。你可以修改代码中的 port 端口，不过如果 Python 这边修改了，记得也要在 Arduino 代码中修改成同一个。

```python
from bottle import run, request, post

@post('/')
def index():
    data = request.body.read()
    print(data)

run(host='0.0.0.0', port=1880, debug=True)
```



### Arduino 代码

下面是 Wio Terminal 端的代码，请将下面代码中的 `ssid` 和 `password` 替换成你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include [HTTPClient.h](HTTPClient.h)
 
const char* ssid = "yourNetwork";
const char* password =  "yourPassword";
 
// Change the following IP to your computer's IP running the server, make sure the Port also match
const char* yourLocalIp =  "http://10.0.0.233:1880/";
 
void setup() {
 
  Serial.begin(115200);
  WiFi.begin(ssid, password);
 
  while (WiFi.status() != WL_CONNECTED) { //Check for the connection
    delay(500);
    Serial.println("Connecting..");
  }
  Serial.print("Connected to the WiFi network with IP: ");
  Serial.println(WiFi.localIP());
}
 
void loop() {
 
 if(WiFi.status()== WL_CONNECTED){   //Check WiFi connection status
 
   HTTPClient http;
 
   http.begin(yourLocalIp);  //Specify destination for HTTP request
   http.addHeader("Content-Type", "text/plain");             //Specify content-type header
 
   int httpResponseCode = http.POST("Hello Bottle, from Wio Terminal");   //Send the actual POST request
 
   if(httpResponseCode>0){
    Serial.print("HTTP Response Code: ");
    Serial.println(httpResponseCode);   //Print return code
   }else{
    Serial.print("Error on sending request: ");
    Serial.println(httpResponseCode);
   }
 
   http.end();  //Free resources
 
 }else{
    Serial.println("Error in WiFi connection");
 }
  delay(5000);  //Send a request every 5 seconds
}
```

编译并上传程序到 Wio Terminal，打开一个 Shell 终端，执行 `python3 simple-server.py` 命令运行服务器，可以观察 HTTP 请求消息。

![](https://static.getiot.tech/wio-terminal-httpclient-http-post.png#center)
