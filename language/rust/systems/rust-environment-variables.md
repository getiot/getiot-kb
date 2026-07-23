---
sidebar_position: 3
slug: /rust-environment-variables
---

# 环境变量

环境变量常用于配置程序，例如端口号、日志级别、数据库地址、API token 等。

## 读取环境变量

```rust title="src/main.rs" showLineNumbers
use std::env;

fn main() {
    match env::var("APP_ENV") {
        Ok(value) => println!("APP_ENV={value}"),
        Err(_) => println!("APP_ENV is not set"),
    }
}
```

运行：

```bash
APP_ENV=dev cargo run
```

## 设置默认值

```rust
let port = env::var("APP_PORT").unwrap_or_else(|_| "8080".to_string());
```

如果环境变量不存在，就使用 `8080`。

## 解析数字

```rust
let port: u16 = env::var("APP_PORT")
    .unwrap_or_else(|_| "8080".to_string())
    .parse()
    .expect("APP_PORT must be a number");
```

这里先读取字符串，再解析成 `u16`。

## 安全提醒

:::warning
环境变量适合传递配置，但不要把敏感值打印到日志里，例如 token、password、private key。
:::

## 小结

环境变量让程序不需要重新编译就能改变行为。初学时先掌握 `env::var()`，再学习如何把它们整理进配置结构体。

