---
sidebar_position: 2
slug: /easylogger
---

# EasyLogger 使用教程



[EasyLogger](https://github.com/armink/EasyLogger) 是一款超轻量级、高性能的 C/C++ 日志库，非常适合对资源敏感的软件项目，例如 IoT 产品、可穿戴设备、智能家居等等。相比 log4c、[zlog](/awesome-c/zlog/) 这些知名的 C/C++ 日志库， EasyLogger 的功能更加简单，提供给用户的接口更少，但上手会很快，更多实用功能支持以插件形式进行动态扩展。ROM < 1.6K, RAM < 0.3K

GitHub 仓库：[https://github.com/armink/EasyLogger](https://github.com/armink/EasyLogger)



## 主要特性

- 支持用户自定义输出方式（例如：终端、文件、数据库、串口、485、Flash...）；
- 日志内容可包含级别、时间戳、线程信息、进程信息等；
- 日志输出被设计为线程安全的方式，并支持 **异步输出** 及 **缓冲输出** 模式；
- 支持多种操作系统（RT-Thread、UCOS、Linux、Windows...），也支持裸机平台；
- 日志支持 **RAW 格式** ，支持 **hexdump** ；
- 支持按 **标签** 、 **级别** 、 **关键词** 进行动态过滤；
- 各级别日志支持不同颜色显示；
- 扩展性强，支持以插件形式扩展新功能。

