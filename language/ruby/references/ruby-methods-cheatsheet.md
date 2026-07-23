---
sidebar_position: 0
sidebar_label: 常用方法速查
slug: /ruby-methods-cheatsheet
---

# Ruby 常用方法速查

这份速查表面向初学者，帮助你快速回忆常见对象和方法。它不是完整 API 手册，只列最常用、最应该先掌握的内容。

## String

```ruby
text.strip        # 去掉首尾空白
text.chomp        # 去掉行尾换行
text.split(",")   # 按分隔符拆成数组
text.include?("r") # 是否包含子串
text.upcase       # 转大写
text.downcase     # 转小写
text.length       # 字符长度
text.bytesize     # 字节数
```

注意：`upcase` 返回新字符串，`upcase!` 会尝试修改原字符串。

## Array

```ruby
items.first
items.last
items.length
items.empty?
items.include?("Ruby")
items << "Rails"
items.each { |item| puts item }
items.map { |item| item.to_s }
items.select { |item| item }
```

`each` 用于逐个执行操作，`map` 用于生成新数组，`select` 用于过滤。

## Hash

```ruby
hash[:name]
hash.fetch(:name, "unknown")
hash[:name] = "Alice"
hash.keys
hash.values
hash.each { |key, value| puts "#{key}=#{value}" }
```

注意 Symbol 键和 String 键不同：

```ruby
hash[:name]
hash["name"]
```

## Enumerable

```ruby
items.any? { |item| item.valid? }
items.all? { |item| item.valid? }
items.find { |item| item.id == 1 }
items.count { |item| item.active? }
items.reduce(0) { |sum, item| sum + item }
```

## File 和 Dir

```ruby
File.read("data.txt")
File.write("out.txt", "hello\n")
File.foreach("data.txt") { |line| puts line }
File.exist?("data.txt")
File.file?("data.txt")
Dir.glob("*.md")
```

## 小结

速查表适合复习，但不要只背方法名。你要知道每个方法返回什么、是否修改原对象、遇到错误时会怎样。

