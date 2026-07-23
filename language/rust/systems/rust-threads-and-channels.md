---
sidebar_position: 5
slug: /rust-threads-and-channels
---

# 线程与消息传递

Rust 支持多线程。它的特别之处在于，很多数据竞争问题会在编译阶段被拦住。

## 创建线程

```rust title="src/main.rs" showLineNumbers
use std::thread;

fn main() {
    let handle = thread::spawn(|| {
        for i in 1..=3 {
            println!("worker: {i}");
        }
    });

    handle.join().unwrap();
}
```

`join()` 会等待线程结束。

## move 闭包

```rust
let message = String::from("hello");

let handle = std::thread::spawn(move || {
    println!("{message}");
});

handle.join().unwrap();
```

`move` 会把闭包用到的值移动进线程，避免线程引用已经失效的数据。

## channel

channel 用于在线程之间发送消息。

```rust title="src/main.rs" showLineNumbers
use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();

    thread::spawn(move || {
        tx.send(String::from("temperature=26")).unwrap();
    });

    let msg = rx.recv().unwrap();
    println!("{msg}");
}
```

`tx` 是发送端，`rx` 是接收端。

## 小结

Rust 的并发并不是不让你共享数据，而是要求你明确共享方式。能传消息就传消息，必须共享时再考虑锁和原子类型。

