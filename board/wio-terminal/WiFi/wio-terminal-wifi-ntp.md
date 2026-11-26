---
sidebar_position: 7
slug: /wio-terminal-wifi-ntp
---

# Wio Terminal NTP 时间同步



本文主要介绍如何在 Wio Terminal 上通过 NTP 同步网络时间。Wio Terminal 配备的无线 WiFi 网卡是 Realtek RTL8720，在开始本次学习之前，请确保你已经阅读 [Wio Terminal 网卡固件更新](/wiot/wio-terminal-network-firmware/)，并完成固件更新和 Arduino 依赖库的安装。

本示例使用 UDP 获取 NTP 时间，并使用主控制器 SAMD51 内核上的内置 RTC 来保持时间更新。



## 安装依赖

为了完成本示例，需要安装两个依赖库 **Seeed_Arduino_RTC** 和 **millisDelay**。

1、在 `Seeed_Arduino_RTC` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_RTC) 下载 zip 包。

2、在 `millisDelay` 的 [GitHub 仓库](https://github.com/ansonhe97/millisDelay) 下载 zip 包。

3、在 Arduino IDE 中点击 *项目 > 加载库 > 添加 .ZIP 库...*，添加 `Seeed_Arduino_RTC` 和 `millisDelay` 库。



## 示例代码

```cpp showLineNumbers
#include <rpcWiFi.h>
#include <millisDelay.h>
#include "RTC_SAMD51.h"
 
const char ssid[] = "yourNetworkName"; // add your required ssid
const char password[] = "yourNetworkPassword"; // add your own netywork password
 
millisDelay updateDelay; // the update delay object. used for ntp periodic update.
 
unsigned int localPort = 2390;      // local port to listen for UDP packets
char timeServer[] = "time.nist.gov"; // extenral NTP server e.g. time.nist.gov
 
const int NTP_PACKET_SIZE = 48; // NTP time stamp is in the first 48 bytes of the message
byte packetBuffer[NTP_PACKET_SIZE]; //buffer to hold incoming and outgoing packets
 
// declare a time object
DateTime now;
 
// define WiFI client
WiFiClient client;
 
//The udp library class
WiFiUDP udp;
 
// localtime
unsigned long devicetime;
 
RTC_SAMD51 rtc;
 
// for use by the Adafuit RTClib library
char daysOfTheWeek[7][12] = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
 
void setup() {
 
    Serial.begin(115200);
 
    while (!Serial); // wait for serial port to connect. Needed for native USB
 
    // setup network before rtc check 
    connectToWiFi(ssid, password);
 
    // get the time via NTP (udp) call to time server
    // getNTPtime returns epoch UTC time adjusted for timezone but not daylight savings
    // time
    devicetime = getNTPtime();
 
    // check if rtc present
    if (devicetime == 0) {
        Serial.println("Failed to get time from network time server.");
    }
 
    if (!rtc.begin()) {
        Serial.println("Couldn't find RTC");
        while (1) delay(10); // stop operating
    }
 
    // get and print the current rtc time
    now = rtc.now();
    Serial.print("RTC time is: ");
    Serial.println(now.timestamp(DateTime::TIMESTAMP_FULL));
 
    // adjust time using ntp time
    rtc.adjust(DateTime(devicetime));
 
    // print boot update details
    Serial.println("RTC (boot) time updated.");
    // get and print the adjusted rtc time
    now = rtc.now();
    Serial.print("Adjusted RTC (boot) time is: ");
    Serial.println(now.timestamp(DateTime::TIMESTAMP_FULL));
 
    // start millisdelays timers as required, adjust to suit requirements
    updateDelay.start(1 * 60 * 60 * 1000); // update time via ntp every hr
 
}
 
void loop() {
 
    if (updateDelay.justFinished()) { // 12 hour loop
        // repeat timer
        updateDelay.repeat(); // repeat
 
        // update rtc time
        devicetime = getNTPtime();
        if (devicetime == 0) {
            Serial.println("Failed to get time from network time server.");
        }
        else {
            rtc.adjust(DateTime(devicetime));
            Serial.println("");
            Serial.println("rtc time updated.");
            // get and print the adjusted rtc time
            now = rtc.now();
            Serial.print("Adjusted RTC time is: ");
            Serial.println(now.timestamp(DateTime::TIMESTAMP_FULL));
        }
    }
}
 
 
void connectToWiFi(const char* ssid, const char* pwd) {
    Serial.println("Connecting to WiFi network: " + String(ssid));
 
    // delete old config
    WiFi.disconnect(true);
 
    Serial.println("Waiting for WIFI connection...");
 
    //Initiate connection
    WiFi.begin(ssid, pwd);
 
    while (WiFi.status() != WL_CONNECTED) {
        WiFi.begin(ssid, pwd);
        delay(500);
    }
    Serial.println("Connected.");
    printWifiStatus();
 
}
 
unsigned long getNTPtime() {
 
    // module returns a unsigned long time valus as secs since Jan 1, 1970 
    // unix time or 0 if a problem encounted
 
    //only send data when connected
    if (WiFi.status() == WL_CONNECTED) {
        //initializes the UDP state
        //This initializes the transfer buffer
        udp.begin(WiFi.localIP(), localPort);
 
        sendNTPpacket(timeServer); // send an NTP packet to a time server
        // wait to see if a reply is available
        delay(1000);
 
        if (udp.parsePacket()) {
            Serial.println("udp packet received");
            Serial.println("");
            // We've received a packet, read the data from it
            udp.read(packetBuffer, NTP_PACKET_SIZE); // read the packet into the buffer
 
            //the timestamp starts at byte 40 of the received packet and is four bytes,
            // or two words, long. First, extract the two words:
 
            unsigned long highWord = word(packetBuffer[40], packetBuffer[41]);
            unsigned long lowWord = word(packetBuffer[42], packetBuffer[43]);
            // combine the four bytes (two words) into a long integer
            // this is NTP time (seconds since Jan 1 1900):
            unsigned long secsSince1900 = highWord << 16 | lowWord;
            // Unix time starts on Jan 1 1970. In seconds, that's 2208988800:
            const unsigned long seventyYears = 2208988800UL;
            // subtract seventy years:
            unsigned long epoch = secsSince1900 - seventyYears;
 
            // adjust time for timezone offset in secs +/- from UTC
            // WA time offset from UTC is +8 hours (28,800 secs)
            // + East of GMT
            // - West of GMT
            long tzOffset = 28800UL;
 
            // WA local time 
            unsigned long adjustedTime;
            return adjustedTime = epoch + tzOffset;
        }
        else {
            // were not able to parse the udp packet successfully
            // clear down the udp connection
            udp.stop();
            return 0; // zero indicates a failure
        }
        // not calling ntp time frequently, stop releases resources
        udp.stop();
    }
    else {
        // network not connected
        return 0;
    }
 
}
 
// send an NTP request to the time server at the given address
unsigned long sendNTPpacket(const char* address) {
    // set all bytes in the buffer to 0
    for (int i = 0; i < NTP_PACKET_SIZE; ++i) {
        packetBuffer[i] = 0;
    }
    // Initialize values needed to form NTP request
    // (see URL above for details on the packets)
    packetBuffer[0] = 0b11100011;   // LI, Version, Mode
    packetBuffer[1] = 0;     // Stratum, or type of clock
    packetBuffer[2] = 6;     // Polling Interval
    packetBuffer[3] = 0xEC;  // Peer Clock Precision
    // 8 bytes of zero for Root Delay & Root Dispersion
    packetBuffer[12] = 49;
    packetBuffer[13] = 0x4E;
    packetBuffer[14] = 49;
    packetBuffer[15] = 52;
 
    // all NTP fields have been given values, now
    // you can send a packet requesting a timestamp:
    udp.beginPacket(address, 123); //NTP requests are to port 123
    udp.write(packetBuffer, NTP_PACKET_SIZE);
    udp.endPacket();
}
 
void printWifiStatus() {
    // print the SSID of the network you're attached to:
    Serial.println("");
    Serial.print("SSID: ");
    Serial.println(WiFi.SSID());
 
    // print your WiFi shield's IP address:
    IPAddress ip = WiFi.localIP();
    Serial.print("IP Address: ");
    Serial.println(ip);
 
    // print the received signal strength:
    long rssi = WiFi.RSSI();
    Serial.print("signal strength (RSSI):");
    Serial.print(rssi);
    Serial.println(" dBm");
    Serial.println("");
}
```



## 运行效果

![img](https://static.getiot.tech/wio-terminal-ntp-demo.png#center)
