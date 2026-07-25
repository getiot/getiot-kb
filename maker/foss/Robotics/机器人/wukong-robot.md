---
sidebar_position: 14
sidebar_label: wukong-robot
slug: /wukong-robot
---

# wukong-robot 中文语音对话机器人

## 简介

**wukong-robot** 是一个中文语音对话机器人/智能音箱项目，使用 Python 开发。它的目标是让个人开发者和 Maker 能够在 Raspberry Pi、Linux 主机或其他设备上搭建可定制的中文语音助手。

它提供了语音唤醒、语音识别、自然语言理解、语音合成、插件扩展和后台管理等能力。相比直接调用某个云端语音助手，wukong-robot 的特点是可定制、可扩展，适合学习语音交互系统的整体链路。

:::note
wukong-robot 项目依赖多种语音识别、语音合成和对话服务。相关第三方服务的可用性、计费方式和 API 政策可能变化，实际部署前应以项目文档和服务商说明为准。
:::

## 工作链路

一个典型语音助手可以拆成几步：

1. 麦克风采集音频。
2. KWS 模块检测唤醒词。
3. ASR 模块把语音转成文本。
4. NLU 或对话模块理解用户意图。
5. 插件或技能模块执行动作。
6. TTS 模块把回复文本合成为语音。
7. 扬声器播放回复。

wukong-robot 把这些环节做成可配置和可扩展的模块，方便你替换不同的语音服务或增加自己的技能。

## 功能特性

![](https://static.getiot.tech/wukong-robot-features.png#center)

wukong-robot 具有如下特性：

- **模块化插件**：功能插件、语音识别、语音合成和对话机器人可以按需替换。
- **中文语音交互**：项目面向中文语音助手场景，适合中文家庭或个人设备。
- **离线唤醒**：支持本地唤醒能力，减少每次交互都依赖云端的需求。
- **对话能力扩展**：可以接入不同对话引擎，也可开发自定义技能。
- **智能家居联动**：可与 MQTT、Home Assistant 等系统结合，用语音控制设备。
- **后台管理**：提供后台功能，用于配置、远程操作和查看日志。
- **开放 API**：便于二次开发或和其他系统集成。

## 适合哪些读者

这个项目适合：

- 想学习中文智能音箱原理的 Maker。
- 想用 Raspberry Pi 或 Linux 主机搭建语音助手的开发者。
- 想理解 ASR、TTS、KWS、NLU 和插件系统如何串起来的学习者。
- 想做智能家居语音入口的个人用户。

如果你只是想买一个稳定可用的商业智能音箱，它并不是最省事的选择。它更适合作为学习、改造和二次开发平台。

## 部署注意事项

部署前需要关注：

- 麦克风和声卡兼容性。
- Python 版本和依赖安装。
- 唤醒词模型与中文识别效果。
- 云端语音服务的账号、额度和网络可用性。
- 本地设备的 CPU、内存和音频采集质量。
- 隐私数据，例如录音、日志、Token 和第三方服务密钥。

:::warning
语音助手可能采集家庭环境音频。部署前应明确录音数据的存储位置、上传服务、日志内容和访问权限，避免泄露隐私。
:::

## 二次开发方向

你可以从这些方向扩展：

- 编写自定义技能插件。
- 接入 Home Assistant，实现智能家居控制。
- 替换 ASR/TTS 服务。
- 增加本地 LLM 或远程 LLM 对话能力。
- 优化唤醒词和噪声环境下的识别效果。
- 增加 Web 控制界面或移动端入口。

## 教学视频

开发团队在腾讯课堂 NEXT 学院有配套视频课程，可以帮助开发者了解全栈项目 wukong-robot 是怎么开发出来的。

这套视频课程将从零开始，一步步教你如何使用 Python 开发出 wukong-robot。涉及 Python 的基础语法，以及离线唤醒（KWS）、静音检测（VAD）、语音识别（ASR）、语音合成（TTS）、对话机器人等知识背景的介绍及相关 SDK 和服务的接入。另外，还介绍了如何使用 Tornado、Bootstrap、jQuery 和 Ajax 开发后台管理端及前端页面。

- 基础篇：[https://ke.qq.com/course/387931](https://ke.qq.com/course/387931)
- 完整篇：[https://ke.qq.com/course/384790](https://ke.qq.com/course/384790)

:::note
教学视频和第三方课程的可访问性可能随平台政策变化。若链接失效，请优先查看项目 GitHub、官方文档和社区讨论。
:::

## 相关链接

- GitHub 仓库：[https://github.com/wzpan/wukong-robot](https://github.com/wzpan/wukong-robot)
- 项目文档：[https://wukong.hahack.com/](https://wukong.hahack.com/)
- 作者主页：[https://www.hahack.com/](https://www.hahack.com/)
- 许可证：MIT License

## 小结

wukong-robot 是一个适合学习中文语音助手和智能音箱系统的开源项目。它的价值在于把唤醒、ASR、NLU、插件、TTS 和后台管理串成一个完整链路，方便你理解和改造语音交互系统。
