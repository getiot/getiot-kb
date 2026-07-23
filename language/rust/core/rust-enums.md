---
sidebar_position: 4
slug: /rust-enums
---

# 枚举 Enum

enum 用于表示“一个值可能是几种情况之一”。Rust enum 比 C 语言 enum 更强，因为每个变体可以携带不同数据。

## 基本 enum

```rust showLineNumbers title="src/main.rs"
enum Direction {
    Up,
    Down,
    Left,
    Right,
}

fn main() {
    let dir = Direction::Up;
}
```

## 携带数据

```rust showLineNumbers title="src/main.rs"
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
}
```

不同变体可以携带不同类型的数据。

## Option

Rust 没有空指针常规用法，而是用 `Option<T>` 表示“可能有值，也可能没有值”：

```rust
enum Option<T> {
    Some(T),
    None,
}
```

示例：

```rust
let value: Option<i32> = Some(10);
let empty: Option<i32> = None;
```

## Result

`Result<T, E>` 表示“成功或失败”：

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

很多 I/O、网络和解析函数都会返回 `Result`。

## 小结

你需要掌握：

- enum 表示多种可能状态。
- enum 变体可以携带数据。
- `Option<T>` 表示可能没有值。
- `Result<T, E>` 表示可能失败。
- enum 通常配合 `match` 使用。
