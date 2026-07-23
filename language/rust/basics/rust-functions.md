---
sidebar_position: 3
slug: /rust-functions
---

# Rust 函数

函数用于组织代码。Rust 函数使用 `fn` 定义，参数必须写类型，返回值也要写类型。

## 定义函数

```rust showLineNumbers title="src/main.rs"
fn add(a: i32, b: i32) -> i32 {
    a + b
}

fn main() {
    let result = add(3, 5);
    println!("{result}");
}
```

输出：

```text
8
```

`a + b` 后面没有分号，所以它是函数返回值。

## 使用 return

你也可以显式写 `return`：

```rust
fn add(a: i32, b: i32) -> i32 {
    return a + b;
}
```

Rust 更惯用的写法是把最后一个表达式作为返回值。

## 无返回值函数

如果函数不返回有意义的值，可以省略返回类型：

```rust
fn say_hello(name: &str) {
    println!("Hello, {name}");
}
```

这种函数实际返回 unit 类型 `()`。

## 参数是不可变绑定

函数参数默认不可变：

```rust
fn show(value: i32) {
    println!("{value}");
}
```

如果你要在函数内部修改参数绑定，可以写：

```rust
fn increase(mut value: i32) -> i32 {
    value += 1;
    value
}
```

这只是修改函数内部的局部绑定，不会修改调用者的变量。

## 小结

你需要掌握：

- 函数使用 `fn` 定义。
- 参数必须标注类型。
- 返回类型写在 `->` 后面。
- 最后一个无分号表达式可作为返回值。
- 无返回值函数返回 `()`。
