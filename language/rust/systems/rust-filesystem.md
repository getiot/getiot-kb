---
sidebar_position: 1
slug: /rust-filesystem
---

# 文件与目录操作

Rust 使用 `std::fs` 处理文件和目录。文件操作经常失败，所以很多函数都会返回 `Result`。

## 读取文本文件

```rust title="src/main.rs" showLineNumbers
use std::fs;

fn main() -> Result<(), std::io::Error> {
    let text = fs::read_to_string("hello.txt")?;
    println!("{text}");
    Ok(())
}
```

这里的 `?` 会在读取失败时返回错误。

## 写入文件

```rust
use std::fs;

fn main() -> Result<(), std::io::Error> {
    fs::write("output.txt", "hello rust\n")?;
    Ok(())
}
```

`fs::write` 会创建文件；如果文件已存在，会覆盖原内容。

:::warning
覆盖文件前要确认路径正确。涉及重要数据时，先备份再操作。
:::

## 遍历目录

```rust title="src/main.rs" showLineNumbers
use std::fs;

fn main() -> Result<(), std::io::Error> {
    for entry in fs::read_dir(".")? {
        let entry = entry?;
        println!("{}", entry.path().display());
    }

    Ok(())
}
```

`read_dir` 返回的是迭代器，每个目录项也可能出错，所以循环里还有一次 `?`。

## 判断路径类型

```rust
let path = std::path::Path::new("hello.txt");

if path.is_file() {
    println!("file");
} else if path.is_dir() {
    println!("directory");
}
```

## 小结

文件系统 API 的核心特点是大量返回 `Result`。你要习惯把“路径不存在、权限不足、磁盘失败”这些情况当作正常分支处理。

