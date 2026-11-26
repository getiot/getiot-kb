---
sidebar_position: 8
slug: /wio-terminal-lvgl
---

# Wio Terminal LVGL 图形库



[LVGL](/foss/lvgl/) 是一个免费的开源嵌入式图形库，具有易于使用的图形元素、美观的视觉效果，支持触摸屏操作，移植简单方便，特别适用于 MCU 级别的嵌入式设备。本文将介绍如何在 Wio Terminal 上运行 LVGL 图形库。

![](https://files.seeedstudio.com/wiki/Wio-Terminal-LVGL/banner.gif#center)



## 安装依赖库

首先需要为 Wio Terminal 安装 LVGL 图形库 `Seeed_Arduino_LvGL`。

1、在 `Seeed_Arduino_LvGL` 的 [GitHub 仓库](https://github.com/Seeed-Studio/Seeed_Arduino_LvGL) 下载 zip 包。

2、然后将 `Seeed_Arduino_LvGL` 库安装到 Arduino IDE 中。具体操作：点击 *项目 > 加载库 > 添加 .ZIP 库…*，然后选择刚刚下载的 Seeed_Arduino_LvGL.zip 文件。



## 使用示例

### 示例 1：Bench Mark

成功加载 `Seeed_Arduino_LvGL` 库后，在 Arduino IDE 点击 *文件 > 示例 > 第三方库示例 > Seeed_Arduino_LvGL* 打开 `benchmark` 示例，编译上传到 Wio Terminal。运行效果如下：

![](https://files.seeedstudio.com/wiki/Wio-Terminal-LVGL/benchmark.gif#center)



### 示例 2：Stress Test

同样，我们在 Arduino IDE 中打开 `lv_test_stress` 示例，编译上传到 Wio Terminal。运行效果如下：

![](https://files.seeedstudio.com/wiki/Wio-Terminal-LVGL/stress.gif#center)

关于 LVGL 的具体使用，可以参考 [官方文档](https://docs.lvgl.io/latest/en/html/index.html) 及其 [Arduino 示例](https://github.com/lvgl/lvgl/tree/master/examples/arduino)。

