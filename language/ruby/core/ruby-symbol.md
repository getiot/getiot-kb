---
sidebar_position: 3
sidebar_label: 符号 Symbol
slug: /ruby-symbol
---

# Ruby 符号 Symbol

Symbol 是 Ruby 中非常常见的对象。它看起来像字符串，但更适合表示“名字”“状态”“固定键”。

## 创建 Symbol

```ruby
status = :ok
role = :admin
field = :name
```

Symbol 通常以冒号开头。

## Symbol 和 String 的区别

```ruby
puts :name.class
puts "name".class
```

String 表示文本内容，适合输入、输出、拼接、替换。

Symbol 更像一个固定标识，适合做字段名、选项名、状态值。

```ruby
command = :start

case command
when :start
  puts "starting"
when :stop
  puts "stopping"
end
```

## Hash 中的 Symbol 键

Ruby 中常用 Symbol 作为 Hash 的键：

```ruby
user = {
  name: "Alice",
  age: 18
}

puts user[:name]
```

`name: "Alice"` 是 `:name => "Alice"` 的简写。

## 转换

```ruby
puts :name.to_s
puts "name".to_sym
```

如果用户输入来自外部，通常先保持字符串；只有确实要作为内部固定标识时，再考虑转成 Symbol。

## 常见错误

混用 String 键和 Symbol 键：

```ruby
user = { name: "Alice" }

puts user[:name]  # Alice
puts user["name"] # nil
```

`:name` 和 `"name"` 是两个不同的键。

## 小练习

1. 创建一个以 Symbol 为键的 Hash。
2. 尝试用字符串键访问它，观察结果。
3. 把 `"status"` 转成 Symbol。

## 小结

Symbol 适合表示稳定标识，String 适合表示文本内容。Hash 中混用 Symbol 和 String 键，是初学者常见问题。

