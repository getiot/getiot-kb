---
sidebar_position: 11
slug: /wio-terminal-retro-gaming
---

# Wio Terminal 怀旧游戏机

![](https://static.getiot.tech/wio-terminal-retro-gaming-jumper.jpg#center)

Wio Terminal 提供了一个复古小游戏，也是出厂自带的固件。这个小游戏叫“Jumper”，包含在 [Seeed_Arduino_Sketchbook](https://github.com/Seeed-Studio/Seeed_Arduino_Sketchbook) 库（位于 examples/jumper 目录），你可以通过将它添加到 Arduino IDE，这样就可以在“示例”中找到它。

此外，Jumper 还依赖下面这些库：

- [Seeed_Arduino_LCD](https://github.com/Seeed-Studio/Seeed_Arduino_SerialLCD)
- [Seeed_Arduino_FS](https://github.com/Seeed-Studio/Seeed_Arduino_FS)
- [Seeed_Arduino_SFUD](https://github.com/Seeed-Studio/Seeed_Arduino_SFUD)
- [Adafruit_ZeroDMA](https://github.com/adafruit/Adafruit_ZeroDMA)
- [Adafruit_ZeroTimer](https://github.com/adafruit/Adafruit_ZeroTimer)

其中，SFUD 库是可选的，这取决于你希望采用哪种图片加载方式。Jumper 支持从内置 Flash 或 SD 卡加载图片。

1. **从内置 Flash 加载图片**
   - 这是默认的加载方式，将图片存储到内置 Flash 中。
2. **从 SD 卡加载图片**
   - 将 `rgb332` 整个文件夹复制到 SD 卡。
   - 并且将代码中的 `LOAD_IMAGE_SD` 宏的注释去掉。

现在，你可以在 Wio Terminal 上好好玩一把 Jumper 小游戏了！

当然，Jumper 的代码也要看！

```cpp showLineNumbers
#define private public
#ifdef max
#pragma push_macro("max")
#pragma push_macro("min")
#undef max
#undef min
#include "algorithm"
#pragma push_macro("max")
#pragma push_macro("min")
#endif
#include <Seeed_FS.h>
#include "SD/Seeed_SD.h"
#include "string.h"
#include "TFT_eSPI.h"
#include "Adafruit_ZeroTimer.h"
#include "Wire.h"
#include "raw.h"
char buf[20];
uint8_t button_state;
#define debug(...)        //\
    Serial.printf(__VA_ARGS__); \
    Serial.println();
#define debug2(...)       //Serial.printf(__VA_ARGS__); Serial.println();
#define debug_begin(baud) //Serial.begin(baud);  while(!Serial);
#define PIN_PLAY BUTTON_3
#define PIN_JUMP BUTTON_2
#define PIN_BREAKING_OUT BUTTON_1

/*****
 * load image from sd 
 ****/
//#define LOAD_IMAGE_SD

//define the interrupt handlers
void TC3_Handler()
{
    Adafruit_ZeroTimer::timerHandler(3);
}

constexpr int16_t screen_width = 320;
constexpr int16_t screen_height = 240;
TFT_eSPI tft;
Adafruit_ZeroTimer zt3 = Adafruit_ZeroTimer(3);

/* ... */
```

