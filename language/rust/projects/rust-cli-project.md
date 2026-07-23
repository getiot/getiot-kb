---
sidebar_position: 0
slug: /rust-cli-project
---

# 命令行工具实战

这一节我们做一个很小的命令行工具：读取一个文件，并统计行数、单词数和字节数。你会把参数、文件读取、错误处理组合起来。

## 创建项目

```bash
cargo new mini-wc
cd mini-wc
```

## 编写代码

```rust title="src/main.rs" showLineNumbers
use std::env;
use std::fs;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let filename = env::args().nth(1).ok_or("usage: mini-wc <file>")?;
    let text = fs::read_to_string(&filename)?;

    let lines = text.lines().count();
    let words = text.split_whitespace().count();
    let bytes = text.len();

    println!("{lines:>8} {words:>8} {bytes:>8} {filename}");
    Ok(())
}
```

## 运行

```bash
cargo run -- README.md
```

你会看到类似输出：

```text
       3       20      120 README.md
```

## 可以继续改进什么

- 支持多个文件
- 支持从 stdin 读取
- 使用 `clap` 生成帮助信息
- 为统计逻辑编写测试

## 小结

小工具是学习 Rust 的好练习。它范围可控，但会自然用到参数解析、文件系统、错误处理和字符串处理。

