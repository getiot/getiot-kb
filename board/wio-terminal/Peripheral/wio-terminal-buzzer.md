---
sidebar_position: 7
slug: /wio-terminal-buzzer
---

# Wio Terminal 蜂鸣器



Wio Terminal 内置了一个压电蜂鸣器（Piezo Buzzer），压电陶瓷可以连接到模拟脉宽调制（PWM）输出以产生各种音调和效果！

**提示**：蜂鸣器位于 Wio Terminal 正面的左下角。



## 电路原理图

下图是 Wio Terminal 中蜂鸣器的电路原理图，它通过一个 IO 引脚（`BUZZER_CTL`）与主控制器 SAMD51 相连。

![](https://static.getiot.tech/wio-terminal-SCH-Buzzer.png#center)



## 引脚定义

在 `variant.h` 中定义了蜂鸣器的控制引脚 `WIO_BUZZER`，另一种风格是 `BUZZER_CTR`。

```cpp showLineNumbers
/*
 * BUZZER_CTR
 */
#define BUZZER_CTR (12ul)
#define WIO_BUZZER (12ul)
```



## 驱动蜂鸣器

Wio Terminal 的内置蜂鸣器是一个无源蜂鸣器，也就是说可以给它一个模拟信号或者 PWM 信号来触发和输出声音。下面示例使用模拟输出让蜂鸣器发出声音。

```cpp showLineNumbers
void setup() 
{
    pinMode(WIO_BUZZER, OUTPUT);
}

void loop() 
{
    analogWrite(WIO_BUZZER, 128);
    delay(1000);
    analogWrite(WIO_BUZZER, 0);
    delay(1000);
}
```

**提示**：要产生默认的蜂鸣器声音，建议使用较低的电压驱动蜂鸣器。



## 音调控制示例

下面示例使用蜂鸣器播放一段旋律。原理是向蜂鸣器发送适当频率的方波，从而产生相应的音调。

```cpp showLineNumbers
/* Macro Define */
#define BUZZER_PIN WIO_BUZZER /* sig pin of the buzzer */
 
int length = 15;         /* the number of notes */
char notes[] = "ccggaagffeeddc ";
int beats[] = { 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 4 };
int tempo = 300;
 
void setup() {
    //set buzzer pin as output
    pinMode(BUZZER_PIN, OUTPUT);
}
 
void loop() {
    for(int i = 0; i < length; i++) {
        if(notes[i] == ' ') {
            delay(beats[i] * tempo);
        } else {
            playNote(notes[i], beats[i] * tempo);
        }
        delay(tempo / 2);    /* delay between notes */
    }
 
}
 
//Play tone
void playTone(int tone, int duration) {
    for (long i = 0; i < duration * 1000L; i += tone * 2) {
        digitalWrite(BUZZER_PIN, HIGH);
        delayMicroseconds(tone);
        digitalWrite(BUZZER_PIN, LOW);
        delayMicroseconds(tone);
    }
}
 
void playNote(char note, int duration) {
    char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
    int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
 
    // play the tone corresponding to the note name
    for (int i = 0; i < 8; i++) {
        if (names[i] == note) {
            playTone(tones[i], duration);
        }
    }
}
```

