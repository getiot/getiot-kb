---
sidebar_position: 3
slug: /wio-terminal-displaying-photos
---

# Wio Terminal 电子相册



![img](https://files.seeedstudio.com/wiki/Wio-Terminal/img/products.2019-11-26%2017_40_45.gif#center)

## Demo 概述

本 Demo 将 Wio Terminal 变成一台电子相册，将保存在 SD 卡上的图片显示在 LCD 显示屏上，支持循环播放，也支持按键切换图片。

在开始之前，我们需要准备一张 SD 卡，容量不大于 16 GB，文件系统格式为 FAT32。然后在 SD 卡中创建一个 `photos` 文件夹，复制一些喜欢的图片进去。

**提示**：Wio Terminal 对图片的大小和格式有要求，参考 [Wio Terminal LCD 加载图片](/wiot/wio-terminal-lcd-images/)。

另外，我们定义两个按键功能，按左键播放上一张图片，按右键播放下一张图片。

**重点难点**

- 从 SD 卡读取图片；
- 实现循环浏览图片；



## 安装依赖库

本示例 Demo 依赖 **LCD** 库和 **FS** 库：

- `LCD` 库在安装 *Seeed SAMD Boards* 库时已经包含了，可以参考 [Wio Terminal 开发环境](/wiot/wio-terminal-development-environment/)。
- `FS` 库可以在 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_FS)下载，安装过程可参考 [Wio Terminal 文件系统](/wiot/wio-terminal-file-system/)。

另外，本示例还依赖一个 `RawImage.h` 库，使用这个库可以使加载和显示图像更加容易，执行下面命令下载。

```bash
wget https://files.seeedstudio.com/wiki/Wio-Terminal/res/RawImage.h
```

**提示**：将 `RawImage.h` 添加到 Arduino 工程，可参考 [Wio Terminal LCD 加载图片](/wiot/wio-terminal-lcd-images/)。



## 功能实现

**初始化 LCD 和 SD 卡**

```cpp showLineNumbers
#include"TFT_eSPI.h"
#include "Seeed_FS.h" //Including SD card library
#include"RawImage.h"  //Including image processing library
TFT_eSPI tft;

void setup() {
    //Initialise SD card
    if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI)) {
        while (1);
    }
    //Initialise LCD screen
    tft.begin();
    tft.setRotation(3);
}
//storing the names of photos 
const char* list[] = {"photos/1.bmp", "photos/2.bmp", "photos/3.bmp", "photos/4.bmp"};

void loop() {
    for (uint8_t cnt = 0; cnt < 4; cnt++) {
        drawImage<uint16_t>(list[cnt],0,0); //dispalying images one by one
        delay(1000);
    }
}
```

**初始化按键**

```cpp showLineNumbers
void setup() {
    ...
    pinMode(BUTTON_1, INPUT); //left button
    pinMode(BUTTON_3, INPUT); //right button
    ...
}
```



## 完整代码

```cpp showLineNumbers
#include"TFT_eSPI.h"
#include "Seeed_FS.h" //Including SD card library
#include"RawImage.h"  //Including image processing library
TFT_eSPI tft;
 
bool left_flag = false;
void button_handler_left() {
  left_flag = true;
}
 
bool right_flag = false;
void button_handler_right() {
  right_flag = true;
}
 
void setup() {
  //Initialise SD card
  if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI,16000000)) {
    while (1);
  }
  tft.begin();
  tft.setRotation(3);
 
  pinMode(BUTTON_1, INPUT);
  pinMode(BUTTON_3, INPUT);
  attachInterrupt(digitalPinToInterrupt(BUTTON_1), button_handler_left, FALLING);
  attachInterrupt(digitalPinToInterrupt(BUTTON_3), button_handler_right, FALLING);
}
 
const char* list[] = {"1.bmp", "2.bmp", "3.bmp", "4.bmp"};
int8_t cnt = 0;
 
void loop() {
  if (left_flag) {
    cnt++;
    left_flag = false;
    if (cnt == 4) {
      cnt = 0;
    }
  }
  if (right_flag) {
    cnt--;
    right_flag = false;
    if (cnt < 0) {
      cnt = 3;
    }
  }
  drawImage<uint16_t>(list[cnt], 0, 0);
}
```

