---
sidebar_position: 4
sidebar_label: IRB 与 Hello World
slug: /ruby-irb-hello-world
---

# IRB 与第一个 Ruby 程序

安装好 Ruby 后，先不要急着创建大项目。你可以从 IRB 和一个简单脚本开始。

## 使用 IRB

在终端输入：

```bash
irb
```

然后试几个表达式：

```ruby
1 + 2
"ruby".upcase
[1, 2, 3].map { |n| n * 2 }
```

IRB 会立即显示结果。你可以把它当成 Ruby 的实验台。

退出 IRB：

```ruby
exit
```

## 第一个 Ruby 文件

创建 `hello.rb`：

```ruby title="hello.rb"
puts "Hello, Ruby!"
```

运行：

```bash
ruby hello.rb
```

输出：

```text
Hello, Ruby!
```

这一行代码里有两个重点：

- `puts` 是一个方法，用来输出内容并换行。
- `"Hello, Ruby!"` 是一个字符串对象。

## puts、print 和 p

`puts` 会输出内容并换行：

```ruby
puts "hello"
puts "ruby"
```

`print` 不会自动换行：

```ruby
print "hello"
print "ruby"
```

`p` 更适合调试，它会输出对象的检查形式：

```ruby
p "hello\n"
p [1, 2, 3]
```

你会在调试时经常用到 `p`。

## 加一点输入

创建 `greet.rb`：

```ruby title="greet.rb"
print "Your name: "
name = gets.chomp

puts "Hello, #{name}!"
```

运行：

```bash
ruby greet.rb
```

这里出现了两个新东西：

- `gets` 从标准输入读取一行。
- `chomp` 去掉行尾换行符。
- `"#{name}"` 是字符串插值，把变量值放进字符串。

## 小练习

1. 修改 `hello.rb`，输出两行文字。
2. 修改 `greet.rb`，让它询问年龄，并输出一句完整介绍。
3. 在 IRB 里试试 `"ruby".capitalize`、`"ruby".reverse` 和 `"ruby".length`。

## 小结

IRB 适合探索，`.rb` 文件适合保存程序。你已经会运行 Ruby 文件、输出内容、读取一行输入，并使用字符串插值。

