---
sidebar_position: 10
slug: /wio-terminal-dnsserver
---

# Wio Terminal DNS 服务器



DNS（Domain Name Server，域名服务器）是进行域名和与之相对应的 IP 地址转换的服务器。有了 DNS，我们就可以通过域名来访问 Web 服务器，不用记住 IP 地址。

当然，Wio Terminal 上也能实现域名解析，因此本文就来介绍 **DNSServer** 库和 **rpcmDNS** 库在 Wio Terminal 上的使用。



## DNSServer 用法

使用 DNSServer 必须将 WiFi 配置为 **AP** 模式。在代码中添加 `<DNSServer.h>` 头文件，并声明 `DNSServer` 对象，然后调用 `start()` 方法，使用 `processNextRequest()` 方法处理请求。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <DNSServer.h>
#include <WebServer.h>

IPAddress local_IP(192, 168, 1, 1);
IPAddress gateway(192, 168, 1, 1);
IPAddress subnet(255, 255, 255, 0);

const byte DNS_PORT = 53;

DNSServer dnsServer;
WebServer webserver(80);

void handleRoot()
{
  webserver.send(200, "text/plain", "Root page accessed via domain name");
}

void handleP1()
{
  webserver.send(200, "text/plain", "Page 1 accessed via domain name");
}

void setup()
{
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(local_IP, gateway, subnet);
  WiFi.softAP("DNSServer example");
 
  webserver.on("/", handleRoot);
  webserver.on("/p1", handleP1);
 
  dnsServer.start(DNS_PORT, "www.wioterminal.com", local_IP); //Start the DNS service, example.com is the registered domain name.
  webserver.begin();
}
 
void loop()
{
  dnsServer.processNextRequest();
  webserver.handleClient();
}
```

将电脑或手机的 WiFi 连接到 Wio Terminal（名称为 **DNSServer example**），打开浏览器输入 `www.wioterminal.com` 和 `www.wioterminal.com/p1` 看看效果吧。

![img](https://files.seeedstudio.com/wiki/Wio-Terminal-Advanced-Wi-Fi/DNS.gif#center)



## mDNS 用法

mDNS 即 [Multicast DNS](https://en.wikipedia.org/wiki/Multicast_DNS)（多播 DNS），mDNS 协议将主机名解析为不包含本地名称服务器的小型网络中的 IP 地址。多播 DNS 专为小型网络设计，旨在提高其用户友好性。这个想法的目的是让用户可以毫无问题地连接秘密局域网中的设备。



### 安装 rpcmDNS 库

首先需要为 Wio Terminal 安装 **Seeed_Arduino_rpcmDNS** 库。

1、在 `Seeed_Arduino_rpcmDNS` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_rpcmDNS) 下载 zip 包。

2、然后将 `Seeed_Arduino_rpcmDNS` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库...*，然后选择刚刚下载的 Seeed_Arduino_rpcmDNS.zip 文件。



### mDNS Web Server 示例

下面是一个在 Wio Terminal 上设置 mDNS 网络服务器的示例。这样，同一网络中的其他设备便可以在定义的站点上浏览网络服务器。

提示：将下面代码中的 `ssid` 和 `password` 替换成你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <RPCmDNS.h>
#include <WiFiClient.h>
 
const char* ssid     = "yourNetwork";
const char* password = "yourPassword";
 
// TCP server at port 80 will respond to HTTP requests
WiFiServer server(80);
 
void setup(void)
{  
    Serial.begin(115200);
    while(!Serial){
        ;
    }
    Serial.printf("Setup Start \r\n");
    // Connect to WiFi network
    WiFi.begin(ssid, password);
    Serial.println("");
 
    // Wait for connection
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
 
    // Set up mDNS responder:
    // - first argument is the domain name, in this example
    //   the fully-qualified domain name is "esp8266.local"
    // - second argument is the IP address to advertise
    //   we send our IP address on the WiFi network
    if (!MDNS.begin("WioTerminal")) {
        Serial.println("Error setting up MDNS responder!");
        while(1) {
            delay(1000);
        }
    }
    Serial.println("mDNS responder started");
 
    // Start TCP (HTTP) server
    server.begin();
    Serial.println("TCP server started");
 
    // Add service to MDNS-SD
    MDNS.addService("http", "tcp", 80);
 
    Serial.printf("Setup Done \r\n");
}
 
void loop(void)
{
    // Check if a client has connected
    WiFiClient client = server.available();
    if (!client) {
        return;
    }
    Serial.println("");
    Serial.println("New client");
    // Wait for data from client to become available
    while(client.connected() && !client.available()){
        delay(1);
    }
    // Read the first line of HTTP request
    String req = client.readStringUntil('\r');
    // First line of HTTP request looks like "GET /path HTTP/1.1"
    // Retrieve the "/path" part by finding the spaces
    int addr_start = req.indexOf(' ');
    int addr_end = req.indexOf(' ', addr_start + 1);
    if (addr_start == -1 || addr_end == -1) {
        Serial.print("Invalid request: ");
        Serial.println(req);
        return;
    }
    req = req.substring(addr_start + 1, addr_end);
    Serial.print("Request: ");
    Serial.println(req);
 
    String s;
    if (req == "/")
    {
        IPAddress ip = WiFi.localIP();
        String ipStr = String(ip[0]) + '.' + String(ip[1]) + '.' + String(ip[2]) + '.' + String(ip[3]);
        s = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>Hello from Wio Terminal at ";
        s += ipStr;
        s += "</html>\r\n\r\n";
        Serial.println("Sending 200");
    }
    else
    {
        s = "HTTP/1.1 404 Not Found\r\n\r\n";
        Serial.println("Sending 404");
    }
    client.print(s);
 
    client.stop();
    Serial.println("Done with client");
}
```

