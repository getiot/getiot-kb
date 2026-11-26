---
sidebar_position: 1
slug: /wio-terminal-buttons
---

# Wio Terminal 按键



Wio-Terminal 上方有三个蓝色按键，本文主要介绍如何配置和使用 Wio-Terminal 的这三个按键。



## 按键定义

在 `variant.h` 中预定义了三个按键的宏定义，有两种命名风格，我们在编程的时候可以直接使用它们。

```cpp showLineNumbers
/*
 * BUTTON
 */
#define BUTTON_1 (28ul)
#define BUTTON_2 (29ul)
#define BUTTON_3 (30ul)
#define WIO_KEY_A (28ul)
#define WIO_KEY_B (29ul)
#define WIO_KEY_C (30ul)
```



## 轮询示例

正如前面所说，你可以是 `WIO_KEY_A`、`WIO_KEY_B` 和 `WIO_KEY_C`，也可以使用 `BUTTON_1`、`BUTTON_2` 和 `BUTTON_3` 名字。

下面是采用轮询方式检查按键状态的一个简单示例：

```cpp showLineNumbers
void setup() {
  Serial.begin(115200);
  pinMode(WIO_KEY_A, INPUT_PULLUP);
  pinMode(WIO_KEY_B, INPUT_PULLUP);
  pinMode(WIO_KEY_C, INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
   if (digitalRead(WIO_KEY_A) == LOW) {
    Serial.println("A Key pressed");
   }
   else if (digitalRead(WIO_KEY_B) == LOW) {
    Serial.println("B Key pressed");
   }
   else if (digitalRead(WIO_KEY_C) == LOW) {
    Serial.println("C Key pressed");
   }
   delay(200);
}
```



## 中断示例

下面是采用中断绑定方式触发按键动作的一个简单示例：

```cpp showLineNumbers
/* Interrupt handler */
void button_handler_a() { Serial.println("button A"); }
void button_handler_b() { Serial.println("button B"); }
void button_handler_c() { Serial.println("button C"); }

void setup() {

    Serial.begin(115200);

    /* Button setup */
    pinMode(WIO_KEY_A,    INPUT);
    pinMode(WIO_KEY_B,    INPUT);
    pinMode(WIO_KEY_C,    INPUT);

    /* Attach */
    attachInterrupt(digitalPinToInterrupt(WIO_KEY_A),     button_handler_a,     FALLING);
    attachInterrupt(digitalPinToInterrupt(WIO_KEY_B),     button_handler_b,     FALLING);
    attachInterrupt(digitalPinToInterrupt(WIO_KEY_C),     button_handler_c,     FALLING);
}

void loop() {}
```

