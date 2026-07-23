---
sidebar_position: 1
slug: /rust-config-parser
---

# 配置文件解析工具

这个小项目会读取一个简单配置文件，把 `key=value` 形式解析成 `HashMap`。

## 配置文件格式

创建 `app.conf`：

```text
host=127.0.0.1
port=8080
mode=dev
```

## 解析函数

```rust title="src/main.rs" showLineNumbers
use std::collections::HashMap;
use std::fs;

fn parse_config(text: &str) -> HashMap<String, String> {
    let mut config = HashMap::new();

    for line in text.lines() {
        let line = line.trim();

        if line.is_empty() || line.starts_with('#') {
            continue;
        }

        if let Some((key, value)) = line.split_once('=') {
            config.insert(key.trim().to_string(), value.trim().to_string());
        }
    }

    config
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let text = fs::read_to_string("app.conf")?;
    let config = parse_config(&text);

    println!("{config:?}");
    Ok(())
}
```

## 测试解析逻辑

```rust
#[test]
fn parse_basic_config() {
    let config = parse_config("host=localhost\nport=8080\n");
    assert_eq!(config.get("host"), Some(&"localhost".to_string()));
}
```

## 小结

这个项目适合练习 `HashMap`、字符串切分和测试。真实项目中，你通常会使用 TOML、YAML 或 JSON，但手写一个小解析器能帮助你理解数据处理流程。

