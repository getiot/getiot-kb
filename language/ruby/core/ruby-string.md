---
sidebar_position: 2
sidebar_label: 字符串 String
slug: /ruby-string
---

# Ruby 字符串 String

字符串用于保存文本，是 Ruby 中最常用的对象之一。你会在输入输出、文件处理、HTTP、日志和数据解析中频繁使用它。

## 创建字符串

```ruby
name = "Ruby"
message = 'Hello'
```

双引号支持插值：

```ruby
puts "Hello, #{name}"
```

单引号不会插值：

```ruby
puts 'Hello, #{name}'
```

## 常用方法

```ruby
text = " ruby "

puts text.strip
puts text.upcase
puts text.downcase
puts text.include?("ru")
puts text.length
```

`strip` 去掉首尾空白，`include?` 判断是否包含子串。

## split 和 join

```ruby
line = "alice,18,admin"
parts = line.split(",")

puts parts.inspect
puts parts.join(" | ")
```

`split` 常用于解析简单文本，`join` 常用于把数组拼回字符串。

## 字符串是否可变

Ruby 字符串通常是可变对象：

```ruby
name = "ruby"
name.upcase!

puts name
```

没有 `!` 的方法通常返回新字符串：

```ruby
name = "ruby"
upper = name.upcase

puts name
puts upper
```

## bytesize 和 length

```ruby
text = "你好"

puts text.length
puts text.bytesize
```

`length` 更接近字符数量，`bytesize` 是字节数。处理网络、文件大小、编码问题时，这个区别很重要。

## 常见错误

在单引号中使用插值：

```ruby
name = "Ruby"
puts 'Hello, #{name}' # 不会插值
```

忘记 `strip` 或 `chomp` 导致比较失败：

```ruby
input = "yes\n"
puts input == "yes" # false
puts input.chomp == "yes" # true
```

## 小练习

1. 把 `" ruby "` 转成 `"RUBY"`。
2. 把 `"a,b,c"` 拆成数组。
3. 比较 `"你好".length` 和 `"你好".bytesize`。

## 小结

字符串是 Ruby 的基础工具。你要熟悉插值、`strip`、`chomp`、`split`、`join`、`include?`，并注意可变方法和编码相关差异。

