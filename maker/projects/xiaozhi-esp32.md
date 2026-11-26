---
sidebar_position: 2
---

# 小智 AI 聊天机器人

![小智 AI 聊天机器人](https://static.getiot.tech/xiaozhi-esp32_1280.webp#center)

**小智 AI 聊天机器人**（XiaoZhi AI Chatbot）是虾哥设计并开源的一个硬件作品，主控制器是 ESP32。该项目使用 MIT 许可证，这意味着任何人都可以免费使用、复刻自己的小智 AI 机器人，甚至用于商业用途。

该项目的初衷是帮助更多人入门 AI 硬件开发，了解如何将当下飞速发展的大语言模型应用到实际的硬件设备中。无论你是对 AI 感兴趣的学生，还是想要探索新技术的开发者，都可以通过这个项目获得宝贵的学习经验。



## 主要功能

- 支持 Wi-Fi、ML307 Cat.1 4G 网络通信模块
- BOOT 键唤醒和打断，支持点击和长按两种触发方式
- 离线语音唤醒 [ESP-SR](https://github.com/espressif/esp-sr)
- 流式语音对话（WebSocket 或 UDP 协议）
- 支持国语、粤语、英语、日语、韩语 5 种语言识别 [SenseVoice](https://github.com/FunAudioLLM/SenseVoice)
- 声纹识别，识别是谁在喊 AI 的名字 [3D Speaker](https://github.com/modelscope/3D-Speaker)
- 大模型 TTS（火山引擎 或 CosyVoice）
- 大模型 LLM（Qwen, DeepSeek, Doubao）
- 可配置的提示词和音色（自定义角色）
- 短期记忆，每轮对话后自我总结
- OLED / LCD 显示屏，显示信号强弱或对话内容
- 支持 LCD 显示图片表情
- 支持多语言（中文、英文）



## 支持硬件

小智 AI 聊天机器人的固件目前已经支持多款硬件，包括：

- [立创·实战派 ESP32-S3 开发板](https://oshwhub.com/li-chuang-kai-fa-ban/li-chuang-shi-zhan-pai-esp32-s3-kai-fa-ban)
- [乐鑫 ESP32-S3-BOX3](https://github.com/espressif/esp-box)
- [M5Stack CoreS3](https://docs.m5stack.com/zh_CN/core/CoreS3)
- [AtomS3R + Echo Base](https://docs.m5stack.com/en/atom/Atomic%20Echo%20Base)
- [AtomMatrix + Echo Base](https://docs.m5stack.com/en/core/ATOM%20Matrix)
- [神奇按钮 2.4](https://gf.bilibili.com/item/detail/1108782064)
- [微雪电子 ESP32-S3-Touch-AMOLED-1.8](https://www.waveshare.net/shop/ESP32-S3-Touch-AMOLED-1.8.htm)
- [LILYGO T-Circle-S3](https://github.com/Xinyuan-LilyGO/T-Circle-S3)
- [虾哥 Mini C3](https://oshwhub.com/tenclass01/xmini_c3)
- [Moji 小智AI衍生版](https://oshwhub.com/movecall/moji-xiaozhi-ai-derivative-editi)
- [无名科技Nologo-星智-1.54TFT](https://github.com/WMnologo/xingzhi-ai)
- [无名科技Nologo-星智-0.96TFT](https://github.com/WMnologo/xingzhi-ai)
- [SenseCAP Watcher](https://www.seeedstudio.com/SenseCAP-Watcher-W1-A-p-5979.html)



## 开发环境

推荐使用 Cursor 或 VSCode 集成开发环境，安装 ESP-IDF 插件，选择 SDK 版本 5.3 或以上。在 Linux 上开发比 Windows 更好，编译速度更快，也免去驱动问题的困扰。

![](https://static.getiot.tech/xiaozhi-esp32-vscode-main_processed.webp#center)



## 智能体配置

小智 AI 聊天机器人的可玩性很高，可通过网页端控制台来添加设备，然后就可以配置机器人的角色、选择语音风格等等。

控制台网址：[https://xiaozhi.me](https://xiaozhi.me)

![](https://static.getiot.tech/xiaozhi-esp32-console-main_processed.webp#center)



## DIY 物料清单

你还可以使用面包板自己动手 DIY 一个 小智 AI 聊天机器人，下表列出了所需的硬件设备信息。

| 模块/元件                 | 描述/型号                             | 价格    |
| ------------------------- | ------------------------------------- | ------- |
| ESP32-S3-DevKitC-1 开发板 | ESP32-S3-WROOM-1/1U N16R8 芯片        | 30-40元 |
| MEMS 数字麦克风           | INMP441                               | 5.5-9元 |
| 数字功放                  | MAX98357 / MAX98357A / MAX98357B      | 3-6元   |
| 腔体喇叭                  | 8Ω 3W / 4Ω 3W                         | 2-10元  |
| 面包板                    | 2 块可拼成400孔面包板                 | 1.5-5元 |
| 导线                      | 跳线1盒，杜邦线若干                   | 5-7元   |
| OLED 显示屏               | SSD1306 驱动，推荐使用 IIC 接口       | 5-7元   |
| 微动开关/按钮             | 尺寸选择 6*6MM 直插按钮               | 1元     |
| 4G Cat1 通信模组          | （可选）中移 ML307R，选择 AT 固件版本 | 20-30元 |

提示：购买全部硬件模块总价在 100 元以内。



## 相关链接

- GitHub 地址：[https://github.com/78/xiaozhi-esp32](https://github.com/78/xiaozhi-esp32)
- 文档教程：[小智 AI 聊天机器人百科全书](https://ccnphfhqs21z.feishu.cn/wiki/F5krwD16viZoF0kKkvDcrZNYnhb)
