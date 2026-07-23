---
sidebar_position: 0
slug: /rust-ownership
---

# 所有权 Ownership

ownership 是 Rust 最重要的概念。你可以先这样理解：每个值都有一个 owner，当 owner 离开作用域时，这个值会被自动释放。

## 三条规则

Rust ownership 有三条基本规则：

1. 每个值都有一个 owner。
2. 同一时间只能有一个 owner。
3. owner 离开作用域时，值会被丢弃。

## 作用域和释放

```rust showLineNumbers title="src/main.rs"
fn main() {
    let s = String::from("hello");
    println!("{s}");
} // s 离开作用域，String 内存被释放
```

你不用手动 `free`，Rust 会在作用域结束时自动释放资源。

## Move

```rust
let s1 = String::from("hello");
let s2 = s1;
println!("{s1}");
```

这段代码会编译失败。`String` 的所有权从 `s1` move 到了 `s2`，之后 `s1` 不再可用。

正确使用：

```rust
let s1 = String::from("hello");
let s2 = s1;
println!("{s2}");
```

## Clone

如果你确实需要复制堆上数据，使用 `clone()`：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let s1 = String::from("hello");
    let s2 = s1.clone();

    println!("{s1}, {s2}");
}
```

`clone()` 可能有成本，因为它会复制数据。

## Copy

整数这类简单类型通常实现了 `Copy`：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let a = 10;
    let b = a;

    println!("{a}, {b}");
}
```

这里不会发生 move，因为 `i32` 可以直接复制。

## 函数与所有权

把 `String` 传给函数，会 move 所有权：

```rust
fn take(s: String) {
    println!("{s}");
}

fn main() {
    let text = String::from("hello");
    take(text);
    // println!("{text}"); // 这里不能再用 text
}
```

如果你不想转移所有权，就需要借用。下一节会讲。

## 小结

你需要掌握：

- owner 离开作用域时，值会被释放。
- `String` 赋值给另一个变量会 move。
- `clone()` 可以显式复制数据。
- 简单标量类型通常是 `Copy`。
- 函数参数也会影响所有权。