使用同一网络的计算机，打开浏览器输入 [http://WioTerminal.local/](http://wioterminal.local/) 访问 Wio Terminal 服务器。

![Wio Terminal mDNS Web Server 示例](https://static.getiot.tech/wio-terminal-mdns-webserver.png#center)



### mDNS-SD 示例

下面这个是 [mDNS-SD(Service Discovery)](https://en.wikipedia.org/wiki/Zero-configuration_networking#DNS-SD) 示例，允许你发现同一网络中的服务。

提示：将下面代码中的 `ssid` 和 `password` 替换成你的 WiFi 网络。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <RPCmDNS.h>
#include <WiFiClient.h>
 
const char* ssid     = "yourNetwork";
const char* password = "yourPassword";
 
// TCP server at port 80 will respond to HTTP requests
WiFiServer server(80);
 
void setup(void)
{  
    Serial.begin(115200);
    while(!Serial){
        ;
    }
    Serial.printf("Setup Start \r\n");
    // Connect to WiFi network
    WiFi.begin(ssid, password);
    Serial.println("");
 
    // Wait for connection
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(ssid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
 
    // Set up mDNS responder:
    // - first argument is the domain name, in this example
    //   the fully-qualified domain name is "esp8266.local"
    // - second argument is the IP address to advertise
    //   we send our IP address on the WiFi network
    if (!MDNS.begin("WioTerminal")) {
        Serial.println("Error setting up MDNS responder!");
        while(1) {
            delay(1000);
        }
    }
    Serial.println("mDNS responder started");
 
    // Start TCP (HTTP) server
    server.begin();
    Serial.println("TCP server started");
 
    // Add service to MDNS-SD
    MDNS.addService("http", "tcp", 80);
 
    Serial.printf("Setup Done \r\n");
}
 
void loop(void)
{
    // Check if a client has connected
    WiFiClient client = server.available();
    if (!client) {
        return;
    }
    Serial.println("");
    Serial.println("New client");
    // Wait for data from client to become available
    while(client.connected() && !client.available()){
        delay(1);
    }
    // Read the first line of HTTP request
    String req = client.readStringUntil('\r');
    // First line of HTTP request looks like "GET /path HTTP/1.1"
    // Retrieve the "/path" part by finding the spaces
    int addr_start = req.indexOf(' ');
    int addr_end = req.indexOf(' ', addr_start + 1);
    if (addr_start == -1 || addr_end == -1) {
        Serial.print("Invalid request: ");
        Serial.println(req);
        return;
    }
    req = req.substring(addr_start + 1, addr_end);
    Serial.print("Request: ");
    Serial.println(req);
 
    String s;
    if (req == "/")
    {
        IPAddress ip = WiFi.localIP();
        String ipStr = String(ip[0]) + '.' + String(ip[1]) + '.' + String(ip[2]) + '.' + String(ip[3]);
        s = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n<!DOCTYPE HTML>\r\n<html>Hello from Wio Terminal at ";
        s += ipStr;
        s += "</html>\r\n\r\n";
        Serial.println("Sending 200");
    }
    else
    {
        s = "HTTP/1.1 404 Not Found\r\n\r\n";
        Serial.println("Sending 404");
    }
    client.print(s);
 
    client.stop();
    Serial.println("Done with client");
}
```

使用同一网络的计算机，打开浏览器输入 [http://WioTerminal.local/](http://wioterminal.local/) 访问 Wio Terminal 服务器。打开 Arduino IDE 串口监视器，观察输出内容。

![Wio Terminal mDNS-SD 示例](https://static.getiot.tech/wio-terminal-mdns-sd2.png#center)

