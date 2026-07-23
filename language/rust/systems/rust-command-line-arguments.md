---
sidebar_position: 2
slug: /rust-command-line-arguments
---

# 命令行参数

命令行工具通常需要从参数读取输入，例如文件名、端口号、运行模式等。

## 读取 args

```rust title="src/main.rs" showLineNumbers
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    println!("{args:?}");
}
```

运行：

```bash
cargo run -- hello.txt
```

`--` 后面的内容会传给你的程序，而不是传给 Cargo。

## 获取第一个参数

```rust title="src/main.rs" showLineNumbers
use std::env;

fn main() {
    let filename = env::args().nth(1).unwrap_or_else(|| {
        eprintln!("usage: app <filename>");
        std::process::exit(1);
    });

    println!("file: {filename}");
}
```

`nth(1)` 是第一个用户参数，因为 `nth(0)` 通常是程序自身路径。

## 更适合复杂 CLI 的方式

当参数变多时，手动解析会很麻烦。实际项目里常用 `clap` 这样的 crate 来处理：

- 子命令
- 帮助信息
- 默认值
- 参数校验

本教程后面的命令行工具实战会使用更接近真实项目的写法。

## 小结

简单程序可以直接用 `std::env::args()`。如果你要做正式 CLI 工具，就应该考虑使用成熟的参数解析库。

