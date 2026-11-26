---
sidebar_position: 14
authors: [luhuadong]
---

# Arduino 按键消抖

![](https://static.getiot.tech/switch-debounce.png#center)

本文主要介绍在 Arduino 中消除按键抖动的几种方法，包括常见的延时判断，以及一些库的使用。

由于物理性质和机械特性等原因，矩阵按键经常在按下后的一小段时间产生不定状态，这很可能被程序误认为在短时间内进行了多次按键操作。因此，在使用矩阵按键时，如果没有硬件消抖的措施，软件消抖是必不可少的，否则可能会产生不可预期的效果！



## 延时判断

延时判断就是通过在一小段间隔时间后再次读取按键状态的方式，来确保按键确实是完全被按下了，简单来说就是屏蔽掉发生按键抖动的时间段。在 Arduino 中可以使用 `millis()` 函数来算得按键按下后经过的时间。

下面示例代码通过延时判断去除按键抖动，并控制 LED 灯翻转。你可能需要根据 Arduino 开发板的硬件情况，修改引脚和有效电平状态。

```cpp showLineNumbers
const int buttonPin = 2;    // 连接矩阵按键的引脚
const int ledPin = 13;      // LED引脚

int ledState = HIGH;         // 记录LED的状态
int buttonState;             // 记录按键的状态
int lastButtonState = LOW;   // 上一次按键的状态

// 以下代码以long类型声明，因为时间值以毫秒为单位(用整型会很快溢出)
long lastDebounceTime = 0;  // 按键最后一次被触发
long debounceDelay = 50;    // 为了滤去抖动暂停的时间，如果发现输出不正常增加这个值

void setup() {
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);

  // 设置LED初始状态
  digitalWrite(ledPin, ledState);
}

void loop() {
  // 读取按键状态并存储到变量中
  int reading = digitalRead(buttonPin);

  // 检查下按键状态是否改变(换句话说，输入是否是从 LOW 到 HIGH)
  // 检查是否距离上一次按下的时间已经足够滤去按键抖动
  
  if (reading != lastButtonState) {  // 如果按键状态和上次不同
    lastDebounceTime = millis();     // 记录初始时间
  }

  // 离初始时间已经过了按键抖动出现的时间，因此当前的按键状态是稳定状态
  if ((millis() - lastDebounceTime) > debounceDelay) {
    
    if (reading != buttonState) {  // 如果按键状态改变了
      buttonState = reading;

      if (buttonState == HIGH) {   // 只有当按键状态稳定为 HIGH 时才打开 LED
        ledState = !ledState;
      }
    }
  }

  digitalWrite(ledPin, ledState);  // 设置LED
  lastButtonState = reading;       // 保存处理结果
}
```



## Bounce2 库

[Bounce2](https://github.com/thomasfredericks/Bounce2) 库是 Thomas O Fredericks 编写的一个专用于机械按钮和开关消抖的软件库。

这个库包含三个类：

- Debouncer：执行实际去抖动的代码。只有高级用户会关心这个类，一般用户不需要关心。
- Bounce：这是通用库。它的底层由 Debouncer 实现。
- Button：基于 Bounce 类，专用于按下（pressed）按钮。

使用该库需要预先安装，并载入头文件：

```cpp showLineNumbers
#include <Bounce2.h>
```



### Bounce 示例

下面示例代码通过 Bounce 类实现按键消抖，当按下按钮（pin 2）时翻转 LED 灯（pin 13）状态。你可能需要根据 Arduino 开发板的硬件情况，修改引脚和有效电平状态。

```cpp showLineNumbers
#include <Bounce2.h>

#define BUTTON_PIN 2
#define LED_PIN 13

int ledState = LOW;


Bounce b = Bounce(); // Instantiate a Bounce object

void setup() {
  
  b.attach(BUTTON_PIN,INPUT_PULLUP); // Attach the debouncer to a pin with INPUT_PULLUP mode
  b.interval(25); // Use a debounce interval of 25 milliseconds
  
  
  pinMode(LED_PIN,OUTPUT); // Setup the LED
  digitalWrite(LED_PIN,ledState); // Turn off the LED
 
}

void loop() {

   b.update(); // Update the Bounce instance
   
   if ( b.fell() ) {  // Call code if button transitions from HIGH to LOW
     ledState = !ledState; // Toggle LED state
     digitalWrite(LED_PIN,ledState); // Apply new LED state
   }
}
```



### Button 示例

下面示例代码通过 Button 类实现按键消抖，当按下按钮（pin 39）时翻转 LED 灯（pin 13）状态。你可能需要根据 Arduino 开发板的硬件情况，修改引脚和有效电平状态。

```cpp showLineNumbers
#include <Bounce2.h>

// INSTANTIATE A Button OBJECT
Bounce2::Button button = Bounce2::Button();

// WE WILL attach() THE BUTTON TO THE FOLLOWING PIN IN setup()
#define BUTTON_PIN 39 

// DEFINE THE PIN FOR THE LED :
// 1) SOME BOARDS HAVE A DEFAULT LED (LED_BUILTIN)
//#define LED_PIN LED_BUILTIN
// 2) OTHERWISE SET YOUR OWN PIN
#define LED_PIN 13

// SET A VARIABLE TO STORE THE LED STATE
bool ledState = LOW;

void setup() {

  // BUTTON SETUP 
  
  // SELECT ONE OF THE FOLLOWING :
  // 1) IF YOUR BUTTON HAS AN INTERNAL PULL-UP
  // button.attach( BUTTON_PIN ,  INPUT_PULLUP ); // USE INTERNAL PULL-UP
  // 2) IF YOUR BUTTON USES AN EXTERNAL PULL-UP
  button.attach( BUTTON_PIN, INPUT ); // USE EXTERNAL PULL-UP

  // DEBOUNCE INTERVAL IN MILLISECONDS
  button.interval(5); 

  // INDICATE THAT THE LOW STATE CORRESPONDS TO PHYSICALLY PRESSING THE BUTTON
  button.setPressedState(LOW); 
  
  // LED SETUP
  pinMode(LED_PIN,OUTPUT);
  digitalWrite(LED_PIN,ledState);

}

void loop() {
  // UPDATE THE BUTTON
  // YOU MUST CALL THIS EVERY LOOP
  button.update();

  if ( button.pressed() ) {
    
    // TOGGLE THE LED STATE : 
    ledState = !ledState; // SET ledState TO THE OPPOSITE OF ledState
    digitalWrite(LED_PIN,ledState);

  }
}
```

