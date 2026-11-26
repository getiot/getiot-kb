---
sidebar_position: 3
slug: /wio-terminal-lcd-fonts
---

# Wio Terminal LCD 字体格式



本文介绍在 Wio-Terminal 中如何使用 LCD 库中包含的不同免费字体（GNU FreeFonts）。阅读完本文，你就可以使用自己喜欢的字体格式在 Wio-Terminal 的屏幕上显示文本啦！



## 可用的字体

TFT LCD 库中提供了三种主要字体，分别是 “Serif”、“Sans” 和 “Mono”。每种字体都有几种样式（**bold**、*italic*、oblique）和 9pt、12pt、18pt 和 24pt 的字体大小。

![](https://static.getiot.tech/fonts-samples-white.png#center)



## 使用字体

为了在 Wio Terminal 上使用这些字体，首先需要将 Free_Fonts.h 头文件添加到你的工程目录。在 Ubuntu 系统上，它的目录路径可能是：

```bash
~/.arduino15/packages/Seeeduino/hardware/samd/1.8.2/libraries/Seeed_Arduino_LCD/examples/320x240/All_Free_Fonts_Demo/
```

为了节省大量输入，可以通过以下三种方式在工程中引用每种字体：

To save a lot of typing, each font can be referenced in the sketch in three ways, either with:

1.Font file name with the `&` in front, such as: `&FreeSansBoldOblique24pt7b`.

1. 字体文件名前面添加 `&`，如 `&FreeSansBoldOblique24pt7b`

   ```cpp showLineNumbers
   tft.setFreeFont(&FreeSansBoldOblique24pt7b);
   ```

2. 使用 `FF#` 格式，其中 `#` 是通过查看 Free_Fonts.h 中的定义确定的数字

   ```cpp showLineNumbers
   tft.setFreeFont(FF32);
   ```

3. 文件名的缩写

   ```cpp showLineNumbers
   tft.setFreeFont(FSSBO24)
   ```

下面是字体文件名采用的缩写：

- F = Free font
- M = Mono
- SS = Sans Serif（使用双 S 与 Serif 字体区别开来）
- S = Serif
- B = Bold
- O = Oblique（注意：是字母 O，不是数字 0 哦）
- I = Italic
- 数字 = 字体大小（磅值），可以是 9、12、18 或 24



## 示例代码

下面示例演示如何在 Wio Terminal 中以三种字体格式显示文本。

```cpp showLineNumbers
#include"TFT_eSPI.h"
#include"Free_Fonts.h" // include the header file
TFT_eSPI tft;
 
void setup() {
    tft.begin();
    tft.setRotation(3);
    tft.fillScreen(TFT_BLACK);                   // Black background
    
    tft.setFreeFont(&FreeSansBoldOblique12pt7b); // select Free, Sans, Bold, Oblique, 12pt.
    tft.drawString("Sans Serif 12pt",70,80);     // prints string at (70,80)

    tft.setFreeFont(FF10);                       // select Free, Mono, Oblique, 12pt.
    tft.drawString("Mono 12pt",70,110);          // prints string at (70,110)
 
    tft.setFreeFont(FS12);                       // select Free, Serif, 12pt.
    tft.drawString("Serif 12pt",70,140);         // prints string at (70,140)
}

void loop() {}
```
