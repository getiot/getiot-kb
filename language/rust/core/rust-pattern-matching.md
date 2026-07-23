---
sidebar_position: 5
slug: /rust-pattern-matching
---

# 模式匹配 Match

`match` 是 Rust 中非常重要的控制流程。它常用来处理 enum、`Option`、`Result` 和各种结构化数据。

## 基本 match

```rust showLineNumbers title="src/main.rs"
enum Direction {
    Up,
    Down,
    Left,
    Right,
}

fn main() {
    let dir = Direction::Left;

    match dir {
        Direction::Up => println!("up"),
        Direction::Down => println!("down"),
        Direction::Left => println!("left"),
        Direction::Right => println!("right"),
    }
}
```

Rust 要求 `match` 覆盖所有可能情况。

## 匹配携带数据的 enum

```rust showLineNumbers title="src/main.rs"
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
}

fn main() {
    let msg = Message::Move { x: 10, y: 20 };

    match msg {
        Message::Quit => println!("quit"),
        Message::Move { x, y } => println!("move to {x}, {y}"),
        Message::Write(text) => println!("{text}"),
    }
}
```

## 通配符

`_` 可以匹配其他所有情况：

```rust
match value {
    0 => println!("zero"),
    1 => println!("one"),
    _ => println!("other"),
}
```

不要过早使用 `_` 忽略重要分支，否则以后新增状态时编译器就不能提醒你。

## if let

如果你只关心一种情况，可以用 `if let`：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let value = Some(10);

    if let Some(n) = value {
        println!("{n}");
    }
}
```

这比只匹配一个分支的 `match` 更简洁。

## 小结

你需要掌握：

- `match` 必须覆盖所有情况。
- enum 携带的数据可以在模式中解构。
- `_` 是通配符。
- 只关心一种情况时可以用 `if let`。
