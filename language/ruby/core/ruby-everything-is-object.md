---
sidebar_position: 0
sidebar_label: 一切皆对象
slug: /ruby-everything-is-object
---

# Ruby 一切皆对象

Ruby 的一个核心观念是：几乎所有东西都是对象。对象可以接收方法调用，也知道自己属于哪个类。

这句话听起来抽象，但它会影响你写 Ruby 的方式。你不是在操作“原始值”，而是在让对象执行方法。

## 数字也是对象

```ruby
puts 42.class
puts 42.even?
puts 42.next
```

`42` 是一个 `Integer` 对象。它能响应 `even?`、`next` 等方法。

## 字符串也是对象

```ruby
text = "ruby"

puts text.class
puts text.upcase
puts text.length
```

`upcase` 和 `length` 都是字符串对象的方法。

## nil 也是对象

```ruby
puts nil.class
puts nil.nil?
```

`nil` 代表“没有值”，但它本身也是 `NilClass` 的唯一实例。

## 类也是对象

```ruby
puts String.class
puts Array.class
```

在 Ruby 中，类本身也是对象。这就是为什么 Ruby 能很自然地支持许多动态能力和元编程。

## 方法调用就是发送消息

Ruby 社区常把方法调用理解成“向对象发送消息”：

```ruby
"ruby".upcase
```

可以读成：把 `upcase` 消息发送给字符串对象 `"ruby"`。

对象能不能处理这个消息，取决于它是否定义了对应方法。

```ruby
"ruby".upcase
# 42.upcase 会报错，因为 Integer 没有 upcase 方法
```

## Duck Typing

Ruby 常强调 Duck Typing。意思是：与其关心对象具体属于哪个类，不如关心它能不能做你需要的事。

```ruby
def print_length(obj)
  puts obj.length
end

print_length("ruby")
print_length([1, 2, 3])
```

字符串和数组都能响应 `length`，这个方法就可以同时处理它们。

## 常见错误

对 `nil` 调用普通方法：

```ruby
user = nil
# user.name 会报 NoMethodError
```

你可以先判断：

```ruby
puts user.name if user
```

或使用安全调用：

```ruby
puts user&.name
```

## 小练习

1. 在 IRB 中查看 `true.class`、`false.class` 和 `nil.class`。
2. 分别对字符串和数组调用 `length`。
3. 用 `respond_to?` 判断对象是否能响应某个方法。

## 小结

理解“一切皆对象”后，Ruby 会变得统一：值是对象，行为是方法调用。写 Ruby 时，你要多问“这个对象能响应什么方法？”

