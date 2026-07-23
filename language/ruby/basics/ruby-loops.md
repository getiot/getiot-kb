---
sidebar_position: 5
sidebar_label: 循环与迭代
slug: /ruby-loops
---

# Ruby 循环与迭代入门

Ruby 支持传统循环，但 Ruby 风格代码更常使用迭代方法和 block。你可以先学会 `while`，再把重点放到 `times`、`each` 和 Enumerable。

## while 循环

```ruby
count = 0

while count < 3
  puts count
  count += 1
end
```

`while` 适合“只要条件成立就继续”的场景。

## until 循环

`until` 表示“直到条件成立前一直执行”：

```ruby
count = 0

until count == 3
  puts count
  count += 1
end
```

如果 `until` 让你读起来绕，就用 `while`。清楚比炫技重要。

## times

```ruby
3.times do |i|
  puts "index=#{i}"
end
```

`times` 很适合明确重复次数的场景。`i` 从 `0` 开始。

## each

遍历数组：

```ruby
names = ["Ada", "Matz", "Ruby"]

names.each do |name|
  puts "Hello, #{name}"
end
```

遍历 Hash：

```ruby
user = { name: "Alice", age: 18 }

user.each do |key, value|
  puts "#{key}: #{value}"
end
```

## for 为什么不常用

Ruby 也支持 `for`：

```ruby
for name in names
  puts name
end
```

但 Ruby 社区更常用 `each`。原因是 `each` 更符合“对象调用方法并接收 block”的 Ruby 风格，也更容易和 Enumerable 方法衔接。

## break 和 next

`break` 结束循环：

```ruby
[1, 2, 3, 4].each do |n|
  break if n > 2
  puts n
end
```

`next` 跳过当前这次：

```ruby
[1, 2, 3, 4].each do |n|
  next if n.odd?
  puts n
end
```

## 不要滥用循环

如果你的代码是“把每个元素转换成另一个值”，后面可以使用 `map`。

如果你的代码是“挑出符合条件的元素”，后面可以使用 `select`。

如果你的代码是“累加成一个结果”，后面可以使用 `reduce` 或 `sum`。

## 小练习

1. 使用 `times` 输出 5 次 `hello`。
2. 使用 `each` 遍历数组并输出每个名字。
3. 使用 `next` 跳过奇数，只输出偶数。

## 小结

Ruby 循环的重点不是 `for`，而是对象迭代。初学者先掌握 `while`、`times`、`each`、`break`、`next`，再进入 Enumerable。

