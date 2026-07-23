---
sidebar_position: 2
sidebar_label: ARGV 与环境变量
slug: /ruby-argv-env
---

# Ruby ARGV 与环境变量

命令行脚本经常需要接收参数和配置。Ruby 用 `ARGV` 读取命令行参数，用 `ENV` 读取环境变量。

## ARGV 基础

创建 `hello.rb`：

```ruby title="hello.rb"
name = ARGV[0] || "Ruby"
puts "Hello, #{name}"
```

运行：

```bash
ruby hello.rb Alice
```

`ARGV` 是数组：

```ruby
p ARGV
```

运行：

```bash
ruby app.rb one two three
```

会看到参数数组。

## 参数校验

```ruby
filename = ARGV[0]

unless filename
  warn "usage: ruby app.rb <file>"
  exit 1
end

puts File.read(filename)
```

`warn` 输出错误提示，`exit 1` 表示异常退出。

## ENV 环境变量

```ruby
port = ENV.fetch("APP_PORT", "8080")
puts "listen on #{port}"
```

运行：

```bash
APP_PORT=9000 ruby app.rb
```

环境变量常用于端口、运行模式、密钥路径等配置。

## 解析数字配置

`ENV` 读到的都是字符串：

```ruby
port = ENV.fetch("APP_PORT", "8080").to_i
```

如果你需要严格校验，可以写：

```ruby
port_text = ENV.fetch("APP_PORT", "8080")
port = Integer(port_text)
```

`Integer("abc")` 会抛出异常，比 `to_i` 更容易发现错误输入。

## 复杂 CLI 用 OptionParser

参数多起来后，不建议手写解析。Ruby 标准库提供 `OptionParser`：

```ruby
require "optparse"

options = {}

OptionParser.new do |parser|
  parser.on("-v", "--verbose", "Enable verbose output") do
    options[:verbose] = true
  end
end.parse!

p options
```

## 小练习

1. 写一个脚本，从 `ARGV` 读取文件名并输出内容。
2. 使用 `ENV.fetch` 读取 `APP_ENV`，默认值为 `dev`。
3. 使用 `Integer()` 解析端口，并处理非法输入。

## 小结

`ARGV` 表示本次命令行输入，`ENV` 表示运行环境配置。简单脚本可以手写解析，正式命令行工具应考虑 `OptionParser` 或专门 gem。

