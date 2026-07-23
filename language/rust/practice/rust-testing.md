---
sidebar_position: 2
slug: /rust-testing
---

# 测试

Rust 自带测试框架。你不用额外安装工具，就可以给函数写单元测试。

## 编写测试

```rust title="src/lib.rs" showLineNumbers
pub fn add(left: i32, right: i32) -> i32 {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn add_two_numbers() {
        assert_eq!(add(2, 3), 5);
    }
}
```

运行测试：

```bash
cargo test
```

如果测试通过，你会看到类似输出：

```text
test tests::add_two_numbers ... ok
```

## 常用断言

```rust
assert!(value > 0);
assert_eq!(actual, expected);
assert_ne!(left, right);
```

`assert_eq!` 和 `assert_ne!` 在失败时会打印左右两边的值，更方便排查问题。

## 测试 panic

```rust
#[test]
#[should_panic]
fn it_panics() {
    panic!("boom");
}
```

这类测试用于验证某些非法输入确实会触发 panic。

## 集成测试

集成测试通常放在 `tests/` 目录：

```text
my-project/
├── src/
│   └── lib.rs
└── tests/
    └── api_test.rs
```

`tests/api_test.rs` 会像外部用户一样使用你的 library crate。

## 小结

测试不是最后才补的装饰。你每写完一个小函数，都可以顺手写一个测试，确认它在正常输入和边界输入下都符合预期。

