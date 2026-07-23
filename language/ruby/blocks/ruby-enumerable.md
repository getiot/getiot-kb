---
sidebar_position: 2
sidebar_label: Enumerable 入门
slug: /ruby-enumerable
---

# Ruby Enumerable 入门

`Enumerable` 是 Ruby 集合处理的核心模块。Array、Hash、Range 都能使用许多 Enumerable 方法。

你可以把 Enumerable 理解成：只要一个对象能“逐个产出元素”，Ruby 就可以给它一整套遍历、查找、过滤、转换能力。

## each 是基础

```ruby
[1, 2, 3].each do |n|
  puts n
end
```

`each` 负责逐个产出元素。Enumerable 的许多方法都建立在这个能力之上。

## any? 和 all?

判断是否有任意元素满足条件：

```ruby
numbers = [1, 2, 3, 4]

puts numbers.any? { |n| n > 3 }
```

判断是否所有元素都满足条件：

```ruby
puts numbers.all? { |n| n.positive? }
```

## find

找到第一个满足条件的元素：

```ruby
numbers = [1, 2, 3, 4]

even = numbers.find { |n| n.even? }
puts even
```

找不到时返回 `nil`。

## count

```ruby
numbers = [1, 2, 3, 4]

puts numbers.count
puts numbers.count { |n| n.even? }
```

## Hash 的 Enumerable

```ruby
user = { name: "Alice", age: 18 }

user.each do |key, value|
  puts "#{key}=#{value}"
end
```

Hash 遍历时，每次产出键和值。

## Enumerable 的思维方式

看到集合处理时，先问：

- 是不是要逐个做事？用 `each`。
- 是不是要判断是否存在？用 `any?`。
- 是不是要判断全部满足？用 `all?`。
- 是不是要找第一个？用 `find`。
- 是不是要计数？用 `count`。

## 小练习

1. 判断数组中是否有负数。
2. 判断数组中所有数字是否都大于 0。
3. 找出第一个长度大于 5 的字符串。

## 小结

Enumerable 是 Ruby 代码简洁自然的重要来源。你不必一开始记住所有方法，但要学会用集合方法表达意图。

