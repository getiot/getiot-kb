---
sidebar_position: 3
sidebar_label: EasyLogger
slug: /easylogger
---

# EasyLogger 超轻量级日志库

**EasyLogger** 是一款由 Armink（朱天龙）开发的超轻量级（ROM < 1.6KB，RAM < 0.3KB）、高性能的 C/C++ 日志库，特别适用于资源受限的嵌入式系统，如物联网（IoT）设备、可穿戴设备和智能家居等。相比 log4c、zlog 等日志库，EasyLogger 提供更简洁的接口和更快的上手体验，同时支持插件式功能扩展。



## 主要特点

- **极致轻量**：ROM 占用小于 1.6KB，RAM 占用小于 0.3KB，非常适合资源受限的系统。
- **多平台支持**：兼容裸机系统、RT-Thread、UCOS、Linux、Windows 等多种操作系统。
- **灵活的输出方式**：支持终端、串口、文件、Flash、数据库等多种输出方式，用户可自定义扩展。
- **丰富的日志信息**：日志内容可包含级别、时间戳、线程信息、进程信息等。
- **线程安全与异步输出**：设计为线程安全，并支持异步输出及缓冲输出模式。
- **动态过滤与彩色显示**：支持按标签、级别、关键词进行动态过滤，各级别日志支持不同颜色显示。
- **插件式扩展**：功能可通过插件进行扩展，如 Flash 存储插件、文件输出插件等。



## 使用方法

#### 1. 获取源码

从 GitHub 克隆 EasyLogger 项目：

```bash
git clone https://github.com/armink/EasyLogger.git
```

#### 2. 添加到工程

将 `easylogger` 目录下的源码文件添加到您的工程中。

#### 3. 初始化日志系统

在程序初始化阶段，调用以下函数初始化日志系统：

```c showLineNumbers
elog_init();
```

#### 4. 设置输出方式和日志级别

设置日志输出方式和默认日志级别：

```c showLineNumbers
elog_set_output_enabled(true);
elog_set_text_color_enabled(true);
elog_set_fmt(ELOG_FMT_LVL | ELOG_FMT_TAG | ELOG_FMT_TIME);
elog_set_filter_lvl(ELOG_LVL_INFO);
```

#### 5. 定义日志标签

在每个源文件中定义日志标签和级别：

```c showLineNumbers
#define LOG_TAG    "main"
#define LOG_LVL    ELOG_LVL_INFO
#include <elog.h>
```

#### 6. 使用日志宏

使用日志宏记录日志信息：

```c showLineNumbers
log_i("This is an info log.");
log_w("This is a warning log.");
log_e("This is an error log.");
```



## 常用 API

- `elog_init()`：初始化日志系统。
- `elog_start()`：启动日志系统。
- `elog_set_output_enabled(bool enabled)`：启用或禁用日志输出。
- `elog_set_text_color_enabled(bool enabled)`：启用或禁用彩色日志输出。
- `elog_set_fmt(uint8_t fmt)`：设置日志格式，如级别、标签、时间等。
- `elog_set_filter_lvl(elog_lvl_t level)`：设置日志过滤级别。
- `elog_set_filter_tag(const char *tag)`：设置日志过滤标签。
- `elog_set_filter_keyword(const char *keyword)`：设置日志过滤关键词。
- `elog_set_output_lock_enabled(bool enabled)`：启用或禁用输出锁，确保线程安全。
- `elog_output(const char *log, size_t size)`：自定义日志输出函数。



## 插件支持

EasyLogger 支持插件式扩展，当前提供以下插件：

- **Flash 插件**：使用 EasyFlash 库将日志存储到 Flash 中，无需文件系统。
- **文件插件**：支持日志文件转储、循环保存等功能。

用户也可以根据需求开发自定义插件，以扩展日志输出方式或功能。



## 相关链接

- [EasyLogger 代码仓库](https://github.com/armink/EasyLogger)
