---
sidebar_position: 3
sidebar_label: 性能优化
slug: /ruby-performance
---

# Ruby 性能优化入门

性能优化的第一步不是改代码，而是测量。没有测量，你不知道程序慢在哪里，也不知道修改有没有效果。

## 使用 Benchmark

```ruby
require "benchmark"

time = Benchmark.realtime do
  100_000.times { "ruby".upcase }
end

puts "cost: #{time}s"
```

`Benchmark.realtime` 可以测量一段代码执行耗时。

## 常见瓶颈

Ruby 程序慢，可能来自：

- 算法复杂度太高。
- 重复读取文件或网络。
- 数据库查询太多。
- 没有使用索引。
- 创建了大量临时对象。
- 日志输出过多。
- JSON/CSV 处理数据量很大。

不要一开始就怀疑 Ruby 语言本身。很多性能问题是算法、I/O 或数据库问题。

## 从算法开始

低效查找：

```ruby
users.find { |user| user[:id] == target_id }
```

如果要反复按 ID 查找，可以先建立 Hash：

```ruby
users_by_id = users.to_h { |user| [user[:id], user] }
user = users_by_id[target_id]
```

## 减少对象分配

在热点路径中，大量创建临时字符串或数组会增加 GC 压力。

```ruby
buffer = +""

1000.times do |i|
  buffer << i.to_s
end
```

这类优化只应在确认热点后使用。

## 小结

Ruby 性能优化要按顺序来：先测量，再定位瓶颈，再选择算法、缓存、数据库优化、并发或原生扩展等方案。

