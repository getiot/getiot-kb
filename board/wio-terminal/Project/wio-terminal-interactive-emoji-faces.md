---
sidebar_position: 4
slug: /wio-terminal-interactive-emoji-faces
---

# Wio Terminal 表情交互



![img](https://files.seeedstudio.com/wiki/Wio-Terminal/img/C0274.2019-11-26%2014_50_05.gif#center)

## Demo 概述

这个 Demo 的功能是在 Wio Terminal 上实现表情交互，实现的方式是在 LCD 屏幕上显示多张图片（例如眼睛和嘴巴），这些图片是 BMP 格式的，并且存储在 SD 卡中。为了增强交互效果，我们还使用 Wio Terminal 内置的按键和陀螺仪。

提示：图片可以在[这里](https://github.com/getiot/GetIoT_WioTerminal_Demo/tree/main/Emoji_face/face)下载，然后放在 SD 卡的 `face` 文件夹中。

**交互方式**：

- 左键：上一张图片（切换眼睛）
- 中键：动画
- 右键：下一张图片（切换眼睛）
- 陀螺仪：眼睛会随 Wio Terminal 的倾斜方向移动



## 安装依赖库

本示例 Demo 依赖 **LCD** 库、 **Linechart** 库和 **LIS3DHTR** 库：

- `LCD` 库在安装 *Seeed SAMD Boards* 库时已经包含了，大家可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- `FS` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_FS)下载，安装过程可参考 [Wio Terminal 文件系统](/wiot/wio-terminal-file-system/)。
- `LIS3DHTR` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_LIS3DHTR)下载，安装过程可参考 [Wio Terminal 惯量传感器](/wiot/wio-terminal-imu/)。

另外，本示例还依赖一个 `RawImage.h` 库，使用这个库可以使加载和显示图像更加容易，执行下面命令下载。

```bash
wget https://files.seeedstudio.com/wiki/Wio-Terminal/res/RawImage.h
```

**提示**：将 `RawImage.h` 添加到 Arduino 工程，可参考 [Wio Terminal LCD 加载图片](/wiot/wio-terminal-lcd-images/)。



## 功能实现

**初始化 LCD 显示屏**

```cpp showLineNumbers
TFT_eSPI tft;
 
void setup() {
  ...
    tft.begin();
    tft.setRotation(3);
  ...
}
```

**初始化 SD 卡**

```cpp showLineNumbers
void setup() {
  ...
    if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI)) {
      while (1);
  }
  ...
}
```

**初始化陀螺仪**

```cpp showLineNumbers
LIS3DHTR<TwoWire>  lis;
 
void setup () {
  ...
  lis.begin(Wire1);
  lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ); //Output rate of Accelerator
  lis.setFullScaleRange(LIS3DHTR_RANGE_2G); //Scale selection
  ...
}
 
void loop() {
  ...
  float x_raw = lis.getAccelerationX(); //Read the raw x-axis values of acc
  float y_raw = lis.getAccelerationY(); //Read the raw y-axis values of acc
  ...
}
```

**初始化按键**

```cpp showLineNumbers
void setup() {
  ...
  pinMode(BUTTON_1, INPUT); //left button
  pinMode(BUTTON_2, INPUT); //middle button
  pinMode(BUTTON_3, INPUT); //right button
  ...
}
```

**初始化图片变量和绘图**

由于图片不是 320x240 的全尺寸，所以在绘图时，需要指定图片的开始位置。为避免摇晃 Wio Terminal 造成图片滞后，应先将图片加载到缓冲区中。（可参考 [Wio Terminal LCD 加载图片](/wiot/wio-terminal-lcd-images/)）

```cpp showLineNumbers
void loop() {
  ...
  Raw8 * eyes = newImage<uint8_t>(eye[eye_count]); //initilising 8-bit images
  writeToBuffer(x_axis, y_axis, eyes); //writing to buffer first, see full code to check this function
  ...
}
```



## 完整代码

