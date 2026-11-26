---
sidebar_position: 5
slug: /wio-terminal-wifi-http
---

# Wio Terminal HTTP 连接



本文将演示如何在 Wio Terminal 上通过 WiFi 建立 HTTP 连接（包括 HTTPS）。Wio Terminal 配备的无线网卡是 Realtek RTL8720，在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。



## Wi-Fi HTTP 客户端

下面这个示例首先将 Wio Terminal 配置为 STA 模式，然后连接指定的 Wi-Fi 接入点（AP），连接成功后发送一个 HTTP GET 请求，并从 Web server 中接收 HTTP 响应。为了简单地测试本示例，你可以在 PC 上使用 Python 启动一个简单的 Web 服务器。

1、将以下内容复制并保存在您的本地磁盘中，并将其命名为 `index.html`。

```html
<html>
<body>
Hello World!
</body>
</html>
```

2、打开 Shell 终端，切换到 `index.html` 所在目录，运行下面命令启动一个简单的 Python HTTP 服务器。

```bash
python -m SimpleHTTPServer 80    # For Python 2
python3 -m http.server 80        # For Pyhton 3
```

注意：Python2 和 Python3 的命令不一样。

3、将 Arduino 代码中的 `ssid` 和 `password` 修改为你的 WiFi 网络参数，将 `host` 修改为 Web 服务器的 IP 地址。

4、编译上传到 Wio Terminal，打开串口监视器观察。

```cpp showLineNumbers
#include <rpcWiFi.h>
 
const char* ssid = "yourNetworkName";
const char* password =  "yourNetworkPassword";

void setup() {
    Serial.begin(115200);
    while(!Serial); // Wait for Serial to be ready
    delay(1000);
 
    // Set WiFi to station mode and disconnect from an AP if it was previously connected
    WiFi.mode(WIFI_STA);
    WiFi.disconnect();
    delay(2000);
 
    WiFi.begin(ssid, password);
 
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.println("Connecting to WiFi..");
    }
    Serial.println("Connected to the WiFi network");
    Serial.print("IP Address: ");
    Serial.println (WiFi.localIP()); // prints out the device's IP address
}
 
void loop() {
    const uint16_t port = 80; // Default port
    const char* host = "192.168.0.10";  // Target Server IP Address
 
    Serial.print("Connecting to ");
    Serial.println(host);
 
    // Use WiFiClient class to create TCP connections
    WiFiClient client;
 
    if (!client.connect(host, port)) {
        Serial.println("Connection failed.");
        Serial.println("Waiting 5 seconds before retrying...");
        delay(5000);
        return;
    }
 
    // This will send a request to the server
    //uncomment this line to send an arbitrary string to the server
    //client.print("Send this data to the server");
    //uncomment this line to send a basic document request to the server
    client.print("GET /index.html HTTP/1.1\n\n"); // sending HTTP GET request
 
    int maxloops = 0;
 
    //wait for the server's reply to become available
    while (!client.available() && maxloops < 1000) {
        maxloops++;
        delay(1); //delay 1 msec
    }
    if (client.available() > 0) {
        //read back one line from the server
        String line = client.readString(); // Read from the server response
        // Proceed various line-endings
        line.replace("\r\n", "\n");
        line.replace('\r', '\n');
        line.replace("\n", "\r\n");
        Serial.println(line);
    } else {
        Serial.println("client.available() timed out ");
    }
 
    Serial.println("Closing connection.");
    client.stop();
 
    Serial.println("Waiting 5 seconds before restarting...");
    delay(5000);
}
```

运行效果如下：

