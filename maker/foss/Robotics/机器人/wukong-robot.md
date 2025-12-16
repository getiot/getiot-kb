---
sidebar_position: 11
slug: /wukong-robot
---

# wukong-robot 智能音箱



## 简介

wukong-robot 是一个简单、灵活、优雅的中文语音对话机器人/智能音箱项目，目的是让中国的 Maker 和 Haker 们也能快速打造个性化的智能音箱。wukong-robot 还可能是第一个开源的脑机唤醒智能音箱。

wukong-robot 使用 Python 语言开发，并且只支持 Python 3.x，不支持 Python 2.x 。可运行在 Mac OS X、Ubuntu、Debian、Raspbian，甚至是装有 WSL（Windows Subsystem for Linux）的 Windows。

- 代码：[https://github.com/wzpan/wukong-robot](https://github.com/wzpan/wukong-robot)
- 文档：[https://wukong.hahack.com/](https://wukong.hahack.com/)
- 作者：[潘伟洲wzpan](https://www.hahack.com/)
- 许可证：MIT License



## 功能特性

![](https://static.getiot.tech/wukong-robot-features.png#center)

wukong-robot 具有如下特性：

- **模块化**。功能插件、语音识别、语音合成、对话机器人都做到了高度模块化，第三方插件单独维护，方便继承和开发自己的插件。
- **中文支持**。集成百度、科大讯飞、阿里、腾讯等多家中文语音识别和语音合成技术，且可以继续扩展。
- **对话机器人支持**。支持基于 AnyQ 的本地对话机器人，并支持接入图灵机器人、Emotibot 等在线对话机器人。
- **全局监听，离线唤醒**。支持 Muse 脑机唤醒，及无接触的离线语音指令唤醒。
- **灵活可配置**。支持定制机器人名字，支持选择语音识别和合成的插件。
- **智能家居**。支持和 mqtt、HomeAssistant 等智能家居协议联动，支持语音控制智能家电。
- **后台配套支持**。提供配套后台，可实现远程操控、修改配置和日志查看等功能。
- **开放 API**。可利用后端开放的 API，实现更丰富的功能。
- **安装简单，支持更多平台**。相比 dingdang-robot ，舍弃了 PocketSphinx 的离线唤醒方案，安装变得更加简单，代码量更少，更易于维护并且能在 Mac 以及更多 Linux 系统中运行。



## 工作模式

wukong-robot 被唤醒后，用户的语音指令先经过 ASR 引擎进行 ASR 识别成文本，然后对识别到的文本进行 NLU 解析，再将解析结果进行技能匹配，交给适合处理该指令的技能插件去处理。插件处理完成后，得到的结果再交给 TTS 引擎合成成语音，播放给用户。

虽然一次交互可能包含多次网络请求，不过带来的好处是：每一个环节都可以被修改和定制。而且我认为，到了 5G 时代，音箱的响应速度将不再成为体验问题。可定制和个性化才是未来的主流，而届时 wukong-robot 将会是更好的选择！



## 教学视频

开发团队在腾讯课堂 NEXT 学院有配套视频课程，可以帮助 Hacker 们了解全栈项目 wukong-robot 是怎么开发出来的。

这套视频课程将从零开始，一步步教你如何使用 Python 开发出 wukong-robot 。涉及 Python 的基础语法，以及离线唤醒（KWS）、静音检测（VAD）、语音识别（ASR）、语音合成（TTS）、对话机器人等知识背景的介绍及相关 sdk 和服务的接入，并在这个基础上如何通过一步步的重构优化，开发出一个灵活可配置的 wukong-robot 。另外，还介绍了如何使用 tornado + twitter bootstrap + jQuery + Ajax 开发后台管理端及前端页面。进阶版中还包括了爬虫技术及 Flask 等技术的相关实战。

- 基础篇：[https://ke.qq.com/course/387931](https://ke.qq.com/course/387931)
- 完整篇：[https://ke.qq.com/course/384790](https://ke.qq.com/course/384790)

