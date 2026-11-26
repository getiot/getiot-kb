---
sidebar_position: 6
---

# Syntiant TinyML Board 语音训练

摘要：本项目使用 Syntiant TinyML 开发板自带的麦克风，通过 Edge Impulse 训练机器学习模型，实现中文语音识别。

![Syntiant TinyML Board 语音训练](https://static.getiot.tech/syntiant-tinyml-funpack-cover.jpeg#center)



## 项目说明

本次项目用 Syntiant TinyML 开发板自带的麦克风，通过 Edge Impulse 搭建机器学习模型，使板卡上的 LED 灯根据中文语音指令呈现出不同效果。一共训练了四个标签的声音数据，具体说明如下。

| 标签          | 关键词   | 动作                          |
| ------------- | -------- | ----------------------------- |
| turn_on_blue  | 打开蓝灯 | 使板卡上的 RGB LED 灯显示蓝色 |
| turn_on_green | 打开绿灯 | 使板卡上的 RGB LED 灯显示绿色 |
| turn_on_red   | 打开红灯 | 使板卡上的 RGB LED 灯显示红色 |
| turn_off      | 关灯     | 关闭板卡上的 RGB LED 灯       |



## 硬件平台

Syntiant TinyML Board 是美国 AI 芯片研发商 Syntiant 推出的一款 TinyML 开发板，它配备了超低功耗 Syntiant NDP101 神经决策处理器，可以使语音和传感器应用程序分别在 140 和 100 微瓦以下运行。与基于 MCU 的传统 MCU 相比，Syntiant TinyML 板的吞吐量提高 20 倍，系统效率提高 200 倍。

Syntiant TinyML 板的尺寸非常小，仅为 24 毫米 x 28 毫米，是一个小型的独立系统。开发者可以直接通过 Micro USB 连接硬件，通过 Edge Impulse 轻松下载经过训练的模型，而无需任何专用调试硬件。

硬件组成：

- 神经决策处理器使用 NDP101，连接了两个传感器
  - BMI160 6 轴运动传感器
  - SPH0641LM4H 麦克风
- 主机处理器：SAMD21 Cortex-M0+ 32 位低功耗 48MHz ARM MCU
  - 内置 256KB FLASH 和 32KB SRAM
  - 5 个数字 I/O（与 Arduino MKR 系列板兼容）
  - 其中包含 1 路 UART 接口和 1 路 I2C 接口（包括在数字 I/O 引脚中）
  - 2MB 板载串行闪存
  - 一个用户定义的 RGB LED
  - uSD 卡插槽
- 电路板可使用 5V Micro-USB 或 3.7V LiPo 电池供电



## 语音训练

打开 [studio.edgeimpulse.com](https://studio.edgeimpulse.com) 网页，创建一个新的项目，例如 Syntiant_TinyML_Voice，作为本次语音训练的项目。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-01.png#center)

创建完成后进入项目主页面，在这里可以看到训练的大致流程：选择设备、选择语音输入源、采集语音数据、创建 Impulse 模型、训练数据、生成固件、部署到硬件。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-02.png#center)

语音数据采集方面，由于我们需要采集类似“打开红灯”这样的语音，为了方便采集和训练，我们将采集时长定为 2 秒。分别为四个标签采集 20 组数据，按照 8:2 的比例分为训练集和测试集。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-03.png#center)

采集数据后记得检查一下数据的质量，在 Data acquisition 页面选中任意一条采集的语音数据，可以看到声音的波形，回放该条录音。在训练之前需要确保所有训练和测试的数据完好，否则会影响训练效果。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-04.png#center)

如果数据没问题，接下来就可以创建机器学习模型，一共分为四个模块。首先是时间窗口的设置，对于 Syntiant TinyML 语音模块，Window size 大小固定为 968 ms，Window increase 设置为 30 ms（窗口增加设置比较小有利于机器学习匹配出语音）。第二个模块选择 Syntiant audio，第三个模块选择最近邻分类器（Nearest Neighbor Classifier），最后确认输出 `turn_off`、`turn_on_blue`、`turn_on_green` 和 `turn_on_red` 四个标签。点击 Save Impulse 保存模型。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-05.png#center)

然后设置 Mel 滤波器特征参数，这里采用默认参数。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-06.png#center)

开始训练模式，训练结果准确率为 90.2%，不是特别高，但也可以测试看看。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-07.png#center)

点击左侧边栏的 Deployment，选择 Syntiant NDP101 library 下载训练好的库，将其替换到你的工程中（参考 [Syntiant TinyML Board 固件下载](/board/syntiant/syntiant-tinyml-board-firmwares/)）。

![](https://static.getiot.tech/edge-impulse-syntiant-voice-08.png#center)



## Arduino 工程

参考 [Syntiant_TinyML_Board_Demo](https://github.com/getiot/Syntiant_TinyML_Board_Demo) 中的 VoiceResponding 项目，修改标签名称及其触发的动作，代码如下。

```cpp
void on_classification_changed(const char *event, float confidence, float anomaly_score) {

    // here you can write application code, e.g. to toggle LEDs based on keywords
    if (strcmp(event, "turn_on_red") == 0) {
        // Toggle LED
        digitalWrite(LED_RED, HIGH);
        digitalWrite(LED_BLUE, LOW);
        digitalWrite(LED_GREEN, LOW);
    }

    if (strcmp(event, "turn_on_green") == 0) {
        // Toggle LED
        digitalWrite(LED_GREEN, HIGH);
        digitalWrite(LED_BLUE, LOW);
        digitalWrite(LED_RED, LOW);
    }

    if (strcmp(event, "turn_on_blue") == 0) {
        // Toggle LED
        digitalWrite(LED_BLUE, HIGH);
        digitalWrite(LED_GREEN, LOW);
        digitalWrite(LED_RED, LOW);
    }

    if (strcmp(event, "turn_off") == 0) {
        // Toggle LED
        digitalWrite(LED_BLUE, LOW);
        digitalWrite(LED_GREEN, LOW);
        digitalWrite(LED_RED, LOW);
    }
}
```

通过 Arduino IDE 重新编译、上传到 Syntiant TinyML Board，就可以看到效果啦！



## 演示视频

- [https://www.bilibili.com/video/BV1ZN4y1u7kX](https://www.bilibili.com/video/BV1ZN4y1u7kX?share_source=copy_web)



## 相关文章

- [Syntiant TinyML Board 简介](/board/syntiant/syntiant-tinyml-board-intro/)
- [Syntiant TinyML Board 固件下载](/board/syntiant/syntiant-tinyml-board-firmwares/)
- [Syntiant TinyML Board 识别声音](/board/syntiant/syntiant-tinyml-board-responding-to-your-voice/)

