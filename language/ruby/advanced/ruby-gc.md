---
sidebar_position: 4
sidebar_label: 内存与 GC
slug: /ruby-gc
---

# Ruby 内存与 GC 基础

Ruby 使用 GC 自动管理内存。GC 是 Garbage Collection 的缩写，通常翻译为垃圾回收。它会回收程序不再使用的对象。

## 对象分配

```ruby
1000.times do
  "ruby".upcase
end
```

这段代码会创建许多临时字符串对象。对象分配越多，GC 压力可能越大。

## 查看 GC 信息

```ruby
p GC.stat
```

`GC.stat` 会返回当前 GC 统计信息。初学时不需要理解所有字段，但可以知道 Ruby 提供了观察 GC 的入口。

## 内存问题常见来源

- 把大量数据一次性读入内存。
- 长时间保存不再需要的对象。
- 大数组、大 Hash 持续增长。
- 缓存没有淘汰策略。
- 字符串拼接制造大量临时对象。

## 逐行处理大文件

不推荐：

```ruby
lines = File.read("huge.log").lines
```

更稳：

```ruby
File.foreach("huge.log") do |line|
  # process line
end
```

## 普通代码先追求清晰

不要因为知道 GC 成本，就把所有代码写得难懂。大多数业务代码先追求清晰；性能敏感路径再关注分配、缓存和数据结构。

## 小结

Ruby 会自动回收内存，但对象分配仍然有成本。处理大文件、大集合、长时间运行服务时，你要关注内存增长和 GC 压力。

