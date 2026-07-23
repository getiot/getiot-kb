---
sidebar_position: 2
slug: /rust-slices
---

# 切片 Slice

slice 是对一段连续数据的引用。它不拥有数据，只是借用其中一段。

## 字符串切片

```rust showLineNumbers title="src/main.rs"
fn main() {
    let text = String::from("hello world");
    let hello = &text[0..5];

    println!("{hello}");
}
```

`&text[0..5]` 是字符串切片，类型是 `&str`。

## 范围写法

```rust
&text[..5]   // 从开头到 5，不包含 5
&text[6..]   // 从 6 到末尾
&text[..]    // 整个字符串
```

字符串切片索引是字节位置，不是字符位置。处理中文时要特别小心。

## 数组切片

```rust showLineNumbers title="src/main.rs"
fn main() {
    let values = [10, 20, 30, 40];
    let part = &values[1..3];

    println!("{part:?}");
}
```

输出：

```text
[20, 30]
```

## 函数参数优先使用切片

如果函数只需要读取字符串，优先写 `&str`：

```rust
fn print_name(name: &str) {
    println!("{name}");
}
```

这样既可以传 `String` 的引用，也可以传字符串字面量：

```rust
let name = String::from("Rust");
print_name(&name);
print_name("GetIoT");
```

## 小结

你需要掌握：

- slice 是借用数据的一部分。
- 字符串切片类型是 `&str`。
- 数组切片类型类似 `&[T]`。
- 字符串切片索引按字节计算。
- 函数参数常优先使用 `&str` 和 `&[T]`。
