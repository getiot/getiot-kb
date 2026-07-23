---
sidebar_position: 6
sidebar_label: 范围 Range
slug: /ruby-range
---

# Ruby 范围 Range

Range 表示从一个值到另一个值的范围。它常用于循环、条件判断、切片和区间表达。

## 包含结束值

```ruby
(1..5).each do |n|
  puts n
end
```

`1..5` 包含 `5`。

## 不包含结束值

```ruby
(1...5).each do |n|
  puts n
end
```

`1...5` 不包含 `5`。

这是 Range 最容易混淆的地方：

- `..` 包含末尾。
- `...` 不包含末尾。

## 判断包含

```ruby
puts (1..10).include?(5)
puts ("a".."z").include?("m")
```

## 配合 case

```ruby
score = 82

case score
when 90..100
  puts "A"
when 60...90
  puts "B"
else
  puts "C"
end
```

这里 `60...90` 表示包含 60，但不包含 90。

## 数组切片

```ruby
items = ["a", "b", "c", "d", "e"]

puts items[1..3].inspect
puts items[1...3].inspect
```

Range 可以用来取数组的一段。

## 无起点或无终点范围

Ruby 支持一些更灵活的范围写法：

```ruby
numbers = [1, 2, 3, 4, 5]

puts numbers[..2].inspect
puts numbers[2..].inspect
```

初学时知道有这种写法即可，不必一开始大量使用。

## 小练习

1. 使用 `1..10` 输出 1 到 10。
2. 比较 `1..3` 和 `1...3`。
3. 使用 Range 从数组中取出中间几个元素。

## 小结

Range 是 Ruby 中表达区间的自然方式。你最需要记住 `..` 和 `...` 的区别。

