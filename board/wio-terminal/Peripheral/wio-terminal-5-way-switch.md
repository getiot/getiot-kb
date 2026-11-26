---
sidebar_position: 2
slug: /wio-terminal-5-way-switch
---

# Wio Terminal 五向开关



Wio-Terminal 除了有[三个蓝色按键](/wiot/wio-terminal-buttons/)，在下方还有一个蓝色的五向开关。所谓“五向开关”，是指其内部设置有五个固定触点，能够对多个单元的断开与接通进行控制的一种开关，在许多家用电器及消费电子产品上都能看到它。

![](https://static.getiot.tech/wio-terminal-5-way-switch.png#center)

本文主要介绍如何配置和使用 Wio-Terminal 的这个五向开关。



## 开关定义

在 `variant.h` 中预定义了五向开关的宏定义，有两种命名风格，我们在编程的时候可以直接使用它们。

```cpp showLineNumbers
/*
 * SWITCH
 */
#define SWITCH_X (31ul)
#define SWITCH_Y (32ul)
#define SWITCH_Z (33ul)
#define SWITCH_B (34ul)
#define SWITCH_U (35ul)

#define WIO_5S_UP (31ul)
#define WIO_5S_LEFT (32ul)
#define WIO_5S_RIGHT (33ul)
#define WIO_5S_DOWN (34ul)
#define WIO_5S_PRESS (35ul)
```



## 轮询示例

下面示例使用 `WIO_5S_UP`、`WIO_5S_DOWN`、`WIO_5S_LEFT`、`WIO_5S_RIGHT` 和 `WIO_5S_PRESS` 来配置五向开关。

下面是采用轮询方式检查按键状态的一个简单示例：

```cpp showLineNumbers
void setup() {
  Serial.begin(115200);
  pinMode(WIO_5S_UP, INPUT_PULLUP);
  pinMode(WIO_5S_DOWN, INPUT_PULLUP);
  pinMode(WIO_5S_LEFT, INPUT_PULLUP);
  pinMode(WIO_5S_RIGHT, INPUT_PULLUP);
  pinMode(WIO_5S_PRESS, INPUT_PULLUP);
}
 
void loop() {
  // put your main code here, to run repeatedly:
   if (digitalRead(WIO_5S_UP) == LOW) {
    Serial.println("5 Way Up");
   }
   else if (digitalRead(WIO_5S_DOWN) == LOW) {
    Serial.println("5 Way Down");
   }
   else if (digitalRead(WIO_5S_LEFT) == LOW) {
    Serial.println("5 Way Left");
   }
   else if (digitalRead(WIO_5S_RIGHT) == LOW) {
    Serial.println("5 Way Right");
   }
   else if (digitalRead(WIO_5S_PRESS) == LOW) {
    Serial.println("5 Way Press");
   }
   delay(200);
}
```



## 中断示例

下面是采用中断绑定方式触发按键动作的一个简单示例：

```cpp showLineNumbers
/* Interrupt handler */
void button_handler_up() { Serial.println("button Up"); }
void button_handler_down() { Serial.println("button Down"); }
void button_handler_left() { Serial.println("button left"); }
void button_handler_right() { Serial.println("button Right"); }
void button_handler_press() { Serial.println("button Press"); }

void setup() {

    Serial.begin(115200);

    /* Button setup */
    pinMode(WIO_5S_UP,    INPUT);
    pinMode(WIO_5S_DOWN,  INPUT);
    pinMode(WIO_5S_LEFT,  INPUT);
    pinMode(WIO_5S_RIGHT, INPUT);
    pinMode(WIO_5S_PRESS, INPUT);

    /* Attach */
    attachInterrupt(digitalPinToInterrupt(WIO_5S_UP),     button_handler_up,    FALLING);
    attachInterrupt(digitalPinToInterrupt(WIO_5S_DOWN),   button_handler_down,  FALLING);
    attachInterrupt(digitalPinToInterrupt(WIO_5S_LEFT),   button_handler_left,  FALLING);
    attachInterrupt(digitalPinToInterrupt(WIO_5S_RIGHT),  button_handler_right, FALLING);
    attachInterrupt(digitalPinToInterrupt(WIO_5S_PRESS),  button_handler_press, FALLING);
}

void loop() {}
```

