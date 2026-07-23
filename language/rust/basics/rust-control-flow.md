---
sidebar_position: 4
slug: /rust-control-flow
---

# Rust 控制流程

控制流程决定程序执行路径。Rust 常见控制流程包括 `if`、`loop`、`while`、`for` 和 `match`。这一节先介绍基础形式，`match` 会在模式匹配章节深入讲。

## if 表达式

```rust showLineNumbers title="src/main.rs"
fn main() {
    let score = 86;

    if score >= 60 {
        println!("pass");
    } else {
        println!("fail");
    }
}
```

Rust 的 `if` 条件必须是 `bool`，不能把整数当作条件。

## if 也能返回值

```rust showLineNumbers title="src/main.rs"
fn main() {
    let score = 86;
    let level = if score >= 90 { "A" } else { "B" };

    println!("{level}");
}
```

`if` 两个分支返回的类型必须一致。

## loop

`loop` 表示无限循环：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let mut count = 0;

    loop {
        count += 1;

        if count == 3 {
            break;
        }
    }
}
```

`break` 可以返回值：

```rust
let result = loop {
    break 42;
};
```

## while

```rust showLineNumbers title="src/main.rs"
fn main() {
    let mut n = 3;

    while n > 0 {
        println!("{n}");
        n -= 1;
    }
}
```

## for

遍历数组：

```rust showLineNumbers title="src/main.rs"
fn main() {
    let values = [10, 20, 30];

    for value in values {
        println!("{value}");
    }
}
```

遍历范围：

```rust
for i in 1..=5 {
    println!("{i}");
}
```

`1..=5` 包含 5，`1..5` 不包含 5。

## 小结

你需要掌握：

- `if` 条件必须是 `bool`。
- `if` 可以作为表达式返回值。
- `loop` 用于无限循环。
- `while` 用于条件循环。
- `for` 常用于遍历集合和范围。
