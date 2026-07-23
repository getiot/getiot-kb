---
sidebar_position: 0
sidebar_label: 基础语法
slug: /ruby-basic-syntax
---

# Ruby 基础语法

Ruby 的语法很轻巧。你不需要写 `main` 函数，也不需要在每行末尾写分号。对初学者来说，这降低了入门门槛；但你也要逐步理解 Ruby 的代码块、表达式和方法调用规则。

## 最小程序

```ruby
puts "Hello, Ruby!"
```

运行时，Ruby 会从文件第一行开始向下执行。

## 换行和分号

Ruby 通常用换行分隔语句：

```ruby
name = "Ruby"
puts name
```

也可以使用分号写在一行，但不推荐：

```ruby
name = "Ruby"; puts name
```

正常教程和项目里，你应该优先使用多行写法。

## 方法调用

Ruby 调用方法时，括号经常可以省略：

```ruby
puts("hello")
puts "hello"
```

两种都能运行。初学时可以这样判断：

- 简单输出和 DSL 风格代码，可以省略括号。
- 参数复杂、嵌套调用较多时，写括号更清楚。

例如：

```ruby
puts "hello"
```

比下面这种复杂写法自然：

```ruby
puts "hello".upcase.reverse
```

但如果表达式更复杂，括号可以帮助读者：

```ruby
puts("hello".upcase.reverse)
```

## 代码块

Ruby 用 `do ... end` 或 `{ ... }` 表示 block：

```ruby
3.times do
  puts "Ruby"
end
```

单行 block 常用 `{ ... }`：

```ruby
3.times { puts "Ruby" }
```

多行 block 常用 `do ... end`。这不是硬性语法规则，而是社区习惯。

## 表达式和值

Ruby 中很多结构都会产生值：

```ruby
score = 85

result = if score >= 60
           "pass"
         else
           "fail"
         end

puts result
```

这里 `if` 表达式的结果被赋给了 `result`。

## 注释

```ruby
# 这是注释
puts "hello"
```

注释应该解释“为什么这样做”，而不是重复代码。

## 常见错误

忘记写 `end`：

```ruby
if true
  puts "yes"
# 少了 end
```

括号和 block 混用导致优先级误解：

```ruby
# 初学时遇到复杂调用，宁可多写括号
```

## 小练习

1. 写一个脚本，输出三行自我介绍。
2. 用 `3.times do ... end` 重复输出一句话。
3. 把一个 `if` 表达式的结果赋给变量并输出。

## 小结

Ruby 基础语法的关键是：换行分隔语句、方法调用可以省略括号、代码块使用 `do ... end` 或 `{ ... }`、很多语法结构本身有返回值。

