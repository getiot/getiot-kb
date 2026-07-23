---
sidebar_position: 1
slug: /rust-variables
---

# Rust 变量与可变性

Rust 变量默认不可变。这一点和很多语言不同，但它能让代码更容易推理：如果你看到一个变量没有 `mut`，就知道它不会被重新赋值。

## 默认不可变

```rust showLineNumbers title="src/main.rs"
fn main() {
    let x = 5;
    println!("{x}");
}
```

下面这段代码会编译失败：

```rust
fn main() {
    let x = 5;
    x = 6;
}
```

编译器会提醒你：不能给不可变变量重新赋值。

## 使用 mut

如果你确实需要修改变量，使用 `mut`：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let mut x = 5;
    x = 6;

    println!("{x}");
}
```

## 常量

常量使用 `const`：

```rust
const MAX_RETRY: u32 = 3;
```

常量必须标注类型，通常使用全大写加下划线命名。

## Shadowing

Rust 允许用同名变量遮蔽前一个变量：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let spaces = "   ";
    let spaces = spaces.len();

    println!("{spaces}");
}
```

这不是修改原变量，而是创建了一个新变量。shadowing 可以改变类型，`mut` 不可以。

## 小结

你需要掌握：

- `let` 创建变量。
- 变量默认不可变。
- 需要修改时写 `mut`。
- `const` 用于常量。
- shadowing 会创建新的同名变量。
