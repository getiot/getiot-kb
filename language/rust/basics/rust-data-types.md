---
sidebar_position: 2
slug: /rust-data-types
---

# Rust 数据类型

Rust 是静态类型语言。编译器通常能推断类型，但在函数参数、常量和某些复杂场景中，你需要显式标注类型。

## 标量类型

常见标量类型：

| 类型 | 示例 | 说明 |
| :--- | :--- | :--- |
| integer | `i32`、`u32` | 有符号/无符号整数 |
| float | `f32`、`f64` | 浮点数 |
| bool | `true`、`false` | 布尔值 |
| char | `'A'`、`'中'` | Unicode scalar value |

示例：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let count: u32 = 10;
    let temperature: f64 = 23.5;
    let online: bool = true;
    let mark: char = 'R';

    println!("{count}, {temperature}, {online}, {mark}");
}
```

## 整数类型

常见整数类型有：

| 有符号 | 无符号 |
| :--- | :--- |
| `i8` | `u8` |
| `i16` | `u16` |
| `i32` | `u32` |
| `i64` | `u64` |
| `i128` | `u128` |
| `isize` | `usize` |

默认整数类型通常是 `i32`。索引和长度通常使用 `usize`。

## 复合类型

tuple：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let point = (10, 20);
    println!("{}, {}", point.0, point.1);
}
```

array：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let values = [1, 2, 3];
    println!("{}", values[0]);
}
```

数组长度固定。需要可增长集合时，使用 `Vec<T>`。

## 类型推断

Rust 可以推断很多类型：

```rust
let x = 10;
let name = "Rust";
```

但有时你要帮助编译器：

```rust
let value: u32 = "42".parse().expect("not a number");
```

## 小结

你需要掌握：

- Rust 是静态类型语言。
- 常用整数是 `i32`、`u32`、`usize`。
- `f64` 是默认浮点类型。
- tuple 可保存不同类型，array 长度固定。
- 类型推断很强，但不是所有地方都能推断。