```cpp showLineNumbers
#ifdef KENDRYTE_K210
#include <SPIClass.h>
#else
#include <SPI.h>
#endif

#include<string.h>
#include "Seeed_FS.h"
#include"LIS3DHTR.h"
#include"TFT_eSPI.h"
#include"RawImage.h"

LIS3DHTR<TwoWire>  lis;
TFT_eSPI tft;

#define debug(...)        //Serial.printf(__VA_ARGS__);
#define debug_begin(baud) //Serial.begin(baud); while (!Serial);
#define screen_height   240
#define screen_width    320

uint8_t raw[screen_height * screen_width];

void writeToBuffer(int x, int y, Raw8 * img) {
  // debug("%p\n", img);
  // debug("%d, %d\n", img->width, img->height);
  for (int j = y; j < y + img->height(); j++) {
    for (int i = x; i < x + img->width(); i++) {
      raw[j * screen_width + i] = img->get(i - x, j - y);
    }
  }
}

void clearBuffer() {
  memset(raw, 0, sizeof(raw));
}

void flushBuffer() {
  tft.pushImage(0, 0, tft.width(), tft.height(), raw);
}

bool flag_left = false;
void button_handler_left() {
  flag_left = true;
}

bool flag_middle = false;
void button_handler_middle() {
  flag_middle = true;
}

bool flag_right = false;
void button_handler_right() {
  flag_right = true;
}

#define FILLTER_N 20
int filter(int16_t val) {
  int32_t filter_sum = 0;
  for (uint8_t i = 0; i < FILLTER_N; i++) {
    filter_sum += val;
    delay(1);
  }
  return (int)(filter_sum / FILLTER_N);
}

const char* face[] = {"face/defaultface.bmp", "face/face0.bmp", "face/face1.bmp", "face/face2.bmp", "face/face3.bmp"};

const char* eye[] = {"face/cool.bmp", "face/happy.bmp", "face/heart.bmp", "face/robot.bmp", "face/sad.bmp",
                     "face/star.bmp", "face/cross.bmp", "face/kaws.bmp", "face/red.bmp"
                    };

void setup() {
  debug_begin(115200);
  pinMode(BUTTON_1, INPUT);
  pinMode(BUTTON_2, INPUT);
  pinMode(BUTTON_3, INPUT);
  attachInterrupt(digitalPinToInterrupt(BUTTON_1), button_handler_left, FALLING);
  attachInterrupt(digitalPinToInterrupt(BUTTON_2), button_handler_middle, FALLING);
  attachInterrupt(digitalPinToInterrupt(BUTTON_3), button_handler_right, FALLING);
  if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI, 16000000)) {
    while (1);
  }
  
  tft.begin();
  tft.setRotation(3);

  tft.fillScreen(TFT_BLACK);

  lis.begin(Wire1);
  lis.setOutputDataRate(LIS3DHTR_DATARATE_25HZ);
  lis.setFullScaleRange(LIS3DHTR_RANGE_2G);
}

int8_t eye_count = 0;

void loop() {
  float x_raw = lis.getAccelerationX();
  float y_raw = lis.getAccelerationY();

  int16_t x_value = 100 * x_raw;
  int16_t y_value = 100 * y_raw;

  delay(30);

  int16_t x_axis = map(filter(x_value), -15, 15, 73, 77); // mapped x-axis
  int16_t y_axis = map(filter(y_value), -15, 15, 53, 57); // mapped y-axis

  Raw8 * eyes = newImage<uint8_t>(eye[eye_count]);
  writeToBuffer(x_axis, y_axis, eyes);
  writeToBuffer(x_axis + 120, y_axis, eyes);
  delete[] eyes;

  Raw8 * mouth = newImage<uint8_t>("face/mouth.bmp");
  writeToBuffer(112, 175, mouth);
  delete[] mouth;
  flushBuffer();
  clearBuffer();

  if (flag_left) {
    flag_left = false;
    eye_count++;
    if (eye_count == 9) eye_count = 0;
  }
  if (flag_right) {
    flag_right = false;
    eye_count--;
    if (eye_count == -1) eye_count = 8;
  }

  if (flag_middle) {
    flag_middle = false;
    for (uint8_t cnt = 1; cnt < 5; cnt++) {
      drawImage<uint8_t>(face[cnt], 75, 55);
    }
  }
}
```

GitHub 仓库：[GetIoT_WioTerminal_Demo/Emoji_face](https://github.com/getiot/GetIoT_WioTerminal_Demo/tree/main/Emoji_face)

