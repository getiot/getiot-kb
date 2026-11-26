---
sidebar_position: 5
slug: /wio-terminal-lcd-images
---

# Wio Terminal LCD 加载图片



本文介绍在 Wio-Terminal 中如何从 SD 卡加载图片并显示到 TFT LCD 屏幕上，这个功能非常实用，在很多地方都能用得上，大家不要错过哦！



## 安装依赖库

- 安装 SD Card 库（参考 [Wio Terminal 文件系统](/wiot/wio-terminal-file-system/)）
- 安装 TFT LCD 库（参考 [Wio Terminal LCD 显示屏](/wiot/wio-terminal-lcd/)）



## 转换图片格式

**1、将图像格式转换为 Windows BMP 格式**

首先，我们需要调整图片大小并将格式转换为 Windows 的 .bmp 格式。在这里，我们建议使用“Microsoft Paint”来执行此操作。只需将图像重新缩放到所需大小，然后另存为 “24-bit 位图（.bmp）” 文件即可。

**2、通过我们的 Python 脚本将 Windows BMP 格式转换为“特殊” .bmp 格式**

要在嵌入式系统上显示 bmp 图像，我们需要删除 Windows bmp 格式中的一些信息（头文件）。为此，我们特意写了一个 Python 脚本来做这件事，下面是关于如何使用它的说明：

- 创建一个名为“bmp”的目录，并将你得到的 .bmp 格式图像保存在该目录中。

- 下载 Python 脚本 bmp_converter.py ，并将其保存在 bmp 目录中。

  ```bash
  wget https://files.seeedstudio.com/wiki/Wio-Terminal/res/bmp_converter.py
  ```

- 打开 cmd 命令行或 shell 终端，切换到 bmp 目录，运行 Python 脚本。

  ```bash
  python3 bmp_converter.py
  ```

- 这个脚本提供了两个转换选项：输入 `1` 进行 8 位颜色转换；输入 `2` 进行 16 位颜色转换。

- 现在，你可以在 bmp 目录中找到另一个名为 “rgb332”（8 位）或 “rgb565”（16 位）的子目录，里面保存了转换后的 .bmp 图像。



## 显示图片

首先需要安装 **RawImage.h** 库，使用这个库可以使加载和显示图像更加容易。执行下面命令下载 RawImage.h 文件，并添加到你的 Arduino 工程。

```bash
wget https://files.seeedstudio.com/wiki/Wio-Terminal/res/RawImage.h
```

接下来，我们看一下如何使用该库在 Arduino 中初始化图片。

方法 1：使用 drawImage 在屏幕上显示图片

```cpp showLineNumbers
//To draw on 8-bit color image on screen, starting from point (x, y):
drawImage<uint8_t>("path to sd card iamge", x, y);
 
//To draw on 16-bit color image on screen, starting from point  (x, y):
drawImage<uint16_t>("path to sd card iamge", x, y);
```

方法 2：使用 newImage 初始化图片（如果使用上述 drawImage 函数则不需要）

```cpp showLineNumbers
//when using 8-bit colour, initialise the image following this:
Raw8 * img8 = newImage<uint8_t>("path to sd card image");
 
//when using 16-bit colour, initialise the image following this:
Raw16 * img16 = newImage<uint16_t>("path to sd card image");
```

**示例代码**：

```cpp showLineNumbers
#include"TFT_eSPI.h"
#include "Seeed_FS.h" // Including SD card library
#include"RawImage.h"  // Including image processing library
TFT_eSPI tft;
 
void setup() {
    // Initialise SD card
    if (!SD.begin(SDCARD_SS_PIN, SDCARD_SPI)) {
        while (1);
    }
    tft.begin();
    tft.setRotation(3);
 
    drawImage<uint8_t>("test.bmp", 0, 0); // Display this 8-bit image in sd card from (0, 0)
}

void loop() {}
```



## FAQs

1、出现 `ImportError: No module named PIL` 错误提示。

解决办法：在 Shell 终端执行下面命令安装 Python 模块。

```bash
pip install pillow
```

