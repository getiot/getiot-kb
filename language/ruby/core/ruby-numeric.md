---
sidebar_position: 1
sidebar_label: 数字 Numeric
slug: /ruby-numeric
---

# Ruby 数字 Numeric

Ruby 常用数字类型包括 `Integer` 和 `Float`。它们都属于数字对象，能调用许多方法。

## Integer

```ruby
count = 42

puts count.class
puts count.odd?
puts count.even?
puts count.next
```

Ruby 的整数可以很大，通常不用你像 C 语言那样一开始就区分 `int32`、`int64`。

## Float

```ruby
price = 19.99

puts price.class
puts price.round
```

Float 用于浮点数，也就是近似小数。

:::warning
浮点数不适合直接处理严格金额。金额建议用整数分、数据库 decimal 类型，或 Ruby 标准库中的 `BigDecimal`。
:::

## 整数除法

```ruby
puts 10 / 3
puts 10 / 3.0
```

`10 / 3` 结果是 `3`，因为两边都是整数。

只要其中一个是浮点数，就会得到浮点结果：

```ruby
puts 10.to_f / 3
```

## 常用方法

```ruby
puts -10.abs
puts 3.14.round
puts 3.14.ceil
puts 3.14.floor
puts 5.zero?
puts 10.between?(1, 20)
```

这些方法比手写复杂条件更容易读。

## Range 和数字

数字常和 Range 配合：

```ruby
(1..5).each do |n|
  puts n
end
```

## 小练习

1. 试验 `7 / 2` 和 `7 / 2.0`。
2. 用 `between?` 判断年龄是否在 18 到 60 之间。
3. 使用 `round`、`ceil`、`floor` 观察浮点数取整区别。

## 小结

Ruby 数字对象方法丰富。初学时要特别注意整数除法和浮点精度，涉及金额时不要随意使用 Float。

