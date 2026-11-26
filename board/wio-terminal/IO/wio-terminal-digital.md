---
sidebar_position: 3
slug: /wio-terminal-digital
---

# Wio Terminal 数字引脚



本文主要介绍 Wio Terminal 上的数字引脚，以及如何将 Grove 端口用作数字端口，如何输出 PWM，如何实现 UART 串口通信等等。阅读本文，你将可以轻松实现数字 IO 输入输出，同时可以借助 Grove 生态系统，满足你的设计需求。



## RPI 数字引脚

在兼容树莓派的 40 pin 引脚中，定义了 9 个数字引脚，即下图浅绿色部分的 `D0` -> `D8`。

![](https://static.getiot.tech/WioT-Pinout.jpg#center)

**示例代码**：

```cpp showLineNumbers
void setup() {
    pinMode(D2, OUTPUT); // Configure D2 as Digital output
}

void loop() {
    digitalWrite(D2, HIGH);
    delay(1000); 
    digitalWrite(D2, LOW); 
    delay(1000); 
}
```

此时，如果在 D2 引脚接一个 LED 灯，就会看到它在以每秒切换一次的频率闪烁。



## Grove 端口配置

参考 [Wio Terminal IO 引脚](/wiot/wio-terminal-io/)，我们知道其中一个 Grove 端口是**可配置 A/D 端口**，对应的引脚定义是：

- `RPI_D0/A0/PWM`
- `RPI_D1/A1/PWM`

如果我们想要将 Grove 可配置 A/D 端口用作数字端口，只需将其定义如下：

```cpp showLineNumbers
void setup() {
    pinMode(D0, INPUT); // Configure UART TX as Digital port
}
```

另一个 **Grove I2C 端口**也可以用作数字端口，设置代码如下：

```cpp showLineNumbers
void setup() {
    pinMode(PIN_WIRE_SCL, INPUT); // Defined SCL of I2C port as Digital Input
```

上述示例中的 `D0` 和 `PIN_WIRE_SCL` 都是 Wio-Terminal 库中预先定义好的引脚名字，具体可以查看 `variant.h` 文件。



## 按键输入示例代码

下面示例将演示如何使用 Grove Button 和 Grove LED，通过按键控制 LED 灯的亮灭。

```cpp showLineNumbers
#define BUTTON D0         // Button to Grove UART Port
#define LED PIN_WIRE_SCL  // LED to Grove I2C Port

void setup() {
    Serial.begin(115200);
    pinMode(BUTTON, INPUT);
    pinMode(LED, OUTPUT);
}

void loop() {
    int buttonState = digitalRead(BUTTON);
    Serial.print("Button State: ");
    Serial.println(buttonState);
 
    if (buttonState == HIGH) {
        digitalWrite(LED, HIGH);
    }
    else {
        digitalWrite(LED, LOW);
    }
    delay(50);
}
```

串口监视器输出如下：

![](https://files.seeedstudio.com/wiki/Wio-Terminal/img/2019-12-12%2014-55-44.2019-12-12%2014_56_10.gif#center)



## PWM 输出示例代码

下面示例将演示如何使用 Grove Servo 库（伺服）来输出 PWM 数字信号。

```cpp showLineNumbers
#include <Servo.h>
Servo myservo;
 
int pos = 0;
 
void setup() {
    myservo.attach(D0); // Connect servo to Grove Digital Port
}
 
void loop() {
    for (pos = 0; pos <= 180; pos += 1) {
        // in steps of 1 degree
        myservo.write(pos);
        delay(15);
    }
    for (pos = 180; pos >= 0; pos -= 1) {
        myservo.write(pos);
        delay(15);
    }
}
```

**注意：** 要将 Servo 库与 Wio Terminal 一起使用，需要先添加 [Adafruit 的版本](https://github.com/PaintYourDragon/Servo) 到 Arduino IDE 以获得 SAMD51 功能。

