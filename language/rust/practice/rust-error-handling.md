---
sidebar_position: 1
slug: /rust-error-handling
---

# 错误处理

Rust 把错误分成两类：可恢复错误和不可恢复错误。可恢复错误通常用 `Result` 表示，不可恢复错误通常用 `panic!` 终止程序。

## panic!

```rust
fn main() {
    panic!("something went wrong");
}
```

`panic!` 适合表示程序已经无法继续，例如数组越界、违反内部假设。业务错误、文件不存在、网络失败这类情况通常不应该直接 panic。

## Result

`Result` 的定义可以简化理解成这样：

```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```

例如读取文件：

```rust title="src/main.rs" showLineNumbers
use std::fs;

fn main() {
    let content = fs::read_to_string("config.txt");

    match content {
        Ok(text) => println!("{text}"),
        Err(err) => println!("读取失败: {err}"),
    }
}
```

## 使用 ? 传播错误

当函数本身返回 `Result` 时，你可以用 `?` 把错误交给调用者处理。

```rust title="src/main.rs" showLineNumbers
use std::fs;
use std::io;

fn read_config() -> Result<String, io::Error> {
    let text = fs::read_to_string("config.txt")?;
    Ok(text)
}

fn main() {
    match read_config() {
        Ok(text) => println!("{text}"),
        Err(err) => eprintln!("error: {err}"),
    }
}
```

`?` 的意思不是忽略错误，而是“如果这里失败，就立刻返回错误”。

## unwrap 和 expect

```rust
let value = "42".parse::<i32>().unwrap();
```

`unwrap()` 遇到错误会 panic。学习阶段可以临时使用，正式代码里要谨慎。

```rust
let value = "42".parse::<i32>().expect("数字格式不正确");
```

`expect()` 至少能给 panic 提供更清楚的说明。

## 小结

Rust 鼓励你显式面对错误。你可以把 `Result` 看成一种提醒：这里可能失败，请你决定失败时怎么办。

