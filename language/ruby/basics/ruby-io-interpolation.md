---
sidebar_position: 7
sidebar_label: 输入、输出与字符串插值
slug: /ruby-io-interpolation
---

# Ruby 输入、输出与字符串插值

命令行脚本经常需要输出提示、读取输入、把变量嵌入字符串。Ruby 提供了非常直接的写法。

## puts、print 和 warn

`puts` 输出并换行：

```ruby
puts "hello"
```

`print` 输出但不自动换行：

```ruby
print "Your name: "
```

`warn` 通常输出警告信息到标准错误：

```ruby
warn "config file not found"
```

写命令行工具时，普通结果用 `puts`，错误提示常用 `warn`。

## gets 读取输入

```ruby
print "Your name: "
name = gets.chomp

puts "Hello, #{name}!"
```

`gets` 读取一行输入，结果包含换行符。`chomp` 会去掉末尾换行。

如果用户直接按 Enter，`name` 会是空字符串，不是 `nil`。

## 字符串插值

```ruby
name = "Ruby"
version = 4

puts "#{name} #{version}"
```

插值可以放表达式：

```ruby
puts "next year: #{2026 + 1}"
```

但复杂表达式不建议直接塞进字符串。先用变量命名，会更清楚。

## 双引号和单引号

双引号支持插值和转义：

```ruby
name = "Ruby"
puts "Hello, #{name}\n"
```

单引号不会执行插值：

```ruby
puts 'Hello, #{name}'
```

输出会原样包含 `#{name}`。

## 格式化输出

```ruby
name = "temperature"
value = 26.5

puts "%s: %.1f" % [name, value]
```

也可以使用 `format`：

```ruby
puts format("%s: %.1f", name, value)
```

## 常见错误

忘记 `chomp`：

```ruby
name = gets
puts "Hello, #{name}!" # name 里带换行
```

在单引号里期待插值：

```ruby
name = "Ruby"
puts 'Hello, #{name}' # 不会插值
```

## 小练习

1. 读取用户姓名并输出问候语。
2. 读取两个数字字符串，转换成整数后相加。
3. 用 `format` 输出保留两位小数的价格。

## 小结

命令行交互常用 `puts`、`print`、`warn`、`gets.chomp` 和字符串插值。记住：插值只在双引号字符串中生效。

