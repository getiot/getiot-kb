---
sidebar_position: 3
slug: /rust-generics
---

# 泛型 Generics

泛型让你编写适用于多种类型的代码。你可以把它理解为“类型参数”。

## 泛型函数

```rust
fn first<T>(values: &[T]) -> Option<&T> {
    values.get(0)
}
```

`T` 表示任意类型。

使用：

```rust showLineNumbers title="src/main.rs"
fn first<T>(values: &[T]) -> Option<&T> {
    values.get(0)
}

fn main() {
    let numbers = vec![1, 2, 3];
    let names = vec!["Alice", "Bob"];

    println!("{:?}", first(&numbers));
    println!("{:?}", first(&names));
}
```

## 泛型结构体

```rust
struct Point<T> {
    x: T,
    y: T,
}
```

使用：

```rust
let p1 = Point { x: 1, y: 2 };
let p2 = Point { x: 1.0, y: 2.0 };
```

## 小结

你需要掌握：

- 泛型用类型参数表示。
- 函数、结构体、枚举和 trait 都可以使用泛型。
- 泛型能减少重复代码。
- 泛型常和 trait bound 一起使用。
