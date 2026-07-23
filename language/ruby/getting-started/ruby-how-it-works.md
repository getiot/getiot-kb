---
sidebar_position: 2
sidebar_label: 工作方式
slug: /ruby-how-it-works
---

# Ruby 工作方式

Ruby 通常作为解释型动态语言使用。你写 `.rb` 文件，然后由 Ruby 解释器读取并执行。理解 Ruby 的工作方式，可以帮你更好地理解“为什么有些错误运行时才出现”“为什么变量不用声明类型”“为什么 gem 需要 require”。

## Ruby 程序怎样运行

创建一个文件：

```ruby title="hello.rb"
puts "Hello, Ruby!"
```

运行：

```bash
ruby hello.rb
```

Ruby 会读取文件并执行里面的代码。对于初学者，你可以先把 Ruby 想象成“从上到下执行脚本”的语言。

## CRuby、解释器和 VM

你通常安装和使用的是 CRuby，也就是官方主流 Ruby 实现。CRuby 会解析 Ruby 源码，并在 Ruby VM 中执行。

你不需要一开始理解 VM 的所有细节，但要知道两件事：

- Ruby 不是像 C/C++ 那样先编译成一个独立二进制文件再运行。
- Ruby 的很多类型检查和方法查找发生在运行时。

例如：

```ruby
value = "ruby"
puts value.upcase

value = 42
puts value.upcase
```

第一段能运行，第二段会报错，因为 `Integer` 对象没有 `upcase` 方法。Ruby 不会在你给 `value` 重新赋值时阻止你，但运行到方法调用时会检查对象是否能响应这个方法。

## 动态类型是什么

Ruby 中变量没有固定类型：

```ruby
value = 10
value = "hello"
value = [1, 2, 3]
```

更准确地说，变量是一个名字，它指向某个对象；对象自己知道自己的类型：

```ruby
puts 10.class
puts "hello".class
puts [1, 2, 3].class
```

动态类型让写代码很灵活，但也要求你通过测试、命名和清楚的结构降低错误风险。

## require 是什么

当你需要使用其他文件或标准库时，会用 `require`：

```ruby
require "json"

data = JSON.parse('{"name":"Ruby"}')
puts data["name"]
```

`require` 会加载库文件。标准库、gem 和你自己的项目文件都可能通过不同方式加载。

项目内部文件也常用：

```ruby
require_relative "my_tool"
```

`require_relative` 会按当前文件位置查找相对路径，适合同一个项目内的小脚本。

## IRB 的作用

IRB 是 Interactive Ruby 的缩写。你可以在里面立刻执行 Ruby 表达式：

```bash
irb
```

然后输入：

```ruby
"ruby".upcase
[1, 2, 3].map { |n| n * 2 }
```

学习新方法时，先在 IRB 里试一试非常有效。

## 小结

Ruby 程序通常由解释器执行，变量是动态类型，方法查找发生在运行时。你可以用 IRB 探索，用 `.rb` 文件保存脚本，用 `require` 组织代码。

