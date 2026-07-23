---
sidebar_position: 4
slug: /rust-process
---

# 进程与命令执行

Rust 可以通过 `std::process::Command` 启动外部命令。它适合写自动化工具、构建脚本、系统管理程序。

## 执行命令

```rust title="src/main.rs" showLineNumbers
use std::process::Command;

fn main() -> Result<(), std::io::Error> {
    let output = Command::new("rustc")
        .arg("--version")
        .output()?;

    println!("{}", String::from_utf8_lossy(&output.stdout));
    Ok(())
}
```

`output()` 会等待命令结束，并收集标准输出和标准错误。

## 检查退出状态

```rust
if output.status.success() {
    println!("command succeeded");
} else {
    eprintln!("command failed: {}", output.status);
}
```

不要只看有没有输出，要检查退出状态。

## 传递多个参数

```rust
let status = Command::new("git")
    .args(["status", "--short"])
    .status()?;
```

`status()` 只关心退出状态，不收集输出。

## 小结

`Command` 的关键点是：命令名和参数分开传递，执行后检查返回状态。不要把用户输入直接拼成一整条 shell 命令。

