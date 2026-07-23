---
sidebar_position: 0
slug: /rust-string
---

# String 与字符串

Rust 字符串最容易让初学者困惑，因为你会同时看到 `String` 和 `&str`。

简单理解：

- `String` 拥有一段可增长、可修改的字符串数据。
- `&str` 是字符串切片，通常只是借用一段字符串。

## 创建 String

```rust showLineNumbers title="src/main.rs"
fn main() {
    let mut text = String::from("hello");
    text.push_str(", Rust");

    println!("{text}");
}
```

## &str

字符串字面量类型是 `&str`：

```rust
let name: &str = "Rust";
```

函数参数如果只读字符串，通常写 `&str`：

```rust
fn greet(name: &str) {
    println!("Hello, {name}");
}
```

这样既能传字符串字面量，也能传 `String` 的引用。

## UTF-8

Rust 字符串是 UTF-8。不能随便用数字下标访问字符：

```rust
let text = String::from("你好");
// text[0] // 不允许
```

你可以按字符遍历：

```rust
for ch in text.chars() {
    println!("{ch}");
}
```

## 小结

你需要掌握：

- `String` 拥有数据，可增长。
- `&str` 是字符串切片，常用于参数。
- Rust 字符串是 UTF-8，不能直接按字节下标当字符访问。
