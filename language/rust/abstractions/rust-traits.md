---
sidebar_position: 4
slug: /rust-traits
---

# Trait

trait 用来定义“一种能力”。如果一个类型实现了某个 trait，就表示它支持这组方法。

## 定义 trait

```rust showLineNumbers title="src/main.rs"
trait Summary {
    fn summary(&self) -> String;
}

struct Device {
    id: String,
}

impl Summary for Device {
    fn summary(&self) -> String {
        format!("device: {}", self.id)
    }
}

fn main() {
    let device = Device {
        id: String::from("sensor-001"),
    };

    println!("{}", device.summary());
}
```

## trait bound

泛型函数可以要求类型实现某个 trait：

```rust
fn print_summary<T: Summary>(item: &T) {
    println!("{}", item.summary());
}
```

也可以使用 `impl Trait`：

```rust
fn print_summary(item: &impl Summary) {
    println!("{}", item.summary());
}
```

## 常见标准 trait

| Trait | 说明 |
| :--- | :--- |
| `Debug` | 调试输出，`{:?}` |
| `Display` | 用户友好输出，`{}` |
| `Clone` | 显式复制 |
| `Copy` | 简单按位复制 |
| `Default` | 默认值 |
| `Iterator` | 迭代器 |

## derive

很多 trait 可以自动派生：

```rust
#[derive(Debug, Clone)]
struct Device {
    id: String,
}
```

## 小结

你需要掌握：

- trait 描述类型具备的能力。
- `impl Trait for Type` 为类型实现 trait。
- trait bound 限制泛型类型必须具备某些能力。
- `#[derive(...)]` 可自动生成常见 trait 实现。
