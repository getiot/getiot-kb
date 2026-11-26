---
sidebar_position: 6
slug: /wio-terminal-wifi-mqtt
---

# Wio Terminal MQTT 连接



本文将演示如何在 Wio Terminal 上通过 WiFi 与 [MQTT](/mqtt/) 服务器建立连接（以及 MQTTs 服务器）。Wio Terminal 配备的无线网卡是 Realtek RTL8720，在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。



## 安装依赖

本示例用到了一个 Arduino MQTT 库 **PubSubClient**，需要自行安装。

1、在 `PubSubClient` 的 [GitHub 仓库](https://github.com/knolleary/pubsubclien) 下载 zip 包。

2、然后将 `PubSubClient` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库...*，然后选择刚刚下载的 pubsubclient-2.8.zip 文件。

另外，我们还使用了一个免费的 MQTT 服务器 [Mosquitto](/foss/mosquitto/)。如果你想在本地网络进行测试，可以执行下面命令安装 Mosquitto 服务器。

```bash
sudo apt install mosquitto
```



## 连接 MQTT 服务器

下面示例演示使用 Wio Terminal 与 MQTT 服务器建立连接，这里使用的 MQTT 服务器是 Mosquitto 官方提供用于测试的。有了 MQTT 通信能力之后，你可以使用 Wio Terminal 订阅和发布消息到 MQTT 服务器，这种通信方式在物联网中应用非常广泛。

```cpp showLineNumbers
#include "rpcWiFi.h"
#include <PubSubClient.h>
 
// Update these with values suitable for your network.
const char *ssid = "yourNetworkName";      // your network SSID
const char *password = "yourNetworkPassword"; // your network password
 
const char *ID = "Wio-Terminal-Client";  // Name of our device, must be unique
const char *TOPIC = "WioTerminal";  // Topic to subcribe to
const char *subTopic = "inTopic";  // Topic to subcribe to
const char *server = "test.mosquitto.org"; // Server URL
 
 
WiFiClient wifiClient;
PubSubClient client(wifiClient);
 
void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i=0;i<length;i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}
 
void reconnect() {
  // Loop until we're reconnected
  while (!client.connected())
  {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect(ID)) {
      Serial.println("connected");
      // Once connected, publish an announcement...
      client.publish(TOPIC, "{\"message\": \"Wio Terminal is connected!\"}");
      Serial.println("Published connection message successfully!");
      // ... and resubscribe
      client.subscribe(subTopic);
      Serial.print("Subcribed to: ");
      Serial.println(subTopic);
    }
    else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}
 
void setup()
{
  Serial.begin(115200);
  while (!Serial)
    ; // Wait for Serial to be ready
  Serial.print("Attempting to connect to SSID: ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
 
  // attempt to connect to Wifi network:
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    WiFi.begin(ssid, password);
    // wait 1 second for re-trying
    delay(1000);
  }
 
  Serial.print("Connected to ");
  Serial.println(ssid);
  delay(500);
 
  client.setServer(server, 1883);
  client.setCallback(callback);
}
 
void loop()
{
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
}
```



## 连接 MQTTs 服务器

下面示例演示使用 Wio Terminal 建立 MQTTs 连接。这里还是使用了 Mosquitto 服务器，并将 Wio-Terminal 的加速度传感器数据发送到一个主题 `WioTerminal/IMU`，同时订阅 `inTopic` 主题。

如果你还没有使用过 IMU 传感器，可以参考 [Wio Terminal 惯量传感器](/wiot/wio-terminal-imu/)，并安装相关依赖库。

```cpp showLineNumbers
#include "rpcWiFi.h"
#include <PubSubClient.h>
#include <WiFiClientSecure.h>
#include "LIS3DHTR.h"
 
const char *ssid = "yourNetworkName";      // your network SSID
const char *password = "yourNetworkPassword"; // your network password
 
const char *ID = "Wio-Terminal-Client";  // Name of our device, must be unique
const char *TOPIC = "WioTerminal/IMU";  // Topic to subcribe to
const char *subTopic = "inTopic";  // Topic to subcribe to
 
const char *server = "test.mosquitto.org"; // Server URL
const char *test_root_ca =
"-----BEGIN CERTIFICATE-----\n"
"MIIEAzCCAuugAwIBAgIUBY1hlCGvdj4NhBXkZ/uLUZNILAwwDQYJKoZIhvcNAQEL\n"
"BQAwgZAxCzAJBgNVBAYTAkdCMRcwFQYDVQQIDA5Vbml0ZWQgS2luZ2RvbTEOMAwG\n"
"A1UEBwwFRGVyYnkxEjAQBgNVBAoMCU1vc3F1aXR0bzELMAkGA1UECwwCQ0ExFjAU\n"
"BgNVBAMMDW1vc3F1aXR0by5vcmcxHzAdBgkqhkiG9w0BCQEWEHJvZ2VyQGF0Y2hv\n"
"by5vcmcwHhcNMjAwNjA5MTEwNjM5WhcNMzAwNjA3MTEwNjM5WjCBkDELMAkGA1UE\n"
"BhMCR0IxFzAVBgNVBAgMDlVuaXRlZCBLaW5nZG9tMQ4wDAYDVQQHDAVEZXJieTES\n"
"MBAGA1UECgwJTW9zcXVpdHRvMQswCQYDVQQLDAJDQTEWMBQGA1UEAwwNbW9zcXVp\n"
"dHRvLm9yZzEfMB0GCSqGSIb3DQEJARYQcm9nZXJAYXRjaG9vLm9yZzCCASIwDQYJ\n"
"KoZIhvcNAQEBBQADggEPADCCAQoCggEBAME0HKmIzfTOwkKLT3THHe+ObdizamPg\n"
"UZmD64Tf3zJdNeYGYn4CEXbyP6fy3tWc8S2boW6dzrH8SdFf9uo320GJA9B7U1FW\n"
"Te3xda/Lm3JFfaHjkWw7jBwcauQZjpGINHapHRlpiCZsquAthOgxW9SgDgYlGzEA\n"
"s06pkEFiMw+qDfLo/sxFKB6vQlFekMeCymjLCbNwPJyqyhFmPWwio/PDMruBTzPH\n"
"3cioBnrJWKXc3OjXdLGFJOfj7pP0j/dr2LH72eSvv3PQQFl90CZPFhrCUcRHSSxo\n"
"E6yjGOdnz7f6PveLIB574kQORwt8ePn0yidrTC1ictikED3nHYhMUOUCAwEAAaNT\n"
"MFEwHQYDVR0OBBYEFPVV6xBUFPiGKDyo5V3+Hbh4N9YSMB8GA1UdIwQYMBaAFPVV\n"
"6xBUFPiGKDyo5V3+Hbh4N9YSMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQEL\n"
"BQADggEBAGa9kS21N70ThM6/Hj9D7mbVxKLBjVWe2TPsGfbl3rEDfZ+OKRZ2j6AC\n"
"6r7jb4TZO3dzF2p6dgbrlU71Y/4K0TdzIjRj3cQ3KSm41JvUQ0hZ/c04iGDg/xWf\n"
"+pp58nfPAYwuerruPNWmlStWAXf0UTqRtg4hQDWBuUFDJTuWuuBvEXudz74eh/wK\n"
"sMwfu1HFvjy5Z0iMDU8PUDepjVolOCue9ashlS4EB5IECdSR2TItnAIiIwimx839\n"
"LdUdRudafMu5T5Xma182OC0/u/xRlEm+tvKGGmfFcN0piqVl8OrSPBgIlb+1IKJE\n"
"m/XriWr/Cq4h/JfB7NTsezVslgkBaoU=\n"
"-----END CERTIFICATE-----\n";

long lastMsg = 0;

LIS3DHTR<TwoWire> lis;
WiFiClientSecure wifiClient;
PubSubClient client(wifiClient);

void callback(char *topic, byte *payload, unsigned int length)
{
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++)
  {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}

void reconnect()
{
  // Loop until we're reconnected
  while (!client.connected())
  {
    Serial.print("Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect(ID))
    {
      Serial.println("connected");
      // Once connected, publish an announcement...
      client.publish(TOPIC, "{\"message\": \"Wio Terminal is connected!\"}");
      Serial.println("Published connection message successfully!");
      // ... and resubscribe
      client.subscribe(subTopic);
      Serial.print("Subcribed to: ");
      Serial.println(subTopic);
    }
    else
    {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void setup()
{
  //Initialize serial and wait for port to open:
  Serial.begin(115200);
  while (!Serial)
    ; // Wait for Serial to be ready
  delay(1000);
 
  lis.begin(Wire1);
 
  if (!lis) {
    Serial.println("ERROR");
    while(1);
  }
  lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); //Data output rate
  lis.setFullScaleRange(LIS3DHTR_RANGE_2G); //Scale range set to 2g
 
  Serial.print("Attempting to connect to SSID: ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
 
  // attempt to connect to Wifi network:
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    WiFi.begin(ssid, password);
    // wait 1 second for re-trying
    delay(1000);
  }
  Serial.print("Connected to ");
  Serial.println(ssid);
 
  wifiClient.setCACert(test_root_ca);
 
  client.setServer(server, 8883);
  client.setCallback(callback);
}

void loop()
{
  if (!client.connected())
  {
    reconnect();
  }

  float x_values, y_values, z_values;
 
  // Sending Data
  long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;
 
  x_values = lis.getAccelerationX();
  y_values = lis.getAccelerationY();
  z_values = lis.getAccelerationZ();
  String data="{\"x-axis\": "+String(x_values)+","+"\"y-axis\": "+String(y_values)+","+"\"z-axis\": "+String(z_values)+"}";
 
  if (!client.publish(TOPIC, data.c_str())) {
    Serial.println("Message failed to send.");
  }
  Serial.printf("Message Send [%s] ", TOPIC);
  Serial.println(data);
  }
 
  client.loop();
}
```



