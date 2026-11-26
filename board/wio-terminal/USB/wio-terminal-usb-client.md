---
sidebar_position: 2
slug: /wio-terminal-usb-client
---

# Wio Terminal USB 从设备



本文主要介绍如何将 Wio-Terminal 用作一个 USB 从设备（USB-Client），例如将其用作键盘、鼠标等人机接口设备（HID），以及用作乐器数字接口设备（MIDI）。



## 安装依赖库

首先需要为 Wio Terminal 安装 TinyUSB 库 `Adafruit_TinyUSB_Arduino`。

1、在 `Adafruit_TinyUSB_Arduino` 的 [GitHub 仓库](https://github.com/adafruit/Adafruit_TinyUSB_Arduino) 下载 zip 包。

2、然后将 `Adafruit_TinyUSB_Arduino` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Adafruit_TinyUSB_Arduino.zip 文件。



## 将 Wio Terminal 用作键盘

Wio Terminal 上有三个按键，本示例将这三个按键映射成 `i`、`o`、`t` 三个字母键，当你按下它们时，就相当于按下你的实际键盘一样。这个功能可以轻松实现到你的设计中，帮助你未来完成更具挑战的任务。

### 安装依赖库

为了完成任务，我们还需要为 Wio Terminal 安装 Keyboard 库。

1、在 `Arduino Keyboard Library` 的 [GitHub 仓库](https://github.com/arduino-libraries/Keyboard) 下载 zip 包。

2、然后将 `Arduino Keyboard Library` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Keyboard.zip 文件。



### 完整代码

关于 USB Keyboard 的更多功能和玩法，请参考 Arduino 官方文档 [keyboard functions](https://www.arduino.cc/reference/en/language/functions/usb/keyboard/)。

```cpp showLineNumbers
#include "Keyboard.h" //keyboard library 

void setup() { 
  //set button pins as inputs
  pinMode(WIO_KEY_A, INPUT);
  pinMode(WIO_KEY_B, INPUT);
  pinMode(WIO_KEY_C, INPUT);
 
  Keyboard.begin(); //start keyboard communication
}

void loop() {
  if (digitalRead(WIO_KEY_A) == LOW) { //detect button press
    Keyboard.write('t'); //single key is pressed (character) 
  }
  if (digitalRead(WIO_KEY_B) == LOW) {   
    Keyboard.write('o'); 
  }  
  if (digitalRead(WIO_KEY_C) == LOW) {        
    Keyboard.write('i');  
  } 

  delay(200); //delay between keypresses
}
```



## 将 Wio Terminal 用作鼠标

Wio Terminal 上有一个五向开关，本示例将这个五向开关模拟成鼠标移动，例如向上、向下、向左和向右。 此外，鼠标左键/右键单击、上/下滚动也可以实现。



### 安装依赖库

为了完成任务，我们还需要为 Wio Terminal 安装 Mouse 库。

1、在 `Arduino Mouse Library` 的 [GitHub 仓库](https://github.com/arduino-libraries/Mouse) 下载 zip 包。

2、然后将 `Arduino Mouse Library` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Mouse.zip 文件。



### 完整代码

关于 USB Mouse 的更多功能和玩法，请参考 Arduino 官方文档 [mouse functions](https://www.arduino.cc/reference/en/language/functions/usb/mouse/)。

```cpp showLineNumbers
/*    
 * A demo for Wio Terminal to simulate mouse by buttons.
 * Such as Mouse Up, Mouse Down, Mouse Left, Mouse Right,
 * Click the left mouse button, Click the right mouse button, 
 * Up roll, Down roll and etc.
 *   
 * Copyright (c) 2020 seeed technology co., ltd.  
 * Author      : weihong.cai (weihong.cai@seeed.cc)  
 * Create Time : July 2020
 * Change Log  : 
 *
 * The MIT License (MIT)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software istm
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS INcommInterface
 * THE SOFTWARE.
 * 
 * Usage(in Wio Terminal):
 *    Press the WIO_5S_UP    --------------------> Mouse Up
 *    Press the WIO_5S_DOWN  --------------------> Mouse Down
 *    Press the WIO_5S_LEFT  --------------------> Mouse Left
 *    Press the WIO_5S_RIGHT --------------------> Mouse Right
 *    Press the BUTTON_3 ------------------------> Click the left mouse button
 *    Press the BUTTON_2 ------------------------> Click the right mouse button    
 *    Press the WIO_5S_PRESS and WIO_5S_UP   ----> Up roll
 *    Press the WIO_5S_PRESS and WIO_5S_DOWN ----> Down roll
 * 
 * Some tips:
 * 1. If your PC unables to recognize USB device leading the Wio Terminal can’t work. 
 *    You can solve this problem through updating your ArduinoCore.
 *    Please follow this: https://forum.seeedstudio.com/t/seeeduino-xiao-cant-simulate-keys-pressed/252819/6?u=weihong.cai
 * 
 * You can know more about the Wio Terminal from: https://wiki.seeedstudio.com/Wio-Terminal-Getting-Started/
 * If you have any questions, you can leave a message on the forum: https://forum.seeedstudio.com
 */
 
#include "Mouse.h"
 
/*----------------define the button pins---------------------------*/ 
const int upButton        = WIO_5S_UP;
const int downButton      = WIO_5S_DOWN;
const int leftButton      = WIO_5S_LEFT;
const int rightButton     = WIO_5S_RIGHT;
const int mouseWheel      = WIO_5S_PRESS;
const int mouseBttonLeft  = BUTTON_3;
const int mouseBttonRight = BUTTON_2;
 
  // output range of X or Y movement; affects movement speed          
int range = 2;
 
  // response delay of the mouse, in ms
int responseDelay = 5;
 
  // the time record paramas
unsigned long _currentMillis;
unsigned long _previousMillis;
 
void setup() {
  // initialize the buttons' inputs:
  pinMode(upButton,         INPUT);
  pinMode(downButton,       INPUT);
  pinMode(leftButton,       INPUT);
  pinMode(rightButton,      INPUT);
  pinMode(mouseWheel,       INPUT);
  pinMode(mouseBttonLeft,   INPUT);
  pinMode(mouseBttonRight,  INPUT);
 
  // initialize mouse control:
  Mouse.begin();
}
 
void loop() {
  // read the button state:
  int upState                     = digitalRead(upButton);
  int downState                   = digitalRead(downButton);
  int rightState                  = digitalRead(rightButton);
  int leftState                   = digitalRead(leftButton);
  int clickState_mouseWheel       = digitalRead(mouseWheel);
  int clickState_mouseButtonLeft  = digitalRead(mouseBttonLeft);
  int clickState_mouseButtonRight = digitalRead(mouseBttonRight);
 
  // calculate the movement distance based on the button states:
  int  xDistance = (leftState - rightState) * range;
  int  yDistance = (upState   - downState)  * range;
 
/*------------------Mouse Move--------------------------------------*/
  // if X or Y is non-zero, move:
  if ((xDistance != 0) || (yDistance != 0)) {
    Mouse.move(xDistance, yDistance, 0);
  }
 
/*-------------Mouse Button Left Click------------------------------*/
  // if the mouse button left is pressed:
  if (clickState_mouseButtonLeft == LOW) {
    // if the mouse is not pressed, press it:
    if (!Mouse.isPressed(MOUSE_LEFT)) {
      Mouse.press(MOUSE_LEFT);
      //Mouse.click(MOUSE_LEFT);
    }
  }
  // else the mouse button left is not pressed:
  else {
    // if the mouse is pressed, release it:
    if (Mouse.isPressed(MOUSE_LEFT)) {
      Mouse.release(MOUSE_LEFT);
    }
  }
 
/*-------------Mouse Button Right Click-----------------------------*/
    // if the mouse button right is pressed:
  if (clickState_mouseButtonRight == LOW) {
    // if the mouse is not pressed, press it:
    if (!Mouse.isPressed(MOUSE_RIGHT)) {
      Mouse.press(MOUSE_RIGHT);
      //Mouse.click(MOUSE_RIGHT);
    }
  }
  // else the mouse button right is not pressed:
  else {
    // if the mouse is pressed, release it:
    if (Mouse.isPressed(MOUSE_RIGHT)) {
      Mouse.release(MOUSE_RIGHT);
    }
  }
 
/*------------------Up roll----------------------------------------*/
  if ((upState == LOW) && (clickState_mouseWheel == LOW)) {
    Mouse.move(0, 0, 1);
    My_delay(200);
  }
 
/*------------------Down roll--------------------------------------*/
  if ((downState == LOW) && (clickState_mouseWheel == LOW)) {
    Mouse.move(0, 0, -1);
    My_delay(200);
  }
 
/*-----------------------------------------------------------------*/ 
  // a delay so the mouse doesn't move too fast:
  My_delay(responseDelay);
}
 
// a delay function uses millis()
void My_delay(int Time)
{
  while((_currentMillis - _previousMillis) <= Time)
  {
      _currentMillis = millis();
  }
  _previousMillis = _currentMillis; 
}
```



## 将 Wio Terminal 用作 MIDI 设备

接下来这个示例，将介绍如何将 Wio Terminal 用作 USB MIDI（乐器数字接口）设备，它可以用来控制乐器！

本示例，我们将 Wio Terminal 连接到 Macbook 并使用 macOS 附带的“音频 MIDI 设置”（Audio MIDI Setup）应用程序进行测试。同时还可以在 Arduino IDE 中查看串行监视器中打印的数据。如果你有可用的 MIDI 设备，可以修改示例代码以获得更逼真的场景！

![将 Wio Terminal 用作 MIDI 设备](https://files.seeedstudio.com/wiki/Wio-Terminal/img/20200110105918.gif#center)



### 安装依赖库

为了完成任务，我们还需要为 Wio Terminal 安装 MIDI 库 `arduino_midi_library`。

1、在 `Arduino MIDI Library` 的 [GitHub 仓库](https://github.com/FortySevenEffects/arduino_midi_library) 下载 zip 包。

2、然后将 `Arduino MIDI Library` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 arduino_midi_library.zip 文件。



### 完整代码

```cpp showLineNumbers
#include <Arduino.h>
#include <Adafruit_TinyUSB.h>
#include <MIDI.h>
 
// USB MIDI object
Adafruit_USBD_MIDI usb_midi;
 
// Create a new instance of the Arduino MIDI Library,
// and attach usb_midi as the transport.
MIDI_CREATE_INSTANCE(Adafruit_USBD_MIDI, usb_midi, MIDI);
 
// Variable that holds the current position in the sequence.
uint32_t position = 0;
 
// Store example melody as an array of note values
byte note_sequence[] = {
  74,78,81,86,90,93,98,102,57,61,66,69,73,78,81,85,88,92,97,100,97,92,88,85,81,78,
  74,69,66,62,57,62,66,69,74,78,81,86,90,93,97,102,97,93,90,85,81,78,73,68,64,61,
  56,61,64,68,74,78,81,86,90,93,98,102
};
 
void setup()
{
  pinMode(LED_BUILTIN, OUTPUT);
 
  // Initialize MIDI, and listen to all MIDI channels
  // This will also call usb_midi's begin()
  MIDI.begin(MIDI_CHANNEL_OMNI);
 
  // Attach the handleNoteOn function to the MIDI Library. It will
  // be called whenever the Bluefruit receives MIDI Note On messages.
  MIDI.setHandleNoteOn(handleNoteOn);
 
  // Do the same for MIDI Note Off messages.
  MIDI.setHandleNoteOff(handleNoteOff);
 
  Serial.begin(115200);
 
  // wait until device mounted
  while( !USBDevice.mounted() ) delay(1);
}
 
void loop()
{
  static uint32_t start_ms = 0;
  if ( millis() - start_ms > 266 )
  {
    start_ms += 266;
 
    // Setup variables for the current and previous
    // positions in the note sequence.
    int previous = position - 1;
 
    // If we currently are at position 0, set the
    // previous position to the last note in the sequence.
    if (previous < 0) {
      previous = sizeof(note_sequence) - 1;
    }
 
    // Send Note On for current position at full velocity (127) on channel 1.
    MIDI.sendNoteOn(note_sequence[position], 127, 1);
 
    // Send Note Off for previous note.
    MIDI.sendNoteOff(note_sequence[previous], 0, 1);
 
    // Increment position
    position++;
 
    // If we are at the end of the sequence, start over.
    if (position >= sizeof(note_sequence)) {
      position = 0;
    }
  }
 
  // read any new MIDI messages
  MIDI.read();  
}
 
void handleNoteOn(byte channel, byte pitch, byte velocity)
{
  // Log when a note is pressed.
  Serial.printf("Note on: channel = %d, pitch = %d, velocity - %d", channel, pitch, velocity);
  Serial.println();
}
 
void handleNoteOff(byte channel, byte pitch, byte velocity)
{
  // Log when a note is released.
  Serial.printf("Note off: channel = %d, pitch = %d, velocity - %d", channel, pitch, velocity);
  Serial.println();
}
```

