---
sidebar_position: 6
slug: /rust-json
---

# JSON 数据处理

JSON 是网络接口中最常见的数据格式之一。Rust 中通常使用 `serde` 和 `serde_json` 处理 JSON。

## 添加依赖

```toml title="Cargo.toml"
[dependencies]
serde = { version = "1", features = ["derive"] }
serde_json = "1"
```

## 解析 JSON

```rust title="src/main.rs" showLineNumbers
use serde::Deserialize;

#[derive(Debug, Deserialize)]
struct SensorData {
    device: String,
    temperature: f32,
}

fn main() -> Result<(), serde_json::Error> {
    let text = r#"{"device":"sensor-1","temperature":26.5}"#;
    let data: SensorData = serde_json::from_str(text)?;

    println!("{data:?}");
    Ok(())
}
```

## 生成 JSON

```rust
use serde::Serialize;

#[derive(Serialize)]
struct Message {
    status: String,
}

let msg = Message {
    status: "ok".to_string(),
};

let text = serde_json::to_string(&msg).unwrap();
println!("{text}");
```

## 字段名不一致

如果 JSON 字段和 Rust 字段命名不同，可以使用属性：

```rust
#[derive(Deserialize)]
struct User {
    #[serde(rename = "user_name")]
    user_name: String,
}
```

## 小结

`serde` 让你用 Rust 结构体表达数据形状。解析 JSON 时，你越早定义清楚结构体，后面的业务代码越不容易混乱。

