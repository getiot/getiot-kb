---
sidebar_position: 4
---

# Syntiant TinyML Board 识别声音





## 准备工作

- 下载模板工程：[firmware-syntiant-tinyml](https://github.com/edgeimpulse/firmware-syntiant-tinyml)
- 克隆官方项目：[Syntiant-RC-Go-Stop](https://studio.edgeimpulse.com/public/42868/latest)



## 训练模型

简单地，你可以在官方提供的 Syntiant-RC-Go-Stop 项目基础上进行修改，重新训练模型。

你也可以新建一个工程，自己设置标签，并且采集数据，训练自己的语音识别模型。



## 控制程序

```cpp
#include "src/syntiant.h"
#include <NDP.h>
#include <NDP_utils.h>
#include <Arduino.h>

/**
 * @brief      Called when a inference matches 1 of the features
 *
 * @param[in]  event          The event
 * @param[in]  confidence     The confidence
 * @param[in]  anomaly_score  The anomaly score
 */
void on_classification_changed(const char *event, float confidence, float anomaly_score) {

    // here you can write application code, e.g. to toggle LEDs based on keywords
    if (strcmp(event, "stop") == 0) {
        // Toggle LED
        digitalWrite(LED_RED, HIGH);
    }

    if (strcmp(event, "go") == 0) {
        // Toggle LED
        digitalWrite(LED_GREEN, HIGH);
    }
}

void setup(void)
{
    syntiant_setup();
}

void loop(void)
{
    syntiant_loop();
}
```



## 运行效果

打开串口终端，例如使用 minicom 命令：

```bash
$ minicom -D /dev/ttyACM0
```

这时候对着 Syntiant TinyML Board 喊 “Go”、“Stop” 等词，可以看到串口打印信息：

```bash
Predictions:
    go:         1
    stop:       0
    z_openset:  0

Predictions:
    go:         0
    stop:       1
    z_openset:  0
                                                                                
Predictions:                                                                    
    go:         1                                                               
    stop:       0                                                               
    z_openset:  0                                                               
                                                                                
Predictions:                                                                    
    go:         0                                                               
    stop:       0                                                               
    z_openset:  1
```





## 参考

- [Responding to your voice - Syntiant - RC Commands](https://docs.edgeimpulse.com/docs/tutorials/hardware-specific-tutorials/responding-to-your-voice-syntiant-rc-commands-go-stop)



