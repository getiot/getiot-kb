---
sidebar_position: 1
slug: /rust-vector
---

# Vector

`Vec<T>` 是 Rust 中最常用的可增长数组。它保存同一种类型的多个值。

## 创建 Vec

```rust showLineNumbers title="src/main.rs"
fn main() {
    let mut values = Vec::new();

    values.push(10);
    values.push(20);
    values.push(30);

    println!("{values:?}");
}
```

也可以使用宏：

```rust
let values = vec![10, 20, 30];
```

## 访问元素

```rust
let first = values[0];
```

如果下标越界，程序会 panic。更安全的方式是 `get()`：

```rust
match values.get(0) {
    Some(value) => println!("{value}"),
    None => println!("not found"),
}
```

## 遍历 Vec

```rust showLineNumbers title="src/main.rs"
fn main() {
    let values = vec![10, 20, 30];

    for value in &values {
        println!("{value}");
    }
}
```

使用 `&values` 可以避免把 vector 的所有权移入循环。

## 小结

你需要掌握：

- `Vec<T>` 是可增长数组。
- `push()` 添加元素。
- `get()` 返回 `Option`，比直接下标更安全。
- 遍历时常用 `&values` 借用。
