---
sidebar_position: 5
slug: /wio-terminal-infrared-emitter
---

# Wio Terminal 红外发射器



Wio Terminal 内置了一个红外线发射器（Infrared Emitter），该红外发射器通过一个数字接口连接主控制器，我们可以它来发送红外信号，就像遥控器一样！

**提示**：红外线发射器位于 Wio Terminal 的背面，在 microSD card 插槽的左边。



## 电路原理图

下图是 Wio Terminal 中红外线发射器的电路原理图，它通过一个数字引脚（`IR_CTL`）与主控制器 SAMD51 相连。

![](https://static.getiot.tech/wio-terminal-Infrared-Emitter.png#center)



## 安装依赖库

首先需要为 Wio Terminal 安装红外线（Infrared）库 `Seeed_Arduino_IR`。

1、在 `Seeed_Arduino_IR` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_IR) 下载 zip 包。

2、然后将 `Seeed_Arduino_IR` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Seeed_Arduino_IR.zip 文件。



## 引脚定义

在 `variant.h` 中定义了红外线发射器的控制引脚 `WIO_IR`。

```cpp showLineNumbers
/*
 * ir sensor
 */
#define WIO_IR  (14ul)
```



## 示例代码

打开 Arduino IDE，点击 *Files -> Examples -> IRLib2 -> Send* 打开红外发送示例。为了完成这个实验，你还需要一个红外线接收器，比如 [Grove Infrared Receiver](https://wiki.seeedstudio.com/Grove-Infrared_Receiver/)。

这个功能很有趣，稍作修改，你就可以将 Wio Terminal 作为你的电视遥控器了！

完整示例代码如下：

```cpp showLineNumbers
/* send.ino Example sketch for IRLib2
 *  Illustrates how to send a code.
 */
#include <IRLibSendBase.h>    // First include the send base
//Now include only the protocols you wish to actually use.
//The lowest numbered protocol should be first but remainder 
//can be any order.
#include <IRLib_P01_NEC.h>
#include <IRLib_P02_Sony.h>
#include <IRLibCombo.h>     // After all protocols, include this
// All of the above automatically creates a universal sending
// class called "IRsend" containing only the protocols you want.
// Now declare an instance of that sender.
 
IRsend mySender;
 
void setup() {
  Serial.begin(9600);
  delay(2000); while (!Serial); //delay for Leonardo
  Serial.println(F("Every time you press a key is a serial monitor we will send."));
}
 
void loop() {
  if (Serial.read() != -1) {
  //   send a code every time a character is received from the 
  //   serial port. You could modify this sketch to send when you
  //   push a button connected to an digital input pin.
  //   Substitute values and protocols in the following statement
  //   for device you have available.
  //  mySender.send(SONY,0xa8bca, 20);//Sony DVD power A8BCA, 20 bits
    mySender.send(NEC,0x61a0f00f,0);//NEC TV power button=0x61a0f00f
    Serial.println(F("Sent signal."));
  }
}
```



## 运行效果

![Wio Terminal 红外发射示例](https://files.seeedstudio.com/wiki/Wio-Terminal/img/Wio-Terminal-IR.gif#center)



