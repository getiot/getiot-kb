---
sidebar_position: 6
sidebar_label: 日志 Logging
slug: /ruby-logging
---

# Ruby 日志 Logging

日志用于记录程序运行状态。脚本很小时你可以用 `puts`，但程序变复杂后，应该使用日志工具来区分级别、输出位置和格式。

Ruby 标准库提供 `logger`。

## 基本用法

```ruby
require "logger"

logger = Logger.new($stdout)

logger.info("server started")
logger.warn("retry connection")
logger.error("connection failed")
```

## 日志级别

常见级别包括：

- `debug`：调试细节。
- `info`：正常运行信息。
- `warn`：可能有问题，但程序还能继续。
- `error`：发生错误，某个操作失败。
- `fatal`：严重错误，程序可能无法继续。

## 写入文件

```ruby
require "logger"

logger = Logger.new("app.log")
logger.info("hello")
```

## 设置级别

```ruby
logger.level = Logger::WARN

logger.debug("debug message")
logger.warn("warn message")
```

设置为 `WARN` 后，`debug` 和 `info` 不会输出。

## 日志中包含上下文

```ruby
device_id = "sensor-001"
temperature = 26.5

logger.info("device=#{device_id} temperature=#{temperature}")
```

日志应该帮助你排查问题，所以要包含关键上下文。

:::warning
不要把 password、token、private key 等敏感信息写入日志。
:::

## 小练习

1. 创建一个 logger，输出到标准输出。
2. 设置日志级别为 `INFO`。
3. 写一条包含设备 ID 和状态的日志。

## 小结

日志回答“程序发生了什么”。当脚本开始变成工具或服务时，使用 `Logger` 比到处写 `puts` 更可靠。

