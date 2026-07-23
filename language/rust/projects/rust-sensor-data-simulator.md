---
sidebar_position: 4
slug: /rust-sensor-data-simulator
---

# 传感器数据采集模拟器

没有真实硬件时，你可以先写一个模拟器，周期性生成传感器数据，并把数据序列化为 JSON。这对 IoT 后端、协议调试和数据管道测试很有用。

## 添加依赖

```toml title="Cargo.toml"
[dependencies]
serde = { version = "1", features = ["derive"] }
serde_json = "1"
```

## 编写代码

```rust title="src/main.rs" showLineNumbers
use serde::Serialize;
use std::thread;
use std::time::{Duration, SystemTime, UNIX_EPOCH};

#[derive(Serialize)]
struct SensorData {
    device_id: String,
    temperature: f32,
    humidity: f32,
    timestamp: u64,
}

fn now() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_secs()
}

fn main() -> Result<(), serde_json::Error> {
    let mut temperature = 25.0;

    loop {
        temperature += 0.1;

        let data = SensorData {
            device_id: "sensor-001".to_string(),
            temperature,
            humidity: 60.0,
            timestamp: now(),
        };

        println!("{}", serde_json::to_string(&data)?);
        thread::sleep(Duration::from_secs(1));
    }
}
```

## 示例输出

```json
{"device_id":"sensor-001","temperature":25.1,"humidity":60.0,"timestamp":1720000000}
```

## 可以继续扩展

- 写入文件
- 通过 UDP 发送
- 通过 MQTT 上报
- 加入随机波动
- 支持命令行参数设置设备编号

## 小结

模拟器能让你在没有硬件时先验证数据格式和系统链路。Rust 的结构体和 `serde` 很适合表达这类结构化数据。

