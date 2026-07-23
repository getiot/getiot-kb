---
sidebar_position: 5
slug: /rust-comments
---

# Rust 注释与文档注释

注释帮助人理解代码。Rust 还支持文档注释，可以直接生成 API 文档。

## 普通注释

单行注释：

```rust
// 读取传感器值
let value = 23.5;
```

多行注释：

```rust
/*
这里可以写多行说明。
*/
```

普通注释不会出现在生成的文档中。

## 文档注释

文档注释使用 `///`，通常写在函数、结构体、枚举、模块前面：

```rust
/// 计算两个整数之和。
fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

为 crate 或模块写文档，可以使用 `//!`：

```rust
//! 这是当前 crate 的说明。
```

## 生成文档

```bash
cargo doc --open
```

Cargo 会生成 HTML 文档并在浏览器中打开。

## 文档测试

文档注释中的代码也可以被测试：

```rust
/// 返回两数之和。
///
/// # Examples
///
/// ```
/// let result = add(2, 3);
/// assert_eq!(result, 5);
/// ```
fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

运行：

```bash
cargo test
```

Rust 会检查文档示例是否仍然可用。

## 小结

你需要掌握：

- `//` 是普通单行注释。
- `///` 是 API 文档注释。
- `//!` 常用于 crate 或模块级文档。
- `cargo doc --open` 可以生成文档。
- 文档示例可以参与测试。
