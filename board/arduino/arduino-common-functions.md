---
sidebar_position: 8
authors: [luhuadong]
---

# Arduino 常用函数



Arduino 编程语言是建立在 C/C++ 语言基础上的，即以 C/C++ 语言为基础，把 AVR 单片机（微控制器）相关的一些寄存器参数设置等进行函数化，以利于开发者更加快速地使用。其主要使用的函数包括数字 I/O 引脚操作函数、模拟 I/O 引脚操作函数、高级 I/O 引脚操作函数、时间函数、中断函数、串口通信函数和数学函数等等。



## 数字 I/O 函数

**数字 IO 口输入输出模式定义函数**

```cpp showLineNumbers
void pinMode(pin, mode);
```

pin 表示为 0~13，mode 表示为 INPUT 或 OUTPUT。



**数字 IO 口输出电平定义函数**

```cpp showLineNumbers
void digitalWrite(pin, value);
```

pin 表示为 0~13，value 表示为 HIGH 或 LOW。比如定义 HIGH 可以驱动 LED。



**数字 IO 口读输入电平函数**

```cpp showLineNumbers
int digitalRead(pin);
```

pin 表示为 0~13，value 表示为 HIGH 或 LOW。比如可以读数字传感器。



## 模拟 I/O 函数

**模拟 IO 口读函数**

```cpp showLineNumbers
int analogRead(pin);
```

pin 表示为 0~5（Arduino Diecimila 为 0~5，Arduino nano 为 0~7）.比如可以读模拟传感器（10位 AD，0~5V 表示为 0~1023）。



**PWM 数字 IO 口 PWM 输出函数**

```cpp showLineNumbers
void analogWrite(pin, value);
```

Arduino 数字 IO 口标注了 PWM 的 IO 口可使用该函数，pin 表示 3,5,6,9,10,11，value 表示为 0~255。比如可用于电机 PWM 调速或音乐播放。



**设置 ADC 参考电压**

```cpp showLineNumbers
void analogReference(type);
```



## 高级 I/O 函数

**调声函数**

```cpp showLineNumbers
void tone(pin, frequency);
void tone(pin, frequency, duration);
void noTone(pin);
```



**脉冲宽度测量函数**

```cpp showLineNumbers
int pulseIn(pin, value);
int pulseIn(pin, value, timeout);
```



## 中断函数

**设置外部中断**

对中断引脚进行初始化配置

```cpp showLineNumbers
void attachInterrupt(interrupt, function, mode);
```



**禁用外部中断**

```cpp showLineNumbers
void detachInterrupt (uint8_t interruptNum) 
```



另外，Arduino 还定义了两个开中断和关中断的宏。

```cpp showLineNumbers
#define interrupts()   sei()
#define noInterrupts() cli()
```



## 时间函数

**延时函数（单位 ms）**

```cpp showLineNumbers
void delay(ms);
```



**延时函数（单位 μs）**

```cpp showLineNumbers
void delayMicroseconds(us);
```



**返回时间（毫秒）**

```cpp showLineNumbers
uint32_t mills(void);
```



**返回时间（微秒）**

```cpp showLineNumbers
uint32_t micros(void);
```

这两个函数用于得到从程序开始运行以来的时间，`mills()` 函数返回以毫秒表示的时间，而 `micros()` 函数返回以微秒表示的时间。当计时溢出后会自动从零开始计数，`mills()` 函数会在程序运行约 50 天后溢出，而 `micros()` 会在程序运行约 70 分钟后溢出。



## 数字函数

**求最小值**

```cpp showLineNumbers
min(x, y);
```



**求最大值**

```cpp showLineNumbers
max(x, y);
```



**计算绝对值**

```cpp showLineNumbers
abs(x)
```



**约束函数**，下限 a，上限 b，x 必须在 ab 之间才能返回。

```cpp showLineNumbers
constrain(x, a, b)
```



**约束函数**，value 必须在 fromLow 与 toLow 之间和 fromHigh 与 toHigh 之间。

```cpp showLineNumbers
map(value, fromLow, fromHigh, toLow, toHigh)
```



**开方函数**，base 的 exponent 次方

```cpp showLineNumbers
pow(base, exponent)
```



**平方**

```cpp showLineNumbers
sq(x)
```



**开根号**

```cpp showLineNumbers
sqrt(x)
```

