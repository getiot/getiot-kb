---
sidebar_position: 1
sidebar_label: 设计哲学
slug: /ruby-philosophy
---

# Ruby 的设计哲学

Ruby 的设计者松本行弘常说 Ruby 关注程序员的幸福感。这里的“幸福感”不是说代码可以随便写，而是语言应该尽量减少无意义的负担，让你能自然地表达想法。

理解 Ruby 的设计哲学很重要，因为 Ruby 的许多语法和约定都来自这个方向。

## 表达力优先

Ruby 代码常常读起来像一句话：

```ruby
3.times do
  puts "hello"
end
```

你可以直接读成：“做 3 次，输出 hello。”

再看一个数组处理：

```ruby
names = ["alice", "bob", "carol"]

names.each do |name|
  puts name.capitalize
end
```

这段代码没有暴露下标，也没有手动管理循环变量。你关心的是“逐个处理名字”，Ruby 就让你直接表达这个意图。

## 一切皆对象

Ruby 追求对象模型的一致性：

```ruby
puts 42.even?
puts "ruby".upcase
puts [1, 2, 3].length
```

数字、字符串、数组都能接收方法调用。你不需要在“基本类型”和“对象类型”之间反复切换思维。

这种设计让 Ruby 代码更统一：遇到一个值时，你可以问“这个对象能响应哪些方法？”

## 约定让代码更好读

Ruby 社区有很多命名约定。

以 `?` 结尾的方法通常返回布尔值：

```ruby
"".empty?
10.positive?
[1, 2, 3].include?(2)
```

以 `!` 结尾的方法通常表示“更危险”“会修改对象本身”或“行为更强烈”：

```ruby
name = "ruby"

puts name.upcase
puts name

name.upcase!
puts name
```

`upcase` 返回新字符串，`upcase!` 会尝试修改原字符串。这个约定不是语法强制，但 Ruby 社区普遍遵守。

## 灵活不等于随意

Ruby 很灵活，例如方法调用可以省略括号：

```ruby
puts "hello"
```

但灵活也意味着你需要更自律。初学时可以记住几条原则：

- 让命名表达意图。
- 方法不要太长。
- 不要滥用全局变量和元编程。
- 复杂表达式里保留括号，让读者看得清楚。
- 能写测试就写测试，别只靠手动运行。

## 小结

Ruby 的设计哲学可以概括为：让代码自然表达，让对象模型保持一致，用约定降低沟通成本。你学 Ruby 时，不只是学语法，也是在学习这种写代码的审美。

