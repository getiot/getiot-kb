---
sidebar_position: 10
authors: [luhuadong]
---

# Arduino 软件串口



除了 HardwareSerial 类库，Arduino 还提供了 SoftwareSerial 类库，可将其他数字引脚通过程序来模拟成串口通信引脚（简称软串口）。

软串口给硬件受限的 Arduino 控制板提供了灵活的扩展能力，比如 Arduino UNO 及其他以 ATmega 328 为主控制器的 Arduino 硬件，只有 0 (RX) 和 1 (TX) 一组硬件串口，而这组串口又经常用于与计算机进行通信，如果使用这组硬件串口连接外部设备，会导致无法向 Arduino 下载程序，以及打印调试信息。因此，如果此时还需要连接其他串口设备，那么可以使用软件模拟串口来达到目的。



## 软串口的局限性

软串口是由软件模拟生成的，使用起来不如硬件串口稳定，并且受限于系统性能，波特率不宜设置太高。

软件串口通过 AVR 芯片的 PCINT 中断功能来实现，在 Arduino UNO 上，所有引脚都支持 PCINT 中断，因此所有引脚都可以设置为软串口的 RX 接收端。但在其他型号的 Arduino 上，并不是每个引脚都支持中断功能，所以只有特定的引脚可以设置为 RX 端。

- 在 Arduino MEGA 上能够被设置为 RX 的引脚有：10、11、12、13、50、51、52、53、62、63、64、65、66、67、68、69。
- 在 Arduino Leonardo 上能够被设置为 RX 的引脚有：8、9、10、11、14（MISO）、15（SCK）、16（MOSI）。

当需要连接多个串口设备时，可以建立多个软串口，但限于软串口的实现原理，使得 Arduino 同一时间只能监听一个软串口。解决办法是在需要切换监听时，使用 `listen()` 函数重新指定需要监听的设备，从而实现多个串口的监听。



## 软串口成员函数

软串口类库并非 Arduino Uno 核心类库，因此使用前你需要先声明包含 SoftwareSerial.h 头文件。 其中定义的成员函数与硬件串口类似，`available()`、`begin()`、`read()`、`write()`、`print()`、`println()`、`peek()` 等用法相同，这里便不一一列举。 此外软串口后还有如下成员函数：

### SoftwareSerial()

SoftwareSerial 类的构造函数，通过它可指定软串口 RX、TX 引脚。

语法： 

```cpp showLineNumbers
SoftwareSerial mySerial = SoftwareSerial(rxPin, txPin);
SoftwareSerial mySerial(rxPin, txPin);
```

参数：

- rxPin：软串口接收引脚
- txPin：软串口发送引脚

mySerial 为用户自定义的软件串口对象。

### listen()

开启软串口监听状态。 Arduino UNO 在同一时间仅能监听一个软串口，当你需要监听某一软串口时，需要该对象调用这个函数开启监听功能。 

语法：

```cpp showLineNumbers
mySerial.listen();
```

参数：无

返回值：无

### isListening()

监测软串口是否正在监听状态。 

语法： 

```cpp showLineNumbers
mySerial.isListening();
```

参数： 无

返回值：boolean 型，true 表示正在监听，false 表示没有监听

### end()

停止监听软串口。 

语法：

```cpp showLineNumbers
mySerial.end();
```

参数： 无

返回值：boolean 型，true 表示关闭监听成功，false 表示关闭监听失败

### overflow()

检测缓冲区是否溢出。 

语法：

```cpp showLineNumbers
mySerial.overflow();
```

参数：无

返回值：boolean 型，true 表示溢出，false 表示没有溢出



## 示例程序

```cpp showLineNumbers
/*
Arduino Uno 软串口通信
*/

#include <SoftwareSerial.h>

SoftwareSerial mySerial(2, 3);    // 创建软串口

void setup()
{
    Serial.begin(115200);
    while (!Serial) {}

    Serial.println("H: getiot.tech");    // 使用硬串口打印

    mySerial.begin(9600);
    mySerial.println("S: getiot.tech");  // 使用软串口打印
}

void loop()
{
    /* 从软串口接收数据，并输出到硬串口 */
    if (mySerial.available())
        Serial.write(mySerial.read());
  
    /* 从硬串口接收数据，并输出到软串口 */
    if (Serial.available())
        mySerial.write(Serial.read());
}
```

