---
sidebar_position: 8
slug: /wio-terminal-rtc
---

# Wio Terminal RTC 实时时钟



Wio Terminal 虽然没有配备 RTC 实时时钟模块，但是主控制器 SAMD51 内核上有一个内置 RTC，我们可以用它来保持时间更新。因此完成本次实验，你无需添加外部 RTC 模块。



## 安装依赖库

首先需要为 Wio Terminal 安装 **Seeed_Arduino_RTC** 库。

1、在 `Seeed_Arduino_RTC` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_RTC) 下载 zip 包。

2、然后将 `Seeed_Arduino_RTC` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Seeed_Arduino_RTC.zip 文件。



## 示例代码

下面演示 `Seeed_Arduino_RTC` 库的基本用法。在该示例中，先用程序编译时间初始化 RTC 时间，然后再读取 RTC 时间，并设置一个延后 15 秒的闹钟。

```cpp showLineNumbers
#include "RTC_SAMD51.h"
#include "DateTime.h"

RTC_SAMD51 rtc;
void setup()
{
    rtc.begin();
    Serial.begin(115200);
 
    while (!Serial) { ; }
 
    DateTime now = DateTime(F(__DATE__), F(__TIME__));
    Serial.println("adjust time!");
    rtc.adjust(now);
 
    now = rtc.now();
 
    Serial.print(now.year(), DEC);
    Serial.print('/');
    Serial.print(now.month(), DEC);
    Serial.print('/');
    Serial.print(now.day(), DEC);
    Serial.print(" ");
    Serial.print(now.hour(), DEC);
    Serial.print(':');
    Serial.print(now.minute(), DEC);
    Serial.print(':');
    Serial.print(now.second(), DEC);
    Serial.println();
 
    DateTime alarm = DateTime(now.year(), now.month(), now.day(), now.hour(), now.minute(), now.second() + 15);

    rtc.setAlarm(0, alarm); // match after 15 seconds
    rtc.enableAlarm(0, rtc.MATCH_HHMMSS); // match Every Day

    rtc.attachInterrupt(alarmMatch); // callback whlie alarm is match
}
 
void loop()
{
}

void alarmMatch(uint32_t flag)
{
    Serial.println("Alarm Match!");
    DateTime now = rtc.now();
    Serial.print(now.year(), DEC);
    Serial.print('/');
    Serial.print(now.month(), DEC);
    Serial.print('/');
    Serial.print(now.day(), DEC);
    Serial.print(" ");
    Serial.print(now.hour(), DEC);
    Serial.print(':');
    Serial.print(now.minute(), DEC);
    Serial.print(':');
    Serial.print(now.second(), DEC);
    Serial.println();
}
```



## 高级用法

为了随时获取准确时间，可以使用 NTP 协议从网络时间服务器中同步时间到 RTC。

具体示例请参考 [Wio Terminal NTP 时间同步](/wiot/wio-terminal-wifi-ntp/)。

