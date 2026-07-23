---
sidebar_position: 7
sidebar_label: nil、true 与 false
slug: /ruby-nil-true-false
---

# Ruby nil、true 与 false

Ruby 用 `nil` 表示没有值，用 `true` 和 `false` 表示布尔值。它们看起来简单，但真值规则非常重要。

## nil

```ruby
value = nil

puts value.nil?
puts value.class
```

`nil?` 用于判断对象是否为 `nil`。

## true 和 false

```ruby
active = true
deleted = false

puts active.class
puts deleted.class
```

`true` 是 `TrueClass` 的实例，`false` 是 `FalseClass` 的实例。

## Ruby 的真值规则

Ruby 中只有 `nil` 和 `false` 是假值，其他所有对象都是真值。

```ruby
puts "yes" if 0
puts "yes" if ""
puts "yes" if []
puts "yes" if {}
```

这些都会输出。

这和一些语言不同。不要把 `0`、空字符串、空数组当作假值。

## 判断空值和空集合

判断是否为 nil：

```ruby
value.nil?
```

判断字符串、数组、哈希是否为空：

```ruby
"".empty?
[].empty?
{}.empty?
```

如果你想表达“不是 nil，也不是空”，可以根据对象类型选择合适方法。

## 安全调用

```ruby
user = nil
puts user&.name
```

`&.` 是 safe navigation operator。如果左边是 `nil`，整个表达式返回 `nil`，不会继续调用方法。

但不要滥用它。太多 `&.` 可能说明数据结构或错误处理需要整理。

## 常见错误

对 `nil` 调用方法：

```ruby
name = nil
# name.upcase 会报 NoMethodError
```

误以为空字符串是假：

```ruby
input = ""
puts "has input" if input # 会输出
```

正确判断：

```ruby
puts "empty input" if input.empty?
```

## 小练习

1. 在 IRB 中测试 `if 0`、`if ""`、`if []`。
2. 使用 `nil?` 判断变量是否为空值。
3. 使用 `empty?` 判断字符串是否为空。

## 小结

Ruby 真值规则必须背熟：只有 `false` 和 `nil` 是假值。判断空字符串、空数组、空哈希时，要使用 `empty?` 等方法。

