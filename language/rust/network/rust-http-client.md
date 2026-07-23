---
sidebar_position: 5
slug: /rust-http-client
---

# HTTP Client

HTTP 是应用层协议。Rust 标准库没有提供高级 HTTP Client，实际项目通常使用 `reqwest`、`ureq` 等 crate。

## 使用 reqwest

在 `Cargo.toml` 中添加依赖：

```toml title="Cargo.toml"
[dependencies]
reqwest = { version = "0.12", features = ["blocking"] }
```

示例代码：

```rust title="src/main.rs" showLineNumbers
fn main() -> Result<(), Box<dyn std::error::Error>> {
    let text = reqwest::blocking::get("https://www.rust-lang.org")?
        .text()?;

    println!("{}", &text[..text.len().min(120)]);
    Ok(())
}
```

这里使用 `blocking` API，适合入门理解。后面学习 Tokio 后，你可以使用异步版本。

## 为什么返回动态错误类型

HTTP 请求可能出现网络错误、DNS 错误、TLS 错误、响应读取错误。示例中用 `Box<dyn std::error::Error>` 接收不同错误类型，方便演示。

## 小结

HTTP 不是从 socket 字节流手写起步的日常任务。多数项目应该使用成熟 HTTP crate，把精力放在请求参数、状态码、响应数据和错误处理上。
