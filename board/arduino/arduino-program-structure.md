---
sidebar_position: 4
authors: [luhuadong]
---

# Arduino 程序结构



本节我们学习 Arduino 的编程框架，并运行第一个 Arduino 程序。



## 程序框架

Arduino 使用 C/C++ 语言编写程序，但 Arduino 程序的结构与传统 C/C++ 的程序结构又有所不同 —— Arduino 程序中没有 main() 函数。

其实并不是 Arduino 程序没有 main() 函数，只是 main() 函数的定义隐藏在了 Arduino 的核心库文件中。用户在进行 Arduino 开发时一般不直接操作 main() 函数，而是使用 setup() 和 loop() 这两个函数。

![](https://static.getiot.tech/arduino-ide-mac.png#center)

Arduino 程序的基本结构由 setup() 和 loop() 两个函数组成。

- **setup()** 

  Arduino 控制器通电或复位后，即会开始执行 setup() 函数中的程序，该程序只会执行一次。通常在这里完成 Arduino 的初始化设置，如初始化变量、初始化串口、配置 I/O 状态、启用软件库等操作。

- **loop()** 

  setup() 函数中的程序执行完毕后，Arduino 会接着执行 loop() 函数中的程序，而 loop() 函数是一个死循环，其中的程序会不断地重复运行，使得 Arduino 可以不断工作。通常在这里完成程序的主要功能，如驱动各种模块和采集数据等。

```cpp showLineNumbers
void setup()
{
    /* 初始化函数，配置管脚、调用库函数 */
}

void loop()
{
    /* 连续执行函数内的语句 */
}
```

通常，一个编程风格良好的 Arduino 程序，会在程序的前几行添加注释，用于介绍该程序的作用及相关声明等。Arduino IDE 编写的代码被称为项目（sketch），当我们点击“保存”，文本编辑器中的项目将会以 .ino 的文件形式保存。



## Hello World

Arduino IDE 内置示例程序，包括基本的、数字的、模拟的、控制的、通信的、传感器的、字符串的、存储卡的、显示的、音频的、网络的示例等等。您可在菜单栏中选择“文件”->“示例”中找到它们。

Arduino 的第一个 Hello World 程序叫做 Blink，在 IDE 中选择“文件”->“示例”->“01. Basics”->“Blink”即可打开该示例程序。Blink 程序的功能是驱动 Arduino 控制板上的 LED 灯，并以打开一秒、关闭一秒的节奏不断闪烁。

```cpp showLineNumbers
/*
  Blink
  Turns an LED on for one second, then off for one second, repeatedly.
*/

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);                       // wait for a second
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);                       // wait for a second
}
```

这里的 LED_BUILTIN 是 Arduino 为方便我们编程预先定义好的常量，用于指向控制板内置 LED 引脚编号。不同控制板对应的值可能不一样，对于大部分 Arduino 控制板（包括 Arduino Uno）来说，该值为 13，对应 D13 数字接口。

```cpp showLineNumbers
#define LED_BUILTIN 13
```

首先，在 setup() 函数中，将 LED_BUILTIN 引脚初始化为输出状态。

```cpp showLineNumbers
pinMode(LED_BUILTIN, OUTPUT);
```

接着，在 loop() 主循环中，将 LED_BUILTIN 引脚电平拉高，点亮 LED 灯。

```cpp showLineNumbers
digitalWrite(LED_BUILTIN, HIGH);
```

延时 1 秒，再将 LED_BUILTIN 引脚电平拉低，熄灭 LED 灯。

```cpp showLineNumbers
delay(1000);
digitalWrite(LED_BUILTIN, LOW);
```

这样循环执行程序，我们就会看到 LED 灯不断闪烁。

除了使用 Arduino 控制板内置的 LED，您也可以像这样外接一个电阻和 LED 进行实验。您也可以将 LED 连接到其他数字接口，通过修改程序中的引脚编号，实现对 LED 灯的控制。

![](https://static.getiot.tech/arduino-blink-circuit.png#center)



## main 函数解析

虽然在开发 Arduino 程序时不需要关心 main 函数，但我们还是想看看 Arduino 的 main 函数长什么样。实际上，main 函数存在于 Arduino 核心库中，且仍然是整个程序的主入口。

在 Arduino 核心库中可见 main.cpp 文件，其内容如下：

```cpp showLineNumbers
#include <Arduino.h>

// Declared weak in Arduino.h to allow user redefinitions.
int atexit(void (* /*func*/ )()) { return 0; }

// Weak empty variant initialization function.
// May be redefined by variant files.
void initVariant() __attribute__((weak));
void initVariant() { }

void setupUSB() __attribute__((weak));
void setupUSB() { }

int main(void)
{
    init();

    initVariant();

#if defined(USBCON)
    USBDevice.attach();
#endif

    setup();

    for (;;) {
        loop();
        if (serialEventRun) serialEventRun();
    }

    return 0;
}
```

可以看到，Arduino 程序中编写的 setup 和 loop 函数，都在 main 函数中被默默调用了。

loop 函数的循环执行，是通过 for 循环实现的，且每次 loop 结束后，都会进行串口事件判断，也正是因为这种设计，串口事件不能实时响应。



