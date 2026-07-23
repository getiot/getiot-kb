---
sidebar_position: 0
sidebar_label: Thread 与 GVL
slug: /ruby-thread-gvl
---

# Ruby Thread 与 GVL

Ruby 支持 Thread，但在 CRuby 中有 GVL。GVL 是 Global VM Lock 的缩写，它会影响 Ruby 线程并行执行 Ruby 代码的方式。

初学时你不需要把并发模型全部吃透，但要知道：Ruby Thread 能解决一些等待问题，不一定能让 CPU 密集计算变快。

## 创建线程

```ruby
thread = Thread.new do
  puts "worker"
end

thread.join
```

`join` 会等待线程执行结束。

## 多个线程

```ruby
threads = 3.times.map do |i|
  Thread.new do
    puts "thread #{i}"
  end
end

threads.each(&:join)
```

## 共享数据要小心

```ruby
counter = 0

threads = 10.times.map do
  Thread.new do
    1000.times do
      counter += 1
    end
  end
end

threads.each(&:join)
puts counter
```

共享可变数据容易出现竞态条件。即使有 GVL，也不要把共享修改当作天然安全的设计。

需要同步时可以使用 `Mutex`：

```ruby
mutex = Mutex.new
counter = 0

threads = 10.times.map do
  Thread.new do
    1000.times do
      mutex.synchronize do
        counter += 1
      end
    end
  end
end

threads.each(&:join)
puts counter
```

## GVL 的影响

在 CRuby 中，同一时刻通常只有一个线程执行 Ruby 字节码。I/O 等待型任务仍然可以从线程中获益，因为等待网络或磁盘时，其他线程有机会继续推进。

CPU 密集型任务，例如大量纯 Ruby 数学计算，不一定能因为 Thread 变快。

## 适合 Thread 的场景

- 同时等待多个网络请求。
- 后台处理较轻的任务。
- 简单并发脚本。
- 需要保持主流程响应的 I/O 任务。

## 小结

Ruby Thread 适合 I/O 等待型并发。共享数据时使用同步工具；CPU 密集型任务要考虑进程、Ractor、原生扩展或其他架构。

