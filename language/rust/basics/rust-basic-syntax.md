---
sidebar_position: 0
slug: /rust-basic-syntax
---

# Rust 基础语法

这一节先让你熟悉 Rust 程序的基本外观。你会看到函数、语句、表达式、分号、代码块和打印输出。

## 最小程序

```rust showLineNumbers title="main.rs"
fn main() {
    println!("Hello, Rust!");
}
```

运行：

```bash
cargo run
```

`main` 是可执行程序入口。`println!` 是 macro，用于输出一行文本。

## 语句和表达式

Rust 中很多代码块都是表达式，可以产生值：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let x = {
        let a = 1;
        a + 2
    };

    println!("{x}");
}
```

输出：

```text
3
```

注意 `a + 2` 后面没有分号。没有分号时，它是表达式的返回值；加上分号就变成语句，不再返回这个值。

## 打印变量

```rust showLineNumbers title="src/main.rs"
fn main() {
    let name = "Rust";
    let year = 2015;

    println!("name: {name}");
    println!("year: {year}");
}
```

`{name}` 是格式化占位。你也可以写：

```rust
println!("name: {}", name);
```

## 注释

单行注释：

```rust
// 这是一行注释
```

多行注释：

```rust
/*
这里是多行注释
*/
```

文档注释会在后续章节介绍。

## 小结

你需要掌握：

- `fn main()` 是程序入口。
- Rust 语句通常以分号结尾。
- 代码块可以作为表达式返回值。
- `println!` 是 macro，不是普通函数。
