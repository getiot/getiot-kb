---
sidebar_position: 7
slug: /rust-async-await
---

# 异步编程 async/await

异步编程用于处理大量等待型任务，例如网络请求、数据库访问、定时任务。它不是让单个计算变快，而是让程序在等待 I/O 时可以继续做别的事。

## async 函数

```rust
async fn fetch_data() -> String {
    "data".to_string()
}
```

调用 async 函数不会立刻执行完整逻辑，而是返回一个 future。

```rust
let future = fetch_data();
```

要真正等待结果，需要 `.await`，而 `.await` 只能写在 async 上下文里。

## 为什么需要运行时

Rust 标准库定义了 async/await 语法和 Future trait，但不自带完整异步运行时。实际项目常用 Tokio 或 async-std 来调度异步任务。

## 同步和异步的区别

同步代码像排队办事：一个操作没结束，当前线程就等着。

异步代码像登记号码：当前任务等待 I/O 时，运行时可以去推进其他任务。

## 初学建议

先学会同步 TCP/UDP，再学习 async/await。这样你会知道异步解决的是“等待很多 I/O”的问题，而不是一种必须到处使用的新语法。

## 小结

async/await 的核心是 future 和运行时。你写 async 函数描述将来要完成的任务，运行时负责调度这些任务。

