---
sidebar_position: 7
slug: /rust-unsafe
---

# Unsafe Rust

Rust 默认提供内存安全保证，但有些底层操作编译器无法完全检查。这时你可以使用 `unsafe`。

## unsafe 能做什么

`unsafe` 主要允许：

- 解引用裸指针
- 调用 unsafe 函数
- 访问或修改可变静态变量
- 实现 unsafe trait
- 访问 union 字段

## 裸指针示例

```rust
fn main() {
    let mut value = 10;

    let p1 = &value as *const i32;
    let p2 = &mut value as *mut i32;

    unsafe {
        println!("{}", *p1);
        *p2 = 20;
    }

    println!("{value}");
}
```

裸指针可以为空，可以悬垂，也不受借用检查器完整保护，所以解引用必须放在 `unsafe` 块里。

## unsafe 不是关闭所有检查

即使在 `unsafe` 块中，Rust 的所有权、类型检查、生命周期检查仍然存在。`unsafe` 只是开启少数额外能力。

## 写 unsafe 的习惯

- 尽量缩小 `unsafe` 块范围
- 在注释中说明你保证了什么安全条件
- 把 unsafe 封装在安全 API 后面
- 优先使用标准库或成熟 crate

## 小结

初学者不需要急着写 `unsafe`。你需要先理解安全 Rust，等遇到 FFI、硬件寄存器、性能边界时，再谨慎使用它。

