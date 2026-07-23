---
sidebar_position: 4
slug: /rust-logging-config
---

# 日志与配置

真实程序不能只靠 `println!`。你通常需要日志记录运行状态，也需要配置文件或环境变量调整程序行为。

## 日志的基本想法

Rust 标准库没有内置完整日志框架，常见做法是使用 `log` facade 搭配具体实现，例如 `env_logger` 或 `tracing`。

概念上你会写出这样的代码：

```rust
log::info!("server started");
log::warn!("retry connection");
log::error!("connection failed");
```

日志级别一般包括 `error`、`warn`、`info`、`debug`、`trace`。

## 使用环境变量控制配置

标准库可以读取环境变量：

```rust title="src/main.rs" showLineNumbers
use std::env;

fn main() {
    let port = env::var("APP_PORT").unwrap_or_else(|_| "8080".to_string());
    println!("listen on {port}");
}
```

运行时指定：

```bash
APP_PORT=9000 cargo run
```

## 简单配置结构

你可以先把配置集中到一个结构体里：

```rust
struct Config {
    port: u16,
    verbose: bool,
}

impl Config {
    fn from_env() -> Self {
        Self {
            port: std::env::var("APP_PORT")
                .ok()
                .and_then(|s| s.parse().ok())
                .unwrap_or(8080),
            verbose: std::env::var("APP_VERBOSE").is_ok(),
        }
    }
}
```

这样主流程会更清楚：

```rust
let config = Config::from_env();
```

## 小结

日志回答“程序正在发生什么”，配置回答“程序应该怎样运行”。小项目可以从环境变量开始，项目变大后再引入配置文件和专门的日志库。

