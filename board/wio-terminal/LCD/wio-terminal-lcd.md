---
sidebar_position: 1
slug: /wio-terminal-lcd
---

# Wio Terminal LCD 显示屏



Wio Terminal 配备了一个 2.4 英寸 LCD 显示屏，分辨率为 320 x 240，显示驱动芯片型号为 ILI9341。

在开始操作 Wio Terminal 的 LCD 屏幕之前，我们先来学习一些 LCD 显示的基础知识，例如像素坐标系统和色深。接着再通过几个示例来演示如何控制 LCD 的显示和背光调节。



## 像素坐标系统

我们知道，数字位图是由许多像素组成的，这些像素按行和列一个接一个地排列在一起。因此，图像中的像素位置是通过说明像素在哪一列和哪一行来指定的，通常将左上角定义为坐标原点，即 `(0, 0)`，这就是像素坐标系统。这样，图像中的每一个像素都可以通过提供列号和行号的一对整数来标识。例如，坐标为 `(4,7)` 的像素位于第 4 列和第 7 行。

![](https://static.getiot.tech/Pixel-Coordinates-System-Grids.jpg#center)



## 色彩深度

色彩深度，简称“色深”，用于表示数字位图中存储 1 个像素所用的位数，因此也称为“位/像素”（bpp）。显然，色彩深度越高，可用的颜色就越多。在 MCU 中，受限于成本、通讯接口、处理速度等因素，8 位和 16 位的色彩深度使用最多。

我们知道，所有颜色都可以通过红、绿、蓝三种颜色组合得到，因此在 LCD 中显示色彩，就需要为每一个像素指定一个 RGB 值。也就是说，RGB 三种成分在 8 位和 16 位变量中的存储情况。下面是两种常用的色彩模型定义。

**8位/像素**

| Bit  |             7              |             6              |             5              |              4               |              3               |              2               |              1              |              0              |
| :--: | :------------------------: | :------------------------: | :------------------------: | :--------------------------: | :--------------------------: | :--------------------------: | :-------------------------: | :-------------------------: |
| Data | <font color='red'>R</font> | <font color='red'>R</font> | <font color='red'>R</font> | <font color='green'>G</font> | <font color='green'>G</font> | <font color='green'>G</font> | <font color='blue'>B</font> | <font color='blue'>B</font> |

**16位/像素**

|   Bit   |              15              |              14              |              13              |             12              |             11              |              10              |              9               |              8               |
| :-----: | :--------------------------: | :--------------------------: | :--------------------------: | :-------------------------: | :-------------------------: | :--------------------------: | :--------------------------: | :--------------------------: |
|  Data   |  <font color='red'>R</font>  |  <font color='red'>R</font>  |  <font color='red'>R</font>  | <font color='red'>R</font>  | <font color='red'>R</font>  | <font color='green'>G</font> | <font color='green'>G</font> | <font color='green'>G</font> |
| **Bit** |            **7**             |            **6**             |            **5**             |            **4**            |            **3**            |            **2**             |            **1**             |            **0**             |
|  Data   | <font color='green'>G</font> | <font color='green'>G</font> | <font color='green'>G</font> | <font color='blue'>B</font> | <font color='blue'>B</font> | <font color='blue'>B</font>  | <font color='blue'>B</font>  | <font color='blue'>B</font>  |

Wio Terminal 的 LCD 显示屏使用 16 位色深表示，不过不用担心，在 Seeed_Arduino_LCD 库中已经为我们定义好了一些颜色宏，我们可以直接拿来用。

```cpp showLineNumbers
// New color definitions use for all my libraries
#define TFT_BLACK 0x0000       /*   0,   0,   0 */
#define TFT_NAVY 0x000F        /*   0,   0, 128 */
#define TFT_DARKGREEN 0x03E0   /*   0, 128,   0 */
#define TFT_DARKCYAN 0x03EF    /*   0, 128, 128 */
#define TFT_MAROON 0x7800      /* 128,   0,   0 */
#define TFT_PURPLE 0x780F      /* 128,   0, 128 */
#define TFT_OLIVE 0x7BE0       /* 128, 128,   0 */
#define TFT_LIGHTGREY 0xC618   /* 192, 192, 192 */
#define TFT_DARKGREY 0x7BEF    /* 128, 128, 128 */
#define TFT_BLUE 0x001F        /*   0,   0, 255 */
#define TFT_GREEN 0x07E0       /*   0, 255,   0 */
#define TFT_CYAN 0x07FF        /*   0, 255, 255 */
#define TFT_RED 0xF800         /* 255,   0,   0 */
#define TFT_MAGENTA 0xF81F     /* 255,   0, 255 */
#define TFT_YELLOW 0xFFE0      /* 255, 255,   0 */
#define TFT_WHITE 0xFFFF       /* 255, 255, 255 */
#define TFT_ORANGE 0xFDA0      /* 255, 180,   0 */
#define TFT_GREENYELLOW 0xB7E0 /* 180, 255,   0 */
#define TFT_PINK 0xFC9F
```



## LCD 示例

了解完上述知识点，下面我们进入实操，尝试在 Wio Terminal 的屏幕上显示一些内容。由于[前面](/wiot/wio-terminal-development-environment/)已经搭建好 Wio Terminal 的开发环境，**Seeed SAMD Boards** 软件包中已经包含了 LCD 库，因此我们不需要再安装任何东西。

### 示例 1：LCD 初始化

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(r);
    digitalWrite(LCD_BACKLIGHT, HIGH); // turn on the backlight
}
```

其中，`tft.setRotation(r)` 中的变量 `r` 表示 TFT LCD 屏幕的旋转从哪个角开始（从 0 到 3）。

### 示例 2：LCD 全屏显示红色

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
 
    tft.fillScreen(TFT_RED); // fills entire the screen with colour red
}
 
void loop() {
 
}
```

### 示例 3：关闭 LCD 背光

要关闭 Wio Terminal 的 LCD 背光，只需要定义 LCD 背光控制引脚 `72Ul`，拉高该引脚表示打开背光，拉低则关闭背光。

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
#define LCD_BACKLIGHT (72Ul) // Control Pin of LCD

void setup() {
  // put your setup code here, to run once:
 
    tft.begin();
    tft.setRotation(3);
    tft.fillScreen(TFT_RED);
 
    delay(2000);
    // Turning off the LCD backlight
    digitalWrite(LCD_BACKLIGHT, LOW);
    delay(2000);
    // Turning on the LCD backlight
    digitalWrite(LCD_BACKLIGHT, HIGH);
}
 
void loop() {
  // put your main code here, to run repeatedly:
 
}
```

### 示例 4：控制背光亮度

```cpp showLineNumbers
#include <TFT_eSPI.h>
#include "lcd_backlight.hpp"
#include <cstdint>

TFT_eSPI tft;
static LCDBackLight backLight;
void setup() {
    Serial.begin(115200);
    while(!Serial);

    tft.begin();
    tft.setRotation(3);

    tft.fillScreen(tft.color565(255, 0, 0));

    Serial.println("initializing backlight...");
    backLight.initialize();
}

static std::uint8_t brightness = 0;
void loop() {
    std::uint8_t maxBrightness = backLight.getMaxBrightness();
    brightness += 1;
    if( brightness > maxBrightness ) {
        brightness = 0;
    }
    backLight.setBrightness(brightness);
    delay(50);
}
```

该示例依赖 [lcd_backlight.hpp](https://github.com/Seeed-Studio/Seeed_Arduino_Sketchbook/blob/master/examples/WioTerminal_BackLight/lcd_backlight.hpp) 文件。
