---
sidebar_position: 3
sidebar_label: map、select 与 reduce
slug: /ruby-map-select-reduce
---

# Ruby map、select 与 reduce

`map`、`select` 和 `reduce` 是 Ruby 集合处理中最常用的三个方法。你可以把它们分别理解为：转换、过滤、汇总。

## map：转换每个元素

```ruby
numbers = [1, 2, 3]
result = numbers.map { |n| n * 2 }

puts result.inspect
```

输出：

```text
[2, 4, 6]
```

`map` 不会改变原数组，而是返回一个新数组。

```ruby
puts numbers.inspect
```

## select：过滤元素

```ruby
numbers = [1, 2, 3, 4, 5]
even = numbers.select { |n| n.even? }

puts even.inspect
```

`select` 保留 block 返回真值的元素。

相反，`reject` 会丢弃符合条件的元素：

```ruby
odd = numbers.reject { |n| n.even? }
puts odd.inspect
```

## reduce：汇总成一个值

```ruby
numbers = [1, 2, 3, 4]
sum = numbers.reduce(0) do |total, n|
  total + n
end

puts sum
```

`0` 是初始值，`total` 是累计结果。

Ruby 也提供一些更直接的方法：

```ruby
puts numbers.sum
puts numbers.max
puts numbers.min
```

## 串联使用

```ruby
numbers = [1, 2, 3, 4, 5]

result = numbers
  .select { |n| n.even? }
  .map { |n| n * 10 }

puts result.inspect
```

这表示：先筛出偶数，再把每个偶数乘以 10。

## each 和 map 的区别

`each` 关注“做一件事”：

```ruby
names.each { |name| puts name }
```

`map` 关注“生成新集合”：

```ruby
upper_names = names.map { |name| name.upcase }
```

不要用 `each` 假装生成结果。

## 小练习

1. 用 `map` 把字符串数组全部转大写。
2. 用 `select` 找出长度大于 3 的字符串。
3. 用 `reduce` 计算数组中所有数字的乘积。
4. 把 `select` 和 `map` 串联起来处理数组。

## 小结

`map` 转换，`select` 过滤，`reduce` 汇总。掌握这三种模式，你就能写出很多 Ruby 风格的集合处理代码。

