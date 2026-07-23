---
sidebar_position: 5
slug: /rust-closures
---

# 闭包 Closure

closure 是可以保存到变量中、也可以传给函数的匿名函数。它可以捕获周围环境中的变量。

## 基本写法

```rust showLineNumbers title="src/main.rs"
fn main() {
    let add_one = |x| x + 1;

    println!("{}", add_one(5));
}
```

输出：

```text
6
```

## 捕获环境

```rust showLineNumbers title="src/main.rs"
fn main() {
    let factor = 10;
    let multiply = |x| x * factor;

    println!("{}", multiply(3));
}
```

closure 捕获了外部变量 `factor`。

## 作为参数

```rust
fn apply<F>(value: i32, f: F) -> i32
where
    F: Fn(i32) -> i32,
{
    f(value)
}
```

使用：

```rust
let result = apply(5, |x| x * x);
```

## 小结

你需要掌握：

- closure 使用 `|args| body`。
- closure 可以捕获环境变量。
- closure 常和 iterator、回调、延迟计算一起使用。
- 参数中的 closure 通常用 `Fn`、`FnMut`、`FnOnce` 约束。
