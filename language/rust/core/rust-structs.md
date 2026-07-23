---
sidebar_position: 3
slug: /rust-structs
---

# 结构体 Struct

struct 用于把相关数据组合成一个类型。你可以用它描述设备、配置、消息、坐标等实体。

## 定义结构体

```rust showLineNumbers title="src/main.rs"
struct Device {
    id: String,
    online: bool,
    value: f64,
}

fn main() {
    let device = Device {
        id: String::from("sensor-001"),
        online: true,
        value: 23.5,
    };

    println!("{}", device.id);
}
```

## 可变结构体

整个变量需要是 `mut`，字段才能被修改：

```rust
let mut device = Device {
    id: String::from("sensor-001"),
    online: true,
    value: 23.5,
};

device.value = 24.0;
```

Rust 不支持只把某个字段标记为可变。

## impl 方法

```rust showLineNumbers title="src/main.rs"
struct Device {
    id: String,
    value: f64,
}

impl Device {
    fn new(id: &str) -> Self {
        Self {
            id: id.to_string(),
            value: 0.0,
        }
    }

    fn set_value(&mut self, value: f64) {
        self.value = value;
    }

    fn show(&self) {
        println!("{}: {}", self.id, self.value);
    }
}

fn main() {
    let mut device = Device::new("sensor-001");
    device.set_value(23.5);
    device.show();
}
```

`&self` 表示只读借用，`&mut self` 表示可变借用。

## 小结

你需要掌握：

- struct 把多个字段组合为自定义类型。
- 修改字段需要变量是 `mut`。
- `impl` 用于给类型定义方法。
- `Self` 表示当前类型。
- 方法常用 `&self` 或 `&mut self` 接收调用者。
