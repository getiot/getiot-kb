---
sidebar_position: 6
slug: /rust-smart-pointers
---

# 智能指针

智能指针像指针，但带有额外规则。Rust 中常见的智能指针包括 `Box<T>`、`Rc<T>`、`Arc<T>`、`RefCell<T>`、`Mutex<T>`。

## Box

`Box<T>` 把数据放到堆上，并在离开作用域时自动释放。

```rust
let value = Box::new(42);
println!("{value}");
```

它常用于递归数据结构或避免移动大对象。

## Rc

`Rc<T>` 用于单线程多所有者。

```rust
use std::rc::Rc;

let a = Rc::new(String::from("shared"));
let b = Rc::clone(&a);

println!("{a}, {b}");
```

`Rc` 通过引用计数决定数据何时释放。

## Arc

`Arc<T>` 是线程安全的引用计数指针，常用于多线程共享只读数据。

```rust
use std::sync::Arc;
use std::thread;

let data = Arc::new(vec![1, 2, 3]);
let cloned = Arc::clone(&data);

thread::spawn(move || {
    println!("{cloned:?}");
}).join().unwrap();
```

## Mutex

当多个线程需要修改共享数据时，可以使用 `Mutex<T>`。

```rust
use std::sync::{Arc, Mutex};
use std::thread;

let counter = Arc::new(Mutex::new(0));
let cloned = Arc::clone(&counter);

thread::spawn(move || {
    let mut value = cloned.lock().unwrap();
    *value += 1;
}).join().unwrap();
```

## 小结

智能指针不是越多越高级。优先使用普通所有权和引用；当确实需要共享、堆分配或内部可变性时，再选择合适的智能指针。

