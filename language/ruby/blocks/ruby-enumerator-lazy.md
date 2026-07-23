---
sidebar_position: 4
sidebar_label: Enumerator 与惰性枚举
slug: /ruby-enumerator-lazy
---

# Ruby Enumerator 与惰性枚举

如果你调用某些迭代方法但不传 block，Ruby 会返回 `Enumerator`。它表示一个“可以逐步产出值”的对象。

## 不传 block 得到 Enumerator

```ruby
enum = [1, 2, 3].each

puts enum.class
puts enum.next
puts enum.next
```

平时你不一定直接调用 `next`，但理解 Enumerator 有助于理解 Ruby 的迭代模型。

## with_index

Enumerator 常用来继续链式调用：

```ruby
names = ["Alice", "Bob", "Carol"]

names.each.with_index(1) do |name, index|
  puts "#{index}. #{name}"
end
```

`with_index(1)` 表示下标从 1 开始。

## lazy 惰性枚举

普通 `map` 会立刻处理整个集合：

```ruby
result = [1, 2, 3].map { |n| n * 2 }
```

`lazy` 会按需计算：

```ruby
result = (1..Float::INFINITY)
  .lazy
  .map { |n| n * 2 }
  .select { |n| n % 3 == 0 }
  .first(5)

puts result.inspect
```

这个例子从无限范围开始，但只取前 5 个结果，所以不会真的计算无限个数字。

## 什么时候需要 lazy

普通数组处理先不用 `lazy`。它更适合：

- 数据量很大。
- 数据来自流式输入。
- 中间步骤很多，但最后只需要一部分结果。
- 处理无限序列。

## 常见错误

以为 `lazy` 会立刻执行：

```ruby
enum = [1, 2, 3].lazy.map { |n| puts n; n * 2 }
```

这时还不会输出。只有你真正取值时才会执行：

```ruby
enum.to_a
```

## 小练习

1. 使用 `each.with_index(1)` 输出带编号的列表。
2. 创建一个 lazy 链，只取前 3 个偶数。
3. 比较普通 `map` 和 `lazy.map` 的执行时机。

## 小结

Enumerator 让迭代过程变成对象，`lazy` 让计算按需发生。初学阶段先熟悉 Enumerable，遇到大数据或无限序列时再深入惰性枚举。

