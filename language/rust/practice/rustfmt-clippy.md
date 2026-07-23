---
sidebar_position: 3
slug: /rustfmt-clippy
---

# 格式化与 Clippy

Rust 社区非常重视一致的代码风格。`rustfmt` 负责自动格式化，`Clippy` 负责给出更细的代码建议。

## rustfmt

在 Cargo 项目中运行：

```bash
cargo fmt
```

它会按照 Rust 社区约定格式化代码。你不需要和缩进、换行、空格纠缠太久，把精力留给程序本身。

## Clippy

运行：

```bash
cargo clippy
```

Clippy 会提醒你一些可能更清晰、更符合 Rust 习惯的写法。

例如，它可能建议把：

```rust
if value == true {
    println!("yes");
}
```

改成：

```rust
if value {
    println!("yes");
}
```

## 在提交前检查

一个实用习惯是提交代码前运行：

```bash
cargo fmt
cargo clippy
cargo test
```

这三条命令分别检查格式、常见问题和行为正确性。

## 小结

`rustfmt` 帮你保持整洁，`Clippy` 帮你靠近 Rust 的惯用写法。初学时不必一次理解所有建议，但要认真读它给出的提示。

