---
sidebar_position: 6
slug: /rust-iterators
---

# 迭代器 Iterator

iterator 用于逐个处理集合中的值。Rust 的迭代器是惰性的：只有被消费时才真正执行。

## iter

```rust showLineNumbers title="src/main.rs"
fn main() {
    let values = vec![1, 2, 3];

    for value in values.iter() {
        println!("{value}");
    }
}
```

`iter()` 产生不可变引用。

## map 和 collect

```rust showLineNumbers title="src/main.rs"
fn main() {
    let values = vec![1, 2, 3];
    let doubled: Vec<i32> = values.iter().map(|x| x * 2).collect();

    println!("{doubled:?}");
}
```

输出：

```text
[2, 4, 6]
```

## filter

```rust
let even: Vec<i32> = values
    .into_iter()
    .filter(|x| x % 2 == 0)
    .collect();
```

## 常见方法

| 方法 | 说明 |
| :--- | :--- |
| `iter()` | 按引用迭代 |
| `iter_mut()` | 按可变引用迭代 |
| `into_iter()` | 消费集合迭代 |
| `map()` | 转换元素 |
| `filter()` | 过滤元素 |
| `collect()` | 收集结果 |
| `fold()` | 累积计算 |

## 小结

你需要掌握：

- iterator 是惰性的。
- `for` 循环背后也使用 iterator。
- `map`、`filter`、`collect` 很常见。
- 注意 `iter()`、`iter_mut()`、`into_iter()` 的所有权差异。
