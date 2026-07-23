---
sidebar_position: 1
sidebar_label: Fiber 与异步 I/O
slug: /ruby-fiber-async-io
---

# Ruby Fiber 与异步 I/O

Fiber 是轻量的协作式执行单元。和 Thread 不同，Fiber 不会由操作系统抢占调度，而是在代码指定的位置暂停和恢复。

## 基本 Fiber

```ruby
fiber = Fiber.new do
  Fiber.yield "step 1"
  "step 2"
end

puts fiber.resume
puts fiber.resume
```

第一次 `resume` 执行到 `Fiber.yield` 并返回 `"step 1"`，第二次继续执行并返回 `"step 2"`。

## Fiber 和 Thread 的区别

Thread 更像多个执行线程，调度由系统和 Ruby VM 共同决定。

Fiber 更像一个可以暂停的函数，什么时候让出执行权由程序控制。

## 异步 I/O

异步 I/O 的核心目标是：当一个任务等待网络或磁盘时，不要让整个程序闲着。

在现代 Ruby 中，一些异步框架会利用 Fiber 和 scheduler 来组织 I/O 并发。初学时你不需要手写 scheduler，但要理解 Fiber 是“可暂停、可恢复”的执行过程。

## 适用场景

- 网络服务中的大量 I/O 等待。
- 流式数据处理。
- 生成器式逻辑。
- 异步框架内部调度。

## 小结

Fiber 不是 Thread 的简单替代品。你可以先把它理解成可暂停任务，再在学习异步框架时理解它如何调度 I/O。

