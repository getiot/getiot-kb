---
sidebar_position: 2
slug: /wio-terminal-lcd-graphics
---

# Wio Terminal LCD 图形绘制



本文主要介绍 Wio Terminal TFT LCD 库的一些基本图形功能，包括如何在 LCD 屏幕上画点、画线、画矩形、画圆形 ...... 以及色彩填充和字符显示等功能。掌握 LCD 库的基本操作之后，你就可以灵活使用这些函数来绘制你需要的图形了！



## 绘制像素

在 LCD 屏幕上绘制像素：

```cpp showLineNumbers
drawPixel(int32_t x, int32_t y, uint32_t color);
```

其中，参数 `x` 和 `y` 是像素坐标，`color` 是像素的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;

void setup() {
    tft.begin();
    tft.setRotation(3);

    tft.fillScreen(TFT_GREEN);        // Green background
    tft.drawPixel(160, 120, TFT_RED); // drawing a red pixel at (160, 120)
}

void loop() {}
```



## 绘制线条

在 LCD 屏幕上的两点之间画一条线：

```cpp showLineNumbers
drawLine(int32_t x0, int32_t y0, int32_t x1, int32_t y1, uint32_t color);
```

其中，参数 `x0` 和 `y0` 是起始点的坐标，参数 `x1` 和 `y1` 是结束点的坐标，`color` 是线条的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    
    tft.fillScreen(TFT_GREEN);               // Green background
    tft.drawLine(0, 120, 320, 120, TFT_RED); // drawing a red line from (0, 120) to (320, 120)
}
 
void loop() {}
```

为了方便绘制水平或垂直线，LCD 库还提供了两个快速绘制函数：

```cpp showLineNumbers
drawFastHLine(int32_t x, int32_t y, int32_t w, uint32_t color); //Horizontal line
drawFastVLine(int32_t x, int32_t y, int32_t h, uint32_t color); //Verical line
```

其中 `(x, y)` 是起始坐标，`w` 是水平线的宽度，`h` 是垂直线的高度，`color` 是线条的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    
    tft.fillScreen(TFT_GREEN);               // Green background
    tft.drawFastHLine(0, 120, 320, TFT_RED); // A red horizontal line starting from (0, 120)
    tft.drawFastVLine(160, 0, 240, TFT_RED); // A red vertical line starting from (160, 0)
}
 
void loop() {}
```



## 绘制矩形

在 LCD 屏幕上绘制或填充矩形：

```cpp showLineNumbers
drawRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
fillRect(int32_t x, int32_t y, int32_t w, int32_t h, uint32_t color);
```

其中 `(x, y)` 是起始坐标，`w` 是宽度，`h` 是矩形的高度，`color` 是矩形边框的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    
    tft.fillScreen(TFT_GREEN);                // Green background
    tft.drawRect(110, 70, 100, 100, TFT_RED); // A 100x100 red rectangle starting from (110, 70)
}
 
void loop() {}
```



## 绘制圆形

在 LCD 屏幕上绘制或填充圆形：

```cpp showLineNumbers
drawCircle(int32_t x0, int32_t y0, int32_t r, uint32_t color);
fillCircle(int32_t x0, int32_t y0, int32_t r, uint32_t color);
```

其中 `(x0, y0)` 是原点，`r` 是圆的半径，`color` 是圆形边框的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    
    tft.fillScreen(TFT_GREEN);             // Green background
    tft.drawCircle(160, 120, 50, TFT_RED); // A red circle origin at (160, 120)
}
 
void loop() {}
```

另外，LCD 库还提供了绘制或填充椭圆的函数：

```cpp showLineNumbers
drawEllipse(int16_t x0, int16_t y0, int32_t rx, int32_t ry, uint16_t color);
fillEllipse(int16_t x0, int16_t y0, int32_t rx, int32_t ry, uint16_t color);
```

其中 `(x0, y0)` 是椭圆的原点，`rx` 是水平半径，`ry` 是垂直半径，`color` 是椭圆边框的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);

    // Green background
    tft.fillScreen(TFT_GREEN);

    // A red ellipse origin at (160, 120) with horizontal radius of 50, and vertical radius of 100
    tft.drawEllipse(160, 120, 50, 100, TFT_RED); 
}
 
void loop() {}
```



