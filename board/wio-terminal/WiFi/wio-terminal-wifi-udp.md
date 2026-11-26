---
sidebar_position: 3
slug: /wio-terminal-wifi-udp
---

# Wio Terminal UDP 连接



本文将演示如何在 Wio Terminal 上通过 WiFi 建立 UDP 连接。Wio Terminal 配备的无线网卡是 Realtek RTL8720，在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。

在本示例中，Wio Terminal 作为 UDP 客户端，另外有一个 Python 编写的 UDP 服务端程序配合工作。你可以将 Python UDP 服务端程序运行在本地的 PC 上，但要注意它和 Wio Terminal 处于同一个局域网中。当然，你也可以将 Python UDP 运行在远程的云服务器上，只要修改 Arduino 代码中 UDP 的目的地址就可以了。



## Python UDP 服务端代码

首先用 Python 写一个简单的 UDP 服务端程序，代码如下：

```python
# This python script listens on UDP port 3333 
# for messages from the Wio Terminal board and prints them
import socket
import sys

try :
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
except socket.error as msg :
    print('Failed to create socket. Error Code : ' + str(msg[0]) + ' Message ' + msg[1])
    sys.exit()

try:
    s.bind(('', 3333))
except socket.error as msg:
    print('Bind failed. Error: ' + str(msg[0]) + ': ' + msg[1])
    sys.exit()

print('Server listening')

while 1:
    d = s.recvfrom(1024)
    data = d[0]
 
    if not data: 
        break
 
    print(data.strip())

s.close()
```

打开 Shell 终端，执行下面代码运行 UDP 服务端程序。

```bash
python3 udp_server.py
```



## Arduino 代码

下面是 Wio Terminal 的代码，你需要将 `networkName` 和 `networkPswd` 参数修改为你的 WiFi 网络，并且将 `udpAddress` 修改为 UDP Server 的目的地址。

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <WiFiUdp.h>
 
// WiFi network name and password:
const char * networkName = "your-ssid";
const char * networkPswd = "your-password";
 
//IP address to send UDP data to:
// either use the ip address of the server or 
// a network broadcast address
const char * udpAddress = "192.168.0.255";
const int udpPort = 3333;
 
//Are we currently connected?
boolean connected = false;
 
//The udp library class
WiFiUDP udp;
 
void setup(){
  // Initilize hardware serial:
  Serial.begin(115200);
 
  //Connect to the WiFi network
  connectToWiFi(networkName, networkPswd);
}
 
void loop(){
  //only send data when connected
  if(connected){
    //Send a packet
    udp.beginPacket(udpAddress,udpPort);
    udp.printf("Seconds since boot: %lu", millis()/1000);
    udp.endPacket();
  }
  //Wait for 1 second
  delay(1000);
}
 
void connectToWiFi(const char * ssid, const char * pwd){
  Serial.println("Connecting to WiFi network: " + String(ssid));
 
  // delete old config
  WiFi.disconnect(true);
  //register event handler
  WiFi.onEvent(WiFiEvent);
 
  //Initiate connection
  WiFi.begin(ssid, pwd);
 
  Serial.println("Waiting for WIFI connection...");
}
 
//wifi event handler
void WiFiEvent(WiFiEvent_t event){
    switch(event) {
      case SYSTEM_EVENT_STA_GOT_IP:
          //When connected set 
          Serial.print("WiFi connected! IP address: ");
          Serial.println(WiFi.localIP());  
          //initializes the UDP state
          //This initializes the transfer buffer
          udp.begin(WiFi.localIP(),udpPort);
          connected = true;
          break;
      case SYSTEM_EVENT_STA_DISCONNECTED:
          Serial.println("WiFi lost connection");
          connected = false;
          break;
      default: break;
    }
}
```

编译上传代码，打开串口监视器，可以看到如下运行过程。

![](https://static.getiot.tech/wio-terminal-udp-demo.png#center)



