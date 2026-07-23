---
sidebar_position: 7
slug: /rust-lifetimes
---

# 生命周期 Lifetime

lifetime 用来描述引用有效的范围。你可以先把它理解成：编译器要确认“引用不会比它指向的数据活得更久”。

大多数时候，Rust 能自动推断 lifetime。你只在某些函数签名和结构体中需要显式写出来。

## 为什么需要 lifetime

下面的代码不能通过编译：

```rust
fn dangling() -> &String {
    let s = String::from("hello");
    &s
}
```

因为 `s` 在函数结束时被释放，返回它的引用会变成悬垂引用。Rust 不允许这种情况。

## lifetime 标注

当函数返回的引用来自参数时，你可能需要告诉编译器它们之间的关系：

```rust showLineNumbers title="src/main.rs"
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

fn main() {
    let a = "hello";
    let b = "rust";

    println!("{}", longest(a, b));
}
```

`'a` 的意思不是“让引用活得更久”，而是描述返回值不会比参数引用活得更久。

## 结构体中的引用

如果结构体保存引用，需要写 lifetime：

```rust
struct Config<'a> {
    name: &'a str,
}
```

这表示 `Config` 不能比它引用的 `name` 活得更久。

## 先别害怕 lifetime

初学时你应该先掌握 ownership 和 borrowing。lifetime 是在引用关系变复杂时，帮助编译器理解代码。

很多日常代码不需要显式 lifetime：

```rust
fn first_word(s: &str) -> &str {
    s.split_whitespace().next().unwrap_or("")
}
```

编译器可以自动推断这里的关系。

## 小结

你需要掌握：

- lifetime 保证引用不会悬垂。
- lifetime 标注描述引用之间的关系，不会延长数据生命。
- 返回参数中的引用时，可能需要显式 lifetime。
- 结构体保存引用时通常需要 lifetime。
- 不要一开始就过度使用引用，必要时拥有数据会更简单。
