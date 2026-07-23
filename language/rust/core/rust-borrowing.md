---
sidebar_position: 1
slug: /rust-borrowing
---

# 引用与借用 Borrowing

如果你只是想读取一个值，不想拿走它的所有权，就可以使用引用。这个过程叫 borrowing。

## 不可变引用

```rust showLineNumbers title="src/main.rs"
fn len(s: &String) -> usize {
    s.len()
}

fn main() {
    let text = String::from("hello");
    let n = len(&text);

    println!("{text}, {n}");
}
```

`&text` 表示借用 `text`。函数拿到的是引用，不拥有 `String`。

更惯用的参数类型是 `&str`：

```rust
fn len(s: &str) -> usize {
    s.len()
}
```

## 可变引用

如果你想通过引用修改值，需要可变引用：

```rust showLineNumbers title="src/main.rs"
fn append_world(s: &mut String) {
    s.push_str(", world");
}

fn main() {
    let mut text = String::from("hello");
    append_world(&mut text);

    println!("{text}");
}
```

注意两处 `mut`：

- 变量本身要 `let mut text`。
- 借用时要 `&mut text`。

## 借用规则

Rust 的核心借用规则：

- 同一时间可以有多个不可变引用。
- 同一时间只能有一个可变引用。
- 可变引用和不可变引用不能同时活跃。

这能防止数据竞争和很多悬垂引用问题。

## 常见错误

```rust
let mut text = String::from("hello");
let r1 = &text;
let r2 = &mut text;
println!("{r1}");
```

这会失败，因为不可变引用 `r1` 仍然会被使用，同时又创建了可变引用 `r2`。

你可以缩短引用使用范围：

```rust
let mut text = String::from("hello");
let r1 = &text;
println!("{r1}");

let r2 = &mut text;
r2.push_str("!");
```

## 小结

你需要掌握：

- `&T` 是不可变引用。
- `&mut T` 是可变引用。
- 引用不会拿走所有权。
- 多个读引用可以共存。
- 写引用同一时间只能有一个，并且不能和读引用同时活跃。
