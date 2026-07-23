---
sidebar_position: 4
sidebar_label: 数组 Array
slug: /ruby-array
---

# Ruby 数组 Array

Array 用来保存一组有顺序的对象。它是 Ruby 中最常用的集合类型之一。

## 创建数组

```ruby
numbers = [1, 2, 3]
names = ["Ada", "Matz", "Ruby"]
mixed = ["Ruby", 42, true]
```

Ruby 数组可以保存不同类型的对象，但实际项目中，一个数组里通常放同一类数据，代码会更容易理解。

## 访问元素

```ruby
names = ["Ada", "Matz", "Ruby"]

puts names[0]
puts names[1]
puts names[-1]
```

负数下标从末尾开始，`-1` 表示最后一个元素。

越界访问会返回 `nil`：

```ruby
puts names[100].nil?
```

## 添加元素

```ruby
names << "Rails"
names.push("Sinatra")
```

`<<` 是 Ruby 中非常常见的追加写法。

## 删除元素

```ruby
names.delete("Ada")
last = names.pop
```

`delete` 按值删除，`pop` 删除并返回最后一个元素。

## 遍历数组

```ruby
names.each do |name|
  puts "Hello, #{name}"
end
```

如果需要下标：

```ruby
names.each_with_index do |name, index|
  puts "#{index}: #{name}"
end
```

## 常用方法

```ruby
numbers = [1, 2, 3, 4]

puts numbers.first
puts numbers.last
puts numbers.length
puts numbers.include?(3)
puts numbers.sum
```

## map 和 select 预览

```ruby
doubled = numbers.map { |n| n * 2 }
even = numbers.select { |n| n.even? }
```

这些方法来自 Enumerable，后面会专门讲。

## 常见错误

误以为 `each` 会返回处理后的数组：

```ruby
result = [1, 2, 3].each { |n| n * 2 }
puts result.inspect # 仍然是原数组
```

如果你要转换数组，应该用 `map`。

## 小练习

1. 创建一个保存 5 个名字的数组。
2. 输出第一个和最后一个元素。
3. 使用 `each_with_index` 输出编号。
4. 使用 `select` 找出偶数。

## 小结

Array 负责保存有序集合。你要熟悉下标、`<<`、`push`、`pop`、`each`，并知道什么时候用 `map` 或 `select`。

