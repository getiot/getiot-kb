---
sidebar_position: 9
sidebar_label: 驱动 LCD 显示
---

# 潘多拉 RT-Thread LCD 显示

![潘多拉 IoT Board RT-Thread LCD 显示](https://static.getiot.tech/pandora-board-lcd-display.jpeg#center)

## 实验概述

本文主要介绍了如何使用潘多拉 IoT 开发板上的 LCD 液晶显示屏，并在 LCD 上显示文字和图片。



## 硬件连接

潘多拉 IoT Board 板载一块 1.3 寸，分辨率为 240x240 的 LCD 显示屏，显示效果十分细腻。显示屏的驱动芯片是 ST7789，通过 4-line SPI 接口和单片机进行通讯。因为只需要往 LCD 写数据而不需要读取，因此可以不接 MISO 引脚。

![](https://static.getiot.tech/pandora-board-schematic-lcd.png#center)

如上图所示，单片机通过以下管脚来控制 LCD 显示屏输出。

| 信号        | 引脚 | 功能             |
| :---------- | :--- | ---------------- |
| LCD_SPI_SCK | PB3  | SPI 时钟线       |
| LCD_WR      | PB4  | SPI 命令数据选择 |
| LCD_SPI_SDA | PB5  | SPI 数据线       |
| LCD_RESET   | PB6  | LCD 复位         |
| LCD_PWR     | PB7  | 背光控制         |
| LCD_CS      | PD7  | SPI 片选信号     |



## 示例代码

参考《[潘多拉 IoT Board 开发环境](/pandora/rtt-pandora-develop-env/)》创建工程，在 applications/main.c 中输入如下代码。

程序主要流程：通过调用已经封装好的 LCD API 函数（位于 drv_lcd.h），首先执行的是清屏操作，将 LCD 全部刷成白色。然后设置画笔的颜色为黑色，背景色为白色。接着显示 RT-Thread 的 Logo。最后会显示一些信息，包括 16x16 像素，24x24 像素和 32x32 像素的三行英文字符，一条横线和一个同心圆。

提示：RT-Thread 的 Logo 已事先通过[图片取模软件](/tools/bitmap-image-converter/)将图像数据转换为 image_rttlogo 数组。

```c showLineNumbers title="applications/main.c"
#include <rtthread.h>
#include <rtdevice.h>
#include <board.h>
#include <drv_lcd.h>
#include <rttlogo.h>

int main(void)
{    
    /* 清屏 */
    lcd_clear(WHITE);

    /* 显示 RT-Thread logo */
    lcd_show_image(0, 0, 240, 69, image_rttlogo);
    
    /* 设置背景色和前景色 */
    lcd_set_color(WHITE, BLACK);

    /* 在 LCD 上显示字符 */
    lcd_show_string(10, 69, 16, "Hello, RT-Thread!");
    lcd_show_string(10, 69+16, 24, "RT-Thread");
    lcd_show_string(10, 69+16+24, 32, "RT-Thread");
    
    /* 在 LCD 上画线 */
    lcd_draw_line(0, 69+16+24+32, 240, 69+16+24+32);
    
    /* 在 LCD 上画一个同心圆 */
    lcd_draw_point(120, 194);
    for (int i = 0; i < 46; i += 4)
    {
        lcd_draw_circle(120, 194, i);
    }

    return 0;
}
```

完整代码：[06_driver_lcd](https://github.com/RT-Thread/IoT_Board/tree/master/examples/06_driver_lcd)



## 编译运行

编译工程

```bash
$ scons
...
LINK rtthread-stm32l4xx.elf
arm-none-eabi-objcopy -O binary rtthread-stm32l4xx.elf rt-thread.bin
arm-none-eabi-size rtthread-stm32l4xx.elf
   text	   data	    bss	    dec	    hex	filename
 115872	    656	   2196	 118724	  1cfc4	rtthread-stm32l4xx.elf
scons: done building targets.
```

将 bin 文件上传到 STM32

```bash
st-flash write rt-thread.bin 0x8000000
```

打开串口终端，输出如下内容

```basic
 \ | /
- RT -     Thread Operating System
 / | \     4.0.1 build Jan  5 2022
 2006 - 2019 Copyright by rt-thread team
msh >
```

现在，潘多拉 IoT Board 上的 LCD 显示屏已经点亮，并显示出预定义的内容。

![潘多拉 IoT Board RT-Thread LCD 显示](https://static.getiot.tech/pandora-board-lcd-display.jpeg#center)



## 思考总结

对图像取模时需要注意设置参数，取模方式为自上而下、自左向右，高位在前，16 位色（RGB-565）。由于 LCD 屏幕的分辨率是 240x240，因此输入位置参数时要注意小于 240，否则会出现无法显示的现象。另外，本例程并未添加中文字库，因此暂时不支持显示中文（后续会介绍）。

ST7789 是一颗常用的 TFT LCD 显示驱动 IC，关于 ST7789 的驱动程序实现细节都在 drv_lcd.c 中，工作原理是单片机通过 SPI 协议给 ST7789 发送指定的命令和数据，由 ST7789 负责最终在 LCD 屏幕上的输出。

同时，LCD 显示驱动也被封装成软件包 [st7789](https://github.com/RT-Thread-packages/st7789)，可以在 menuconfig 配置菜单中选中它添加到你的项目。

```bash
RT-Thread online packages  --->
  peripheral libraries and drivers  --->
    lcd drivers  --->
      st7789: lcd ic st7789 for rt-thread
              Version (latest)  --->
```

