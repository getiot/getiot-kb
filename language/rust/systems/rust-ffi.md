---
sidebar_position: 8
slug: /rust-ffi
---

# Rust 与 C FFI

FFI 是 Foreign Function Interface 的缩写，表示一种语言调用另一种语言代码的接口。Rust 可以调用 C，也可以把 Rust 函数暴露给 C。

## 调用 C 函数

下面声明 C 标准库中的 `abs` 函数：

```rust title="src/main.rs" showLineNumbers
unsafe extern "C" {
    fn abs(input: i32) -> i32;
}

fn main() {
    let value = unsafe { abs(-3) };
    println!("{value}");
}
```

`extern "C"` 表示使用 C ABI。调用外部函数通常是 `unsafe`，因为 Rust 编译器无法检查 C 代码是否满足安全条件。

## 向 C 暴露 Rust 函数

```rust
#[unsafe(no_mangle)]
pub extern "C" fn add(left: i32, right: i32) -> i32 {
    left + right
}
```

`extern "C"` 指定 ABI，`no_mangle` 用于保留函数名，方便 C 侧链接。

## 字符串要特别小心

Rust 的 `String` 和 C 的字符串不是同一种表示。跨 FFI 传递字符串时，通常要使用 `CString`、`CStr` 和裸指针。

:::warning
FFI 的内存归属必须非常明确：谁分配、谁释放、指针能活多久，都要写清楚。
:::

## 小结

FFI 是 Rust 接入现有 C/C++ 生态的重要能力。你要记住边界原则：Rust 内部尽量保持安全，跨语言边界处集中处理 `unsafe` 和内存约定。

