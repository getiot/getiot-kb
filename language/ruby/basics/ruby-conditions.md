---
sidebar_position: 4
sidebar_label: 条件判断
slug: /ruby-conditions
---

# Ruby 条件判断

条件判断让程序根据不同情况执行不同代码。Ruby 常用 `if`、`unless` 和 `case`。

## if / elsif / else

```ruby
score = 85

if score >= 90
  puts "excellent"
elsif score >= 60
  puts "pass"
else
  puts "fail"
end
```

Ruby 使用 `elsif`，不是 `else if`。

## if 作为表达式

`if` 可以返回值：

```ruby
score = 85

result = if score >= 60
           "pass"
         else
           "fail"
         end

puts result
```

这种写法适合“根据条件得到一个值”的场景。

## 行尾 if

简单条件可以写在行尾：

```ruby
puts "debug mode" if ENV["DEBUG"]
```

但如果逻辑稍微复杂，还是展开成多行更清楚。

## unless

`unless` 表示“除非条件成立”：

```ruby
unless File.exist?("config.yml")
  puts "config not found"
end
```

适合表达简单的反向条件。如果条件里有多个逻辑运算，使用 `if` 会更清楚。

## case

`case` 适合多分支判断：

```ruby
command = "start"

case command
when "start"
  puts "starting"
when "stop"
  puts "stopping"
when "restart"
  puts "restarting"
else
  puts "unknown command"
end
```

也可以配合 Range：

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

## Ruby 的真值规则

这是初学者必须记住的一点：Ruby 中只有 `false` 和 `nil` 是假值，其他都是真值。

```ruby
puts "yes" if 0
puts "yes" if ""
puts "yes" if []
```

这三行都会输出 `yes`。

如果你想判断字符串是否为空，要写：

```ruby
name = ""

if name.empty?
  puts "empty"
end
```

## 常见错误

把 `0` 当成假值：

```ruby
count = 0
puts "has count" if count
```

这会输出，因为 `0` 在 Ruby 中是真值。

把 `unless` 写得太复杂：

```ruby
# 这种代码不容易读
unless user.nil? || user.admin?
end
```

复杂条件用 `if` 和清楚的变量名更好。

## 小练习

1. 根据分数输出等级。
2. 使用 `case` 根据命令字符串执行不同输出。
3. 在 IRB 中测试 `if 0`、`if ""`、`if nil` 的行为。

## 小结

Ruby 条件判断简洁自然。你要掌握 `if`、`unless`、`case`，更要牢记真值规则：只有 `false` 和 `nil` 是假值。

