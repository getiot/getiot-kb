---
sidebar_position: 2
slug: /wio-terminal-analog
---

# Wio Terminal 模拟引脚



![](https://files.seeedstudio.com/wiki/Wio-Terminal/img/2019-12-12%2011-36-22.2019-12-12%2011_37_02.gif#center)

本文主要介绍 Wio Terminal 上的模拟（Analog）引脚，并演示如何使用模拟输入端口来监测环境声音的大小。值得一提的是，Wio Terminal 上的模拟引脚必须使用 RPI 引脚。



## RPI 模拟引脚

在兼容树莓派的 40 pin 引脚中，定义了 9 个模拟引脚，即下图橙色部分的 `A0` -> `A8`。

![](https://static.getiot.tech/WioT-Pinout.jpg#center)



## Grove 端口配置

当然，我们也可以将 **Grove 可配置 A/D 端口**中的 `RPI_D0/A0/PWM` 和 `RPI_D1/A1/PWM` 用作模拟引脚使用，只需将其定义如下：

```cpp showLineNumbers
void setup() {
    pinMode(A0, INPUT);
}
```



## 示例代码

下面示例演示了如何使用模拟输入引脚获取 Grove Loudness 传感器数据。

```cpp showLineNumbers
void setup() {
    Serial.begin(115200);
    pinMode(A0, INPUT);
}
void loop() {
    int loudness = analogRead(A0);
    Serial.print("Loudness: ");
    Serial.println(loudness);
    delay(50);
}
```

