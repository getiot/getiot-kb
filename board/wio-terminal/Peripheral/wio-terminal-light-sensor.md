---
sidebar_position: 4
slug: /wio-terminal-light-sensor
---

# Wio Terminal 光线传感器



Wio Terminal 内置了一个光线传感器（Light Sensor）。本文主要介绍如何使用 Wio Terminal 上的光线传感器，通过模拟输入接口读取光纤传感器采集的周围环境光数据，并打印到 Arduino IDE 串口监视器。

**提示**：光线传感器位于 Wio Terminal 的背面，在 microSD card 插槽上方。



## 电路原理图

下图是 Wio-Terminal 的光线传感器的电路原理图，使用模拟输入采集光感信号。该引脚连接到主控制器 SAMD51 的 A13 管脚。

![](https://static.getiot.tech/wio-terminal-SCH-Light-Sensor.png#center)



## 示例代码

在 `variant.h` 中定义了光线传感器的输入引脚 `WIO_LIGHT`。

```cpp showLineNumbers
/*
 * light sensor
 */
#define WIO_LIGHT (27ul)
```

下面示例代码将通过 `WIO_LIGHT` 循环读取光线传感器数据。

```cpp showLineNumbers
void setup()
{
    pinMode(WIO_LIGHT, INPUT);
    Serial.begin(115200);
}

void loop() 
{
    int light = analogRead(WIO_LIGHT);
    Serial.print("Light value: ");
    Serial.println(light);
    delay(200);
}
```

