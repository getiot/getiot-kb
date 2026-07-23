---
sidebar_position: 8
slug: /rust-tokio
---

# Tokio 入门

Tokio 是 Rust 生态中常用的异步运行时，适合构建网络服务、客户端、任务调度程序等。

## 添加依赖

```toml title="Cargo.toml"
[dependencies]
tokio = { version = "1", features = ["full"] }
```

## 第一个 Tokio 程序

```rust title="src/main.rs" showLineNumbers
#[tokio::main]
async fn main() {
    println!("hello tokio");
}
```

`#[tokio::main]` 会生成运行异步 main 函数所需的运行时入口。

## 创建异步任务

```rust title="src/main.rs" showLineNumbers
#[tokio::main]
async fn main() {
    let handle = tokio::spawn(async {
        println!("task running");
    });

    handle.await.unwrap();
}
```

`tokio::spawn` 会把任务交给运行时调度。

## 异步等待

```rust
use std::time::Duration;

tokio::time::sleep(Duration::from_secs(1)).await;
println!("one second later");
```

这个等待不会阻塞整个线程池。

## 小结

Tokio 是学习 Rust 异步编程的重要工具。你先掌握 `#[tokio::main]`、`async fn`、`.await`、`tokio::spawn`，再去写更复杂的异步 TCP、HTTP 或 MQTT 程序。

