---
sidebar_position: 2
slug: /rust-hashmap
---

# HashMap

`HashMap<K, V>` 用于保存键值对，类似很多语言中的 dictionary 或 map。

## 创建 HashMap

```rust showLineNumbers title="src/main.rs"
use std::collections::HashMap;

fn main() {
    let mut scores = HashMap::new();

    scores.insert(String::from("Alice"), 95);
    scores.insert(String::from("Bob"), 82);

    println!("{scores:?}");
}
```

## 读取值

```rust
let score = scores.get("Alice");
```

`get()` 返回 `Option<&V>`：

```rust
match scores.get("Alice") {
    Some(score) => println!("{score}"),
    None => println!("not found"),
}
```

## 遍历 HashMap

```rust
for (name, score) in &scores {
    println!("{name}: {score}");
}
```

遍历顺序不固定，不要依赖它。

## entry

只在 key 不存在时插入：

```rust
scores.entry(String::from("Cindy")).or_insert(100);
```

## 小结

你需要掌握：

- `HashMap` 位于 `std::collections`。
- `insert()` 插入键值对。
- `get()` 返回 `Option`。
- 遍历顺序不固定。
- `entry()` 适合“没有就插入”的场景。
