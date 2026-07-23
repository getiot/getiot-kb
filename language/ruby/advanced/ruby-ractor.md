---
sidebar_position: 2
sidebar_label: Ractor 入门
slug: /ruby-ractor
---

# Ruby Ractor 入门

Ractor 是 Ruby 为并行执行提供的机制。它通过隔离对象共享，减少多线程共享可变状态带来的问题。

## 基本示例

```ruby
ractor = Ractor.new do
  message = Ractor.receive
  "hello #{message}"
end

ractor.send("Ruby")
puts ractor.take
```

`send` 发送消息，`take` 获取 Ractor 返回结果。

## 为什么需要隔离

多线程共享可变对象容易产生竞态条件。Ractor 要求不同 Ractor 之间通过消息传递数据，并对对象共享有更严格规则。

这让并行更安全，但也让使用方式更受限制。

## 适合什么场景

Ractor 更适合：

- CPU 密集型并行任务。
- 数据可以清楚切分的任务。
- 不需要共享大量可变对象的任务。

不适合：

- 简单脚本。
- 大量依赖不兼容库的项目。
- 需要共享复杂对象图的业务。

## 学习建议

初学阶段先掌握 Thread 和 Mutex，再了解 Ractor。Ractor 是进阶工具，不是日常 Ruby 入门必须使用的并发方案。

## 小结

Ractor 通过隔离和消息传递帮助 Ruby 做并行。它更安全，也更受限制，适合在明确需要 CPU 并行时评估。