## 绘制三角形

在 LCD 屏幕上绘制或填充三角形：

```cpp showLineNumbers
drawTriangle(int32_t x0, int32_t y0, int32_t x1, int32_t y1, 
             int32_t x2, int32_t y2, uint32_t color);
fillTriangle(int32_t x0, int32_t y0, int32_t x1, int32_t y1, 
             int32_t x2, int32_t y2, uint32_t color);
```

其中 `(x0, y0)` 是第一个坐标，`(x1, y1)` 是第二个坐标，`(x2, y2)` 是三角形的第三个坐标，`color` 是三角形边框的颜色值（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);

    // Green background
    tft.fillScreen(TFT_GREEN);

    // A triangle with points at (160, 70), (60, 170) and (260, 170)
    tft.drawTriangle(160, 70, 60, 170, 260, 170, TFT_RED);
}
 
void loop() {}
```



## 绘制圆角矩形

在 LCD 屏幕上绘制或填充圆角矩形：

```cpp showLineNumbers
drawRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t r, uint32_t color);
fillRoundRect(int32_t x, int32_t y, int32_t w, int32_t h, int32_t r, uint32_t color);
```

其中 `(x, y)` 是起始坐标，`w` 和 `h` 表示矩形的宽度和高度，`r` 表示倒角半径，`color` 是圆角矩形边框的颜色值。（RGB）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);

    // Green background
    tft.fillScreen(TFT_GREEN);

    // A 100x100 red roudned rectangle starting from (110, 70)
    tft.drawRoundRect(110, 70, 100, 100, 10, TFT_RED);
}
 
void loop() {}
```



## 绘制字符

要在 LCD 屏幕上绘制单个字符：

```cpp showLineNumbers
drawChar(int32_t x, int32_t y, uint16_t c, uint32_t color, uint32_t bg, uint8_t size)
```

其中 `(x, y)` 是起始位置，`c` 是字符，`color` 是字符的颜色，`bg` 是字符的背景颜色，`size` 是字符的大小（缩放比例）。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);

    // Green background
    tft.fillScreen(TFT_GREEN);

    tft.drawChar(140, 120, 'A', TFT_BLACK, TFT_RED, 1); // Draw a black character A from (140,120)
    tft.drawChar(155, 120, 'B', TFT_BLACK, TFT_RED, 2); // Draw a black character B from (155,120)
    tft.drawChar(170, 120, 'C', TFT_BLACK, TFT_RED, 4); // Draw a black character C from (170,120)
}
 
void loop() {}
```



## 绘制文本字符串

在 LCD 屏幕上绘制字符串：

```cpp showLineNumbers
drawString(const String& string, int32_t poX, int32_t poY);
```

其中 `string` 是文本字符串，`(poX, poY)` 是起始坐标。

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);

    tft.fillScreen(TFT_GREEN);            // Green background

    tft.setTextColor(TFT_BLACK);          // sets the text colour to black
    tft.setTextSize(1);                   // sets the size of text
    tft.drawString("Hello world!", 0, 0); // prints strings from (0, 0)
    tft.setTextSize(2);
    tft.drawString("Hello world!", 0, 10);
}
 
void loop() {}
```



## 填满屏幕

要填充或着色整个屏幕：

```cpp showLineNumbers
fillScreen(uint32_t color);
```

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
}
 
void loop() {
    // Looping through color R-G-B
    tft.fillScreen(TFT_RED);
    delay(1000);
    tft.fillScreen(TFT_GREEN);
    delay(1000);
    tft.fillScreen(TFT_BLUE);
    delay(1000);
}
```