![](https://static.getiot.tech/wio-terminal-http-demo.png#center)



## Wi-Fi HTTPS 连接

由于 HTTP 是明文传输，为了提高 Web 的安全性，需要使用 HTTPS。下面示例就来演示一下，如何在 Wio Terminal 上建立 HTTPS 连接。掌握了这个技能，你就可以连接到几乎所有网站并获取需要的数据。

注意：将 `ssid` 和 `password` 修改为你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <WiFiClientSecure.h>
 
const char* ssid     = "yourNetworkName";     // your network SSID
const char* password = "yourNetworkPassword"; // your network password
 
const char*  server = "www.example.com";  // Server URL
const char* test_root_ca = \
                            "-----BEGIN CERTIFICATE-----\n"
                            "MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBh\n"
                            "MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3\n"
                            "d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBD\n"
                            "QTAeFw0wNjExMTAwMDAwMDBaFw0zMTExMTAwMDAwMDBaMGExCzAJBgNVBAYTAlVT\n"
                            "MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j\n"
                            "b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IENBMIIBIjANBgkqhkiG\n"
                            "9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4jvhEXLeqKTTo1eqUKKPC3eQyaKl7hLOllsB\n"
                            "CSDMAZOnTjC3U/dDxGkAV53ijSLdhwZAAIEJzs4bg7/fzTtxRuLWZscFs3YnFo97\n"
                            "nh6Vfe63SKMI2tavegw5BmV/Sl0fvBf4q77uKNd0f3p4mVmFaG5cIzJLv07A6Fpt\n"
                            "43C/dxC//AH2hdmoRBBYMql1GNXRor5H4idq9Joz+EkIYIvUX7Q6hL+hqkpMfT7P\n"
                            "T19sdl6gSzeRntwi5m3OFBqOasv+zbMUZBfHWymeMr/y7vrTC0LUq7dBMtoM1O/4\n"
                            "gdW7jVg/tRvoSSiicNoxBN33shbyTApOB6jtSj1etX+jkMOvJwIDAQABo2MwYTAO\n"
                            "BgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUA95QNVbR\n"
                            "TLtm8KPiGxvDl7I90VUwHwYDVR0jBBgwFoAUA95QNVbRTLtm8KPiGxvDl7I90VUw\n"
                            "DQYJKoZIhvcNAQEFBQADggEBAMucN6pIExIK+t1EnE9SsPTfrgT1eXkIoyQY/Esr\n"
                            "hMAtudXH/vTBH1jLuG2cenTnmCmrEbXjcKChzUyImZOMkXDiqw8cvpOp/2PV5Adg\n"
                            "06O/nVsJ8dWO41P0jmP6P6fbtGbfYmbW0W5BjfIttep3Sp+dWOIrWcBAI+0tKIJF\n"
                            "PnlUkiaY4IBIqDfv8NZ5YBberOgOzW6sRBc4L0na4UU+Krk2U886UAb3LujEV0ls\n"
                            "YSEY1QSteDwsOoBrp+uvFRTp2InBuThs4pFsiv9kuXclVzDAGySj4dzp30d8tbQk\n"
                            "CAUw7C29C79Fv1C5qfPrmAESrciIxpg0X40KPMbp1ZWVbd4=\n"
                            "-----END CERTIFICATE-----\n";
 
// You can use x.509 client certificates if you want
//const char* test_client_key = "";   //to verify the client
//const char* test_client_cert = "";  //to verify the client
 
WiFiClientSecure client;
 
void setup() {
    //Initialize serial and wait for port to open:
    Serial.begin(115200);
    while(!Serial); // Wait for Serial to be ready
    delay(1000);
 
    Serial.print("Attempting to connect to SSID: ");
    Serial.println(ssid);
    WiFi.begin(ssid, password);
 
    // attempt to connect to Wifi network:
    while (WiFi.status() != WL_CONNECTED) {
        Serial.print(".");
        // wait 1 second for re-trying
        delay(1000);
    }
    Serial.print("Connected to ");
    Serial.println(ssid);
 
    client.setCACert(test_root_ca);
    //client.setCertificate(test_client_key); // for client verification
    //client.setPrivateKey(test_client_cert); // for client verification
 
    Serial.println("\nStarting connection to server...");
    if (!client.connect(server, 443)) {
        Serial.println("Connection failed!");
    } else {
        Serial.println("Connected to server!");
        // Make a HTTP request:
        client.println("GET https://www.example.com HTTP/1.0");
        client.println("Host: www.example.com");
        client.println("Connection: close");
        client.println();
 
        while (client.connected()) {
            String line = client.readStringUntil('\n');
            if (line == "\r") {
                Serial.println("headers received");
                break;
            }
        }
        // if there are incoming bytes available
        // from the server, read them and print them:
        while (client.available()) {
            char c = client.read();
            if (c == '\n') {
                Serial.write('\r');
            }
            Serial.write(c);
        }
        client.stop();
    }
}
 
void loop() {
    // do nothing
}
```

要获取网站的根 CA 证书，你可以在终端（Linux Bash Shell）中运行以下命令：

```bash
openssl s_client -showcerts -verify 5 -connect www.example.com:443 < /dev/null
```

提示：用目标网站的 URL 替换 `www.example.com`。

如果命令无法执行，请检查是否已经安装 openssl 软件包。

```bash
sudo apt update
sudo apt install openssl
```

