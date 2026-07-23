---
sidebar_position: 6
slug: /rust-option-result
---

# Option 与 Result

Rust 不鼓励你用空指针和异常表达普通失败。它用 `Option<T>` 表示“可能没有值”，用 `Result<T, E>` 表示“可能失败”。

## Option

```rust
let value: Option<i32> = Some(10);
let empty: Option<i32> = None;
```

处理 `Option`：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let value = Some(10);

    match value {
        Some(n) => println!("{n}"),
        None => println!("no value"),
    }
}
```

## Result

解析字符串为数字会返回 `Result`：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let result = "42".parse::<i32>();

    match result {
        Ok(n) => println!("{n}"),
        Err(e) => println!("parse error: {e}"),
    }
}
```

## unwrap 和 expect

`unwrap()` 会在失败时 panic：

```rust
let n = "42".parse::<i32>().unwrap();
```

`expect()` 可以提供更清楚的错误信息：

```rust
let n = "42".parse::<i32>().expect("not a number");
```

初学示例中可以使用它们，但正式程序应优先处理错误。

## ? 运算符

`?` 可以把错误向上传播：

```rust
use std::fs;
use std::io;

fn read_config() -> io::Result<String> {
    let content = fs::read_to_string("config.txt")?;
    Ok(content)
}
```

如果读取失败，函数会直接返回错误；成功时取出里面的值。

## 小结

你需要掌握：

- `Option<T>` 表示有值或没有值。
- `Result<T, E>` 表示成功或失败。
- `match` 能完整处理所有分支。
- `unwrap()` 和 `expect()` 会在失败时 panic。
- `?` 用于传播错误。
